//
//  UILabel+AlertActionFont.h
//  Wisdomfamily
//
//  Created by libj on 2019/5/17.
//  Copyright © 2019 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AlertActionFont)
- (void) textLeftTopAlign;
@property (nonatomic,copy) UIFont *appearanceFont UI_APPEARANCE_SELECTOR;


/**
 自定义文字大小与颜色

 @param text 内容
 @param color 字体颜色
 @param size 字体大小
 @return 返回label
 */
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size;

/**
 自定义文字大小与颜色

 @param text 内容
 @param color 字体颜色
 @param font 字体
 @return 返回label
 */
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;


+(void)showLever:(NSInteger)level;
@end

NS_ASSUME_NONNULL_END
