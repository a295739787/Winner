//
//  LLMeOrderListModel.m
//  Winner
//
//  Created by YP on 2022/2/23.
//

#import "LLMeOrderListModel.h"

@implementation LLMeOrderListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":@"listModel",
             @"appOrderListGoodsVos":@"LLMeOrderListModel",
    };
}

@end
