//
//  MyLiquorCardTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/24.
//

import UIKit

public protocol MyLiquorCardDelegate : NSObjectProtocol{
    
    func clickButton(any:AnyObject,tag:Int)
}

class MyLiquorCardTableViewCell: UITableViewCell {
    
    var mainView = UIView()
    /// 间隔view
    var spaceView = UIView()
    ///商品图
    var goodsImage = UIImageView()
    ///失效图
    var goodsInvalidImage = UIImageView()
    ///商品信息
    var goodsInfoLabel = UILabel()
    ///商品余额
    var goodsBalanceLabel = UILabel()
    ///多少瓶
    var goodsNumberLabel = UILabel()
    ///截止时间
    var goodsTimeLabel = UILabel()
    ///商品卡号
    var goodsCardNumberLabel = UILabel()
    ///查看明细
    var seeDetailButton = UIButton()
    ///去提货
    var goodsExtractButton = UIButton()
    
    weak open var delegate: MyLiquorCardDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        loadMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadNeededView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadMainView(){
        
        spaceView = UIView.init()
        spaceView.backgroundColor = .hexString("#F0EFED")
        contentView.addSubview(mainView)
        
        mainView = UIView.init()
        mainView.backgroundColor = .white
        contentView.addSubview(mainView)
        loadMasksToBounds(targetView: mainView, corners: 5)
        
        goodsImage = UIImageView.init()
        mainView.addSubview(goodsImage)
        
        goodsInvalidImage = UIImageView.init()
        mainView.addSubview(goodsInvalidImage)
        
        goodsInfoLabel = UILabel.init()
        goodsInfoLabel.loadMasksDynamicLabel(text: "测试数据-大赢家 进取 500ml单瓶装 酱香型白酒家庭聚会 商务 必选白酒", color: .hexString("#443415"), textAlignment: .left, font: .systemFont(ofSize: 14),number: 2)
        mainView.addSubview(goodsInfoLabel)
        
        goodsBalanceLabel = UILabel.init()
        goodsBalanceLabel.loadMasksDynamicLabel(text: "余额", color: .hexString("#999999"), textAlignment: .left, font: .systemFont(ofSize: 12), number: 1)
        mainView.addSubview(goodsBalanceLabel)
        
        goodsNumberLabel = UILabel.init()
        goodsNumberLabel.loadMasksDynamicLabel(text: "166 瓶", color: .hexString("#D40006"), textAlignment: .left, font: .systemFont(ofSize: 12), number: 1)
        mainView.addSubview(goodsNumberLabel)
        
        goodsTimeLabel = UILabel.init()
        goodsTimeLabel.loadMasksDynamicLabel(text: "有效期至2022年12月31日止", color: .hexString("#999999"), textAlignment: .left, font: .systemFont(ofSize: 12), number: 1)
        mainView.addSubview(goodsTimeLabel)
        
        goodsCardNumberLabel = UILabel.init()
        goodsCardNumberLabel.loadMasksDynamicLabel(text: "卡号码:8008899", color: .hexString("#999999"), textAlignment: .left, font: .systemFont(ofSize: 12), number: 1)
        mainView.addSubview(goodsCardNumberLabel)
        
        seeDetailButton = UIButton(type: .custom)
        seeDetailButton.tag = 101
        seeDetailButton.loadMasksButton(title: "查看明细", color: .hexString("#333333"), fontSize: 13)
        loadMasksToBounds(targetView: seeDetailButton, corners: 15, borderWidth: 1, borderColor: .hexString("#999999"))
        mainView.addSubview(seeDetailButton)
        seeDetailButton.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        
        goodsExtractButton = UIButton(type: .custom)
        goodsExtractButton.tag = 102
        goodsExtractButton.loadMasksButton(title: "去提货", color: .hexString("#D40006"), fontSize: 13)
        loadMasksToBounds(targetView: goodsExtractButton, corners: 15, borderWidth: 1, borderColor: .hexString("#D40006"))
        mainView.addSubview(goodsExtractButton)
        goodsExtractButton.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        
    }
    
    private func loadNeededView(){
        
        spaceView.frame = CGRect(x: 10, y: 0, width: self.frame.size.width-20, height: 10)
        
        mainView.frame = CGRect(x: 10, y: 10, width: self.frame.size.width-20, height: self.frame.size.height-10)
        
        goodsImage.frame = CGRect(x: 15, y: 10, width: 80, height: 80)
        
        goodsInvalidImage.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        
        goodsInfoLabel.frame = CGRect(x: goodsImage.frame.maxX+10, y: 12, width: mainView.frame.size.width-goodsImage.frame.maxX-10-14, height: 35)
        
        goodsBalanceLabel.frame = CGRect(x: goodsImage.frame.maxX+10, y: goodsInfoLabel.frame.maxY+8, width: 25, height: 12)
        
        goodsNumberLabel.frame = CGRect(x: goodsBalanceLabel.frame.maxX+6, y: goodsInfoLabel.frame.maxY+8, width:  mainView.frame.size.width-goodsBalanceLabel.frame.maxX-6-14, height: 12)
        
        goodsTimeLabel.frame = CGRect(x: goodsImage.frame.maxX+10, y: goodsBalanceLabel.frame.maxY+4, width:  mainView.frame.size.width-goodsImage.frame.maxX-10-14, height: 12)
        
        goodsCardNumberLabel.frame = CGRect(x: 15, y: mainView.frame.size.height-35, width:  mainView.frame.size.width-15-10-160-10-15, height: 12)
        
        seeDetailButton.frame = CGRect(x: goodsCardNumberLabel.frame.maxX+10, y: mainView.frame.size.height-44, width: 80, height: 30)
        
        goodsExtractButton.frame = CGRect(x: seeDetailButton.frame.maxX+10, y: mainView.frame.size.height-44, width: 80, height: 30)
        
    }
    
    
    @objc private func selectButton(_ sender: UIButton){
        self.delegate?.clickButton(any: sender, tag: sender.tag)
    }
    
}
