//
//  UIImage+change.h
//  FindWorker
//
//  Created by zhiqiang meng on 16/7/2019.
//  Copyright © 2019 zhiqiang meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (change)

+(UIImage*)changeOrientationImage:(UIImage*)image  orientation:(UIImageOrientation)orientation;

/**
   图片倒立
 */
+(UIImage*)DownImage:(UIImage*)image ;

/**
  图片左转
 */
+(UIImage*)LeftImage:(UIImage*)image ;

/**
 图片右转
 */
+(UIImage*)RightImage:(UIImage*)image ;

/**
 图片镜像倒立
 */
+(UIImage*)MirroredDownImage:(UIImage*)image ;

/**
 图片镜像直立
 */
+(UIImage*)MirroredUpImage:(UIImage*)image ;

/**
  图片镜像左转
 */
+(UIImage*)MirroredLeftImage:(UIImage*)image ;

/**
  图片镜像右转
 */
+(UIImage*)MirroredRightImage:(UIImage*)image ;

@end

NS_ASSUME_NONNULL_END
