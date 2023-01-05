//
//  DataModel.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/11/10.
//

import Foundation
import MJExtension


// MARK: - 数据模型
///库存明细
class StockModel: NSObject {
    @objc var orderNo : String = ""
    @objc var id : String = ""
    @objc var createTime : String = ""
    @objc var userId : String = ""
    @objc var type : String = ""
    @objc var goodsNum : Int = 0
}

///消费钱包与钱包余额
class WalletOrConsumeModel:NSObject{
    
    ///现金累计收入
    @objc var totalCashRedPrice : Double = 0.0
    ///现金累计支出
    @objc var totalOutCashRedPrice : Double = 0.0
    ///现金余额
    @objc var totalReCashRedPrice : Double = 0.0
    ///红包累计收入
    @objc var totalConsumeRedPrice : Double = 0.0
    ///红包累计支出
    @objc var totalOutConsumeRedPrice : Double = 0.0
    ///红包余额
    @objc var totalReConsumeRedPrice : Double = 0.0    
}
///钱包固定数据
var WalletType : [Int:String] {
    
    let type = [1:"惊喜红包奖励",2:"推广佣金",3:"回购商品",4:"配送任务库存金额反还",5:"配送任务佣金奖励",6:"提现",7:"配送任务超时罚款",9:"红包购买商品抵扣",14:"扫码开盖/幸运红包",15:"配送超时消费红包",16:"排行包消费红包",18:"提现失败余额退回",19:"订单取消返回红包",20:"惊喜红包奖励平台手续费",21:"推广佣金代缴个税",22:"回购商品平台手续费",23:"配送任务佣金奖励代缴个税"]
    return type
}
///钱包符号对应列表
var WalletSymbol : [Int:String] {
    
    let symbol = [1:"+",2:"+",3:"+",4:"+",5:"+",6:"-",7:"-",9:"-",14:"+",15:"+",16:"+",18:"+",19:"+",20:"-",21:"-",22:"-",23:"-"]
    return symbol
}

///钱包收支明细
class WalletIncomeAndRecoverModel:NSObject{
    
    @objc var createTime : String = ""
    @objc var id : String = ""
    @objc var orderNo : String = ""
    @objc var price : Double = 0.0
    @objc var surplusPrice : Double = 0.0
    @objc var type : Int = 0
    @objc var withdrawalMsg : String = ""
    @objc var withdrawalStatus : Int = 0
}

///酒卡列表数据
class LiquorCardModel:NSObject{
    
    @objc var cardNo : String = ""
    @objc var goodsName : String = ""
    @objc var id : String = ""
    @objc var goodsId : String = ""
    @objc var goodsPic : String = ""
    @objc var remainNum : Int = 0
    @objc var cardExpdate : String = ""
}

///酒卡明细数据
class LiquorCardDetailModel:NSObject{
    
    @objc var userId : String = ""
    @objc var id : String = ""
    @objc var goodsId : String = ""
    @objc var orderNo : String = ""
    @objc var goodsNum : Int = 0
    @objc var remainNum : Int = 0
    @objc var type : String = ""
    @objc var createTime : String = ""
    
    @objc var goodsSpecsPriceId : String = ""
    @objc var stockType : Int = 0
    @objc var orderId : String = ""
    @objc var status : String = ""
    @objc var typeName : String = ""
}

///酒卡背景样式数据
class LiquorCardStyleModel:NSObject{
    
    @objc var id : String = ""
    @objc var buttonEnColor : String = ""
    @objc var bgImages : String = ""
    @objc var buttonDisColor : String = ""
    @objc var footImages : String = ""
    
}
