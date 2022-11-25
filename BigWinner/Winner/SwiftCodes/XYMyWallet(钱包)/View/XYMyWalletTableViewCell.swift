//
//  XYMyWalletTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/15.
//

import UIKit

class XYMyWalletTableViewCell: UITableViewCell {

    var showOtherLabel : Bool = false
    
    var bgView = UIView()
    var titleLabel = UILabel()
    var moneyLabel = UILabel()
    var timeLabel = UILabel()
    var balanceLabel = UILabel()
    var lineView = UIView()
    
    var messageView = UIView()
    var messageLabel = UILabel()
    var messageImageView = UIImageView()

    var model = WalletIncomeAndRecoverModel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        loadMainView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        loadNeededView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func loadMainView(){
        
        bgView = UIView.init()
        bgView.backgroundColor = .white
        contentView.addSubview(bgView)
        
        titleLabel = UILabel.init()
        titleLabel.loadMasksDynamicLabel(text: "提现", color: .hexString("#443415"), textAlignment: .left, font: UIFont.systemFont(ofSize: 14),number: 1)
        bgView.addSubview(titleLabel)
        
        moneyLabel = UILabel.init()
        moneyLabel.loadMasksDynamicLabel(text: "-95.20", color: .hexString("#C43136"), textAlignment: .right, font: UIFont.systemFont(ofSize: 14),number: 1)
        bgView.addSubview(moneyLabel)
        
        timeLabel = UILabel.init()
        timeLabel.loadMasksDynamicLabel(text: "2022-10-22  10:00:01", color: .hexString("#999999"), textAlignment: .left, font: UIFont.systemFont(ofSize: 12),number: 1)
        bgView.addSubview(timeLabel)
        
        balanceLabel = UILabel.init()
        balanceLabel.loadMasksDynamicLabel(text: "余额 9800", color: .hexString("#999999"), textAlignment: .right, font: UIFont.systemFont(ofSize: 12),number: 1)
        bgView.addSubview(balanceLabel)
        
        messageView = UIView.init()
        messageView.backgroundColor = UIColor.white
        bgView.addSubview(messageView)
     
        messageImageView = UIImageView.init()
        messageImageView.image = UIImage(named: "walletWarn")
        messageImageView.contentMode = .scaleAspectFit
        messageView.addSubview(messageImageView)
        
        messageLabel = UILabel.init()
        messageLabel.loadMasksDynamicLabel(text: "提现失败，银行退回汇款，原因为该收款账号支…", color: .hexString("#CA363B"), textAlignment: .left, font: UIFont.systemFont(ofSize: 14),number: 1)
        messageView.addSubview(messageLabel)
        
        lineView = UIView.init()
        lineView.backgroundColor = .hexString("#F5F5F5")
        bgView.addSubview(lineView)
    }
    
    private func loadNeededView(){
        
        bgView.frame = CGRect(x: 10, y: 0, width: self.frame.size.width-20, height: self.frame.size.height)
        
        titleLabel.frame = CGRect(x: 15, y: 14, width: (bgView.frame.size.width-30)/2, height: 14)
        
        moneyLabel.frame = CGRect(x: titleLabel.frame.maxX, y: 17, width: (bgView.frame.size.width-30)/2, height: 11)
        
        timeLabel.frame = CGRect(x: 15, y: titleLabel.frame.maxY+9, width: (bgView.frame.size.width-30)/2, height: 10)
        
        balanceLabel.frame = CGRect(x: timeLabel.frame.maxX, y: moneyLabel.frame.maxY+8, width: (bgView.frame.size.width-30)/2, height: 12)
        
        messageView.frame = CGRect(x: 0, y: timeLabel.frame.maxY, width: bgView.frame.size.width, height: 45)
        
        messageImageView.frame = CGRect(x: 16, y: (messageView.frame.size.height-11)/2, width: 11, height: 11)
        
        messageLabel.frame = CGRect(x: messageImageView.frame.maxX+5, y: (messageView.frame.size.height-15)/2, width: messageView.frame.size.width-messageImageView.frame.maxX-5-18, height: 15)

        lineView.frame = CGRect(x: 15, y: bgView.frame.size.height-1, width:(bgView.frame.size.width-30) , height: 1)
        
        loadDataSource()
    }
    
    private func loadDataSource(){
        
        titleLabel.text = WalletType[model.type]
        
        let symbol = WalletSymbol[model.type]!
        let price = String(format: "%.2f", model.price)
        moneyLabel.text = "\(symbol)\(price)"
        if symbol == "-" {
            moneyLabel.textColor = .hexString("#C43136")
        }else{
            moneyLabel.textColor = .hexString("#443415")
        }
        
        timeLabel.text = model.createTime
        
        let balance = String(format: "%.2f", model.surplusPrice)
        balanceLabel.text = "余额 \(balance)"
        
        messageLabel.text = model.withdrawalMsg
        
    }
}
