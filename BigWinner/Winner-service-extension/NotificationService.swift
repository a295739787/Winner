//
//  NotificationService.swift
//  Winner-service-extension
//
//  Created by 一只莫得感情的寒鱼 on 2022/12/6.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [大赢家]"
            
            if  let imageURLString = bestAttemptContent.userInfo["image"] as? String,let url = URL(string: imageURLString) {
                
                downloadAndSave(url: url) { localURL in
                    
                    if let localURL = localURL {
                        do {
                            
                            let attachment = try UNNotificationAttachment(identifier: "download",url: localURL,options: nil)
                            bestAttemptContent.attachments = [attachment]
                            
                        }catch {
                                print("-----------push\(error)------------")
                        }
                    }
                    contentHandler(bestAttemptContent)
                }
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    //将图片下载到本地临时文件夹中
    private func downloadAndSave(url: URL,handler: @escaping (_ localURL: URL?) -> Void){
        
        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            var localURL: URL? = nil
            if let data = data {
                let timeInterval = Date().timeIntervalSince1970
                let timeStamp = Int(timeInterval)
                //文件后缀
                let ext = (url.absoluteString as NSString).pathExtension
                let temporaryURL = FileManager.default.temporaryDirectory
                let url = temporaryURL.appendingPathComponent("\(timeStamp)")
                    .appendingPathExtension(ext)
                if let _ = try? data.write(to: url) {
                    localURL = url
                }
            }
            handler(localURL)
        }
        task.resume()
    }
}
