//
//  LLBackBuyModel.m
//  Winner
//
//  Created by YP on 2022/3/16.
//

#import "LLBackBuyModel.h"

@implementation LLBackBuyModel



YYModelExplain {
    return @{@"list":LLBackBuyListModel.class};
}

@end


@implementation LLBackBuyListModel

YYModelLocaKey_SerKey{
    return @{
             @"ID":@"id",
             };
}

@end
