//
//  File.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/10/20.
//

import Foundation
import UIKit

//一键认证所需要的key值
let ATAuthSDKKey = "pSwlMF1p/3qRN9vlcGvi59EwIzqNFWtw3pC41gABjn2DaQODnYlFINw5yFcWdMsYFqJ5OncyoDKNkW9BXMxvcaWShqkbCAR6DvaxsXMXJONOLsTitjKd1ycZ1EuFn2f6g4jbZ45ADu+pHaVb8moDj12ff+soK3jkYOhed3Kg4/fDGkntreQYdrrk2bvkbRShP4W1+SC3Tm1KMVKe31dNHynjaO6Ss6KgIl2CoXf32NJzJ1EGe/XA/VE67iXxV4Gl2xByaGsXVdyECDkgrxUGQQ=="


@objcMembers class OneKeyLoginTools : NSObject{
    
    // MARK: - 一键登录授权
    class func OneKeyLoginAuthSDKInfo() {
        //一键登录授权
        TXCommonHandler.sharedInstance().setAuthSDKInfo(ATAuthSDKKey) { resultDic in
            let code = (resultDic[AnyHashable("resultCode")] as! String);
            if (code == "600000") {
                print("-------------授权成功-------------")
            }else{
                print("-------------授权失败-------------")
            }
        }
        //       检测当前环境是否能一键登录
//        TXCommonHandler.sharedInstance().checkEnvAvailable(with: .loginToken) { resultDic in
//            let code = (resultDic?[AnyHashable("resultCode")] as! String);
//            if (PNSCodeSuccess == code){
//                print("-------------当前支持一键登录-------------")
//            }else{
//
//                SMSLoginPage()
//            }
//
//        }
        
    }
    
    // MARK: - 进入⼀键登录界面
    class func JoinOneKeyLoginPage(view:UIViewController,joinOtherLoginView:Selector){
        
        TXCommonHandler.sharedInstance().accelerateLoginPage(withTimeout: 3) { resultDic in
            let code = (resultDic[AnyHashable("resultCode")] as! String);
            
            if (PNSCodeSuccess != code){
                
                SMSLoginPage()
                return
            }
            TXCommonHandler.sharedInstance().getLoginToken(withTimeout: 3, controller: view, model: CustomOneKeyLoginPage(target:view,selector:joinOtherLoginView)) { resultDic in
                let code = (resultDic[AnyHashable("resultCode")] as! String);
                if(PNSCodeLoginControllerPresentSuccess == code){
                    print("授权页拉起成功回调：\(resultDic)")
                }else if(("700000" == code) ||
                         ("700001" == code) ||
                         ("700002" == code) ||
                         ("700003" == code) ||
                         ("700006" == code) ||
                         ("700008" == code) ||
                         ("700007" == code)){
                    print("页面点击事件回调：\(resultDic)")
                    
                }
                else if((PNSCodeLoginControllerClickProtocol == code) ||
                        (PNSCodeLoginPrivacyAlertViewPrivacyContentClick == code)){
                    let privacyUrl = (resultDic["url"] as! String)
                    let privacyName = (resultDic["urlName"] as! String)
                    
                    
                    if (privacyName == "服务协议") || (privacyName == "隐私政策"){
                        let vc = LLWebViewController()
                        vc.isHiddenNavgationBar = true
                        if (privacyUrl == "yonghuxieyi") {
                            
                            vc.htmlStr = "AppServiceAgreement"
                        }else{
                            
                            vc.htmlStr = "AppPrivacyAgreement"
                        }
                        var navigationController = view.navigationController
                        if (view.presentedViewController != nil){
                            //找到授权页的导航控制器
                            navigationController = (view.presentedViewController as! UINavigationController)
                        }
                        navigationController?.pushViewController(vc, animated: true)
                    }else{
                        
                        let privacy = PrivacyWebViewController()
                        privacy.isHiddenNavgationBar = true
                        privacy.url = privacyUrl
                        privacy.urlName = privacyName
                        var navigationController = view.navigationController
                        if (view.presentedViewController != nil){
                            //找到授权页的导航控制器
                            navigationController = (view.presentedViewController as! UINavigationController)
                        }
                        navigationController?.pushViewController(privacy, animated: true)
                        
                    }
                    
                }else if(PNSCodeSuccess == code){
                    let tokenCode = (resultDic["token"] as! String);
                    print("\(tokenCode)")
                    OneKeyLoginTools.login(tonken: tokenCode)
                    
                }else{
                    SMSLoginPage()
                }
            }
        }
    }
    
    // MARK: - 登录
    class func login(tonken:String){
        if tonken.isEmpty {
            MBProgressHUD.showError("一键登录失败")
        }
        let timestamp = NSString.getNowTimeTimestamp3();
        
