//
//  AppDelegate+CloudPushSDK.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/12/2.
//

import Foundation
///ios+
import UserNotifications

extension AppDelegate:UNUserNotificationCenterDelegate{
    
    /// 初始化推送
    @objc func loadCloudPush(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        
        let uuid = UIDevice.current.identifierForVendor ?? UUID()
        let deviceID = uuid.uuidString.lowercased().replacingOccurrences(of:"-", with:"")
        print("------------------\(deviceID)------------------")
        
        // APNs注册，获取deviceToken并上报
        registerAPNs(application)
        // 初始化阿里云推送SDK
        initCloudPush()
        // 监听推送通道打开动作
        listenOnChannelOpened()
        // 监听推送消息到达
        registerMessageReceive()
        // 点击通知将App从关闭状态启动时，将通知打开回执上报
        CloudPushSDK.sendNotificationAck(launchOptions)
        
    }
    
    //MARK: - 初始化推送SDK
    private func initCloudPush() {
        // 正式上线需要关闭 debug下日志调试
        CloudPushSDK.turnOnDebug()
        CloudPushSDK.autoInit { res in
            if res!.success{
                print("Push SDK init success, deviceId: \(CloudPushSDK.getDeviceId()!)")
            }else{
                print("Push SDK init failed, error: \(res!.error!).")
            }
        }
    }
    
    //MARK: - 向APNs注册，获取deviceToken用于推送
    private func registerAPNs(_ application: UIApplication) {
        if #available(iOS 10, *) {
            // iOS 10+
            let center = UNUserNotificationCenter.current()
            // 创建category，并注册到通知中心
//            createCustomNotificationCategory()
            center.delegate = self
            center.requestAuthorization(options: [.alert,.badge,.sound]) {(granted, error) in
                if (granted) {
                    // User authored notification
                    print("User authored notification.")
                    // 向APNs注册，获取deviceToken
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                } else {
                    // User denied notification
                    print("User denied notification.")
                }
            }
        }else if #available(iOS 8, *) {
            // iOS 8+
            application.registerUserNotificationSettings(UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil))
            application.registerForRemoteNotifications()
        } else {
            // < iOS 8
            application.registerForRemoteNotifications(matching: [.alert,.badge,.sound])
        }
    }
    
    //MARK: - 创建自定义category，并注册到通知中心
    @available(iOS 10, *)
    func createCustomNotificationCategory() {
        let action1 = UNNotificationAction.init(identifier: "action1", title: "test1", options: [])
        let action2 = UNNotificationAction.init(identifier: "action2", title: "test2", options: [])
        let category = UNNotificationCategory.init(identifier: "category", actions: [action1, action2], intentIdentifiers: [], options: UNNotificationCategoryOptions.customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    //MARK: - 监听推送通道是否打开
    func listenOnChannelOpened() {
        let notificationName = Notification.Name("CCPDidChannelConnectedSuccess")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(channelOpenedFunc(notification:)),
                                               name: notificationName,
                                               object: nil)
    }
    @objc func channelOpenedFunc(notification : Notification) {
        print("Push SDK channel opened.")
    }
    
    //MARK: - 注册消息到来监听
    func registerMessageReceive() {
        let notificationName = Notification.Name("CCPDidReceiveMessageNotification")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onMessageReceivedFunc(notification:)),
                                               name: notificationName,
                                               object: nil)
    }
    
    //MARK: - 处理推送消息
    @objc func onMessageReceivedFunc(notification : Notification) {
        print("Receive one message.")
        let pushMessage: CCPSysMessage = notification.object as! CCPSysMessage
        let title = String.init(data: pushMessage.title, encoding: String.Encoding.utf8)
        let body = String.init(data: pushMessage.body, encoding: String.Encoding.utf8)
        print("Message title: \(title!), body: \(body!).")
    }
    
    //MARK: - App处于启动状态时，通知打开回调（< iOS 10）
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Receive one notification.")
        let aps = userInfo["aps"] as! [AnyHashable : Any]
        let alert = aps["alert"] ?? "none"
        let badge = aps["badge"] ?? 0
        let sound = aps["sound"] ?? "none"
        let extras = userInfo["Extras"]
        // 设置角标数为0
        application.applicationIconBadgeNumber = 0;
        // 同步角标数到服务端
         self.syncBadgeNum(0)
        CloudPushSDK.sendNotificationAck(userInfo)
        print("Notification, alert: \(alert), badge: \(badge), sound: \(sound), extras: \(String(describing: extras)).")
    }
    
    // 处理iOS 10通知(iOS 10+)
    @available(iOS 10.0, *)
    func handleiOS10Notification(_ notification: UNNotification) {
        let content: UNNotificationContent = notification.request.content
        let userInfo = content.userInfo
        // 通知时间
        let noticeDate = notification.date
        // 标题
        let title = content.title
        // 副标题
        let subtitle = content.subtitle
        // 内容
        let body = content.body
        // 角标
        let badge = content.badge ?? 0
        // 取得通知自定义字段内容，例：获取key为"Extras"的内容
        let extras = userInfo["Extras"]
        // 设置角标数为0
        UIApplication.shared.applicationIconBadgeNumber = 0
        // 同步角标数到服务端
         self.syncBadgeNum(0)
        // 通知打开回执上报
        CloudPushSDK.sendNotificationAck(userInfo)
        print("Notification, date: \(noticeDate), title: \(title), subtitle: \(subtitle), body: \(body), badge: \(badge), extras: \(String(describing: extras)).")
    }
    
    //MARK: - App处于前台时收到通知(iOS 10+)
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Receive a notification in foreground.")
//        handleiOS10Notification(notification)
        // 通知不弹出
//        completionHandler([])
        // 通知弹出，且带有声音、内容和角标
        completionHandler([.alert, .badge, .sound])
    }
    
    //MARK: -  触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
    @available(iOS 10, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userAction = response.actionIdentifier
        if userAction == UNNotificationDefaultActionIdentifier {
            print("User opened the notification.")
            // 处理iOS 10通知，并上报通知打开回执
            handleiOS10Notification(response.notification)
        }
        
        if userAction == UNNotificationDismissActionIdentifier {
            print("User dismissed the notification.")
        }
        
        let customAction1 = "action1"
        let customAction2 = "action2"
        if userAction == customAction1 {
            print("User touch custom action1.")
        }
        
        if userAction == customAction2 {
            print("User touch custom action2.")
        }
        
        completionHandler()
    }
    
    /* 同步角标数到服务端 */
    func syncBadgeNum(_ badgeNum: UInt) {
        CloudPushSDK.syncBadgeNum(badgeNum) { (res) in
            if (res!.success) {
                print("Sync badge num: [\(badgeNum)] success")
            } else {
                print("Sync badge num: [\(badgeNum)] failed, error: \(String(describing: res?.error))")
            }
        }
    }
    
}
