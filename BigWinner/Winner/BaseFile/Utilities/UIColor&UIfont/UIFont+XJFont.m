//
//  UIFont+XJFont.m
//  UIFont分类
//
//  Created by 雷小军 on 2017/7/11.
//  Copyright © 2017年 雷小军. All rights reserved.
//

#import "UIFont+XJFont.h"

@implementation UIFont (XJFont)

+ (UIFont *)adjustFontSize:(CGFloat)fontSize {

    
    if ([UIScreen mainScreen].bounds.size.width > 375) {
        fontSize = fontSize + 1.5;
    }else if ([UIScreen mainScreen].bounds.size.width == 375){
        fontSize = fontSize;
    }else if ([UIScreen mainScreen].bounds.size.width == 320){
        fontSize = fontSize - 1;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}


+ (UIFont *) fontWithFontSize:( CGFloat ) fontSize {
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *) boldFontWithFontSize:( CGFloat ) fontSize {
    
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

+ (UIFont *) fontWithFontSize:( CGFloat ) fontSize
                   fontWeight:( UIFontWeight )fontWeight {
    
    return [UIFont systemFontOfSize:fontSize weight:fontWeight];
}
@end
