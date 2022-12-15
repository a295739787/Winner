//
//  XYDealDetailViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/17.
//

import UIKit

class XYDealDetailViewController: LMHBaseViewController {
    
    private var tableView = UITableView()
    
    var dealPrice = ""
    var dealHexString = ""
    var urlId = ""
    var dataArrar = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        loadMainView()
        loadMainNetwork()
    }
    
    private func loadMainView(){
        
        self.customNavBar.title = "交易详情"
        
        tableView = UITableView.init(frame: CGRect(x: 0, y:statusBarForHeight+44 , width: deviceWidth, height: deviceHeight-(statusBarForHeight+44)), style: .grouped)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DealDetailTableViewCell.self, forCellReuseIdentifier: "DealDetailCell")
        self.view.addSubview(tableView)
      }
    
    private func loadMainNetwork(){
        
        let param = NSMutableDictionary()
        param.setValue(urlId, forKey: "urlId")
        
        XJHttpTool.post(L_getUserRecordByrId, method: GET, params: param, isToken: true) { [self] responseObj in
    
            let data = responseObj as! NSDictionary
            let msg = data.object(forKey: "msg") as? String
            if msg == "Success" {
                let dataList = data.object(forKey: "data") as! NSDictionary
                let model: WalletIncomeAndRecoverModel = WalletIncomeAndRecoverModel.mj_object(withKeyValues: dataList)
                loadDataSource(model: model)
            }
            
        } failure: { errore in
            
        }
    }
    
    private func loadDataSource(model:WalletIncomeAndRecoverModel){
        
        let price = String(format: "%.2f", model.price)
        dealPrice = "\(price)"
        var msg = "成功"
        var colorHex = "#443415"
        if !model.withdrawalMsg.isEmpty {
            msg = model.withdrawalMsg
            colorHex = "#CA363B"
        }
        dataArrar = [["key":"交易类型","value":WalletType[model.type]!,"color":"#443415"],["key":"交易金额","value":dealPrice,"color":"#443415"],["key":"交易时间","value":model.createTime,"color":"#443415"],["key":"交易单号","value":model.orderNo,"color":"#443415"],["key":"交易状态","value":msg ,"color":colorHex]]
        
        tableView.reloadData()
    }
 
}

extension XYDealDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArrar.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dic = dataArrar[indexPath.row]
        let value = dic["value"]
        var height  = 0.0
        if ((value?.isEmpty) != nil) {
            height = labelForHeight(width:  self.view.frame.size.width-108-17-44, font: 14.0, string: value! as NSString)
        }
        return 20+height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 156
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = DealDetailHeaderView.init()
        headerView.moneyLabel.text = dealPrice
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = DealDetailFootView.init()
        footerView.serviceButton.addTarget(self, action: #selector(footderButtonCilck(sender:)), for: .touchUpInside)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "DealDetailCell") as! DealDetailTableViewCell
        let dic = dataArrar[indexPath.row]
        cell.keyLabel.text = dic["key"]
        cell.valueLabel.text = dic["value"]
        cell.valueLabel.textColor = .hexString(dic["color"])
        
        return cell
    }
    
    //MARK: - 尾视图跳转客服
    @objc private func footderButtonCilck(sender:UIButton){
        let serviceVC = XYServiceTipsViewController()
        serviceVC.pushBlock = {  view in
            self.navigationController?.pushViewController(view, animated: true)
        }
        serviceVC.modalTransitionStyle = .coverVertical
        serviceVC.modalPresentationStyle = .overFullScreen
        self.present(serviceVC, animated: true)
    }
    
}
