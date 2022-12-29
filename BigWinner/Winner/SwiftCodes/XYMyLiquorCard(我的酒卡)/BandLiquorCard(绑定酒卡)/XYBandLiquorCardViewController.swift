//
//  XYBandLiquorCardViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/25.
//

import UIKit

class XYBandLiquorCardViewController: LMHBaseViewController {
    
    var topView = UIView()
    var topImageView = UIImageView()
    var contentView = UIView()
    var bottomView = UIView()
    var bottomImageView = UIImageView()
    
    var accountTextField = UITextField()
    var passWordTextField = UITextField()
    var bindButton = UIButton()
    var cardModel = LiquorCardStyleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMainView()
        loadCardInfoNetwork()
    }
    
    private func loadMainView(){
        
        self.customNavBar.title = "绑定酒卡"
        self.customNavBar.wr_setRightButton(withTitle: "绑卡记录", titleColor: UIColor.hexString("#443415"))
        self.customNavBar.onClickRightButton = {[self] in
            
            let vc = XYLiquorCardDetailViewController.init()
            vc.userId = UserModel.sharedUserInfo().userId
            vc.liquorCardDetailType = .all
            vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(vc, animated: true)
           
        }
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .hexString("#F8F4F4");
        scrollView.frame = CGRect(x: 0, y: statusBarForHeight+44, width: deviceWidth, height: deviceHeight-statusBarForHeight-44)
        self.view.addSubview(scrollView)
        
        topView = UIView.init()
        topView.frame = CGRect(x: 0, y: 0, width: deviceWidth, height: 204)
//        topView.backgroundColor = .white;
        scrollView.addSubview(topView)
        
        topImageView = UIImageView.init()
        topImageView.frame = CGRect(x: 0, y: 0, width: topView.frame.size.width, height: topView.frame.size.height)
        //        topImageView.contentMode = .scaleAspectFill
        topView.addSubview(topImageView)
        
        contentView = UIView.init()
        contentView.frame = CGRect(x: 0, y: topView.frame.maxY-12, width: deviceWidth, height: 350)
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        loadMasksToBounds(targetView: contentView, corners: 10)
        loadContentSubView(view: contentView)
        
        bottomView = UIView.init()
        bottomView.frame = CGRect(x: 0, y: contentView.frame.maxY-12, width: deviceWidth, height: 182)
        bottomView.backgroundColor = .hexString("#F8F4F4");
        scrollView.insertSubview(bottomView, belowSubview: contentView)
        
        bottomImageView = UIImageView.init()
        bottomImageView.frame = CGRect(x: 0, y: 32, width: bottomView.frame.size.width, height: bottomView.frame.size.height-32)
        bottomImageView.contentMode = .scaleAspectFit
//        bottomImageView.image = UIImage(named: "bottomCard")
        bottomView.addSubview(bottomImageView)
        
        scrollView.contentSize = CGSize(width: deviceWidth, height: bottomView.frame.maxY)
    }
    ///点击背景退出键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view?.endEditing(true)
    }
    ///卡号与密码视图布局
    private func loadContentSubView(view:UIView){
        
        let contentTopLabel = UILabel.init()
        contentTopLabel.loadMasksDynamicLabel(text: "卡密绑定", color: .hexString("#443415"), textAlignment: .center, font: .systemFont(ofSize: 18), number: 1)
        contentTopLabel.frame = CGRect(x: 0, y: 21, width: view.width, height: 18)
        view.addSubview(contentTopLabel)
        
        let contentTipsLabel = UILabel.init()
        contentTipsLabel.loadMasksDynamicLabel(text: "请输入酒卡的卡号和密码进行绑定", color: .hexString("#999999"), textAlignment: .center, font: .systemFont(ofSize: 12), number: 1)
        contentTipsLabel.frame = CGRect(x: 0, y: contentTopLabel.frame.maxY+11, width: view.width, height: 18)
        view.addSubview(contentTipsLabel)
        
        let accountCardLabel = UILabel.init()
        accountCardLabel.loadMasksDynamicLabel(text: "卡号", color: .hexString("#443415"), textAlignment: .center, font: .systemFont(ofSize: 14), number: 1)
        accountCardLabel.frame = CGRect(x: 30, y: contentTipsLabel.frame.maxY+33, width: 35, height: 14)
        view.addSubview(accountCardLabel)
        
        accountTextField = UITextField.init()
        accountTextField.frame = CGRect(x: 30, y: accountCardLabel.frame.maxY+10, width: view.width-60, height: 44)
        accountTextField.keyboardType = .numberPad
        accountTextField.clearButtonMode = .always
        accountTextField.tag = 101
        accountTextField.backgroundColor = .hexString("#F2F2F2")
        accountTextField.textColor = .hexString("#443415")
        accountTextField.font = .systemFont(ofSize: 18)
        accountTextField.addTarget(self, action: #selector(changeTextFieldValue(textField:)), for: .editingChanged)
        view.addSubview(accountTextField)
        loadTextFieldBlankView(textField: accountTextField)
        
        let passWordCardLabel = UILabel.init()
        passWordCardLabel.loadMasksDynamicLabel(text: "密码", color: .hexString("#443415"), textAlignment: .center, font: .systemFont(ofSize: 14), number: 1)
        passWordCardLabel.frame = CGRect(x: 30, y: accountTextField.frame.maxY+15, width: 35, height: 14)
        view.addSubview(passWordCardLabel)
        
        passWordTextField = UITextField.init()
        passWordTextField.frame = CGRect(x: 30, y: passWordCardLabel.frame.maxY+10, width: view.width-60, height: 44)
        passWordTextField.keyboardType = .numberPad
        passWordTextField.clearButtonMode = .always
        passWordTextField.isSecureTextEntry = true
        passWordTextField.tag = 102
        passWordTextField.backgroundColor = .hexString("#F2F2F2")
        passWordTextField.textColor = .hexString("#443415")
        passWordTextField.font = .systemFont(ofSize: 18)
        view.addSubview(passWordTextField)
        passWordTextField.addTarget(self, action: #selector(changeTextFieldValue(textField:)), for: .editingChanged)
        loadTextFieldBlankView(textField: passWordTextField)
        
        bindButton = UIButton(type: .custom)
        bindButton.frame = CGRect(x: 30, y: passWordTextField.frame.maxY+36, width: view.frame.size.width-60, height: 47)
        bindButton.loadMasksButton(title: "绑定", color: .white, fontSize: 15)
        bindButton.isEnabled = false
        view.addSubview(bindButton)
        loadMasksToBounds(targetView: bindButton, corners: 47/2)
        bindButton.addTarget(self, action: #selector(bindCard(_:)), for: .touchUpInside)
    }
    
    ///button方法
    @objc private func bindCard(_ sender:UIButton){
        
        if accountTextField.text!.isEmpty {
            
            MBProgressHUD.showError("请输入卡号")
            
        }else if passWordTextField.text!.isEmpty{
            
            MBProgressHUD.showError("请输入密码")
            
        }else{
            
            self.view?.endEditing(true)
            loadMainNetwork()
        }
        
    }
    /// 绑卡网络请求
    private func loadMainNetwork(){
        
        let param = NSMutableDictionary()
        param.setValue(accountTextField.text, forKey: "cardNo")
        param.setValue(passWordTextField.text, forKey: "cardCode")
        
        XJHttpTool.post(L_cardBindUrl, method: POST, params: param, isToken: true) { [self] responseObj in
            
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                
                let tips = XYMessageTipsView()
                tips.showView()
                tips.buttonClickBlock = { [self]tag in
                    if tag == 101 {
                        accountTextField.text = ""
                        passWordTextField.text = ""
                    }else{
                        let vc = LLStorageController()
                        vc.popViewOption = .popRootView
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        } failure: { errore in
            
        }
    }
    
    /// 绑卡网络请求
    private func loadCardInfoNetwork(){
        
        let param = NSMutableDictionary()
        
        XJHttpTool.post(L_cardGetSetInfoUrl, method: GET, params: param, isToken: true) { [self] responseObj in
            
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                let dataList = data.object(forKey: "data") as! NSDictionary
                let model: LiquorCardStyleModel = LiquorCardStyleModel.mj_object(withKeyValues: dataList)
                loadDataSource(model: model)
            }
        } failure: { errore in
            
        }
    }
    private func loadDataSource(model:LiquorCardStyleModel){
        
        cardModel = model
        topImageView.sd_setImage(withUrlString: model.bgImages, placeholderImageName: "topCard")
        bottomImageView.sd_setImage(withUrlString: model.footImages, placeholderImageName: "bottomCard")
        bindButton.backgroundColor = .hexString(model.buttonDisColor)
        
    }

    
    ///TextField方法
    @objc private func changeTextFieldValue(textField:UITextField){
        
        if (textField.tag == 101) || (textField.tag == 102){
            
            if textField.text!.count > 0 {
                
                bindButton.isEnabled = true
                bindButton.backgroundColor = .hexString(cardModel.buttonEnColor)
            }else{
                
                bindButton.isEnabled = false
                bindButton.backgroundColor = .hexString(cardModel.buttonDisColor)
            }
        }
    }
}

