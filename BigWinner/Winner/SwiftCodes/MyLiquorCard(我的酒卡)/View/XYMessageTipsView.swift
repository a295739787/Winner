//
//  XYMessageTipsView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/29.
//

import UIKit

class XYMessageTipsView: UIView {

    private var backView = UIView()
    private var noticeLabel = UILabel()
    private var contentView = UILabel()
    private var lineView = UIView()
    private var sureButton = UIButton()
    private var cancelButton = UIButton()
    
    public var tipsTitle : String = "绑卡成功"
    public var tipsContent : String =   "您的酒卡已绑定成功，您可以入我的库存中查看或继续绑卡。"
    public var cancel : String = "继续绑卡"
    public var sure : String = "查看库存"

    ///选中省市区
    var buttonClickBlock :((Int) -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadMainSubView()
    }
    //MARK: - 加载主视图
    private func loadMainSubView(){
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        backView = UIView.init()
        backView.frame = CGRect(x: 48, y: (self.frame.size.height-162)/2, width: self.frame.size.width-96, height: 162)
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .white
        self.addSubview(backView)

        noticeLabel = UILabel.init()
        noticeLabel.frame = CGRect(x: 5, y: 19, width: backView.frame.size.width-10, height: 20)
        noticeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        noticeLabel.textAlignment = .center;
        noticeLabel.text = tipsTitle
        noticeLabel.textColor = UIColor.black
        backView.addSubview(noticeLabel)
        
        contentView = UILabel.init()
        contentView.frame = CGRect(x: 23, y: noticeLabel.frame.maxY+23, width:backView.frame.size.width-46 , height: 35)
        contentView.textAlignment = .center
        contentView.font = UIFont.systemFont(ofSize: 13)
        contentView.text = tipsContent
        contentView.textColor = .hexString("#666666")
        contentView.numberOfLines = 2
        backView.addSubview(contentView)

        lineView = UIView.init()
        lineView.frame = CGRect(x: 0, y: contentView.frame.maxY+20, width: backView.frame.size.width, height: 1)
        lineView.backgroundColor = UIColor.hexString("#F0EFED")
        backView.addSubview(lineView)
        
        cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect(x:0 , y: lineView.frame.maxY, width: backView.frame.size.width/2, height: 45)
        cancelButton.setTitle(cancel, for: .normal)
        cancelButton.setTitleColor(.hexString("#020202"), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.tag = 101
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        backView.addSubview(cancelButton)
        
        
        sureButton = UIButton.init(type: .custom)
        sureButton.frame = CGRect(x: cancelButton.frame.maxX, y: lineView.frame.maxY, width: backView.frame.size.width/2, height: 45)
        sureButton.setTitle(sure, for: .normal)
        sureButton.setTitleColor(.hexString("#020202"), for: .normal)
        sureButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sureButton.tag = 102
        sureButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        backView.addSubview(sureButton)
    }

    ///取消和确认按钮点击方法
    @objc private func buttonClick(_ sender:UIButton){
        
        hideView()

        self.buttonClickBlock?(sender.tag)
    }
    
   ///显示界面
    public func showView(){
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        self.layoutIfNeeded()
        let tempFrame = backView.frame
        self.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
        } completion: { finished in
            
            UIView.animate(withDuration: 0.25) {
                self.backView.frame = tempFrame
            }
        }
    }
    
    ///关闭界面
    public func hideView(){
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
        } completion: { finished in
            if finished {
                UIView.animate(withDuration: 0.25) {
                    self.alpha = 0.0
                } completion: { finished in
                    self.removeFromSuperview()
                }
            }
        }
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }

}
