//
//  CountView.m
//  MeiXiangDao_iOS
//
//  Created by 澜海利奥 on 2017/9/26.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import "CountView.h"
#import "Header.h"
@implementation CountView
@synthesize addButton,reduceButton,countTextField,label;
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(kSize(15), kSize(10), kSize(100), kSize(30))];
        label.text = @"数量";
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reduceButton.layer.cornerRadius = CGFloatBasedI375(20);
        reduceButton.layer.masksToBounds = YES;
        [reduceButton setTitle:@"-" forState:UIControlStateNormal];
        reduceButton.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [reduceButton setTitleColor:[UIColor colorWithHexString:@"#212121"] forState:UIControlStateNormal];
        reduceButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        [JXUIKit ViewcornerRadius:CGFloatBasedI375(15) andColor:[UIColor clearColor] andWidth:0 :reduceButton];
        [self addSubview:reduceButton];
        [reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(CGFloatBasedI375(10));
            make.left.offset(kSize(15));
            make.height.mas_equalTo(CGFloatBasedI375(30));
            make.width.mas_equalTo(CGFloatBasedI375(30));
        }];
        countTextField = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter numberOfLines:1 fontSize:15 font:[UIFont systemFontOfSize:14] text:@"1"];
        countTextField.adjustsFontSizeToFitWidth = YES;
//        countTextField = [JXUIKit textFieldWithBackgroundColor:WhiteColor textColor:[UIColor blackColor] secureTextEntry:NO fontSize:15 font:nil text:@"1" placeholder:nil textAlignment:NSTextAlignmentCenter];
//        countTextField.keyboardType = UIKeyboardTypeNumberPad;
//        countTextField.enabled = NO;
        [JXUIKit ViewcornerRadius:CGFloatBasedI375(10) andColor:[UIColor clearColor] andWidth:1 :countTextField];
        [self addSubview:countTextField];
        [countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(reduceButton.mas_centerY);
            make.left.equalTo(reduceButton.mas_right).offset(CGFloatBasedI375(0));
            make.height.mas_equalTo(CGFloatBasedI375(20));
            make.width.mas_equalTo(CGFloatBasedI375(40));
        }];
        
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.layer.cornerRadius = CGFloatBasedI375(20);
        addButton.layer.masksToBounds = YES;
        [addButton setTitle:@"+" forState:UIControlStateNormal];
        addButton.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [addButton setTitleColor:[UIColor colorWithHexString:@"#212121"] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
//        [addButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        [JXUIKit ViewcornerRadius:CGFloatBasedI375(15) andColor:[UIColor clearColor] andWidth:0 :addButton];
        
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerY.equalTo(reduceButton.mas_centerY);
            make.left.equalTo(countTextField.mas_right).offset(CGFloatBasedI375(0));
            make.height.mas_equalTo(CGFloatBasedI375(30));
            make.width.mas_equalTo(CGFloatBasedI375(30));
        }];
        
      
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
        view.backgroundColor = WhiteColor;
        
       _textFieldDownButton= [JXUIKit buttonWithBackgroundColor:WhiteColor imageForNormal:@"jiantou_down" imageForSelete:nil];
        _textFieldDownButton.frame = CGRectMake(kWidth-50, 0, 50, 40);
        [view addSubview:_textFieldDownButton];
//        countTextField.inputAccessoryView = view;
        
        
        self.countlabel = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:Main_Color textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(13) font:[UIFont systemFontOfSize:CGFloatBasedI375(13)] text:@"单次限10件"];
        [self addSubview: self.countlabel];
        [ self.countlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(reduceButton.mas_centerY);
            make.left.equalTo(addButton.mas_right).offset(CGFloatBasedI375(15));
        }];
//        reduceButton= [JXUIKit buttonWithBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] titleColorForNormal:[UIColor blackColor] titleForNormal:@"-" titleForSelete:nil titleColorForSelete:nil fontSize:20 font:nil];
//        [JXUIKit ViewcornerRadius:CGFloatBasedI375(10) andColor:[UIColor clearColor] andWidth:1 :reduceButton];
//        [reduceButton setEnlargeEdge:20];
//        [self addSubview:reduceButton];
      
    }
    return self;
}

//-(void)clickTap:(UIButton *)sender{
//
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
