//
//  XYLiquorCardDetailViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/25.
//

import UIKit

@objc enum LiquorCardDetailType : Int {
    ///所有详情
    case all = 0
    ///单个详情
    case single = 1
}

@objcMembers class XYLiquorCardDetailViewController: UIViewController {
    
    public var liquorCardDetailType : LiquorCardDetailType = .single

    private var mainView = UIView()
    private var topView = UIView()
    private var tableView = UITableView()
    private var bottomView = UIView()
    public var goodId : String = ""
    public var status : String = ""
    public var userId : String = ""
    public var userType : String = ""
    
    var dataArray = [LiquorCardDetailModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMainView()
        loadMainNetwork()
    }
    
    private func loadMainView(){
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dissMissView(_:))))
        
        mainView = UIView.init()
        mainView.backgroundColor = .white
        mainView.frame = CGRect(x: 0, y: deviceHeight-(deviceHeight * 0.7), width: deviceWidth, height: deviceHeight * 0.7)
        self.view.addSubview(mainView)
        loadMasksDynamicCorner(targetView: mainView, corners: [.topLeft,.topRight], cornerRadii: CGSize(width: 10, height: 10))

        topView = UIView.init()
        topView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: 50)
        mainView.addSubview(topView)
        
        let messageLabel = UILabel.init()
        messageLabel.loadMasksDynamicLabel(text: "库存明细", color: .hexString("#D40006"), textAlignment: .left, font: .systemFont(ofSize: 15), number: 1)
        messageLabel.frame = CGRect(x: 25, y: (topView.frame.size.height-15)/2, width: 65, height: 15)
        topView.addSubview(messageLabel)
        
        let topCanceButton = UIButton(type: .custom)
        topCanceButton.setImage(UIImage(named: "close_btn"), for: .normal)
        topCanceButton.frame = CGRect(x: topView.width-50, y: 0, width: 50, height: 50)
        topView.addSubview(topCanceButton)
        topCanceButton.addTarget(self, action: #selector(cilckButton(_:)), for: .touchUpInside)
        
        tableView = UITableView.init(frame: CGRect(x: 0, y:topView.frame.maxY , width: mainView.width, height: mainView.height-topView.frame.maxY-49-windowSafeAreaBottomMargin), style: .plain)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LiquorCardDetailTableViewCell.self, forCellReuseIdentifier: "LiquorCardDetailCell")
        mainView.addSubview(tableView)
        
        bottomView = UIView.init()
        bottomView.frame = CGRect(x: 0, y: tableView.frame.maxY, width: mainView.width, height: 49+windowSafeAreaBottomMargin)
        mainView.addSubview(bottomView)
        let bottomCanceButton = UIButton(type: .custom)
        bottomCanceButton.frame = CGRect(x: 15, y: 6, width: bottomView.width-30, height: 37)
        bottomCanceButton.loadMasksButton(title: "我知道了", color: .white, fontSize: 16)
        bottomCanceButton.backgroundColor = .hexString("#D40006")
        bottomView.addSubview(bottomCanceButton)
        bottomCanceButton.addTarget(self, action: #selector(cilckButton(_:)), for: .touchUpInside)
        loadMasksToBounds(targetView: bottomCanceButton, corners: 37/2)
    }
    
    ///点击背景退出界面
    @objc private func dissMissView(_ tap:UITapGestureRecognizer){
        
        if tap.state == .ended {
            
            let point = tap.location(in: nil)
            
            if !(mainView.point(inside: mainView.convert(point, from: mainView.window), with: nil)) {
                dismissView()
            }
        }
    }
    
    /// 绑卡网络请求
    private func loadMainNetwork(){
        
        let param = NSMutableDictionary()
        var url = ""
        if self.liquorCardDetailType == .all {
            url = L_cardGetBindRecordByUserId
        }else{
            url = L_cardGetMyStockUrl
            param.setValue(userType, forKey: "userType")
            param.setValue(status, forKey: "status")
            param.setValue(goodId, forKey: "goodId")
        }
        param.setValue(userId, forKey: "userId")
        
        XJHttpTool.post(url, method:GET, params: param, isToken: true) { [self] responseObj in
            
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                
                let listArray = data.object(forKey: "data") as! NSArray
                let modelArray =  LiquorCardDetailModel.mj_objectArray(withKeyValuesArray: listArray).copy() as? [LiquorCardDetailModel]
                dataArray = modelArray!
                
            }
            tableView.reloadData()
        } failure: {  errore in
            
        }
    }
    
    /// 退出界面按钮
    @objc private func cilckButton(_ sender:UIButton){
        
        dismissView()
    }
    
    //MARK: -界面退出
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - TableView模块
extension XYLiquorCardDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "LiquorCardDetailCell") as! LiquorCardDetailTableViewCell
        
        let dataModel = dataArray[indexPath.row]
        cell.model = dataModel
        cell.cellType = liquorCardDetailType.rawValue
        
        return cell
    }
}
