//
//  XYAddressPickerView.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/10/25.
//

import UIKit

@objcMembers class XYAddressPickerView: UIView{

    var containView = UIView()
    var pickerView = UIPickerView()
    
    ///省
    var provinceArray = NSArray()
    ///市
    var cityArray = NSArray()
    ///区
    var areaArray = NSArray()
    ///所有数据
    var dataSource = NSArray()
    ///记录省选中的位置
    var selectProvinceIndex:Int = 0
    ///默认选中的省
    var selectProvince :String = ""
    ///默认选中的市
    var selectCity :String = ""
    ///默认选中的区
    var selectArea :String = ""

    ///选中省市区
    var addressClickBlock :((String,String,String) -> Void)?
    
    /// 初始化地址页，参数必传，默认全屏无法修改
    /// - Parameters:
    ///   - province: 省
    ///   - city: 市
    ///   - area: 区
    public init(province:String,city:String,area:String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
       selectProvince = province
        selectCity = city
        selectArea = area
        
       loadMainSubView()
    }
    
    //MARK: - 加载主视图
    private func loadMainSubView(){
        
        containView = UIView.init()
        containView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 300)
        self.addSubview(containView)
        
        let toolBar = UIView.init()
        toolBar.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 50)
        toolBar.backgroundColor = UIColor(hexString: "0xf6f6f6")
        containView.addSubview(toolBar)
        
        let cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 65, height: toolBar.frame.size.height)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.tag = 101
        cancelButton.setTitleColor(.hexString("0x666666"), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        toolBar.addSubview(cancelButton)
        
        let sureButton = UIButton.init(type: .custom)
        sureButton.frame = CGRect(x: toolBar.frame.size.width-65, y: 0, width: 65, height: toolBar.frame.size.height)
        sureButton.setTitle("确定", for: .normal)
        sureButton.tag = 102
        sureButton.setTitleColor(.blue, for: .normal)
        sureButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        sureButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        toolBar.addSubview(sureButton)
        
        pickerView = UIPickerView.init()
        pickerView.backgroundColor = .white
        pickerView.frame = CGRect(x: 0, y: toolBar.frame.maxY, width: containView.frame.size.width, height: containView.frame.size.height-toolBar.frame.size.height)
        pickerView.delegate = self
        pickerView.dataSource = self
        containView.addSubview(pickerView)
  
        loadMainDataSource()
    }
    
    //MARK: - 获取数据
    private func loadMainDataSource(){
        
        let path = Bundle.main.path(forResource: "city", ofType: "plist")
        dataSource = NSArray(contentsOfFile: path ?? "") ?? []
        let tempArray = NSMutableArray()
        
        for  index in 0..<dataSource.count {
           let tempDic = dataSource[index] as! NSDictionary
            for tempIndex in 0..<tempDic.allKeys.count {
                tempArray.add(tempDic.allKeys[tempIndex])
            }
        }
        
        provinceArray = tempArray.copy() as! NSArray
        cityArray = getCityFromProvinceIndex(index: 0)
        areaArray = getAreaFromProvinceAndcCity(provinceIndex: 0, cityIndex: 0)
        
        ///默认初始化省市区
        if selectProvince.isEmpty {
            selectProvince = provinceArray.firstObject as! String
        }
        if selectCity.isEmpty {
            selectCity = cityArray.firstObject as! String
        }
        if selectArea.isEmpty {
            selectArea = areaArray.firstObject as! String
        }
        
        ///定位到相应的省市区
        var provinceIndex = 0
        var cityIndex = 0
        var areaIndex = 0

        for p in 0..<provinceArray.count {
            let pString = provinceArray[p] as! String
            if selectProvince == pString {
                selectProvinceIndex = p
                provinceIndex = p
               cityArray = getCityFromProvinceIndex(index: p)
                for c in 0..<cityArray.count {
                    let cString = cityArray[c] as! String
                    if selectCity == cString {
                        cityIndex = c
                        areaArray = getAreaFromProvinceAndcCity(provinceIndex: p, cityIndex: c)
                        for a in 0..<areaArray.count {
                            let aString = areaArray[a] as! String
                            if selectArea == aString {
                                areaIndex = a
                            }
                        }
                    }
                }
            }
        }
        
        pickerView.selectRow(provinceIndex, inComponent: 0, animated: true)
        pickerView.selectRow(cityIndex, inComponent: 1, animated: true)
        pickerView.selectRow(areaIndex, inComponent: 2, animated: true)
        
    }
    
    //MARK: - 获取城市数据
    private func getCityFromProvinceIndex(index:Int) ->NSArray{
        let provinceDic = dataSource[index] as! NSDictionary
        let cityDic = provinceDic.object(forKey: provinceArray[index]) as! NSDictionary
        let cityArray = NSMutableArray()
        let valueDic = cityDic.allValues
        for index in 0..<valueDic.count {
            let tempDic = valueDic[index] as! NSDictionary
            for tempIndex in 0..<tempDic.allKeys.count {
                cityArray.add(tempDic.allKeys[tempIndex])
            }
        }
        
        return cityArray.copy() as! NSArray
    }
    
    //MARK: - 获取区数据
    private func getAreaFromProvinceAndcCity(provinceIndex:Int,cityIndex:Int) ->NSArray{

        let provinceDic = dataSource[provinceIndex] as! NSDictionary
        let cityDic = provinceDic.object(forKey: provinceArray[provinceIndex]) as! NSDictionary
        let areaDic = cityDic.allValues[cityIndex] as! NSDictionary
        var array = NSArray()
        array = areaDic.object(forKey: cityArray[cityIndex]) as! NSArray
        
       return array
    }
    
    //MARK: - 显示地址页面
    /// 显示地址页面
    public func showView(){
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, animations:{
            self.backgroundColor = UIColor(hexString: "0x000000", alpha: 0.3)
            self.containView.frame.origin.y =  self.frame.size.height - self.containView.frame.size.height
        })
        
    }
    //MARK: - 隐藏页面
    private func hideView(){
        UIView.animate(withDuration: 0.3, animations: {
            
            self.backgroundColor = .clear
            self.containView.frame.origin.y  = self.frame.size.height
        }, completion: { finished in
            self.removeFromSuperview()
        })
    }
    
    ///取消和确认按钮点击方法
    @objc private func buttonClick(_ sender:UIButton){
        hideView()
        if sender.tag == 102 {
            self.addressClickBlock?(selectProvince,selectCity,selectArea)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        
    }
}
//MARK: - 多重选择代理
extension XYAddressPickerView :UIPickerViewDelegate,UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinceArray.count
        }else if component == 1 {
            return cityArray.count
        }else{
            return areaArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel.init()
        label.frame = CGRect(x: 0, y: 0, width: self.frame.size.width/3, height: 30)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center

        if (component == 0) {
            label.text = provinceArray[row] as? String
        }else if (component == 1){
            label.text = cityArray[row] as? String
        }else{
            label.text = areaArray[row] as? String
        }

        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectProvinceIndex = row
            
            cityArray = getCityFromProvinceIndex(index: row)
            areaArray = getAreaFromProvinceAndcCity(provinceIndex: row, cityIndex: 0)
            
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)

            selectProvince = provinceArray[row] as! String
            selectCity = cityArray[0] as! String
            selectArea = areaArray[0] as! String
            
        }else if component == 1 {
            
            areaArray = getAreaFromProvinceAndcCity(provinceIndex: selectProvinceIndex, cityIndex: row)
            
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            selectCity = cityArray[row] as! String
            selectArea = areaArray[0] as! String
        }else{
            
            selectArea = areaArray[row] as! String
        }
    }
    
}
