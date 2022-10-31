//
//  PLLocationManage.h
//  PieLifeApp
//
//  Created by libj on 2019/8/3.
//  Copyright © 2019 Libj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MapLocatingCompletionBlock)(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error);
@interface PLLocationManage : NSObject
+ (instancetype)shareInstance;

@property ( nonatomic, copy) MapLocatingCompletionBlock completionBlock;

- (void) requestLocationWithCompletionBlock:(MapLocatingCompletionBlock)completionBlock;

/**
 调用三方软件导航

 @param coordinate 终点经纬度
 */
- (void)doNavigationWithEndLocationWith:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END
