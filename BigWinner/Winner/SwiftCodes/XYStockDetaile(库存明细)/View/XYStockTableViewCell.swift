//
//  StockTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/8.
//

import UIKit

class XYStockTableViewCell: UITableViewCell {
    
    var noteLabel = UILabel()
    var sumLabel = UILabel()
    var orderNumberLabel = UILabel()
    var timeLabel = UILabel()
    var lineView = UIView()
    
    var model = StockModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        loadSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubviews() {
        
        noteLabel = UILabel.init()
        noteLabel.text = "个人库存转入"
        noteLabel.textColor = UIColor.hexString("#443415")
        noteLabel.font = UIFont.systemFont(ofSize: 14)
        noteLabel.textAlignment = .left
        contentView.addSubview(noteLabel)
        
        sumLabel = UILabel.init()
        sumLabel.text = "+3"
        sumLabel.textColor = UIColor.hexString("#443415")
        sumLabel.font = UIFont.systemFont(ofSize: 14)
        sumLabel.textAlignment = .right
        contentView.addSubview(sumLabel)
        
        orderNumberLabel = UILabel.init()
        orderNumberLabel.text = "20210445616464642"
        orderNumberLabel.textColor = UIColor.hexString("#999999")
        orderNumberLabel.font = UIFont.systemFont(ofSize: 12)
        orderNumberLabel.textAlignment = .left
        contentView.addSubview(orderNumberLabel)
        
        timeLabel = UILabel.init()
        timeLabel.text = "2021-10-22 19:26:57"
        timeLabel.textColor = UIColor.hexString("#999999")
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textAlignment = .right
        contentView.addSubview(timeLabel)
        
        lineView = UIView.init()
        lineView.backgroundColor = UIColor.hexString("#F5F5F5")
        contentView.addSubview(lineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        noteLabel.frame = CGRect(x: 16, y: 13, width: (self.frame.size.width-32)/2, height: 14)
        sumLabel.frame  = CGRect(x: noteLabel.frame.maxX, y: 13, width: (self.frame.size.width-32)/2, height: 14)
        orderNumberLabel.frame = CGRect(x: 16, y: noteLabel.frame.maxY+10, width: (self.frame.size.width-32)/2, height: 10)
        timeLabel.frame = CGRect(x: orderNumberLabel.frame.maxX, y: sumLabel.frame.maxY+10, width: (self.frame.size.width-32)/2, height: 10)
        lineView.frame = CGRect(x: 15, y: self.frame.size.height-1, width: (self.frame.size.width-30), height: 1)
        
        noteLabel.text = model.type
        let num = model.goodsNum
        if num > 0 {
            sumLabel.text = "+\(model.goodsNum)"
        }else{
            sumLabel.text = "\(model.goodsNum)"
        }
        orderNumberLabel.text = model.orderNo
        timeLabel.text = model.createTime
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
