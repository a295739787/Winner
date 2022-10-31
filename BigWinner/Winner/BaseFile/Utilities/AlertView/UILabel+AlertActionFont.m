//
//  UILabel+AlertActionFont.m
//  Wisdomfamily
//
//  Created by libj on 2019/5/17.
//  Copyright © 2019 lijun L. All rights reserved.
//

#import "UILabel+AlertActionFont.h"

@implementation UILabel (AlertActionFont)

- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}
- (void) textLeftTopAlign

{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    
    self.frame = dateFrame;
    
}

- (UIFont *)appearanceFont
{
    return self.font;
}



+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size {
    
    UILabel *label = [[self alloc] init];
    [label setText:text];
    [label setTextColor:color ? : MainTitle_Color];
//    [label setFont:[UIFont fontWithFontSize:size]];
    [label setFont:FontSize(size)];
    return label;
}

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font {
    
    UILabel *label = [[self alloc] init];
    [label setText:text];
    [label setTextColor:color ? : MainTitle_Color];
    [label setFont:font];
    return label;
}

@end
