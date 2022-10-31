//
//  UIColor+ColorChange.m
//  QuickGames
//
//  Created by 利君 on 2017/6/6.
//  Copyright © 2017年 LiJun All rights reserved.
//

#import "UIColor+ColorChange.h"

@implementation UIColor (ColorChange)
+ (UIColor *) colorWithHexString: (NSString *)color
{
    return [UIColor colorWithRed:((float) [self rValueWithHexString:color] / 255.0f) green:((float) [self gValueWithHexString:color] / 255.0f) blue:((float) [self bValueWithHexString:color] / 255.0f) alpha:1.0f];
    
//    NSString *colorString = [[color stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
//    CGFloat alpha, red, blue, green;
//    switch ([colorString length]) {
//        case 3: // #RGB
//            alpha = 1.0f;
//            red   = [self colorComponentFrom: colorString start: 0 length: 1];
//            green = [self colorComponentFrom: colorString start: 1 length: 1];
//            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
//            break;
//        case 4: // #ARGB
//            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
//            red   = [self colorComponentFrom: colorString start: 1 length: 1];
//            green = [self colorComponentFrom: colorString start: 2 length: 1];
//            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
//            break;
//        case 6: // #RRGGBB
//            alpha = 1.0f;
//            red   = [self colorComponentFrom: colorString start: 0 length: 2];
//            green = [self colorComponentFrom: colorString start: 2 length: 2];
//            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
//            break;
//        case 8: // #AARRGGBB
//            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
//            red   = [self colorComponentFrom: colorString start: 2 length: 2];
//            green = [self colorComponentFrom: colorString start: 4 length: 2];
//            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
//            break;
//        default:
//            blue=0;
//            green=0;
//            red=0;
//            alpha=0;
//            break;
//    }
//    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
    
    
}

+(CGFloat)rValueWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return 0;
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return 0;
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    // Scan values
    unsigned int r;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    return r;
}

+(CGFloat)gValueWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return 0;
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return 0;
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.length = 2;
    //R、G、B
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // Scan values
    unsigned int g;

    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    return g;
}

+(CGFloat)bValueWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return 0;
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return 0;
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.length = 2;
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int  b;
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return b;
}


RGBA RGBAFromUIColor(UIColor *color)
{
    return RGBAFromCGColor(color.CGColor);
}

RGBA RGBAFromCGColor(CGColorRef color)
{
    RGBA rgba;
    
    CGColorSpaceRef color_space = CGColorGetColorSpace(color);
    CGColorSpaceModel color_space_model = CGColorSpaceGetModel(color_space);
    const CGFloat *color_components = CGColorGetComponents(color);
    size_t color_component_count = CGColorGetNumberOfComponents(color);
    
    switch (color_space_model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            assert(color_component_count == 2);
            rgba = (RGBA)
            {
                .r = color_components[0],
                .g = color_components[0],
                .b = color_components[0],
                .a = color_components[1]
            };
            break;
        }
            
        case kCGColorSpaceModelRGB:
        {
            assert(color_component_count == 4);
            rgba = (RGBA)
            {
                .r = color_components[0],
                .g = color_components[1],
                .b = color_components[2],
                .a = color_components[3]
            };
            break;
        }
            
        default:
        {
            rgba = (RGBA) { 0, 0, 0, 0 };
            break;
        }
    }
    
    return rgba;
}



+(CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
