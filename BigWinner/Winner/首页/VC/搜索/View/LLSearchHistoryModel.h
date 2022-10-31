//
//  LLSearchHistoryModel.h
//  ShopApp
//
//  Created by lijun L on 2021/4/16.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLSearchHistoryModel : NSObject
+(LLSearchHistoryModel*)shareInstance;

/**
 *  获取历史搜索记录
 *
 */
-(NSMutableArray*)getSearchHistoryMArray;

/**
 *  清空搜索记录
 */
-(void)clearAllSearchHistory;

/**
 *  清空某个记录
 */
-(void)clearSearchHistory:(NSInteger)row;
/*
 * 保存搜索历史到文件
 */
- (void)saveSearchItemHistory;
@end

NS_ASSUME_NONNULL_END
