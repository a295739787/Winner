//
//  AppDelegate+CloudPushSDK.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/12/2.
//

import Foundation
///ios+
import UserNotifications

extension AppDelegate{
    
    ///初始化推送SDK
    @objc func initCloudPush() {
        
        // 正式上线需要关闭 debug下日志调试
        CloudPushSDK.turnOnDebug()
        CloudPushSDK.autoInit { res in
            
            if res!.success{
                print("Push SDK init success, deviceId: \(CloudPushSDK.getDeviceId()!)")
            }else{
                print("Push SDK init failed, error: \(res!.error!).")

            }
        }
        
    }
    
    
}
