//
//  UIView+HSConfiguration.m
//  HuaSheng
//
//  Created by 杨波 on 2018/5/3.
//  Copyright © 2018年 ebenny. All rights reserved.
//

#import "UIView+HSConfiguration.h"

@implementation UIView (HSConfiguration)

/**
 为控件添加渐变色
 
 @param starColor 起点颜色
 @param endColor 结点颜色
 */
- (void)setGradientStarColor:(NSString *)starColor EndColor:(NSString *)endColor{

    UIColor *stars = [UIColor colorWithHexString:starColor];
    UIColor *ends = [UIColor colorWithHexString:endColor];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, self.width, self.height);
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = @[(__bridge id)stars.CGColor, (__bridge id)ends.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    self.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:72/255.0 blue:68/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,11);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 15;
    [self.layer addSublayer:gl];
    [self.layer addSublayer:gl];
    
}

- (void)setGradientStarColor:(UIColor *)starColor endColor:(UIColor *)endColor{
        
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, self.width, self.height);
    gl.startPoint = CGPointMake(0.56, 1);
    gl.endPoint = CGPointMake(0.56, 0);
    gl.colors = @[(__bridge id)starColor.CGColor, (__bridge id)endColor.CGColor];
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self.layer addSublayer:gl];
    
}


-(void)setShowdow{
    CALayer *layer = [self layer];
    layer.shadowOffset = CGSizeMake(0, 3); //(0,0)时是四周都有阴影
    layer.shadowRadius = 5.0;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.5;
    [self.layer addSublayer:layer];
}


/**
 获取当前view所在的UIViewController
 */
- (UIViewController *)controller{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
