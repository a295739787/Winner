//
//  UIView+HSConfiguration.h
//  HuaSheng
//
//  Created by 杨波 on 2018/5/3.
//  Copyright © 2018年 ebenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HSConfiguration)

/**
 为控件添加渐变色

 @param starColor 起点颜色
 @param endColor 结点颜色
 */
- (void)setGradientStarColor:(NSString *)starColor EndColor:(NSString *)endColor;

- (void)setGradientStarColor:(UIColor *)starColor endColor:(UIColor *)endColor;

/**
 获取当前view所在的UIViewController
 */
- (UIViewController *)controller;

-(void)setShowdow;
@end
