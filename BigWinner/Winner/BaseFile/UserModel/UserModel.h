//
//  UserModel.h
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface UserModel : NSObject<MJKeyValue>
/** 用户信息 */
+ (instancetype)sharedUserInfo;
/** 设置用户信息 */
+ (void)setUserInfoModelWithTokenDict:(NSDictionary *)dict;
+ (void)setUserInfoModelWithDict:(NSDictionary *)dict;
+ (void)resetModel:(UserModel *)model;
/// 1=已经设置支付密码；2=未设置支付密码
@property (nonatomic,copy)NSString *has_password;
@property (nonatomic,copy)NSString *is_company;
@property (nonatomic,copy)NSString *shop_id;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *nick;
@property (nonatomic,assign) NSInteger is_wx;/** <#class#> **/
@property (nonatomic,assign) BOOL isClerk;/** class **/
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *headIcon;
@property (nonatomic,assign) NSInteger clerkStatus;/** 状态（1待审核、2已通过、3不通过） **/
@property (nonatomic,assign) NSInteger shopStatus;/** 状态（1待审核、2已通过、3不通过） **/
@property (nonatomic,assign) BOOL isShop;/** class **/
@property (nonatomic,assign) NSInteger messageNum;/** class **/
@property (nonatomic, copy) NSString *account;

@property (nonatomic,assign) NSInteger is_ali;/** <#class#> **/
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *level;
@property (nonatomic,copy)NSString *birthday;
@property (nonatomic,copy) NSString *name;/** <#class#> **/
@property (nonatomic,copy) NSString *icon;/** <#class#> **/
@property (nonatomic,strong) UserModel *level_object;/** <#class#> **/
@property (nonatomic,copy) NSString *third_username;/** <#class#> **/
@property (nonatomic,assign) NSInteger has_safe_password;/** <#class#> **/
@property (nonatomic,copy) NSString *pid;/** <#class#> **/
@property (nonatomic,copy)NSString *experience;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy) NSString *gender;/** <#class#> **/
@property (nonatomic,copy)NSString *uploadToken;
@property (nonatomic,copy) NSString *district;/** <#class#> **/
@property (nonatomic,copy) NSString *province;/** <#class#> **/
@property (nonatomic,copy) NSString *city;/** <#class#> **/
@property (nonatomic,copy) NSString *bankName;/** <#class#> **/
@property (nonatomic,copy) NSString *realName;/** <#class#> **/
@property (nonatomic,assign) NSInteger userIdentity;/** 用户身份（1普通用户，2推广点，3配送员） **/


- (BOOL)checkSetPsw;

+(void)saveInfo;
@end
