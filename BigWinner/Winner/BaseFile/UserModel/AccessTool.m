//
//  AccessTool.m
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import "AccessTool.h"
#import "UserModel.h"

@implementation AccessTool
+ (void)saveUserInfo {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    
    [NSKeyedArchiver archiveRootObject:[UserModel sharedUserInfo] toFile:userInfoPath];
}

+ (void)removeUserInfo
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDelete = [manager removeItemAtPath:userInfoPath error:nil];
    [AccessTool loadUserInfo];
}

+ (void)loadUserInfo {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [path stringByAppendingPathComponent:@"userInfo.data"];
    /** 读取信息 */
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
    if (![NSString isBlankString:model.token]) {
        [UserModel resetModel:model];
    }
    
//    [UserModel sharedUserInfo].ID = model.ID;
//    [UserModel sharedUserInfo].isset_pay_password = model.isset_pay_password;
//        [UserModel sharedUserInfo].order_b = model.order_b;
//    [UserModel sharedUserInfo].head_img = model.head_img;
//    [UserModel sharedUserInfo].order_d = model.order_d;
//    [UserModel sharedUserInfo].order_a = model.order_a;
//    [UserModel sharedUserInfo].grade_id = model.grade_id;
//    [UserModel sharedUserInfo].price = model.price;
//    [UserModel sharedUserInfo].level = model.level;
//    [UserModel sharedUserInfo].order_c = model.order_c;
//    [UserModel sharedUserInfo].point = model.point;
//    [UserModel sharedUserInfo].tel = model.tel;
//    [UserModel sharedUserInfo].coupon_count = model.coupon_count;
//    [UserModel sharedUserInfo].nickname = model.nickname;
//    [UserModel sharedUserInfo].token = model.token;
//    [UserModel sharedUserInfo].is_member = model.is_member;
}

+ (void)saveIntgerValueWith:(NSInteger)value key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (NSInteger)loadIntgerValueWithKey:(NSString *)key {
    return  [[NSUserDefaults standardUserDefaults] integerForKey:key];
}


@end
