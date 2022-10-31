//
//  AccessTool.h
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTool : NSObject
/** 保存用户信息数据 */
+ (void)saveUserInfo;
/** 读取用户数据 */
+ (void)loadUserInfo;
/** 删除用户数据 */
+ (void)removeUserInfo;
/** 保存整型数据 */
+ (void)saveIntgerValueWith:(NSInteger)value key:(NSString *)key;
/** 读取整型数据 */
+ (NSInteger)loadIntgerValueWithKey:(NSString *)key;
@end
