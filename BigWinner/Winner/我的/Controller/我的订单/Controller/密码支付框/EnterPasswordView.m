//
//  EnterPasswordView.m
//  Winner
//
//  Created by YP on 2022/3/28.
//

#import "EnterPasswordView.h"
#import "CodeInputView.h"

@interface EnterPasswordView ()<CodeInputViewDelegate>

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)CodeInputView *inputView ;

@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong)UIView *line1;
@property (nonatomic,strong)UIView *line2;

@property (nonatomic,strong)NSString *number;


@end

@implementation EnterPasswordView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.bottomView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(CGFloatBasedI375(280));
        make.height.mas_equalTo(CGFloatBasedI375(160));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    _inputView = [[CodeInputView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(54), CGFloatBasedI375(280), CGFloatBasedI375(60)) Space:25 Margin:10 Count:6];
    _inputView.inputType = inputTypeNormal;
    _inputView.delegate = self;
    [self.contentView addSubview:_inputView];
    
    [self.contentView addSubview:self.cancleBtn];
    [self.contentView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.line1];
    [self.contentView addSubview:self.line2];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(45);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(45);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(CGFloatBasedI375(-45));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(CGFloatBasedI375(45));
        make.width.mas_equalTo(0.5);
    }];
}

#pragma mark--CodeInputViewDelegate
- (void)beginEnterCode:(CodeInputView *)inputView {
    NSLog(@"开始输入");
}

- (void)codeDuringEnter:(CodeInputView *)inputView code:(NSString *)number {
    NSLog(@"输入中 %@", number);
}

- (void)finishEnterCode:(CodeInputView *)inputView code:(NSString *)number {
    _number = number;
    NSLog(@"输入完成 %@", number);
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
}

-(void)show{
    _inputView.isFirst = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hidden{
    _inputView.isFirst = NO;
    [self removeFromSuperview];
}
#pragma mark--passwordViewBtnBlock
-(void)passwordViewBtnBlock:(UIButton *)btn{
    
    if (btn.tag == 100) {
        [self hidden];
    }else{
        if ([_number length] < 6) {
            [MBProgressHUD showError:@"请输入6位核销码"];
        }else{
            if (self.EnterPasswordBlock) {
                self.EnterPasswordBlock(_number,_model);
                [self hidden];
            }
        }
    }
    
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.6;
    }
    return _bottomView;
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = CGFloatBasedI375(5);
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _titleLabel.text = @"请输入提货码核销";
    }
    return _titleLabel;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _cancleBtn.tag = 100;
        [_cancleBtn addTarget:self action:@selector(passwordViewBtnBlock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _confirmBtn.tag = 101;
        [_confirmBtn addTarget:self action:@selector(passwordViewBtnBlock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = UIColorFromRGB(0xCCCCCC);
    }
    return _line1;
}
-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = UIColorFromRGB(0xCCCCCC);
    }
    return _line2;
}



@end
