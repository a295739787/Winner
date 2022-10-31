//
//  LLGoodModel.m
//  Winner
//
//  Created by 廖利君 on 2022/2/15.
//

#import "LLGoodModel.h"

@implementation LLGoodModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"descriptionStr":@"description",
             };
}
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"carousels":@"LLGoodModel",
             @"list":@"LLGoodModel",
             @"goodsEvaluateLists":@"LLGoodModel",
             @"goodsSpecsLists":@"LLGoodModel",
             @"goodsSpecsValLists":@"LLGoodModel",
             @"address_list":@"LLGoodModel",
             @"appOrderConfirmGoodsVo":@"LLGoodModel",
             @"redUsers":@"LLGoodModel",
             @"carousels":@"LLGoodModel",
             @"appOrderListGoodsVos":@"LLGoodModel",
             

             
    };
}
@end
