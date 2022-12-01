//
//  StockDetaileViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/7.
//

import UIKit

@objcMembers class XYStockDetaileViewController: LMHBaseViewController {
    
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
    var tableView = LLBaseTableView()
    var dataArray = [StockModel]()
    private var status : String = "1"
    private var userType : String = ""
    public var goodModel = LLGoodModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customNavBar.title = "库存明细"
        self.view.backgroundColor = UIColor.hexString("#F0EFED")
        loadSubMainView()
        loadMainNetwork()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGoodsInfo()
    }
    /// 初始化界面
    private func loadSubMainView(){
        let y =  UIApplication.shared.statusBarFrame.height+44
        
        topView = UIView.init()
        topView.frame = CGRect(x: 10, y: y+10, width: UIScreen.main.bounds.width-20, height: 140)
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
        topGoddsInfoLabel.frame = CGRect(x: topImageView.frame.maxX+10, y: 13, width: (topView.frame.size.width-topImageView.frame.maxX-20), height: 40)
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
        topGoodsVolumeLabel.frame = CGRect(x: topImageView.frame.maxX+12, y: topGoodsPriceLabel.frame.maxY+10, width: topView.frame.size.width-topImageView.frame.maxX-12-80, height: 12)
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
        topGoodsShopButton.setBackgroundImage(UIImage(named: "topGoodsShopButton"), for: .highlighted)
        topGoodsShopButton.setTitle("去采购", for: .normal)
        topGoodsShopButton.setTitleColor(UIColor.hexString("#FFFFFF"), for: .normal)
        topGoodsShopButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        topGoodsShopButton.addTarget(self, action: #selector(joinShopping(_:)), for: .touchUpInside)
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
        
        
        tableView = LLBaseTableView.init(frame: CGRect(x: 10, y:changeKuCunView.frame.maxY , width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height-changeKuCunView.frame.maxY), style: .plain)
        tableView.backgroundColor = UIColor.hexString("#F0EFED")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(XYStockTableViewCell.self, forCellReuseIdentifier: "StockCell")
        self.view.addSubview(tableView)
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(header))
        
        topImageView.sd_setImage(withUrlString: goodModel.coverImage, placeholderImageName: morenpic)
        topGoddsInfoLabel.text = goodModel.name
        topGoodsPriceLabel.attributedText = self.getAttribuStr(withStrings: ["￥","\(goodModel.purchasePrice)"], fonts: [UIFont.systemFont(ofSize: 12),UIFont.systemFont(ofSize: 16)], colors: [UIColor.hexString("#D40006"),UIColor.hexString("#D40006")])
        topGoodsVolumeLabel.text = goodModel.specsValName
    }
    
    /// 网络请求
    private func loadMainNetwork(){
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if (delegate.status == .peisong) {
            userType = "3"
            topGoodsShopButton.isHidden = false
        }else{
            userType = "2"
            topGoodsShopButton.isHidden = true
        }
        let userId = UserModel.sharedUserInfo().userId
        let param = NSMutableDictionary()
        param.setValue(status, forKey: "status")
        param.setValue(userId, forKey: "userId")
        param.setValue(userType, forKey: "userType")
        param.setValue(goodModel.goodsId, forKey: "goodId")
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        XJHttpTool.post(L_getUserStockDetail, method: GET, params: param, isToken: true) { [self] responseObj in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let data = responseObj as! NSDictionary
            let msg = data.object(forKey: "msg") as? String
            if msg == "Success" {
                let listArray = data.object(forKey: "data") as! NSArray
                let modelArray =  StockModel.mj_objectArray(withKeyValuesArray: listArray).copy() as? [StockModel]
                dataArray = modelArray!
                
            }
            
            if(dataArray.count <= 0){
                tableView.showEmpty(withType: 0, imagename: "", noticename: "暂无数据")
            }else{
                tableView.removeEmpty()
            }
            
            tableView.mj_header?.endRefreshing()
            tableView.reloadData()
            
        } failure: { errore in
            self.tableView.mj_header?.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    /// 商品详情
    private func loadGoodsInfo(){
        let param = NSMutableDictionary()
        param.setValue(goodModel.goodsId, forKey: "goodId")
        
        XJHttpTool.post(L_apiappjudgegoodsdiststockgetList, method: GET, params: param, isToken: true) { [self] responseObj in
            
            let data = responseObj as! NSDictionary
            let msg = data.object(forKey: "msg") as? String
            if msg == "Success" {
                let dataDic = data.object(forKey: "data") as! NSDictionary
                
                let list = dataDic.object(forKey: "list") as? NSArray
                
                if list != nil {
                    let listArray = list!
                    let listDic = listArray.firstObject as! NSDictionary
                    let goodsNum = listDic["goodsNum"] as! Int
                    let stayStock = listDic["stayStock"] as! Int
                    topGoodsKuCunLabel.text = "库存: \(goodsNum)"
                    topGoodsDaiRuKuLabel.text = "待入库: \(stayStock)"
                }else{
                    topGoodsKuCunLabel.text = "库存: 0"
                    topGoodsDaiRuKuLabel.text = "待入库: 0"
                }
                
            }
        } failure: { errore in
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
    ///上拉刷新
    @objc private func header(){
        
        loadMainNetwork()
    }
    
    /// 切换数据
    @objc private func buttonClick(_ sender:UIButton){
        
        if sender.tag == 101 {
            
            changeKuCunButton.setTitleColor(UIColor.hexString("#D40006"), for: .normal)
            changeDaiRuKuButton.setTitleColor(UIColor.hexString("#443415"), for: .normal)
            status = "1"
        }else{
            status = "2"
            changeKuCunButton.setTitleColor(UIColor.hexString("#443415"), for: .normal)
            changeDaiRuKuButton.setTitleColor(UIColor.hexString("#D40006"), for: .normal)
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            
            changeLineView.frame.origin.x = sender.center.x-12
        }
        
        loadMainNetwork()
    }
    
    /// 去采购
    @objc private func joinShopping(_ sender:UIButton){
        
        let vc = LLGoodDetailViewController()
        vc.status = .stockPeisong
        vc.id = goodModel.id
        vc.stocks = goodModel.stayStock
        vc.distDistGoodsId = goodModel.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - tableview模块
extension XYStockDetaileViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "StockCell") as! XYStockTableViewCell
        let dataModel = dataArray[indexPath.row]
        cell.model = dataModel
        return cell
    }
    
}
