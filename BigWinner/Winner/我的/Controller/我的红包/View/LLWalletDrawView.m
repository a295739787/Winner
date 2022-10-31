//
//  LLWalletDrawView.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLWalletDrawView.h"

@interface LLWalletDrawView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *drawBottomView;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIButton *allDrawBtn;
@property (nonatomic,strong)UILabel *leftLabel;

@end

@implementation LLWalletDrawView

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
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.drawBottomView];
    [self.bottomView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.allDrawBtn];
    [self.drawBottomView addSubview:self.leftLabel];
    [self.drawBottomView addSubview:self.textField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(CGFloatBasedI375(20));
        make.height.mas_equalTo(CGFloatBasedI375(54));
    }];
    
    [self.drawBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(54));
        make.left.mas_equalTo(CGFloatBasedI375(20));
        make.right.mas_equalTo(CGFloatBasedI375(-20));
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drawBottomView.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.allDrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-20));
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(18));
        make.height.mas_equalTo(CGFloatBasedI375(18));
        make.centerY.mas_equalTo(self.drawBottomView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(30));
        make.right.mas_equalTo(CGFloatBasedI375(-20));
        make.height.mas_equalTo(CGFloatBasedI375(18));
        make.centerY.mas_equalTo(self.drawBottomView);
    }];
    
}
#pragma mark--allDrawBtnClick
-(void)allDrawBtnClick:(UIButton *)btn{
    self.textField.text = _model.balance;
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), CGFloatBasedI375(10), SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(145))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
        
    }
    return _bottomView;
}
- (void)setModel:(LLPersonalModel *)model{
    _model = model;
    _noteLabel.text = FORMAT(@"可提现金额:￥%.2f",_model.balance.floatValue);
}
#pragma mark--lazy
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _titleLabel.text = @"提现金额";
    }
    return _titleLabel;
}
-(UIView *)drawBottomView{
    if (!_drawBottomView) {
        _drawBottomView = [[UIView alloc]init];
        _drawBottomView.backgroundColor = UIColorFromRGB(0xF2F2F2);
        _drawBottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _drawBottomView.clipsToBounds = YES;
    }
    return _drawBottomView;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x666666);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"可提现金额:￥0.00";
    }
    return _noteLabel;
}
-(UIButton *)allDrawBtn{
    if (!_allDrawBtn) {
        _allDrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allDrawBtn.backgroundColor = [UIColor whiteColor];
        [_allDrawBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [_allDrawBtn setTitleColor:UIColorFromRGB(0xEFA729) forState:UIControlStateNormal];
        _allDrawBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        [_allDrawBtn addTarget:self action:@selector(allDrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allDrawBtn;
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(18)];
        _leftLabel.text = @"¥";
    }
    return _leftLabel;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(18)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.placeholder = @"请输入提现金额";
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end





@interface LLWalletDrawFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *drawBtn;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation LLWalletDrawFooterView

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
    
    [self.bottomView addSubview:self.drawBtn];
    [self.bottomView addSubview:self.titleLabel];
    
    [self.drawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(20));
        make.centerX.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(CGFloatBasedI375(180));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drawBtn.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(20));
    }];
    
}
#pragma mark--drawBtnClick
-(void)drawBtnClick:(UIButton *)btn{
    if(self.clickTap){
        self.clickTap();
    }
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(147))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
        
    }
    return _bottomView;
}

-(UIButton *)drawBtn{
    if (!_drawBtn) {
        _drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _drawBtn.backgroundColor = UIColorFromRGB(0xD40006);
        [_drawBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_drawBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _drawBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_drawBtn addTarget:self action:@selector(drawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _drawBtn.layer.cornerRadius = CGFloatBasedI375(20);
        _drawBtn.clipsToBounds = YES;
    }
    return _drawBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x999999 );
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"温馨提示！\n1.提现金额最低100元起申请，提现手续费1%；\n2.申请提现后将在1-3个工作日内到账，请注意查收。";
    }
    return _titleLabel;
}

@end
