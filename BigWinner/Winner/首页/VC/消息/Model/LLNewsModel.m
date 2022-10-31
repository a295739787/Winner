//
//  LLNewsModel.m
//  Winner
//
//  Created by YP on 2022/3/19.
//

#import "LLNewsModel.h"

@implementation LLNewsModel


YYModelExplain {
    return @{@"list":LLNewsListModel.class};
}

@end


@implementation LLNewsListModel

YYModelLocaKey_SerKey{
    return @{
             @"ID":@"id",
             };
}

@end
