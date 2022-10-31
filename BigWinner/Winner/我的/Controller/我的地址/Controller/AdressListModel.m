//
//  AdressListModel.m
//  Winner
//
//  Created by YP on 2022/2/17.
//

#import "AdressListModel.h"

@implementation AdressListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
            };
}
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":@"AdressListModel",
             @"pagination":@"AdressListModel"
    };
}

@end
