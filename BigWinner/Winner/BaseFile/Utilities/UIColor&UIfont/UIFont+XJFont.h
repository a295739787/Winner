//
//  UIFont+XJFont.h
//  UIFont分类
//
//  Created by 雷小军 on 2017/7/11.
//  Copyright © 2017年 雷小军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (XJFont)


/**
 
 苹方-简 常规体
 font-family: PingFangSC-Regular, sans-serif;
 苹方-简 极细体
 font-family: PingFangSC-Ultralight, sans-serif;
 苹方-简 细体
 font-family: PingFangSC-Light, sans-serif;
 苹方-简 纤细体
 font-family: PingFangSC-Thin, sans-serif;
 苹方-简 中黑体
 font-family: PingFangSC-Medium, sans-serif;
 苹方-简 中粗体
 font-family: PingFangSC-Semibold, sans-serif;
 
 **/

+ (UIFont *)adjustFontSize:(CGFloat)fontSize;

/**
 苹方

 @param fontSize 字体大小
 @return font
 */
+ (UIFont *) fontWithFontSize:( CGFloat ) fontSize;

/**
 通过字体大小，笔锋状态 来获取UIFont对象

 @param fontSize 字体大小
 @param fontWeight 笔锋
 @return font
 */
+ (UIFont *) fontWithFontSize:( CGFloat ) fontSize
                   fontWeight:( UIFontWeight )fontWeight;

/**
 苹方-简 中粗体

 @param fontSize 字体大小
 @return font
 */
+ (UIFont *) boldFontWithFontSize:( CGFloat ) fontSize;

+ (UIFont *)dinFontWithFontSize:(CGFloat)fontSize;
@end
