//
//  UILabel+Extension.m
//  text
//
//  Created by 利君 on 15/9/10.
//  Copyright (c) 2017年 LiJun All rights reserved.
//

#import "UILabel+Extension.h"
#import <objc/runtime.h>
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}
@implementation UILabel (Extension)

- (CGFloat)heightForOffset {
    CGFloat height = self.frame.size.height;
    UIFont *font = self.font;
    NSString *text = self.text;
    return [self heightForAdaptWithText:text font:font] - height;
}

- (CGFloat)heightForOffsetWithText:(NSString *)text {
    CGFloat height = self.frame.size.height;
    UIFont *font = self.font;
    return [self heightForAdaptWithText:text font:font] - height;
}

- (CGFloat)heightForOffsetWithText:(NSString *)text font:(UIFont *)font {
    CGFloat height = self.frame.size.height;
    return [self heightForAdaptWithText:text font:font] - height;
}

- (CGFloat)heightForAdapt {
    UIFont *font = self.font;
    NSString *text = self.text;
    return [self heightForAdaptWithText:text font:font];
}

- (CGFloat)heightForAdaptWithText:(NSString *)text {
    UIFont *font = self.font;
    return [self heightForAdaptWithText:text font:font];
}

- (CGFloat)heightForAdaptWithText:(NSString *)text font:(UIFont *)font {
    CGFloat width = self.frame.size.width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    CGRect frame = self.frame;
    frame.size.height = label.frame.size.height;
    self.frame = frame;
    self.numberOfLines = 0;
    
    CGFloat height = label.frame.size.height;
    return height;
}

/** 自定义文字大小与颜色  字体类型*/
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size atTextFontForType:(NSString *)type{
    UILabel *label = [[self alloc] init];

    [label setText:text];
    [label setTextColor:color ? : FontGray_Color];
    [label setFont:[UIFont fontWithName:@"airal" size:size]];
    return label;
}

/** 自定义文字大小与颜色 */
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size{
    UILabel *label = [[self alloc] init];
    [label setText:text];
    [label setTextColor:color ? : FontGray_Color];
    [label setFont:[UIFont systemFontOfSize:size]];
    return label;
}
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    if( label.text.length <= 0){
        return;;
    }
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
+(NSAttributedString *)attbuite:(CGRect)bouns titles:(NSString *)title tyle:(attLocationType)type{
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:title];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"shuzigoodimages"];
    attch.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    if(type == attLocationTypeFirst){
        [attri insertAttributedString:string atIndex:0];
    }else{
       [attri appendAttributedString:string]; //在文字后面添加图片
    }
    return attri;
}
+(NSAttributedString *)attbuiteImage:(CGRect)bouns titles:(NSString *)title images:(NSString *)images tyle:(attLocationType)type{
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:title];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:images];
    attch.bounds = bouns;
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    if(type == attLocationTypeFirst){
        [attri insertAttributedString:string atIndex:0];
    }else{
       [attri appendAttributedString:string]; //在文字后面添加图片
    }
    return attri;
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(yf_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(yf_sizeThatFits:));
    });
}

- (void)yf_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.yf_contentInsets;
    [self yf_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)yf_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.yf_contentInsets;
    size = [self yf_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedYf_contentInsets;
- (void)setYf_contentInsets:(UIEdgeInsets)yf_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedYf_contentInsets, [NSValue valueWithUIEdgeInsets:yf_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)yf_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedYf_contentInsets) UIEdgeInsetsValue];
}


@end
