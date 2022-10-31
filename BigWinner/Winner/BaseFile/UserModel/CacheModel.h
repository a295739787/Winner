//
//  CacheModel.h
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheModel : NSObject
/**
 *  存 数组数据
 */
+(void)setObectOfArray:(NSMutableArray *)array fileName:(NSString *)fileName;
/**
 *  取 数组数据
 */
+(NSMutableArray *)cacheArrayForFileName:(NSString *)fileName;


/**
 * 清除 这个类(全部) 造成的 缓存 数据，成功的回调Block :completion
 */
+(void)clearCacheListData:(void(^)())completion;

@end
