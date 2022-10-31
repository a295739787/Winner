//
//  LLMoudleButton.m
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import "LLMoudleButton.h"


@interface LLMoudleButton ()

@property (nonatomic,strong)UILabel *textLabel;

@end

@implementation LLMoudleButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.countLabel];
    [self addSubview:self.textLabel];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(CGFloatBasedI375(24));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.countLabel.mas_bottom).offset(CGFloatBasedI375(8));
    }];
}
-(void)setCountStr:(NSString *)countStr{
    _countLabel.text = FORMAT(@"%.2f",countStr.floatValue);
}
-(void)setTextStr:(NSString *)textStr{
    _textLabel.text = textStr;
}

#pragma mark--lazy
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0xD40006);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
    }
    return _countLabel;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x666666);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
    }
    return _textLabel;
}


@end



@interface LLMeStockButton ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UILabel *countLabel;

@end

@implementation LLMeStockButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.textLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.imgView];
    
    [self.textLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textLabel);
        make.left.mas_equalTo(self.textLabel.mas_right).offset(CGFloatBasedI375(8));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textLabel);
        make.right.mas_equalTo(self.textLabel.mas_left).offset(CGFloatBasedI375(-8));
        make.width.height.mas_equalTo(CGFloatBasedI375(18));
    }];
}
-(void)setCountStr:(NSString *)countStr{
    _countLabel.text = countStr;
}
-(void)setTextStr:(NSString *)textStr{
    _textLabel.text = textStr;
}
-(void)setImgStr:(NSString *)imgStr{
    _imgView.image = [UIImage imageNamed:imgStr];
}

#pragma mark--lazy
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x443415);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _textLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0x666666);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _countLabel;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}


@end



@interface LLMeOrderHeaderButton ()

@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIImageView *nextImgView;


@end

@implementation LLMeOrderHeaderButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.textLabel];
    [self addSubview:self.nextImgView];
    [self addSubview:self.rightLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(5));
    }];
    
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.nextImgView.mas_left).offset(CGFloatBasedI375(-10));
    }];
    
    
}
-(void)setTitleStr:(NSString *)titleStr{
    _textLabel.text = titleStr;
}
#pragma mark--lazy
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x443415);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textLabel.text = @"我的订单";
    }
    return _textLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x999999);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _rightLabel.text = @"全部订单";
    }
    return _rightLabel;
}
-(UIImageView *)nextImgView{
    if (!_nextImgView) {
        _nextImgView = [[UIImageView alloc]init];
        _nextImgView.backgroundColor = [UIColor whiteColor];
        _nextImgView.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImgView;
}


@end



@interface LLMeOrderButton ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UIView *countView;
@property (nonatomic,strong)UILabel *countLabel;

@end

@implementation LLMeOrderButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.imgView];
    [self addSubview:self.textLabel];
    [self addSubview:self.countView];
    [self.countView addSubview:self.countLabel];
    
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(24));
    }];
    
    [self.textLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(CGFloatBasedI375(8));
    }];
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imgView.mas_top).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(self.imgView.mas_right).offset(CGFloatBasedI375(-10));
        make.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.countView);
        make.left.mas_equalTo(CGFloatBasedI375(5));
        make.right.mas_equalTo(CGFloatBasedI375(-5));
    }];
    
}
-(void)setTextStr:(NSString *)textStr{
    _textLabel.text = textStr;
}
-(void)setImgStr:(NSString *)imgStr{
    _imgView.image = [UIImage imageNamed:imgStr];
}
-(void)setCountStr:(NSString *)countStr{
    _countLabel.text = countStr;
    if ([countStr intValue] == 0) {
        _countView.hidden = YES;
        _countLabel.hidden = YES;
    }else{
        _countView.hidden = NO;
        _countLabel.hidden = NO;
    }
}

#pragma mark--lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x666666);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
    }
    return _textLabel;
}
-(UIView *)countView{
    if (!_countView) {
        _countView = [[UIView alloc]init];
        _countView.backgroundColor = UIColorFromRGB(0xD40006);
        _countView.layer.cornerRadius = CGFloatBasedI375(7.5);
        _countView.clipsToBounds = YES;
    }
    return _countView;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(11)];
    }
    return _countLabel;
}

@end


@interface LLMeListButton ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UIImageView *nextImg;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLMeListButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.imgView];
    [self addSubview:self.textLabel];
    [self addSubview:self.nextImg];
    [self addSubview:self.line];
    
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.textLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.imgView.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}
-(void)setTextStr:(NSString *)textStr{
    _textLabel.text = textStr;
}
-(void)setImgStr:(NSString *)imgStr{
    _imgView.image = [UIImage imageNamed:imgStr];
}

#pragma mark--lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x333333);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _textLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor whiteColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
}


@end
