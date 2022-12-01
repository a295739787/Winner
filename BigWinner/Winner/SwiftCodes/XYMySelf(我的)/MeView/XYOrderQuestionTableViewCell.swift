//
//  XYOrderQuestionTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/14.
//

import UIKit

@objcMembers class XYOrderQuestionTableViewCell: UITableViewCell {
    
    var bgView = UIView()
    var questionLabel = UILabel()
    var serviceImageView = UIImageView()
    var serviceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        loadSubviews()
    }
    
    ///初始化
    private func loadSubviews() {
        bgView = UIView.init()
        bgView.backgroundColor = UIColor.clear
        contentView.addSubview(bgView)
        
        questionLabel = UILabel.init()
        questionLabel.textColor = .hexString("#999999")
        questionLabel.font = .systemFont(ofSize: 14)
        questionLabel.textAlignment = .left
        bgView.addSubview(questionLabel)
        
        serviceImageView = UIImageView.init()
        serviceImageView.contentMode = .scaleAspectFit
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
        
        bgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        questionLabel.frame = CGRect(x: bgView.frame.size.width * 0.264, y: (bgView.frame.size.height-14)/2, width: 95, height: 14)
        serviceImageView.frame = CGRect(x:questionLabel.frame.maxX+7 , y: (bgView.frame.size.height-18)/2, width: 21, height: 18)
        serviceLabel.frame = CGRect(x: serviceImageView.frame.maxX+5, y: (bgView.frame.size.height-14)/2, width: 60, height: 14)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
