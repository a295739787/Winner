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
