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
/// 窗口底部安全区域间距
var windowSafeAreaBottomMargin: CGFloat {
    if #available(iOS 11.0, *) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window else {
                return 0.0
        }
        return window.safeAreaInsets.bottom
    } else {
        // Fallback on earlier versions
        return 0.0
    }
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

/// textField 光标间隔
/// - Parameters:
///   - textField: 目标textField
///   - sepac: 间隔 默认15
func loadTextFieldBlankView(textField:UITextField,sepac:CGFloat = 15){
    let blankView = UIView.init()
    blankView.frame = CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y, width: sepac, height: textField.frame.size.height)
    textField.leftView = blankView
    textField.leftViewMode = .always
}
/// 切圆角及边线
/// - Parameters:
///   - targetView: 目标view，必填
///   - corners: 圆角，必填
///   - borderWidth: 边宽,可选
///   - borderColor: 变宽色。可选
func loadMasksToBounds(targetView:UIView,corners:CGFloat,borderWidth:CGFloat = 0,borderColor:UIColor = .white){
     
    targetView.layer.masksToBounds = true
    targetView.layer.cornerRadius = corners
    targetView.layer.borderWidth = borderWidth
    targetView.layer.borderColor = borderColor.cgColor
}

// MARK: - UILabel模块
extension UILabel {
   
    ///初始化label
    func loadMasksDynamicLabel(text:String,color:UIColor,textAlignment:NSTextAlignment,font:UIFont,number:Int) {
        self.text = text
        self.textColor = color
        self.textAlignment = textAlignment
        self.font = font
        self.numberOfLines = number
    }
    
}

// MARK: - UIbutton模块
extension UIButton{
    
    func loadMasksButton(title:String,color:UIColor,fontSize:CGFloat) {
    
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: fontSize)
        
    }
    
}
