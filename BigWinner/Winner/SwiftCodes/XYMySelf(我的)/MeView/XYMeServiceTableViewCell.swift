//
//  XYMeServiceTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/10.
//

import UIKit

@objcMembers class XYMeServiceTableViewCell: UITableViewCell {
    var bgView = UIView()
    var serviceImageView = UIImageView()
    var serviceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        loadSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    ///初始化
    private func loadSubviews() {
        bgView = UIView.init()
        bgView.backgroundColor = UIColor.white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5.0
        contentView.addSubview(bgView)
        
        serviceImageView = UIImageView.init()
        serviceImageView.contentMode = .scaleAspectFill
        serviceImageView.image = UIImage.init(named: "service_red")
        bgView.addSubview(serviceImageView)
        
        serviceLabel = UILabel.init()
        serviceLabel.text = "联系客服"
        serviceLabel.textColor = .hexString("#333333")
        serviceLabel.font = .systemFont(ofSize: 14)
        serviceLabel.textAlignment = .left
        bgView.addSubview(serviceLabel)
        
    }
    ///布局及加载数据
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.frame = CGRect(x: 10, y: 0, width: self.frame.size.width-20, height: self.frame.size.height)
        serviceImageView.frame = CGRect(x: bgView.frame.size.width * 0.38, y: (bgView.frame.size.height-18)/2, width: 21, height: 18)
        serviceLabel.frame = CGRect(x: serviceImageView.frame.maxX+9, y: (bgView.frame.size.height-14)/2, width: 60, height: 14)
        
    }
    
    
}
