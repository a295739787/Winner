//
//  UIImageView+Extension.h
//  PieLifeApp
//
//  Created by libj on 2019/8/8.
//  Copyright © 2019 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)

/**
 加载图片 使用默认占位图
 
 @param urlStr 图片地址
 */
- (void)sd_setImageWithUrlString:(NSString *)urlStr;

- (void)sd_setImageWithUrlString:(NSString *)urlStr placeholderImageName:(NSString * _Nullable )placeholderImageName;
/**
 加载图片
 
 @param urlStr 图片地址
 @param placeholderImage 占位图
 */
- (void)sd_setImageWithUrlString:(NSString *)urlStr placeholderImage:(UIImage * _Nullable )placeholderImage;


@end

NS_ASSUME_NONNULL_END
