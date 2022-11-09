//
//  StockDetaileViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/7.
//

import UIKit

class StockDetaileViewController: LMHBaseViewController {
    
    var topView = UIView()
    var topImageView = UIImageView()
    var topGoddsInfoLabel = UILabel()
    var topGoodsPriceLabel = UILabel()
    var topGoodsVolumeLabel = UILabel()
    var topGoodsKuCunLabel = UILabel()
    var topGoodslineView = UIView()
    var topGoodsDaiRuKuLabel = UILabel()
    var topGoodsShopButton = UIButton()
    
    ///库存数据切换
    var changeKuCunView = UIView()
    var changeKuCunButton = UIButton()
    var changeDaiRuKuButton = UIButton()
    var changeLineView = UIView()
    
    /// 数据列表
    var tableView = UITableView()
    var dataArray = NSMutableArray()
    var page  = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customNavBar.title = "库存明细"
        self.view.backgroundColor = UIColor.hexString("#F0EFED")
        loadSubMainView()
    }
    
    /// 初始化界面
    private func loadSubMainView(){
        let y =  UIApplication.shared.statusBarFrame.height+44
        
        topView = UIView.init()
        topView.frame = CGRect(x: 10, y: y+10, width: UIScreen.main.bounds.width-20, height: 128)
        topView.backgroundColor = .white
        topView.layer.masksToBounds = true
        topView.layer.cornerRadius = 5
        self.view.addSubview(topView)
        
        topImageView = UIImageView.init()
        topImageView.frame = CGRect(x: 7, y: (topView.frame.size.height-80)/2, width: 80, height: 80)
        topImageView.image = UIImage(named: "headimages")
        topImageView.contentMode = .scaleAspectFit
        topView.addSubview(topImageView)
        
        topGoddsInfoLabel = UILabel.init()
        topGoddsInfoLabel.frame = CGRect(x: topImageView.frame.maxX+10, y: 13, width: (topView.frame.size.width-topImageView.frame.maxX-20), height: 30)
        topGoddsInfoLabel.numberOfLines = 2
        topGoddsInfoLabel.font = UIFont.systemFont(ofSize: 13)
        topGoddsInfoLabel.textColor = UIColor.hexString("#443415")
        topGoddsInfoLabel.textAlignment = .left
        topGoddsInfoLabel.text = "大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒"
        topView.addSubview(topGoddsInfoLabel)
        
        topGoodsPriceLabel = UILabel.init()
        topGoodsPriceLabel.frame = CGRect(x: topImageView.frame.maxX+10, y: topGoddsInfoLabel.frame.maxY+10, width: 120, height: 14)
        topGoodsPriceLabel.textAlignment = .left
        topGoodsPriceLabel.textColor = UIColor.hexString("#D40006")
        topGoodsPriceLabel.font = UIFont.systemFont(ofSize: 15)
        topGoodsPriceLabel.text = "¥ 139.00"
        topView.addSubview(topGoodsPriceLabel)
        
        topGoodsVolumeLabel = UILabel.init()
        topGoodsVolumeLabel.frame = CGRect(x: topImageView.frame.maxX+12, y: topGoodsPriceLabel.frame.maxY+10, width: 120, height: 12)
        topGoodsVolumeLabel.textAlignment = .left
        topGoodsVolumeLabel.textColor = UIColor.hexString("#999999")
        topGoodsVolumeLabel.font = UIFont.systemFont(ofSize: 12)
        topGoodsVolumeLabel.text = "1支(500ml)/52°"
        topView.addSubview(topGoodsVolumeLabel)
        
        topGoodsKuCunLabel = UILabel.init()
        topGoodsKuCunLabel.frame = CGRect(x: topImageView.frame.maxX+11, y: topGoodsVolumeLabel.frame.maxY+11, width: 70, height: 13)
        topGoodsKuCunLabel.textAlignment = .left
        topGoodsKuCunLabel.textColor = UIColor.hexString("#999999")
        topGoodsKuCunLabel.font = UIFont.systemFont(ofSize: 14)
        topGoodsKuCunLabel.text = "库存: 3"
        topView.addSubview(topGoodsKuCunLabel)
        
        topGoodslineView = UIView.init()
        topGoodslineView.frame = CGRect(x: topGoodsKuCunLabel.frame.maxX+5, y: topGoodsVolumeLabel.frame.maxY+10, width: 1, height: 15)
        topGoodslineView.backgroundColor = UIColor.hexString("#CCCCCC")
        topView.addSubview(topGoodslineView)
        
        topGoodsDaiRuKuLabel = UILabel.init()
        topGoodsDaiRuKuLabel.frame = CGRect(x: topGoodslineView.frame.maxX+5, y: topGoodsVolumeLabel.frame.maxY+11, width: 80, height: 13)
        topGoodsDaiRuKuLabel.textAlignment = .right
        topGoodsDaiRuKuLabel.textColor = UIColor.hexString("#999999")
        topGoodsDaiRuKuLabel.font = UIFont.systemFont(ofSize: 14)
        topGoodsDaiRuKuLabel.text = "待入库: 0"
        topView.addSubview(topGoodsDaiRuKuLabel)
        
        topGoodsShopButton = UIButton.init(type: .custom)
        topGoodsShopButton.frame = CGRect(x: topView.frame.size.width-73, y: topView.frame.size.height-60, width: 60, height: 30)
        topGoodsShopButton.setBackgroundImage(UIImage(named: "topGoodsShopButton"), for: .normal)
        topGoodsShopButton.setTitle("去采购", for: .normal)
        topGoodsShopButton.setTitleColor(UIColor.hexString("#FFFFFF"), for: .normal)
        topGoodsShopButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        topView.addSubview(topGoodsShopButton)
        
        changeKuCunView = UIView.init()
        changeKuCunView.frame = CGRect(x: 10, y: topView.frame.maxY+10, width: UIScreen.main.bounds.width-20, height: 43)
        changeKuCunView.backgroundColor = .white
        self.view.addSubview(changeKuCunView)
        loadMasksTopLeftOrRight(view: changeKuCunView)
        
        changeKuCunButton = UIButton.init()
        changeKuCunButton.frame = CGRect(x: 0, y: 0, width: changeKuCunView.frame.size.width/2, height: 40)
        changeKuCunButton.tag = 101
        changeKuCunButton.setTitle("库存记录", for: .normal)
        changeKuCunButton.setTitleColor(UIColor.hexString("#D40006"), for: .normal)
        changeKuCunButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        changeKuCunButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        changeKuCunView.addSubview(changeKuCunButton)
        
        changeDaiRuKuButton = UIButton.init()
        changeDaiRuKuButton.frame = CGRect(x: changeKuCunButton.frame.maxX, y: 0, width: changeKuCunView.frame.size.width/2, height: 40)
        changeDaiRuKuButton.tag = 102
        changeDaiRuKuButton.setTitle("待入库记录", for: .normal)
        changeDaiRuKuButton.setTitleColor(UIColor.hexString("#443415"), for: .normal)
        changeDaiRuKuButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        changeDaiRuKuButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        changeKuCunView.addSubview(changeDaiRuKuButton)
        
        changeLineView = UIView.init()
        changeLineView.frame = CGRect(x: ((changeKuCunView.frame.size.width/2)-24)/2, y: changeKuCunButton.frame.maxY, width: 24, height: 2)
        changeLineView.layer.masksToBounds = true
        changeLineView.layer.cornerRadius = 1.0
        changeLineView.backgroundColor = UIColor.hexString("#D40006")
        changeKuCunView.addSubview(changeLineView)
        
        
        tableView = UITableView.init(frame: CGRect(x: 10, y:changeKuCunView.frame.maxY , width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height-changeKuCunView.frame.maxY), style: .plain)
        tableView.backgroundColor = UIColor.hexString("#F0EFED")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: "StockCell")
        self.view.addSubview(tableView)
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(header))
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(footer))

    }
    @objc func header() {
        page = 1
    }
    @objc func footer() {
        page += 1
    }
    
    /// 网络请求
    private func loadMainNetwork(){
        
        let param = NSMutableDictionary()
        
        XJHttpTool.posts("", method: GET, params: param, isToken: true) { [self] responseObj in
            
            if (page == 1){
                dataArray.removeAllObjects()
            }
            
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                
            }
            
            
            tableView.reloadData()
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
        } failure: { [self] errore in
            tableView.mj_header?.endRefreshing()
            tableView.mj_footer?.endRefreshing()
            
        }

    }
    
    ///切左右上圆角
    private func loadMasksTopLeftOrRight(view:UIView){
        
        let path = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: [.topRight,.topLeft], cornerRadii: CGSize(width: 5, height: 5))
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
        view.layer.mask = shapeLayer
        
    }

    
    /// 切换数据
    @objc private func buttonClick(_ sender:UIButton){
        
        if sender.tag == 101 {
            
            changeKuCunButton.setTitleColor(UIColor.hexString("#D40006"), for: .normal)
            changeDaiRuKuButton.setTitleColor(UIColor.hexString("#443415"), for: .normal)
        }else{
            changeKuCunButton.setTitleColor(UIColor.hexString("#443415"), for: .normal)
            changeDaiRuKuButton.setTitleColor(UIColor.hexString("#D40006"), for: .normal)
        }
    
        UIView.animate(withDuration: 0.3) { [self] in
            
            changeLineView.frame.origin.x = sender.center.x-12
        }
        
    }
    
}

//MARK: - tableview模块
extension StockDetaileViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "StockCell") as! StockTableViewCell
        
        return cell
    }
    
    
}
