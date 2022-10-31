//
//  JSTextView.m
//  FitMent
//
//  Created by 张煜 on 15/12/18.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "LLTextView.h"
#import "UIView+Extension.h"

@interface LLTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation LLTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    UILabel *placeholderLabel = [[UILabel alloc]init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.numberOfLines = 0;
    [self addSubview:placeholderLabel];
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(isPad ? 2 : 8);
    }];
    
    _placeholderLabel = placeholderLabel;
    _myPlaceholderColor = UIColorFromRGB(0xA3A3A3);
    
    self.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}
-(void)textDidChange{
    _placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
//    self.placeholderLabel.y=8; //设置UILabel 的 y值
//    self.placeholderLabel.x=5;//设置 UILabel 的 x 值
    self.placeholderLabel.width=self.width; //设置 UILabel 的 x
    
    //根据文字计算高度
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    
    self.placeholderLabel.height= [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height + (isPad ? 13 : 0);
}
- (void)setMyPlaceholder:(NSString*)myPlaceholder{
    
    _myPlaceholder= [myPlaceholder copy];
    //设置文字
    
    self.placeholderLabel.text= myPlaceholder;
    
    //重新计算子控件frame
    [self setNeedsLayout];
}
-(void)setMyPlaceholderColor:(UIColor *)myPlaceholderColor{
    _myPlaceholderColor = myPlaceholderColor;
    _placeholderLabel.textColor = myPlaceholderColor;
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    _placeholderLabel.font = font;
    [self setNeedsLayout];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}
@end
