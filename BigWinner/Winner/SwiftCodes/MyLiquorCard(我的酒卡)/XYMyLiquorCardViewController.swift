//
//  XYMyLiquorCardViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/24.
//

import UIKit

@objc public enum MyLiquorCardOption : Int{
    
    case popView = 0
    case popRootView = 1
}

@objcMembers class XYMyLiquorCardViewController: LMHBaseViewController {
    
    private var tableView = LLBaseTableView()
    private var bottomView = UIView()
    private var bindCardButton = UIButton()
    public var popViewOption : MyLiquorCardOption = .popView
    
    var dataArray = [LiquorCardModel]()
    private var page = 1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMainNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        loadMainView()
    }
    
    private func loadMainView(){
        self.customNavBar.title = "我的酒卡"
        self.customNavBar.onClickLeftButton = { [self] in
            
            if popViewOption == .popView {
                
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        tableView = LLBaseTableView.init(frame: CGRect(x: 0, y:statusBarForHeight+44 , width: deviceWidth, height: deviceHeight-(statusBarForHeight+44)-49-windowSafeAreaBottomMargin), style: .plain)
        tableView.backgroundColor = .hexString("#F0EFED")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyLiquorCardTableViewCell.self, forCellReuseIdentifier: "MyLiquorCardCell")
        self.view.addSubview(tableView)
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(header))
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(footer))
        
        bottomView = UIView.init()
        bottomView.frame = CGRect(x: 0, y: tableView.frame.maxY, width: deviceWidth, height: 49+windowSafeAreaBottomMargin)
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        
        bindCardButton = UIButton(type: .custom)
        bindCardButton.frame = CGRect(x: 15, y: 6, width: bottomView.frame.size.width-30, height: 37)
        bindCardButton.setTitle("去绑卡", for: .normal)
        bindCardButton.setTitleColor(.white, for: .normal)
        bindCardButton.backgroundColor = .hexString("#D40006")
        loadMasksToBounds(targetView: bindCardButton, corners: 37/2)
        bottomView.addSubview(bindCardButton)
        
    }
    
    ///上拉刷新
    @objc private func header(){
        
        tableView.mj_footer?.isHidden = false
        page = 1
        loadMainNetwork()
    }
    
    ///下拉加载
    @objc private func footer(){
        
        page += 1
        loadMainNetwork()
    }
    
    /// 酒卡列表网络请求
    private func loadMainNetwork(){
        
        let param = NSMutableDictionary()
        param.setValue("1", forKey: "cardStatus")
        param.setValue(page, forKey: "currentPage")
        param.setValue("10", forKey: "pageSize")
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        XJHttpTool.post(L_cardGetListUrl, method: GET, params: param, isToken: true) { [self] responseObj in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                
                let dataList = data.object(forKey: "data") as! NSDictionary
                let listArray = dataList.object(forKey: "list") as! NSArray
                let modelArray =  LiquorCardModel.mj_objectArray(withKeyValuesArray: listArray).copy() as? [LiquorCardModel]
                
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
//MARK: - TableView模块
extension XYMyLiquorCardViewController:UITableViewDelegate,UITableViewDataSource,MyLiquorCardDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init()
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MyLiquorCardCell") as! MyLiquorCardTableViewCell
        cell.delegate = self
        return cell
    }
    
    func clickButton(any: AnyObject, tag: Int) {
        
        if tag == 101 {
            
            let vc = XYLiquorCardDetailViewController.init()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
            
        }else{
            
        }
    }
}




