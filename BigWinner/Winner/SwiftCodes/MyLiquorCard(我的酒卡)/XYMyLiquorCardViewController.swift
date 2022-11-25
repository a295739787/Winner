//
//  XYMyLiquorCardViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/24.
//

import UIKit

class XYMyLiquorCardViewController: LMHBaseViewController {
    
    private var tableView = LLBaseTableView()
    private var bottomView = UIView()
    private var bindCardButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        loadMainView()
    }
    
    private func loadMainView(){
        self.customNavBar.title = "我的酒卡"
        
        tableView = LLBaseTableView.init(frame: CGRect(x: 0, y:statusBarForHeight+44 , width: deviceWidth, height: deviceHeight-(statusBarForHeight+44)-49-windowSafeAreaBottomMargin), style: .plain)
        tableView.backgroundColor = .hexString("#F0EFED")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyLiquorCardTableViewCell.self, forCellReuseIdentifier: "MyLiquorCardCell")
        self.view.addSubview(tableView)
        
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




