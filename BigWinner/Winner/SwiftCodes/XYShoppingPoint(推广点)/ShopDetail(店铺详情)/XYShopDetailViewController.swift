//
//  XYShopDetailViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/22.
//

import UIKit

@objcMembers class XYShopDetailViewController: LMHBaseViewController, TZImagePickerControllerDelegate ,UIImagePickerControllerDelegate{
    
    
    private var tableView = UITableView()
    var personalModel = LLPersonalModel()
    var dataArray = [[String:Any]]()
    var imageArray = NSMutableArray()
    var headerImgStr : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMainView()
    }
    
    private func loadMainView(){
        self.customNavBar.title = "店铺详情"
        self.view.backgroundColor = .white
        
        tableView = LLBaseTableView.init(frame: CGRect(x: 0, y:statusBarForHeight+44 , width: deviceWidth, height: deviceHeight-(statusBarForHeight+44)), style: .grouped)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(XYShopDetailTableViewCell.self, forCellReuseIdentifier: "ShopDetailCell")
        self.view.addSubview(tableView)
        
        let address = "\(personalModel.shopProvince)\(personalModel.shopCity)\(personalModel.shopArea)\(personalModel.shopAddress)"
        
        var realName = "未实名"
        if !personalModel.realName.isEmpty {
            realName = "实名"
        }
        dataArray = [["title":"店铺名称","show":true,"content":personalModel.shopName],
                     ["title":"地址","show":false,"content":address],
                     ["title":"手机号码","show":false,"content":personalModel.shopTelePhone],
                     ["title":"实名认证","show":false,"content":realName]]
        
    }
}

extension XYShopDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 67
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = XYShopDetailHeaderView.init()
        
        if !personalModel.shopPhoto.isEmpty {
            headerView.iconURL = personalModel.shopPhoto
        }
        if !headerImgStr.isEmpty {
            headerView.iconURL = headerImgStr
        }
        
        headerView.selectIconButton.addTarget(self, action: #selector(selectPhotoImage(sender:)), for: .touchUpInside)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ShopDetailCell") as! XYShopDetailTableViewCell
        let dic = dataArray[indexPath.row]
        cell.titleLabel.text = (dic["title"] as! String)
        cell.showMoreImage = dic["show"] as! Bool
        cell.contentLabel.text = (dic["content"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            let dic = dataArray[indexPath.row]
            
            let changeVC = LLPersonalChangeVC.init()
            let nickName = (dic["content"] as! String)
            changeVC.nameStr = nickName;
            changeVC.titleStr = "修改店铺名称"
            changeVC.userType = "2"
            changeVC.changeSuccessBlock = {[self] changeText in
                personalModel.shopName = changeText
                dataArray[0] = ["title":"店铺名称","show":true,"content":personalModel.shopName]
                tableView.reloadData()
            }
            self.navigationController?.pushViewController(changeVC, animated: true)
        }
    }
    
    ///点击选择头像
    @objc func selectPhotoImage(sender:UIButton){
        
        let imagePickerVc = TZImagePickerController(maxImagesCount: 1, delegate: self)
        imagePickerVc?.allowPickingVideo = false
        imagePickerVc?.hideWhenCanNotSelect = true
        imagePickerVc?.oKButtonTitleColorNormal = .white
        imagePickerVc?.barItemTextColor = .black
        imagePickerVc?.iconThemeColor = .black
        imagePickerVc?.showSelectBtn = false
        imagePickerVc?.allowCrop = true
        imagePickerVc?.naviTitleColor = .black
        imagePickerVc?.oKButtonTitleColorDisabled = .black
        imagePickerVc?.didFinishPickingPhotosHandle = { [self] photos,assets,isSelectOriginalPhoto in
            
            if (photos?[0] == nil) {
                return
            }
            
            updateShopIcon(photo: photos![0])
        }
        
        imagePickerVc?.navigationBar.barTintColor = .hexString("#D53329");
        self.present(imagePickerVc!, animated: true)
    }
    /// 上传图片到服务器
    private func updateShopIcon(photo:UIImage){
        
        let url = "\(apiQiUrl)\(L_apifileUploaderimages)"
        let param = NSDictionary()
        XJHttpTool.upload(withImageArr: photo, url: url, filename: "", name: "", mimeType: "", parameters: param as! [AnyHashable : Any]) { bytesWritten, totalBytesWritten in
            
        } success: { [self] response in
            let data = response as! NSDictionary
            let msg = data.object(forKey: "msg") as? String
            if msg == "Success" {
                let dic = data.object(forKey: "data") as! NSDictionary
                let name = dic["name"] as! String
                updateShopInfoUtl(pic: name)
            }
            
        } fail: { error in
            
        }
    }
    
    /// 提交头像修改申请
    private func updateShopInfoUtl(pic:String){
        
        let params = NSMutableDictionary()
        params.setValue(pic, forKey: "value")
        params.setValue("2", forKey: "type")
        params.setValue("2", forKey: "userType")
        
        XJHttpTool.post(L_updateUserById, method: POST, params: params, isToken: true) { [self] responseObj in
            
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                
                headerImgStr = pic
                tableView.reloadData()
            }
        } failure: { errore in
            
        }        
    }
}

