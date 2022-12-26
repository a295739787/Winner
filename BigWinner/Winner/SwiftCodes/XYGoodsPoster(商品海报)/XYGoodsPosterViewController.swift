//
//  XYGoodsPosterViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/12/8.
//

import UIKit

class XYGoodsPosterViewController: UIViewController {
    
    private var mainView = UIScrollView()
    private var goodsImageView = UIImageView()
    private var zheKouPriceLabel = UILabel()
    private var yuanPriceLabel = UILabel()
    private var posterIconImageView = UIImageView()
    private var goodsTitleLabel = UILabel()
    private var goodsSpecLabel = UILabel()
    @objc var QRCodeString : String = "我是一条测试数据"
    @objc var goodsId : String = ""
    @objc var type : String = "1"

    
    let QRCodeW : CGFloat = 58.0
    private var buttomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMainView()
        loadMainNetwork()
    }
    private func loadMainNetwork(){
        
        let param = NSMutableDictionary()
        XJHttpTool.post("\(L_apiappgoodshomegetInfo)/\(type)/\(goodsId)", method: GET, params: param, isToken: true) { [self] responseObj in
            let data = responseObj as! NSDictionary
            let code = data.object(forKey: "code") as? Int
            if code == 200 {
                let dataList = data.object(forKey: "data") as! NSDictionary
                let model: LLGoodModel = LLGoodModel.mj_object(withKeyValues: dataList)
                loadDataSource(model: model)
            }
        } failure: { errore in
            
        }
    }

    private func loadDataSource(model:LLGoodModel){
        
        let images = model.images.components(separatedBy: ",")
        if images.count > 0 {
            let image = images.first! as String
            let imageUrl = "\(API_IMAGEHOST)\(image)"
            goodsImageView.sd_setImage(withUrlString: imageUrl)
        }
        
        let zheKouMoney = String(format: "¥%.2f", NSString(string: model.salesPrice).floatValue)
        zheKouPriceLabel.attributedText = getPriceTextAreaFontSize(text: zheKouMoney, unChangedFont: 18, changedFont: 9, firstArea: 1, lastArea: 3)
        
        let yuanMoney = String(format: "%.2f", NSString(string: model.scribingPrice).floatValue)
        yuanPriceLabel.attributedText = getPriceUnderlineStyleSingle(text: yuanMoney)
        
        let zheKouW = labelForWidth(height: zheKouPriceLabel.frame.size.height, font: 14, string: NSString(string: zheKouMoney))
        zheKouPriceLabel.frame = CGRect(x: 13, y: goodsImageView.frame.maxY+10, width: zheKouW, height: 14)
        
        let yuanW = labelForWidth(height: zheKouPriceLabel.frame.size.height, font: 12, string: NSString(string: yuanMoney))
        yuanPriceLabel.frame = CGRect(x: zheKouPriceLabel.frame.maxX+4, y: goodsImageView.frame.maxY+10, width: yuanW, height: 14)

        posterIconImageView.frame = CGRect(x: yuanPriceLabel.frame.maxX+9, y: goodsImageView.frame.maxY+12, width: 48, height: 12)
        
        goodsTitleLabel.text = model.name

        let specList = model.goodsSpecsLists.first as! LLGoodModel
        let spec = specList.goodsSpecsValLists.first as! LLGoodModel
        goodsSpecLabel.text = "规格：\(spec.name)"
    
    }
    
    private func loadMainView(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dissMissView(_:))))
        //顶部容器
        mainView = UIScrollView.init()
        mainView.backgroundColor = .white
        mainView.frame = CGRect(x: deviceWidth * 0.192, y: deviceHeight * 0.134, width: deviceWidth-(deviceWidth * 0.192 * 2), height: deviceHeight * 0.558)
        self.view.addSubview(mainView)
        loadMasksToBounds(targetView: mainView, corners: 5)
        
        let topTitleView = UIView.init()
        topTitleView.frame = CGRect(x: mainView.frame.size.width * 0.182, y: 14, width: mainView.frame.size.width-(mainView.frame.size.width * 0.182*2), height: 16)
        topTitleView.backgroundColor = .hexString("#E6E6E6")
        mainView.addSubview(topTitleView)
        loadMasksToBounds(targetView: topTitleView, corners: 8)
        
        let topIconImageView = UIImageView.init()
        topIconImageView.frame = CGRect(x: 3, y: 2, width: 12, height: 12)
        topIconImageView.contentMode = .scaleAspectFit
        topIconImageView.image = UIImage(named: "posterIcon");
        topTitleView.addSubview(topIconImageView)
        
        let topMessageLabel = UILabel.init()
        topMessageLabel.frame = CGRect(x: topIconImageView.frame.maxX+6, y: (16-9)/2, width: topTitleView.frame.size.width-topIconImageView.frame.maxX-6-14, height: 9)
        topMessageLabel.loadMasksDynamicLabel(text: "推荐一个好物给您，请查收!", color: .hexString("#999999"), textAlignment: .center, font: UIFont.systemFont(ofSize: 9), number: 1)
        topTitleView.addSubview(topMessageLabel)
        
        goodsImageView = UIImageView.init()
        goodsImageView.frame = CGRect(x: 0, y: topTitleView.frame.maxY+11, width: mainView.frame.size.width, height: mainView.frame.size.height * 0.508)
        goodsImageView.contentMode = .scaleAspectFit
        mainView.addSubview(goodsImageView)
        
        zheKouPriceLabel = UILabel.init()
        zheKouPriceLabel.frame = CGRect(x: 13, y: goodsImageView.frame.maxY+10, width: 48, height: 14)
        zheKouPriceLabel.loadMasksDynamicLabel(text: "¥380.00", color: .hexString("#D40006"), textAlignment: .left, font: UIFont.systemFont(ofSize: 18), number: 1)
        mainView.addSubview(zheKouPriceLabel)
        
        yuanPriceLabel = UILabel.init()
        yuanPriceLabel.frame = CGRect(x: zheKouPriceLabel.frame.maxX+4, y: goodsImageView.frame.maxY+10, width: 45, height: 14)
        yuanPriceLabel.loadMasksDynamicLabel(text: "789.00", color: .hexString("#666666"), textAlignment: .left, font: UIFont.systemFont(ofSize: 12), number: 1)
        mainView.addSubview(yuanPriceLabel)
        
        posterIconImageView = UIImageView.init()
        posterIconImageView.frame = CGRect(x: yuanPriceLabel.frame.maxX+9, y: goodsImageView.frame.maxY+12, width: 48, height: 12)
        posterIconImageView.image = UIImage(named: "posterAppIcon");
        mainView.addSubview(posterIconImageView)
        
        goodsTitleLabel = UILabel.init()
        goodsTitleLabel.frame = CGRect(x: 14, y: posterIconImageView.frame.maxY+11, width: mainView.frame.size.width-14-20, height: 30)
        goodsTitleLabel.loadMasksDynamicLabel(text: "大赢家进取 壬寅虎年生肖纪念酒 53度 500ml 酱香酒白酒", color: .hexString("#1A1A1A"), textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 12), number: 2)
        mainView.addSubview(goodsTitleLabel)
        
        goodsSpecLabel = UILabel.init()
        goodsSpecLabel.frame = CGRect(x: 14, y: goodsTitleLabel.frame.maxY+5, width: mainView.frame.size.width-14-20, height: 9)
        goodsSpecLabel.loadMasksDynamicLabel(text: "规格：58度单瓶装", color: .hexString("#808080"), textAlignment: .left, font: UIFont.systemFont(ofSize: 9), number: 1)
        mainView.addSubview(goodsSpecLabel)
        
       let qrCodeImageView = UIImageView.init()
        qrCodeImageView.frame = CGRect(x: (mainView.frame.size.width-QRCodeW)/2, y: goodsSpecLabel.frame.maxY+18, width: QRCodeW, height: QRCodeW)
        mainView.addSubview(qrCodeImageView)
        qrCodeImageView.image = getQRCodeAndLogo(info: QRCodeString, size: QRCodeW)

        
        let QRMessageLabel = UILabel.init()
        QRMessageLabel.frame = CGRect(x: 0, y: qrCodeImageView.frame.maxY+5, width: mainView.frame.size.width, height: 8)
        QRMessageLabel.loadMasksDynamicLabel(text: "长按或扫描查看", color: .hexString("#808080"), textAlignment: .center, font: UIFont.systemFont(ofSize: 8), number: 1)
        mainView.addSubview(QRMessageLabel)
        
         mainView.contentSize = CGSize(width: mainView.frame.size.width, height: QRMessageLabel.frame.maxY+10)
        
        //尾部容器
        var bottomH = deviceHeight * 0.25
        var cancelY = 20.0

        if bottomH < 200 {
            bottomH = 200
            cancelY = 10.0
        }
        buttomView = UIView.init()
        buttomView.backgroundColor = .white
        buttomView.frame = CGRect(x: 0, y: mainView.frame.maxY + (deviceHeight * 0.06), width: deviceWidth, height: bottomH)
        self.view.addSubview(buttomView)
        loadMasksDynamicCorner(targetView: buttomView, corners: [.topLeft,.topRight], cornerRadii: CGSize(width: 12, height: 12))
        
        let buttomLabel = UILabel.init()
        buttomLabel.frame = CGRect(x: 0, y: 15, width: buttomView.frame.size.width, height: 14)
        buttomLabel.loadMasksDynamicLabel(text: "分享当前图片到", color: .hexString("#443415"), textAlignment: .center, font: UIFont.systemFont(ofSize: 15), number: 1)
        buttomView.addSubview(buttomLabel)
        
        let buttonViews = UIView.init()
        buttonViews.frame = CGRect(x: 0, y: buttomLabel.frame.maxY+10, width: buttomView.frame.size.width, height: 74)
        buttomView.addSubview(buttonViews)
        setButtons(view: buttonViews)
        
        let cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: 0, y: buttonViews.frame.maxY+cancelY, width:buttomView.frame.size.width , height: 44)
        cancelButton.backgroundColor = UIColor.hexString("#FAFAFA")
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.hexString("#999999"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelDissView(_:)), for: .touchUpInside)
        buttomView.addSubview(cancelButton)
    }
    
    ///循序遍历button
    private func setButtons(view:UIView) {
        let titles = ["微信好友","朋友圈","下载"]
        let images = ["wx","pyq","updatePhoto"]
        
        for i in 0..<titles.count {
            let w = deviceWidth/3
            let h : CGFloat = 50
            let x = CGFloat(i) * w
            let y : CGFloat = 0.0
            
            let button = LLShowView.init()
            button.frame = CGRect(x: x, y: y, width: w, height: h)
            button.style = .normalImage40State
            button.tag = 100 + i
            button.titlelable.text = titles[i]
            button.showimage.image = UIImage.init(named: images[i])
            view.addSubview(button)
            
            button.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(shareBtn(_:))))
        }
    }
    
 
    
    @objc private func cancelDissView(_ sender:UIButton){
        dismissView()
    }
    
    //MARK: -点击分享控件
    @objc private func shareBtn(_ tap:UITapGestureRecognizer){
        
        if tap.view?.tag  == 100{
            shareWechat(platformType: SSDKPlatformType.subTypeWechatSession)
        }else if tap.view?.tag  == 101{
            shareWechat(platformType: SSDKPlatformType.subTypeWechatTimeline)
        }else{
            savePhoto()
        }
        dismissView()
    }
    
    //MARK: -分享到朋友圈或者微信好友
    private func shareWechat(platformType:SSDKPlatformType){
        let param = NSMutableDictionary()
        param.ssdkSetupShareParams(byText: "", images: screenshotScrollView(scrollView:mainView), url: nil, title: "", type: SSDKContentType.auto)
        ShareSDK.share(platformType, parameters: param) { state, data, contentEntity, error in
            
            if state == .success {
                MBProgressHUD.showSuccess("分享成功")
            }else if state == .fail {
                MBProgressHUD.showError("分享失败")
            }else {
                
            }
            
        }
    }
    //MARK: - 保存图片
    private func savePhoto(){
        
        UIImageWriteToSavedPhotosAlbum(screenshotScrollView(scrollView:mainView) ?? UIImage.init(), self, #selector(imageSavedToPhotosAlbum), nil)
    }
    @objc private func imageSavedToPhotosAlbum(image:UIImage,error:NSError?,contextInfo:AnyObject) {
        
        if error != nil {
            MBProgressHUD.showError("成功失败")
        } else {
            MBProgressHUD.showSuccess("成功保存")
        }
        
    }
    ///点击背景退出界面
    @objc private func dissMissView(_ tap:UITapGestureRecognizer){
        
        if tap.state == .ended {
            
            let point = tap.location(in: nil)
            
            if !(mainView.point(inside: mainView.convert(point, from: mainView.window), with: nil)) {
                dismissView()
            }
        }
    }
    //MARK: -界面退出
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