        let param = NSMutableDictionary()
        param.setValue(tonken, forKey: "mobileToken")
        param.setValue("5", forKey: "platform")
        param.setValue(timestamp, forKey: "timestamp")
        
        
        let url = "\(L_apioauthLogin)?n=5&client_id=admin&client_secret=123456&scope=all&grant_type=password"
        XJHttpTool.post(url, method: POST, params: param, isToken: false) { responseObj in
            print(responseObj)
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                let userData = data.object(forKey: "data") as! NSDictionary
                let isPhone = userData.object(forKey: "phone")
                UserDefaults.standard.set(isPhone, forKey: "phones")
                UserDefaults.standard.synchronize()
                let userInfo = data.object(forKey: "data") as? NSDictionary as? [AnyHashable: Any]
                UserModel.setUserInfoModelWithTokenDict(userInfo)
                AccessTool.saveUserInfo()
                UserModel.saveInfo()
                OneKeyLoginTools.signOutOneKeyLogin(completion: nil)
            }else{
                
                MBProgressHUD.showError("\(data.object(forKey: "msg") ?? "登录失败")")
            }
            
        } failure: { error in
            
        }
    }
    
    // MARK: - 退出一键登录界面
    class func signOutOneKeyLogin(completion: (() -> Void)?){
        
        DispatchQueue.main.async {
            TXCommonHandler.sharedInstance().cancelLoginVC(animated: true, complete: completion)
        }
        
    }
}

// MARK: - 自定义一键登录界面
private func CustomOneKeyLoginPage(target:Any,selector:Selector) -> TXCustomModel{
    
    let model = TXCustomModel.init()
    model.supportedInterfaceOrientations = UIInterfaceOrientationMask.portrait
    model.navColor = UIColor.clear
    model.navTitle = NSAttributedString.init(string: "")
    model.backgroundImage = UIImage(named:"oneKeyBG")!
    model.logoImage = UIImage(named: "oneKeyLogo")!
    model.numberFont = UIFont.systemFont(ofSize: 30)
    
    let carrierName = TXCommonUtils.getCurrentCarrierName()
    let string = "本次认证由\(carrierName ?? "")提供服务"
    model.sloganText = changeText(contentText: string,fontSize: 12, color: UIColor.black)
    
    model.loginBtnText = changeText(contentText: "本机号码一键登录", fontSize: 20, color: UIColor.white)
    var imageArray : [UIImage] = []
    imageArray.append(UIImage(named: "oneKeyLoginBtn")!)
    imageArray.append(UIImage(named: "oneKeyLoginBtn")!)
    imageArray.append(UIImage(named: "oneKeyLoginBtn")!)
    model.loginBtnBgImgs = imageArray;
    
    model.changeBtnIsHidden = true
    
    let otherButton = UIButton.init(type: .custom)
    otherButton.setTitle("其他号码登录", for: .normal)
    otherButton.setTitleColor(.lightGray, for: .normal)
    otherButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    otherButton.layer.masksToBounds = true
    otherButton.layer.cornerRadius = 20
    otherButton.layer.borderWidth = 1
    otherButton.addTarget(target, action: selector, for: .touchUpInside)
    otherButton.layer.borderColor = UIColor.lightGray.cgColor
    model.customViewBlock = {(superCustomView) in
        superCustomView.addSubview(otherButton)
    }
    
    model.privacyPreText = "若您的账号未注册，将为您自动注册。注册或登录即代表您同意我们的"
    model.privacyOne = ["服务协议","yonghuxieyi"]
    model.privacyTwo = ["隐私政策","yisizhengce"]
    model.privacyOperatorIndex = 3
    model.checkBoxIsHidden = true
    model.privacyVCIsCustomized = true
    model.privacyAlignment = .center
    
    var logoFrame = CGRect()
    var numberFrame = CGRect()
    var sloganFrame = CGRect()
    var loginBtnFrame = CGRect()


    //    logo背景frame设置
    model.logoFrameBlock = {(screenSize,superViewSize,frame) in
        
        let y = (superViewSize.height)*0.1
         logoFrame = CGRect(x: (superViewSize.width-100)/2, y:y < 81 ? y:80, width: 100, height: 100)
        return logoFrame
    }
    //    电话frame设置
    model.numberFrameBlock = {(screenSize,superViewSize,frame) in
                
        numberFrame = CGRect(x: (superViewSize.width-frame.size.width)/2, y: logoFrame.maxY+20, width: frame.size.width, height: frame.size.height)
        return numberFrame
    }
    //    sloganframe设置
    model.sloganFrameBlock = {(screenSize,superViewSize,frame) in
        
         sloganFrame = CGRect(x: (superViewSize.width-frame.size.width)/2, y: logoFrame.maxY+30+36, width: frame.size.width, height: frame.size.height)
        return sloganFrame
    }
    //    loginBtnframe设置
    model.loginBtnFrameBlock = {(screenSize,superViewSize,frame) in
        
         loginBtnFrame = CGRect(x: (superViewSize.width-(superViewSize.width-38-38))/2, y: sloganFrame.maxY+50, width: superViewSize.width-38-38, height: 50)
        return loginBtnFrame
    }
    //    切换到其他方式frame设置
    model.customViewLayoutBlock = {(screenSize,contentViewFrame,navFrame,titleBarFrame,logoFrame,sloganFrame,numberFrame,loginFrame,changeBtnFrame,privacyFrame) in
        
        otherButton.frame = CGRect(x: (screenSize.width-120)/2, y: privacyFrame.minY-80, width: 120, height: 40)
    }
    
    
    return model
}
// MARK: - 富文本
private func changeText(contentText:String,fontSize:CGFloat,color:UIColor)->NSMutableAttributedString{
    
    let att = NSMutableAttributedString.init(string: contentText)
    
    let textContentRange = NSRange(location: 0, length: contentText.count)
    att.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize), range: textContentRange)
    att.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: textContentRange)
    
    return att
}

// MARK: - 进入短信登录界面
private func SMSLoginPage(){
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    delegate.showLoginVc()
}
