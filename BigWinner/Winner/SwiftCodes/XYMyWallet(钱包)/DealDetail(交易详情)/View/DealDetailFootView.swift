//
//  DealDetailFootView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/17.
//

import UIKit

class DealDetailFootView: UIView {
    
    var showLineView : Bool = false
    private var lineView = UIView()
    var questionLabel = UILabel()
    private var serviceImageView = UIImageView()
    private var serviceLabel = UILabel()
    var serviceButton = UIButton()
    
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
        
        lineView = UIView.init()
        lineView.backgroundColor = .hexString("#F5F5F5")
        self.addSubview(lineView)
        
        questionLabel = UILabel.init()
        questionLabel.loadMasksDynamicLabel(text: "订单遇到问题?", color: .hexString("#999999"), textAlignment: .left, font: UIFont.systemFont(ofSize: 14),number: 1)
        self.addSubview(questionLabel)
        
        serviceImageView = UIImageView.init()
        serviceImageView.contentMode = .scaleAspectFit
        serviceImageView.image = UIImage(named: "service_red")
        self.addSubview(serviceImageView)
        
        serviceLabel = UILabel.init()
        serviceLabel.loadMasksDynamicLabel(text: "联系客服", color: .hexString("#333333"), textAlignment: .left, font: UIFont.systemFont(ofSize: 14),number: 1)
        self.addSubview(serviceLabel)
        
        serviceButton = UIButton(type: .custom)
        self.addSubview(serviceButton)
        
    }
    
    private func loadNeededView(){
        
        lineView.frame = CGRect(x: 48, y: 16, width: self.frame.size.width-96, height: 1)
        lineView.isHidden = showLineView
        
        questionLabel.frame = CGRect(x: self.frame.size.width * 0.264, y: lineView.frame.maxY+18,width: 95, height: 14);
        
        serviceImageView.frame = CGRect(x: questionLabel.frame.maxX+7, y: lineView.frame.maxY+16, width: 21, height: 18)
        
        serviceLabel.frame = CGRect(x: serviceImageView.frame.maxX+5, y: lineView.frame.maxY+18, width: 60, height: 14)
        
        serviceButton.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
}
