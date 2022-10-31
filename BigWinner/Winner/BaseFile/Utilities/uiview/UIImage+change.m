//
//  UIImage+change.m
//  FindWorker
//
//  Created by zhiqiang meng on 16/7/2019.
//  Copyright © 2019 zhiqiang meng. All rights reserved.
//

/**
 
 更改图片方向
 左 右 倒立
 镜像： 直立 左 右 倒立
 
 */


#import "UIImage+change.h"

@implementation UIImage (change)

+(UIImage*)changeOrientationImage:(UIImage*)image  orientation:(UIImageOrientation)orientation{
    
    UIImage *backImage = [UIImage imageNamed:@"fbfw-icon-xl"];
    //改变该图片的方向
    backImage = [UIImage imageWithCGImage:backImage.CGImage
                                    scale:backImage.scale
                              orientation:UIImageOrientationDown];
    
    return backImage ;
}

+(UIImage*)DownImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationDown] ;
}

+(UIImage*)LeftImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationLeft] ;
}

+(UIImage*)RightImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationRight] ;
}

+(UIImage*)MirroredDownImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationDownMirrored] ;
}

+(UIImage*)MirroredUpImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationUpMirrored] ;
}

+(UIImage*)MirroredLeftImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationLeftMirrored] ;
}

+(UIImage*)MirroredRightImage:(UIImage*)image {
    
    return [self changeOrientationImage:image orientation:UIImageOrientationRightMirrored] ;
}

@end
