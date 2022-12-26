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
/// 动态获取label宽度
func labelForWidth(height:CGFloat,font:Float,string:NSString) -> CGFloat {
    
    let size = CGSize(width: 1000000000000.0, height: height)
    let font = UIFont.systemFont(ofSize: CGFloat(font))
    let dict = NSDictionary.init(object: font,forKey: NSAttributedString.Key.font as NSCopying)
    let height = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict as? [NSAttributedString.Key : Any], context: nil).size
    
    return height.width
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

///获取当前显示的控制器 UIWindow (Visible)
func getCurrentViewController() -> UIViewController {
    let keywindow = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController//UIApplication.shared.keyWindow
    let rootVC = keywindow!//UIApplication.shared.keyWindow!.rootViewController!
    return getVisibleViewControllerFrom(vc: rootVC)
}

///获取当前
func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {

    if vc.isKind(of: UINavigationController.self) {
        return getVisibleViewControllerFrom(vc: (vc as! UINavigationController).visibleViewController!)
    } else if vc.isKind(of: UITabBarController.self) {
        return getVisibleViewControllerFrom(vc: (vc as! UITabBarController).selectedViewController!)
    } else {
        if (vc.presentedViewController != nil) {
            return getVisibleViewControllerFrom(vc: vc.presentedViewController!)
        } else {
            return vc
        }
    }
}

/// 富文本设置金额失效划线
/// - Parameter text: 文本
/// - Returns: 返回文本
func getPriceUnderlineStyleSingle(text:String)->NSAttributedString{
    
    let attStr = NSMutableAttributedString.init(string: text)
    attStr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, text.count))
    attStr.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: NSMakeRange(0, text.count))

    return attStr
}

/// 富文本设置金额不同区域的字体大小
/// - Parameters:
///   - text: 文本
///   - unChangedFont: 不需要字体大小
///   - changedFont: 需要改变字体大小
///   - firstArea: 从0开始需要改变的范围
///   - lastArea: 从文(t.length-first-last)开始需要改变的范围
/// - Returns: 返回文本
func getPriceTextAreaFontSize(text:String,unChangedFont:Float,changedFont:Float,firstArea:Int,lastArea:Int) ->NSAttributedString{
    
    let attStr = NSMutableAttributedString.init(string: text)
    attStr.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: CGFloat(changedFont)), range: NSMakeRange(0, firstArea))
    attStr.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: CGFloat(changedFont)), range: NSMakeRange((text.count-lastArea), lastArea))
    attStr.addAttribute(NSAttributedString.Key.font, value:UIFont.boldSystemFont(ofSize: CGFloat(unChangedFont)), range: NSMakeRange(firstArea, (text.count-lastArea-firstArea)))
    return attStr
}

func getQRCodeAndLogo(info:String,size:CGFloat,logoString:String = "") -> UIImage {
    
    let imageCI = getQRCode(codeInfo: info)
    var imageQR = getResizeQRCodeImage(image: imageCI, size: size)
    
    if logoString != ""{
        
        let logo = UIImage.init(named: logoString)!
        UIGraphicsBeginImageContext(imageQR.size)
        imageQR.draw(in: CGRect(x: 0, y: 0, width: imageQR.size.width, height: imageQR.size.height))
        let logoWidth = imageQR.size.width * 0.15
        logo.draw(in: CGRect(x: (imageQR.size.width - logoWidth) * 0.5, y: (imageQR.size.height - logoWidth) * 0.5, width: logoWidth, height: logoWidth))
        imageQR = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
   
    return imageQR
}

/// 生成一个二维码
/// - Parameter codeInfo: 需要生成的参数
/// - Returns: 二维码图片
private func getQRCode(codeInfo:String) ->CIImage{
    
    let filer = CIFilter.init(name: "CIQRCodeGenerator")!
    filer.setDefaults()
    let data  = codeInfo.data(using: .utf8)
    filer.setValue(data, forKey: "inputMessage")
    filer.setValue("H", forKey: "inputCorrectionLevel")
    let image = filer.outputImage!
    
    return image
}
    
/// 生成一个固定大小的二维码
/// - Parameters:
///   - image: 二维码图片
///   - size: 尺寸
/// - Returns: 固定大小的二维码
private func getResizeQRCodeImage(image:CIImage,size:CGFloat) -> UIImage {

    let extent = image.extent
    let scale: CGFloat = min(size/extent.width, size/extent.height) * UIScreen.main.scale
    
    let width :size_t = size_t(extent.width * scale)
    let height :size_t = size_t(extent.height * scale)
    let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
    let bitmapRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)!
    let context = CIContext(options: nil)
    
    let bitmapImage: CGImage = context.createCGImage(image, from: extent)!
    bitmapRef.interpolationQuality = .none
    bitmapRef.scaleBy(x: scale, y: scale)
    bitmapRef.draw(bitmapImage, in: extent)
    let scaledImage: CGImage = bitmapRef.makeImage()!
    
    let image = UIImage.init(cgImage: scaledImage)
    
    return image
}

/// 普通截图
/// - Parameter bgView: 需要截图区域
/// - Returns: image
func screenshotImage(bgView:UIView) ->UIImage?{
        
    UIGraphicsBeginImageContextWithOptions(bgView.bounds.size, true, UIScreen.main.scale)
    bgView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

/// 截取UIScrollView上所有内容
/// - Parameter scrollView: scrollView
/// - Returns: image
func screenshotScrollView(scrollView:UIScrollView) -> UIImage? {
    
    var image : UIImage? = nil
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, true, UIScreen.main.scale)
    let savedContentOffset = scrollView.contentOffset
    let savedFrame = scrollView.frame
    scrollView.frame = CGRect(x: 0 , y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
   
    image = UIGraphicsGetImageFromCurrentImageContext()
    scrollView.contentOffset = savedContentOffset
    scrollView.frame = savedFrame
    UIGraphicsEndImageContext()
    
    let data =  image?.jpegData(compressionQuality: 1)
    let jpegImage = UIImage(data: data!)
    return jpegImage ?? nil
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
