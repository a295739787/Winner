//
//  XYMyWalletTitleHeaderView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/15.
//
import UIKit

class XYMyWalletTitleHeaderView: UIView {

    var bgView = UIView()
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .hexString("#F0EFED")
        loadMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.frame = CGRect(x: 10, y: 0, width: self.frame.size.width-20, height: self.frame.size.height)
        loadMasksDynamicCorner(targetView: bgView, corners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))

        titleLabel.frame = CGRect(x: 15, y: 18, width: 100, height: 14)
    }

    private func loadMainView(){
        
        bgView = UIView.init()
        bgView.backgroundColor = .white
        self.addSubview(bgView)

        titleLabel = UILabel.init()
        titleLabel.loadMasksDynamicLabel(text: "记录明细", color: .hexString("#666666"), textAlignment: .left, font: UIFont.systemFont(ofSize: 15))
        bgView.addSubview(titleLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
