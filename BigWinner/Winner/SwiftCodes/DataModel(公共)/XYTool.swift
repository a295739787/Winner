//
//  XYTool.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/16.
//

import UIKit

///设备宽度
var deviceWidth: CGFloat{
    return UIScreen.main.bounds.size.width
}
///设备高度
var deviceHeight: CGFloat{
    return UIScreen.main.bounds.size.height
}
///刘海高度
var statusBarForHeight: CGFloat{
    return UIApplication.shared.statusBarFrame.height
}

///动态切四周圆角
func loadMasksDynamicCorner(targetView:UIView,corners:UIRectCorner = .allCorners,cornerRadii:CGSize){
     
    let path = UIBezierPath.init(roundedRect: targetView.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
    let shapeLayer = CAShapeLayer.init()
    shapeLayer.frame = targetView.bounds
    shapeLayer.path = path.cgPath
    targetView.layer.mask = shapeLayer
    
}

/// 金额小数点
/// - Parameters:
///   - money: 参数
///   - roundingMode: 计算规则：(四舍五入，向上取整...)
///   - scale: 保留几位小数点
/// - Returns: String
func computeMoney(money:Double,roundingMode:NSDecimalNumber.RoundingMode,scale:Int) -> String{
    
    let decimal = NSDecimalNumber.init(value: money)
    let one = NSDecimalNumber.init(value: 1.0)
    let decimalHandler = NSDecimalNumberHandler.init(roundingMode: roundingMode, scale: Int16(scale), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
    let number = decimal.dividing(by: one, withBehavior: decimalHandler)
    
    return number.description
}

/// 动态获取label高度
func labelForHeight(width:CGFloat,font:Float,string:NSString) -> CGFloat {
    
    let size = CGSize(width: width, height: 1000000000000.0)
    let font = UIFont.systemFont(ofSize: CGFloat(font))
    let dict = NSDictionary.init(object: font,forKey: NSAttributedString.Key.font as NSCopying)
    let height = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict as? [NSAttributedString.Key : Any], context: nil).size
    
    return height.height
}

// MARK: - UILabel模块
extension UILabel {
   
    ///初始化label
    func loadMasksDynamicLabel(text:String,color:UIColor,textAlignment:NSTextAlignment,font:UIFont) {
        self.text = text
        self.textColor = color
        self.textAlignment = textAlignment
        self.font = font
    }
    
}

