//
//  UIColor+ColorChange.h
//  QuickGames
//
//  Created by 利君 on 2017/6/6.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import <UIKit/UIKit.h>
typedef struct
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}RGBA;
@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
// 颜色转换：16进制转为 R值
+ (CGFloat ) rValueWithHexString: (NSString *)color;
// 颜色转换：16进制转为 G值
+ (CGFloat ) gValueWithHexString: (NSString *)color;
// 颜色转换：16进制转为 B值
+ (CGFloat ) bValueWithHexString: (NSString *)color;

/**
 *  获取UIColor对象的RGBA值
 *
 *  @param color UIColor
 *
 *  @return RGBA
 */
RGBA RGBAFromUIColor(UIColor *color);
@end
