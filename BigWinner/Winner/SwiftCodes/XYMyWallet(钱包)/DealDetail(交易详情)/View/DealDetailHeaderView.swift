//
//  DealDetailHeaderView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/17.
//

import UIKit

class DealDetailHeaderView: UIView {

    var moneyLabel = UILabel()
    private var lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private func loadMainView(){
        
        moneyLabel = UILabel.init()
        moneyLabel.loadMasksDynamicLabel(text: "+300.00", color: .hexString("#443415"), textAlignment: .center, font: UIFont.systemFont(ofSize: 30),number: 1)
        self.addSubview(moneyLabel)
        
        lineView = UIView.init()
        lineView.backgroundColor = .hexString("#F5F5F5")
        self.addSubview(lineView)
        
    }
    
    private func loadNeededView(){
        
        moneyLabel.frame = CGRect(x: 0, y: self.frame.size.height * 0.45, width: self.frame.size.width, height: 23)
        lineView.frame = CGRect(x: 48, y: self.frame.size.height-25, width: self.frame.size.width-96, height: 1)
    }
    
}
