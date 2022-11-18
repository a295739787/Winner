//
//  XYServiceTipsViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/11.
//

import UIKit

@objcMembers class XYServiceTipsViewController: UIViewController {
    
    var bottomView = UIView()
    var telPhoneButton = UIButton()
    var onLineService = UIButton()
    var lineView = UIView()
    var serviceDic = NSDictionary()
    var pushBlock :((UIViewController) -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dissMissView(_:))))
        
        loadMainView()
    }
    
    private func loadMainView(){
        
        let y =  UIApplication.shared.statusBarFrame.height
        var bottomH = 0.0
        
        if y > 0 {
            bottomH = 135.0
        }else{
            bottomH = 101.0
        }
        
        bottomView = UIView.init()
        bottomView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-135, width: UIScreen.main.bounds.size.width, height: bottomH)
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        loadMasksTopLeftOrRight(view: bottomView)
        
        telPhoneButton = UIButton.init(type: .custom)
        telPhoneButton.tag = 101;
        telPhoneButton.frame = CGRect(x: 0, y: 0, width: bottomView.frame.size.width, height: 50)
        telPhoneButton.setTitle("电话客服", for: .normal)
        telPhoneButton.setTitleColor(.black, for: .normal)
        telPhoneButton.titleLabel?.font = .systemFont(ofSize: 14)
        telPhoneButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bottomView.addSubview(telPhoneButton)
        
        lineView = UIView.init()
        lineView.frame = CGRect(x: 15, y: telPhoneButton.frame.maxY, width: bottomView.frame.size.width-30, height: 1)
        lineView.backgroundColor = UIColor.hexString("#F5F5F5")
        bottomView.addSubview(lineView)
        
        onLineService = UIButton.init(type: .custom)
        onLineService.tag = 102;
        onLineService.frame = CGRect(x: 0, y: lineView.frame.maxY, width: bottomView.frame.size.width, height: 50)
        onLineService.setTitle("联系在线客服", for: .normal)
        onLineService.setTitleColor(.black, for: .normal)
        onLineService.titleLabel?.font = .systemFont(ofSize: 14)
        onLineService.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bottomView.addSubview(onLineService)
        
        
    }
    
    @objc private func dissMissView(_ tap:UITapGestureRecognizer){
        
        if tap.state == .ended {
            
            let point = tap.location(in: nil)
            
            if !(bottomView.point(inside: bottomView.convert(point, from: bottomView.window), with: nil)) {
                dismissView()
            }
        }
    }
    
    ///切左右上圆角
    private func loadMasksTopLeftOrRight(view:UIView){
        
        let path = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: [.topRight,.topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
        view.layer.mask = shapeLayer
        
    }
    
    /// 切换数据
    @objc private func buttonClick(_ sender:UIButton){
        
        if sender.tag == 101 {
            
            let callWebview = UIWebView()
            callWebview.loadRequest(NSURLRequest(url: URL(string: "tel:400-156-9788")!) as URLRequest)
            self.view.addSubview(callWebview)
        }else{
            loadService()
        }
        
        dismissView()
    }
    
    private func loadService(){
        
        QMConnect.sdkGetWebchatScheduleConfig { scheduleDic in
            
            DispatchQueue.main.async { [self] in
                guard let dic  = scheduleDic as? [String:Any] else {
                    return
                }
                serviceDic = scheduleDic! as NSDictionary
                let scheduleEnable = dic["scheduleEnable"] as! Bool
                if scheduleEnable == true {
                    serviceShowMessage(scheduleDic: dic)
                }else{
                    getPeers()
                }
                
            }
            
        } fail: {
            
        }
        
    }
    ///获取技能组信息
    private func getPeers(){
        
        QMConnect.sdkGetPeers { peerArray in
            let peers = peerArray! as NSArray
            DispatchQueue.main.async { [self] in
                
                if (peers.count == 1 && peers.count != 0) {
                    let first = peers.firstObject
                    let dic = first as! NSDictionary
                    showChatRoomViewController(peerId: dic.object(forKey: "id") as! String, processType: "", entranceId: "")
                }else{
                    showPeersWithAlert(peers: peers, messageStr: NSLocalizedString("title.type", comment: ""))
                }
            }
            
        } failureBlock: {
            
        }
        
        
        
    }
    /// 客服回调提示
    private func serviceShowMessage(scheduleDic:[String:Any]){
        
        let scheduleId = scheduleDic["scheduleId"] as! String
        let processId = scheduleDic["processId"] as! String
        let entranceNode = scheduleDic["entranceNode"] as! NSDictionary
        let leavemsgNodes = scheduleDic["leavemsgNodes"] as! String
        
        if (scheduleId.isEmpty ||
            processId.isEmpty ||
            entranceNode.count <= 0 ||
            leavemsgNodes.isEmpty) {
            
            QMRemind.showMessage(NSLocalizedString("title.sorryconfigurationiswrong", comment: ""))
        }else{
            let entranceNode = scheduleDic["entranceNode"] as! NSDictionary
            let entrances = entranceNode["entrances"] as! NSArray
            if (entrances.count == 1 && entrances.count != 0) {
            }else{
                showPeersWithAlert(peers: entrances, messageStr: NSLocalizedString("title.schedule_type", comment: ""))
            }
            
        }
        
    }
    
    /// 消息提示
    private func showPeersWithAlert(peers:NSArray,messageStr:String){
        
        let alertController = UIAlertController.init(title: nil, message: NSLocalizedString("title.type", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: NSLocalizedString("button.cancel", comment: ""), style: .cancel) { action in
        }
        alertController.addAction(cancelAction)
        for index in 0..<peers.count {
            let dic = peers.object(at: index) as! NSDictionary
            let name = dic.object(forKey: "name") as! String
            let surelAction = UIAlertAction.init(title: name, style: .default) { [self] action in
                let processTo = dic.object(forKey: "processTo") as! String
                let processType = dic.object(forKey: "processType") as! String
                let _id = dic.object(forKey: "_id") as! String
                let id = dic.object(forKey: "id") as! String
                
                let scheduleEnable = serviceDic["scheduleEnable"] as! Bool
                if scheduleEnable == true {
                    showChatRoomViewController(peerId: processTo, processType: processType, entranceId: _id)
                }else{
                    showChatRoomViewController(peerId: id, processType: "", entranceId: "")
                }
            }
            alertController.addAction(surelAction)
        }
        self.present(alertController, animated: true)
    }
    
    ///跳转聊天页面
    private func showChatRoomViewController(peerId:String,processType:String,entranceId:String){
        
        if peerId.isEmpty {
            QMRemind.showMessage("peerId不能为空")
            return
        }
        
        let chatRoomViewController = QMChatRoomViewController.init()
        chatRoomViewController.peerId = peerId
        chatRoomViewController.disMissViewBlock = {
            
        }
        chatRoomViewController.isPush = false
        chatRoomViewController.avaterStr = ""
        chatRoomViewController.darkStyle = .init(rawValue: 1)
        
        let scheduleEnable = serviceDic["scheduleEnable"] as! Bool
        if scheduleEnable == true {
            if (processType.isEmpty && entranceId.isEmpty) {
                QMRemind.showMessage("processType和entranceId为必传参数")
                return
            }
            chatRoomViewController.isOpenSchedule = true
            chatRoomViewController.scheduleId = serviceDic["scheduleId"] as! String
            chatRoomViewController.processId = serviceDic["processId"] as! String
            chatRoomViewController.currentNodeId = peerId
            chatRoomViewController.processType = processType
            chatRoomViewController.entranceId = entranceId
        }else{
            chatRoomViewController.isOpenSchedule = false
        }
        
        self.pushBlock!(chatRoomViewController)
    }
 
    //MARK: -界面退出
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
