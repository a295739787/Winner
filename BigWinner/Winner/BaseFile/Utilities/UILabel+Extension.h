//
//  UILabel+Extension.h
//  text
//
//  Created by 利君 on 15/9/10.
//  Copyright (c) 2017年 LiJun All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, attLocationType) {
    attLocationTypeFirst,   // 前面
    attLocationTypeLast,   // 后面
};
@interface UILabel (Extension)

/** 自定义文字大小与颜色 以及字体类型*/
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size atTextFontForType:(NSString *)type;
+(NSAttributedString *)attbuiteImage:(CGRect)bouns titles:(NSString *)title images:(NSString *)images tyle:(attLocationType)type;

/** 自定义文字大小与颜色  字体默认系统字体*/
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size;

/**
 返回适应后偏移的高度
 
 @return 自动适应后偏移的高度
 */
- (CGFloat)heightForOffset;

/**
 返回适应后偏移的高度
 
 @param text 需要适应的文本内容
 @return 自动适应后偏移的高度
 */
- (CGFloat)heightForOffsetWithText:(NSString *)text;

/**
 返回适应后偏移的高度
 
 @param text 需要适应的文本内容
 @param font 需要适应的字体
 @return 自动适应后偏移的高度
 */
- (CGFloat)heightForOffsetWithText:(NSString *)text font:(UIFont *)font;

/**
 返回适应后的实际高度
 
 @return 自动适应后的实际高度
 */
- (CGFloat)heightForAdapt;

/**
 返回适应后的实际高度
 
 @param text 需要适应的文本内容
 @return 自动适应后的实际高度
 */
- (CGFloat)heightForAdaptWithText:(NSString *)text;

/**
 返回适应后的实际高度
 
 @param text 需要适应的文本内容
 @param font 需要适应的字体
 @return 自动适应后的实际高度
 */
- (CGFloat)heightForAdaptWithText:(NSString *)text font:(UIFont *)font;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

@property (nonatomic, assign) UIEdgeInsets yf_contentInsets;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


+(NSAttributedString *)attbuite:(CGRect)bouns titles:(NSString *)title tyle:(attLocationType)type;
@end
