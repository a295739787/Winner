//
//  LiquorCardDetailTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/25.
//

import UIKit

class LiquorCardDetailTableViewCell: UITableViewCell {
    
    ///提货单
    var oddNumberLabel = UILabel()
    ///单号时间
    var oddTimeLabel = UILabel()
    ///金额
    var goodsMoneyLabel = UILabel()
    ///金额时间
    var goodsMoneyTimeLabel = UILabel()
    
    var lineView = UIView()
    
    var model = LiquorCardDetailModel()
    
    var cellType : Int = -1
    
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
        
        oddNumberLabel = UILabel.init()
        oddNumberLabel.loadMasksDynamicLabel(text: "提货单2022", color: .hexString("#443415"), textAlignment: .left, font: .systemFont(ofSize: 14),number: 1)
        contentView.addSubview(oddNumberLabel)
        
        oddTimeLabel = UILabel.init()
        oddTimeLabel.loadMasksDynamicLabel(text: "2021-10-22 19:26:57", color: .hexString("#999999"), textAlignment: .left, font: .systemFont(ofSize: 12),number: 1)
        contentView.addSubview(oddTimeLabel)
        
        goodsMoneyLabel = UILabel.init()
        goodsMoneyLabel.loadMasksDynamicLabel(text: "-1", color: .hexString("#D40006"), textAlignment: .right, font: .systemFont(ofSize: 14),number: 1)
        contentView.addSubview(goodsMoneyLabel)
        
        goodsMoneyTimeLabel = UILabel.init()
        goodsMoneyTimeLabel.loadMasksDynamicLabel(text: "2021-10-15 18:22:24", color: .hexString("#999999"), textAlignment: .right, font: .systemFont(ofSize: 12),number: 1)
        contentView.addSubview(goodsMoneyTimeLabel)
        
        lineView = UIView.init()
        lineView.backgroundColor = .hexString("#F5F5F5")
        contentView.addSubview(lineView)
    }
    
    private func loadNeededView(){
        
        oddNumberLabel.frame = CGRect(x: 25, y: 14, width: (self.frame.size.width-25-25-10)*0.8, height: 14)
        
        oddTimeLabel.frame = CGRect(x: 25, y: oddNumberLabel.frame.maxY+14, width: (self.frame.size.width-25-25-10)/2, height: 10)
        
        goodsMoneyLabel.frame = CGRect(x: oddNumberLabel.frame.maxX+10, y: 14, width: (self.frame.size.width-25-25-10)*0.2, height: 11)
        
        goodsMoneyTimeLabel.frame = CGRect(x: oddTimeLabel.frame.maxX+10, y: goodsMoneyLabel.frame.maxY+17, width: (self.frame.size.width-25-25-10)/2, height: 10)
        
        lineView.frame = CGRect(x: 25, y: self.frame.size.height-1, width:(self.frame.size.width-50) , height: 1)
        
        if cellType == 1 {
            
            if model.goodsNum > 0 {
                goodsMoneyLabel.textColor = .hexString("#999999")
            }else{
                goodsMoneyLabel.textColor = .hexString("#D40006")
            }
            
            var goodsNumString = "\(model.goodsNum)"
            if model.goodsNum > 0 {
                goodsNumString = "+\(model.goodsNum)"
            }
            
            oddNumberLabel.text = "\(model.type)\(model.orderNo)"
            oddTimeLabel.text = model.createTime
            goodsMoneyLabel.text = goodsNumString
            goodsMoneyTimeLabel.text = "余额 \(model.remainNum)"
            
        }else{
            oddNumberLabel.text = "\(model.typeName)\(model.orderNo)"
            oddTimeLabel.text = model.createTime
            goodsMoneyLabel.text = "+\(model.goodsNum)"
            goodsMoneyTimeLabel.text = ""
        }

    }
}
