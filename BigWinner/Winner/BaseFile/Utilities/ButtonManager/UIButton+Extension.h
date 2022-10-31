//
//  UIButton+Extension.h
//  text
//
//  Created by 利君 on 15/9/10.
//  Copyright (c) 2017年 LiJun All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (Extension)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
/** 创建按钮，设置按钮文字，文字颜色默认灰色，文字大小默认12 */
+ (instancetype)buttonWithTitle:(NSString *)title atTarget:(id)target atAction:(SEL)action;

/** 创建按钮，设置按钮文字与大小，文字颜色默认灰色 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleSize:(CGFloat)size atTarget:(id)target atAction:
(SEL)action;
/** 创建按钮，设置按钮文字与文字颜色，文字大小默认12 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleColor:(UIColor *)color atTarget:(id)target atAction:(SEL)action;

/** 创建按钮，设置按钮文字、文字颜色与文字大小 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleSize:(CGFloat)size atTitleColor:(UIColor *)color atTarget:(id)target atAction:(SEL)action;

- (void)setEnlargeEdge:(CGFloat) size;
- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

/** 创建带有图片与文字的按钮，文字颜色默认为灰色 */
+ (instancetype)buttonWithTitle:(NSString *)title atNormalImageName:(NSString *)normalImageName atSelectedImageName:(NSString *)selectedImageName atTarget:(id)target atAction:(SEL)action;

/** 创建带有图片与文字的按钮，图片在右边   文字颜色默认为灰色 */
+ (instancetype)buttonWithTitle:(NSString *)title atRightNormalImageName:(NSString *)ImageName atRightSelectedImageName:(NSString *)selectedImageName atTarget:(id)target atAction:(SEL)action;

/** 创建带有背景图片与文字的按钮，文字颜色默认为灰色 */
+ (instancetype)buttonWithTitle:(NSString *)title atBackgroundNormalImageName:(NSString *)BackgroundImageName atBackgroundSelectedImageName:(NSString *)BackgroundselectedImageName atTarget:(id)target atAction:(SEL)action;


- (void)invalidate;
/** 验证码倒计时 **/
-(void)jk_startTime:(NSInteger )timeout waitTittle:(NSString *)waitTittle;

/** 按钮图片文字具体 **/
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;


/** 设置按钮背景色 **/
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/// 设置渐变色
/// @param starColor 开始色
/// @param endColor 结束色
- (void)setGradientStarColor:(NSString *)starColor endColor:(NSString *)endColor;
@end
