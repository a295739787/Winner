//
//  UIImage+Extension.h
//  SmartDevice
//
//  Created by singelet on 16/6/28.
//  Copyright © 2016年 ALPHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)mergeImage:(NSArray *)imgArray;

+ (UIImage *)zh_fetchImage:(NSString *)imageNameOrPath;

+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)mergeImage:(UIImage *)img1 andPoint:(CGPoint)point1 andImg2:(UIImage *)img2 andPoint2:(CGPoint)point2 andMergeImageSize:(CGSize)size;

+ (UIImage *)resizeImage:(UIImage *)originImage andSize:(CGSize)size;

+ (UIImage *)makeStyleMaskImageFromSourceImg:(UIImage *)sourImg andMask:(UIImage *)maskImg andSize:(CGSize)imgSize andTeeSize:(CGSize)teeSize;

#pragma mark  固定宽度  获取图片的高度
+(CGFloat) imageCompressForWidth:(NSString *)path targetWidth:(CGFloat)defineWidth;
+ (UIImage *)blurImageWithImage:(UIImage *)image;

#pragma mark  获取图片宽高
+ (CGSize)getImageSizeWithURL:(id)URL;
@end
