//
//  XYSystemUpdate.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/1.
//

import UIKit
import AFNetworking

@objcMembers class XYSystemUpdate: UIView {

    private var backView = UIView()
    private var noticeLabel = UILabel()
    private var contentView = UITextView()
    private var contentH : CGFloat = 0.0
    private var lineView = UIView()
    private var sureButton = UIButton()
    private var cancelButton = UIButton()
    private var AppID : String = "1586242929"
    
    static let sharedInstance = XYSystemUpdate()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        SystemUpadate()
    }
    //MARK: - 加载主视图
    private func loadMainSubView(contentString:String){
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
         contentH = XYSystemUpdate.getLabelHeight(byWidth: self.frame.size.width-70, title: contentString, font: UIFont.systemFont(ofSize: 15))
        if contentH < 100 {
            contentH = 100
        }else if contentH > 200{
            contentH = 200
        }
        
        let backViewH = 60+40+1+contentH
        backView = UIView.init()
        backView.frame = CGRect(x: 35, y: (self.frame.size.height-backViewH)/2, width: self.frame.size.width-70, height: backViewH)
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .white
        self.addSubview(backView)

        noticeLabel = UILabel.init()
        noticeLabel.frame = CGRect(x: 5, y: 15, width: backView.frame.size.width-10, height: 20)
        noticeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        noticeLabel.textAlignment = .center;
        noticeLabel.text = "系统更新"
        noticeLabel.textColor = UIColor.black
        backView.addSubview(noticeLabel)
        
        contentView = UITextView.init()
        contentView.frame = CGRect(x: 10, y: noticeLabel.frame.maxY+10, width:backView.frame.size.width-20 , height: contentH)
        contentView.font = UIFont.systemFont(ofSize: 15)
        contentView.text = contentString
        contentView.showsHorizontalScrollIndicator = false
        contentView.isEditable = false
        contentView.isSelectable = false
        backView.addSubview(contentView)

        lineView = UIView.init()
        lineView.frame = CGRect(x: 0, y: contentView.frame.maxY, width: backView.frame.size.width, height: 1)
        lineView.backgroundColor = UIColor.hexString("#F0EFED")
        backView.addSubview(lineView)
        
        cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect(x:0 , y: lineView.frame.maxY, width: backView.frame.size.width/2, height: 60)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.hexString("#999999"), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.tag = 101
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        backView.addSubview(cancelButton)
        
        
        sureButton = UIButton.init(type: .custom)
        sureButton.frame = CGRect(x: cancelButton.frame.maxX, y: lineView.frame.maxY, width: backView.frame.size.width/2, height: 60)
        sureButton.setTitle("同意", for: .normal)
        sureButton.setTitleColor(.black, for: .normal)
        sureButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sureButton.tag = 102
        sureButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        backView.addSubview(sureButton)
    }

    ///取消和确认按钮点击方法
    @objc private func buttonClick(_ sender:UIButton){
        
        hideView()

        if sender.tag == 101 {
            
            let currentDate = NSString.getCurrentTimesYYDD()
            UserDefaults.standard.set(currentDate, forKey: "SYSTEMUPDATEDATE")
            UserDefaults.standard.synchronize()
            
        }
        if sender.tag == 102 {
            let url = URL(string: "https://itunes.apple.com/app/id\(AppID)?mt=8")
            UIApplication.shared.open(url!)
        }
    }
    
   ///显示界面
    private func showView(){
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        self.layoutIfNeeded()
        let tempFrame = backView.frame
        self.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
        } completion: { finished in
            
            UIView.animate(withDuration: 0.25) {
                self.backView.frame = tempFrame
            }
        }
    }
    
    ///关闭界面
    private func hideView(){
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
        } completion: { finished in
            if finished {
                UIView.animate(withDuration: 0.25) {
                    self.alpha = 0.0
                } completion: { finished in
                    self.removeFromSuperview()
                }
            }
        }
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
 
    
  private func SystemUpadate (){
        
        let infoDictionary = Bundle.main.infoDictionary! as NSDictionary
        let locVersion = infoDictionary.object(forKey: "CFBundleShortVersionString") as! String
        let appStoreUrl = "http://itunes.apple.com/lookup?id=\(AppID)"
        
        AFHTTPSessionManager.init().get(appStoreUrl, parameters: nil, headers: nil) { progress in
        } success: { task, responseObj in
                        
            let data = responseObj as! NSDictionary
            let resultCount = data.object(forKey: "resultCount") as! Int

            if (resultCount > 0){
                //取出线上的版本号
                let results = data.object(forKey: "results") as! NSArray
                let version = results.firstObject as! NSDictionary
                let onlineVersion = version.object(forKey: "version") as! String
                //获取更新版本信息
                let updateMessage = version.object(forKey: "releaseNotes") as! String

                let comparisonResult = self.compareOnlineVersion(online: onlineVersion, local: locVersion)
                switch comparisonResult {

                case .orderedAscending:
                    //线上的版本小不做操作
                    break
                case .orderedSame:
                    //版本相同
                    break
                case .orderedDescending:
                    //线上的版本大进行更新操作
                    self.loadMainSubView(contentString: updateMessage)
                    self.showView()
                    break
                default:
                    break
                }
            }
        } failure: { task, error in
            
        }
    }

  private func compareOnlineVersion(online:String,local:String) -> ComparisonResult {
        
        let onlineArray = online.components(separatedBy: ".") as NSArray
        let localArray = local.components(separatedBy: ".") as NSArray
        var points = 0
        
        while((onlineArray.count > points) || (localArray.count > points)){
            
            let v1 = onlineArray.count > points ? (onlineArray.object(at: points) as AnyObject).integerValue : 0
            let v2 = localArray.count > points ? (localArray.object(at: points) as AnyObject).integerValue : 0

            if (v1! < v2!) {
                return .orderedAscending
            }else if (v1! > v2!){
                return .orderedDescending
            }
            points += 1
        }
        
        return .orderedSame
    }

}

