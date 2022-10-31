//
//  LLWalletButton.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLWalletButton.h"

@interface LLWalletButton ()

@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UIView *line;


@end

@implementation LLWalletButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.textLabel];
    [self addSubview:self.line];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.textLabel.mas_bottom).offset(CGFloatBasedI375(5));
        make.width.mas_equalTo(CGFloatBasedI375(24));
        make.height.mas_equalTo(2);
    }];
    
}
-(void)setIsSelect:(BOOL)isSelect{
    if (isSelect == YES) {
        _textLabel.textColor = UIColorFromRGB(0xD40006);
        _line.hidden = NO;
    }else{
        _textLabel.textColor = UIColorFromRGB(0x666666);
        _line.hidden = YES;
    }
}
-(void)setTextStr:(NSString *)textStr{
    _textLabel.text = textStr;
}
#pragma mark--lazy
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x666666);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _textLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xFD40006);
    }
    return _line;
}

@end
