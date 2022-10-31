//
//  UserModel.m
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import "UserModel.h"

static UserModel *userInfo = nil;
@implementation UserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
+ (instancetype)sharedUserInfo {
    return userInfo;
}

+ (void)setUserInfoModelWithTokenDict:(NSDictionary *)dict {
    if (dict == nil){
        return;
    }
    UserModel *model = [UserModel mj_objectWithKeyValues:dict];
    userInfo = model;
 
}
+ (void)setUserInfoModelWithDict:(NSDictionary *)dict{
    if (dict == nil){
        return;
    }
    UserModel *model = [UserModel mj_objectWithKeyValues:dict];
    model.token = userInfo.token;
    model.third_username = userInfo.third_username;
    userInfo = model;
    [AccessTool saveUserInfo];
}
+ (void)resetModel:(UserModel *)model {
    userInfo = model;
}
- (id)initWithCoder:(NSCoder *)deCoder {
    if (self = [super init]) {
        for (NSString *key in [self getPropertyList:[UserModel class]]) {
            id value = [deCoder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder {
    for (NSString *key in [self getPropertyList:[self class]]) {
        id value = [self valueForKey:key];
        [enCoder encodeObject:value forKey:key];
    }
}

/// 获取类的属性列表

- (NSArray *)getPropertyList:(Class)klass {
    NSMutableArray *propertyNamesArray = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
//        const char * name = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        //遵守协议就会出现
        NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
        if ([filters containsObject:name]) {
            continue;
        }
        [propertyNamesArray addObject:name];
    }
    free(properties);
    return propertyNamesArray;
}

- (BOOL)checkSetPsw {
    return self.has_safe_password == 1;
}
+(void)saveInfo{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [UserModel setUserInfoModelWithDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
    } failure:^(NSError * _Nonnull error) {
        
    }];
   
}
@end
