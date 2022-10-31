//
//  LLMeOrderDetailModel.m
//  Winner
//
//  Created by YP on 2022/3/13.
//

#import "LLMeOrderDetailModel.h"

@implementation LLMeOrderDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             };
}



YYModelExplain {
    return @{@"appOrderListGoodsVos":LLappOrderListGoodsVos.class};
}

@end




@implementation LLappAddressInfoVo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"adressId":@"id",
             };
}


@end




@implementation LLappOrderListGoodsVos

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"idd":@"id",
             };
}


@end



@implementation LLappOrderEvaluateVo



@end





//@implementation LLappDeliveryClerkDistanceVo
//
//
//
//@end






@implementation LLshopDistanceVo


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"idd":@"id",
             };
}

@end



