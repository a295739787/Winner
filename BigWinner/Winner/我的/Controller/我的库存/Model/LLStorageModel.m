//
//  LLStorageModel.m
//  Winner
//
//  Created by YP on 2022/3/16.
//

#import "LLStorageModel.h"

@implementation LLStorageModel



YYModelExplain {
    return @{@"list":LLStorageListModel.class};
}

@end



@implementation LLStorageListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
            };
}

YYModelLocaKey_SerKey{
    return @{
             @"ID":@"id",
             };
}


@end
