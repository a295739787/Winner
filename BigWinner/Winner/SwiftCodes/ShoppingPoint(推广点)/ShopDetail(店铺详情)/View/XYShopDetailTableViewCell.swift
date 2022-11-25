//
//  XYShopDetailTableViewCell.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/22.
//

import UIKit

class XYShopDetailTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var moreImageView = UIImageView()
    var showMoreImage :Bool = false
    var lineView = UIView()

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
        
        titleLabel = UILabel.init()
        titleLabel.loadMasksDynamicLabel(text: "店铺名称", color: .hexString("#443415"), textAlignment: .left, font: UIFont.systemFont(ofSize: 13),number: 1)
        contentView.addSubview(titleLabel)
        
        contentLabel = UILabel.init()
        contentLabel.loadMasksDynamicLabel(text: "大赢家四小店", color: .hexString("#666666"), textAlignment: .left, font: UIFont.systemFont(ofSize: 15),number: 1)
        contentView.addSubview(contentLabel)
        
        moreImageView = UIImageView.init()
        moreImageView.image = UIImage(named: "more_gray")
        moreImageView.contentMode = .scaleAspectFit
        contentView.addSubview(moreImageView)
        
        lineView = UIView.init()
        lineView.backgroundColor = .hexString("#F5F5F5")
        contentView.addSubview(lineView)
    }
    
    private func loadNeededView(){
        
        titleLabel.frame = CGRect(x: 15, y: 15, width: self.frame.size.width-30, height: 13)
        contentLabel.frame = CGRect(x: 15, y: titleLabel.frame.maxY+9, width: self.frame.size.width-40, height: 15)
        moreImageView.frame = CGRect(x: contentLabel.frame.maxX+10, y: contentLabel.frame.midY-5, width: 6, height: 10)
        moreImageView.isHidden = !showMoreImage
        
        lineView.frame = CGRect(x: 15, y: self.frame.size.height-1, width:(self.frame.size.width-15) , height: 1)

    }
}
