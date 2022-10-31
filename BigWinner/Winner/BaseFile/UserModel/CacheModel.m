//
//  CacheModel.m
//  BasicFramework
//
//  Created by 利君 on 2017/6/13.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import "CacheModel.h"

@implementation CacheModel
+(void)setObectOfArray:(NSArray *)array fileName:(NSString *)fileName
{
    
    //缓存文件的 根路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // 缓存 文件夹 路径
    NSString *filePath = [path stringByAppendingPathComponent:@"Project.dataCache"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath] == NO)
    {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //缓存文件的路径
    NSString * cacheFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    BOOL isSuccess = [array writeToFile:cacheFilePath atomically:NO];
    if (isSuccess) {
        NSLog(@"缓存数据成功:---%@",cacheFilePath);
    }else
    {
        NSLog(@"缓存数据失败:---%@",cacheFilePath);
    }
    
}
+(NSArray *)cacheArrayForFileName:(NSString *)fileName
{
    
    //缓存文件的 根路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // 缓存 文件夹 路径
    NSString *filePath = [path stringByAppendingPathComponent:@"Project.dataCache"];
    //缓存文件的路径
    NSString * cacheFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    //取得缓存文件
    NSArray *array  = [NSArray arrayWithContentsOfFile:cacheFilePath];
    
    return array;
}


+(void)clearCacheListData:(void (^)())completion
{
    // 异线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 清楚缓存
        //缓存文件的 根路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        // 缓存 文件夹 路径
        NSString *filePath = [path stringByAppendingPathComponent:@"Project.dataCache"];
        NSFileManager *manager = [NSFileManager defaultManager];
        //移除文件夹
        [manager removeItemAtPath:filePath error:nil];
        //  创建一个新的文件夹
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (completion)
        {
            //回调主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

@end
