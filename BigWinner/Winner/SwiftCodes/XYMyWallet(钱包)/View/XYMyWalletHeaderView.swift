//
//  XYMyWalletHeaderView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/15.
//

import UIKit

class XYMyWalletHeaderView: UIView {
    
    public var type : MyWalletType = .normal
    var bgView = UIView()
    var bgImageView = UIImageView()
    var moneyNumberLabel = UILabel()
    var button = UIButton()
    var moneyTipsLabel = UILabel()
    var bottomView = UIView()
    var incomeLabel = UILabel()
    var incomeTipsLabel = UILabel()
    var lineView = UIView()
    var recoverLabel = UILabel()
    var recoverTipsLabel = UILabel()
    
    var model : WalletOrConsumeModel?{
        didSet{
            loadDataSource()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .hexString("#F0EFED")
        loadMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadNeededView()
    }
    
    private func loadMainView(){
        
        bgView = UIView.init()
        bgView.backgroundColor = .white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 5.0
        self.addSubview(bgView)
        
        bgImageView = UIImageView.init()
        bgImageView.contentMode = .scaleAspectFill
        bgView.addSubview(bgImageView)
        
        moneyNumberLabel = UILabel.init()
        moneyNumberLabel.text = "0.00"
        moneyNumberLabel.textColor = .hexString("#FFFFFF")
        moneyNumberLabel.font = UIFont.dinFont(withFontSize: 24)
        moneyNumberLabel.textAlignment = .left
        bgView.addSubview(moneyNumberLabel)
        
        button = UIButton.init(type: .custom)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.setTitleColor(.hexString("#D40006"), for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(button)
        
        moneyTipsLabel = UILabel.init()
        moneyTipsLabel.textColor = .white
        moneyTipsLabel.textAlignment = .left
        moneyTipsLabel.font = UIFont.systemFont(ofSize: 12)
        bgView.addSubview(moneyTipsLabel)
        
        bottomView = UIView.init()
        bottomView.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 0.2)
        bgView.addSubview(bottomView)
        
        incomeLabel = UILabel.init()
        incomeLabel.text = "0.00"
        incomeLabel.textColor = .white
        incomeLabel.textAlignment = .center
        incomeLabel.font = UIFont.systemFont(ofSize: 12)
        bottomView.addSubview(incomeLabel)
        
        incomeTipsLabel = UILabel.init()
        incomeTipsLabel.textColor = .white
        incomeTipsLabel.textAlignment = .center
        incomeTipsLabel.font = UIFont.systemFont(ofSize: 12)
        bottomView.addSubview(incomeTipsLabel)
        
        lineView = UIView.init()
        lineView.backgroundColor = .white
        bottomView.addSubview(lineView)
        
        recoverLabel = UILabel.init()
        recoverLabel.text = "0.00"
        recoverLabel.textColor = .white
        recoverLabel.textAlignment = .center
        recoverLabel.font = UIFont.systemFont(ofSize: 12)
        bottomView.addSubview(recoverLabel)
        
        recoverTipsLabel = UILabel.init()
        recoverTipsLabel.textColor = .white
        recoverTipsLabel.textAlignment = .center
        recoverTipsLabel.font = UIFont.systemFont(ofSize: 12)
        bottomView.addSubview(recoverTipsLabel)
        
    }
    private func loadNeededView(){
        
        bgView.frame = CGRect(x: 10, y: 10, width: self.frame.size.width-20, height: 155)
        
        bgImageView.frame = CGRect(x: 0, y: 0, width: bgView.frame.size.width, height: bgView.frame.size.height)
        
        moneyNumberLabel.frame = CGRect(x: 31, y: 30, width: bgView.frame.size.width-31-80-30-10, height: 27)
        
        button.frame = CGRect(x: moneyNumberLabel.frame.maxX+10, y: 31, width: 80, height: 40)
        
        moneyTipsLabel.frame = CGRect(x: 30, y: moneyNumberLabel.frame.maxY+5, width: 80, height: 12)
        
        bottomView.frame = CGRect(x: 0, y: bgView.frame.size.height-50, width: bgView.frame.size.width, height: 50)
        
        incomeLabel.frame = CGRect(x: 0, y: 12, width: (bottomView.frame.size.width-5)/2, height: 10)
        
        incomeTipsLabel.frame = CGRect(x: 0, y: incomeLabel.frame.maxY+5, width: (bottomView.frame.size.width-5)/2, height: 12)
        
        lineView.frame = CGRect(x: (bottomView.frame.size.width)/2, y: (bottomView.frame.size.height-27)/2, width: 1, height: 27)
        
        recoverLabel.frame = CGRect(x: lineView.frame.maxX+5, y: 12, width: (bottomView.frame.size.width-5)/2, height: 10)
        
        recoverTipsLabel.frame = CGRect(x: lineView.frame.maxX+5, y: recoverLabel.frame.maxY+5, width: (bottomView.frame.size.width-5)/2, height: 12)
        
        typeChange()
    }
    
    private func typeChange(){
        
        if type == .normal {
            
            button.setTitle("提现", for: .normal)
            moneyTipsLabel.text = "钱包余额(元)"
            incomeTipsLabel.text = "累计收入"
            recoverTipsLabel.text = "累计提现"
            bgImageView.image = UIImage(named: "normal")
            
        }else{
            
            button.setTitle("去使用", for: .normal)
            moneyTipsLabel.text = "红包余额(元)"
            incomeTipsLabel.text = "累计获得红包"
            recoverTipsLabel.text = "累计已使用"
            bgImageView.image = UIImage(named: "consume")
            
        }
        
    }
    
    private func loadDataSource(){
        
        var money = ""
        var income = ""
        var recover = ""
        
        if type == .normal {
            
            money = String(format: "%.2f", model?.totalReCashRedPrice ?? "0.00")
            income = String(format: "%.2f", model?.totalCashRedPrice ?? "0.00")
            recover = String(format: "%.2f", model?.totalOutCashRedPrice ?? "0.00")
        }else{
            
            money = String(format: "%.2f", model?.totalReConsumeRedPrice ?? "0.00")
            income = String(format: "%.2f", model?.totalConsumeRedPrice ?? "0.00")
            recover = String(format: "%.2f", model?.totalOutConsumeRedPrice ?? "0.00")
        }
        
        moneyNumberLabel.text = money
        incomeLabel.text = income
        recoverLabel.text = recover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
