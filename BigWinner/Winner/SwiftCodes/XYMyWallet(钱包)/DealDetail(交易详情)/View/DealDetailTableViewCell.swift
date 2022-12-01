//
//  DealDetailTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/17.
//

import UIKit

class DealDetailTableViewCell: UITableViewCell {
    
    var keyLabel = UILabel()
    var valueLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        loadMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadNeededView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    private func loadMainView(){
        
        keyLabel = UILabel.init()
        keyLabel.loadMasksDynamicLabel(text: "交易类型", color: .hexString("#919191"), textAlignment: .left, font: UIFont.systemFont(ofSize: 14),number: 1)
        contentView.addSubview(keyLabel)
        
        valueLabel = UILabel.init()
        valueLabel.numberOfLines = 0
        valueLabel.loadMasksDynamicLabel(text: "推广佣金", color: .hexString("#443415"), textAlignment: .left, font: UIFont.systemFont(ofSize: 14),number: 1)
        contentView.addSubview(valueLabel)
        
    }
    
    private func loadNeededView(){
        
        keyLabel.frame = CGRect(x: 48, y: 10, width: 60, height: 14)
        valueLabel.frame = CGRect(x: keyLabel.frame.maxX+17, y: 10, width: self.frame.size.width-keyLabel.frame.maxX-17-44, height: self.frame.size.height-20)
        
    }
    
    
}
