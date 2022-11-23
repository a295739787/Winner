//
//  XYShopDetailHeaderView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/22.
//

import UIKit

class XYShopDetailHeaderView: UIView {
    
    private var iconImageView = UIImageView()
    private var noteImgView = UIImageView()
    private var spaceView = UIView()
    var selectIconButton = UIButton()
    var iconURL : String?{
        
        didSet{
            iconImageView.sd_setImage(withUrlString: iconURL ?? "", placeholderImageName: "headimages")
        }
    }

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
        
        iconImageView = UIImageView.init()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "headimages")
        loadMasksToBounds(targetView: iconImageView, corners: 30)
        self.addSubview(iconImageView)
        
        noteImgView = UIImageView.init()
        noteImgView.contentMode = .scaleAspectFit
        noteImgView.image = UIImage(named: "bj")
        self.addSubview(noteImgView)
        
        selectIconButton = UIButton(type: .custom)
        self.addSubview(selectIconButton)
        
        spaceView = UIView.init()
        spaceView.backgroundColor = .hexString("#F5F5F5")
        self.addSubview(spaceView)
        
    }
    
    private func loadNeededView(){
        
        iconImageView.frame = CGRect(x:(self.frame.size.width-60)/2 , y: 40, width: 60, height: 60)
        
        noteImgView.frame = CGRect(x:iconImageView.frame.maxX-16 , y: iconImageView.frame.maxY-16, width: 16, height: 16)
        
        selectIconButton.frame = iconImageView.frame
        
        spaceView.frame = CGRect(x: 0, y:self.frame.size.height-10 , width: self.frame.size.width, height: 10)
    }
    
}
