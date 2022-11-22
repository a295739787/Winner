//
//  XYShopDetailViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/22.
//

import UIKit

@objcMembers class XYShopDetailViewController: LMHBaseViewController, TZImagePickerControllerDelegate ,UIImagePickerControllerDelegate{
    
    
    private var tableView = UITableView()
    
    var dataArrar = [[String:Any]]()
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
        
        dataArrar = [["title":"店铺名称","show":true],
                     ["title":"地址","show":false],
                     ["title":"手机号码","show":false],
                     ["title":"手机号码","show":false]]
        
    }
}

extension XYShopDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArrar.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 67
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = XYShopDetailHeaderView.init()
        headerView.selectIconButton.addTarget(self, action: #selector(selectPhotoImage(sender:)), for: .touchUpInside)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ShopDetailCell") as! XYShopDetailTableViewCell
        let dic = dataArrar[indexPath.row]
        cell.titleLabel.text = (dic["title"] as! String)
        cell.showMoreImage = dic["show"] as! Bool

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            let dic = dataArrar[indexPath.row]

            let changeVC = LLPersonalChangeVC.init()
            let nickName = (dic["title"] as! String)
            changeVC.nameStr = nickName;
            changeVC.changeSuccessBlock = {changeText in
                print(changeText)
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
        imagePickerVc?.didFinishPickingPhotosHandle = { photos,assets,isSelectOriginalPhoto in
      
            if (photos?[0] == nil) {
                return
            }
        }

        imagePickerVc?.navigationBar.barTintColor = .hexString("#D53329");
        self.present(imagePickerVc!, animated: true)
    }
    
}

