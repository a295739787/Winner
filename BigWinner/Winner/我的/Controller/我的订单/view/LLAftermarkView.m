//
//  LLAftermarkView.m
//  Winner
//
//  Created by YP on 2022/1/26.
//

#import "LLAftermarkView.h"

@interface LLAftermarkView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textField;

@end

@implementation LLAftermarkView

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
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.textField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
}
-(void)setIsHidden:(BOOL)isHidden{
    self.textField.hidden = isHidden;
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"售后商品";
    }
    return _titleLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.placeholder = @"选填";
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}


@end



@interface LLAfertmarkTypeView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *rigthLabel;
@property (nonatomic,strong)UILabel *noteLabel;

@end

@implementation LLAfertmarkTypeView

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
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.rigthLabel];
    [self.bottomView addSubview:self.noteLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    
    [self.rigthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        
    }];
    
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"售后商品";
    }
    return _titleLabel;
}
-(UILabel *)rigthLabel{
    if (!_rigthLabel) {
        _rigthLabel = [[UILabel alloc]init];
        _rigthLabel.textColor = UIColorFromRGB(0xD40006);
        _rigthLabel.textAlignment = NSTextAlignmentRight;
        _rigthLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _rigthLabel.text = @"¥ 139.00";
    }
    return _rigthLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x999999);
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"可修改，最多￥139.00，含发货邮费￥0.00";
    }
    return _noteLabel;
}

@end



@interface LLAftermarkBottomView ()

@property (nonatomic,strong)UIButton *confirmBtn;

@end

@implementation LLAftermarkBottomView

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
    
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.confirmBtn];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(36));
    }];
    
}
#pragma mark--confirmBtnClick
-(void)confirmBtnClick:(UIButton *)btn{
    
    
}
#pragma mark--lazy
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = UIColorFromRGB(0xD40006);
        [_confirmBtn setTitle:@"提交售后" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = CGFloatBasedI375(16);
        _confirmBtn.clipsToBounds = YES;
    }
    return _confirmBtn;
}

@end
