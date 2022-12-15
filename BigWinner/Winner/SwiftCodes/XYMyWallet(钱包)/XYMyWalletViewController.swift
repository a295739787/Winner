//
//  XYMyWalletViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/15.
//

import UIKit

@objc enum MyWalletType : Int {
    ///余额钱包
    case normal = 0
    ///消费钱包
    case consume = 1
}

@objcMembers class XYMyWalletViewController: LMHBaseViewController {
    
    public var walletType : MyWalletType = .normal
    
    private var walletView = XYMyWalletHeaderView()
    
    private var titleView = XYMyWalletTitleHeaderView()
    
    private var tableView = LLBaseTableView()
    
    private var page = 1
    
    var dataArray = [WalletIncomeAndRecoverModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hexString("#F0EFED")
        
        loadSubMainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserWalletNetwork()
        loadUserWalletListNetwork()
    }
    
    /// 初始化界面
    private func loadSubMainView(){
        
        if walletType == .normal {
            self.customNavBar.title = "我的钱包"
        }else{
            self.customNavBar.title = "消费红包"
        }
        let y =  UIApplication.shared.statusBarFrame.height+44
        
        walletView = XYMyWalletHeaderView.init()
        walletView.type = walletType
        walletView.button.addTarget(self, action: #selector(buttonCilck(sender:)), for: .touchUpInside)
        walletView.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 165)
        self.view.addSubview(walletView)
        
        titleView = XYMyWalletTitleHeaderView.init()
        titleView.frame = CGRect(x: 0, y: walletView.frame.maxY+10, width: UIScreen.main.bounds.width, height: 50)
        self.view.addSubview(titleView)
        
        tableView = LLBaseTableView.init(frame: CGRect(x: 0, y:titleView.frame.maxY , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-titleView.frame.maxY), style: .plain)
        tableView.backgroundColor = UIColor.hexString("#F0EFED")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(XYMyWalletTableViewCell.self, forCellReuseIdentifier: "WalletCell")
        self.view.addSubview(tableView)
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(header))
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(footer))
    }
    
    ///上拉刷新
    @objc private func header(){
        
        tableView.mj_footer?.isHidden = false
        page = 1
        loadUserWalletListNetwork()
        loadUserWalletNetwork()
    }
    
    ///下拉加载
    @objc private func footer(){
        
        page += 1
        loadUserWalletListNetwork()
    }
    
    //MARK: - 尾视图跳转客服
    @objc private func buttonCilck(sender:UIButton){
        
        if walletType == .normal {
            let drawVC = LLWalletDrawController()
            drawVC.clickTap = {
                self.page = 1
                //                self.loadUserWalletListNetwork()
            }
            self.navigationController?.pushViewController(drawVC, animated: true)
        }else{
            
            let thirdVC = LLTabbarViewController()
            thirdVC.selectedIndex = 1
            UIApplication.shared.keyWindow?.rootViewController = thirdVC
        }
        
    }
    
    private func loadUserWalletNetwork(){
        
        let param = NSMutableDictionary()
        XJHttpTool.post(L_getUserWallet, method: GET, params: param, isToken: true) { [self] responseObj in
            
            let data = responseObj as! NSDictionary
            let msg = data.object(forKey: "msg") as? String
            if msg == "Success" {
                let list = data.object(forKey: "data") as! NSDictionary
                let model: WalletOrConsumeModel = WalletOrConsumeModel.mj_object(withKeyValues: list)
                walletView.model = model
            }
        } failure: { errore in
            
        }
    }
    
    private func loadUserWalletListNetwork(){
        
        var type = "1"
        if walletType == .normal {
            type = "1"
        }else{
            type = "2"
        }
        
        let param = NSMutableDictionary()
        param.setValue(type, forKey: "type")
        param.setValue(page, forKey: "currentPage")
        param.setValue("10", forKey: "pageSize")
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        XJHttpTool.post(L_getRecord, method: GET, params: param, isToken: true) { [self] responseObj in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let data = responseObj as! NSDictionary
            let msg = data.object(forKey: "msg") as? String
            if msg == "Success" {
                let dataList = data.object(forKey: "data") as! NSDictionary
                let listArray = dataList.object(forKey: "list") as! NSArray
                let modelArray =  WalletIncomeAndRecoverModel.mj_objectArray(withKeyValuesArray: listArray).copy() as? [WalletIncomeAndRecoverModel]
                
                if page == 1 {
                    dataArray = modelArray ?? []
                }else{
                    dataArray += modelArray ?? []
                }
                
                if listArray.count < 10 {
                    tableView.mj_footer?.isHidden = true
                    tableView.mj_footer?.resetNoMoreData()
                }else{
                    tableView.mj_footer?.isHidden = false
                }
            }
            
            if(dataArray.count <= 0){
                tableView.showEmpty(withType: 0, imagename: "", noticename: "暂无数据")
            }else{
                tableView.removeEmpty()
            }
            
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
            tableView.reloadData()
        } failure: { [self] errore in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
        }
    }
    
}

//MARK: - tableview模块
extension XYMyWalletViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if walletType == .normal {
            
            let dataModel = dataArray[indexPath.row]
            if dataModel.withdrawalMsg.isEmpty {
                return 60
            }else{
                return 95
            }
            
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "WalletCell") as! XYMyWalletTableViewCell
        
        let dataModel = dataArray[indexPath.row]
        
        if walletType == .normal {
            
            if dataModel.withdrawalMsg.isEmpty {
                
                cell.messageView.isHidden = true
            }else{
                
                cell.messageView.isHidden = false
            }
        }else{
            cell.messageView.isHidden = true
        }
        
        cell.model = dataModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataModel = dataArray[indexPath.row]
        let vc = XYDealDetailViewController.init()
        vc.urlId = dataModel.id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
