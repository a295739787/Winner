//
//  LLWalletHeaderView.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLWalletHeaderView.h"
#import "LLWalletButton.h"

@interface LLWalletHeaderView ()

@property (nonatomic,strong)UIImageView *bottomView;
@property (nonatomic,strong)UIButton *accountBtn;
@property (nonatomic,strong)UIButton *consumeBtn;
@property (nonatomic,strong)UIButton *currentBtn;
@property (nonatomic,strong)UILabel *walletLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIButton *useBtn;


@end

@implementation LLWalletHeaderView

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
    
    self.backgroundColor = UIColorFromRGB(0xF0EFED);
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.accountBtn];
    [self.bottomView addSubview:self.consumeBtn];
    [self.bottomView addSubview:self.walletLabel];
    [self.bottomView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.useBtn];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(10));
        make.bottom.right.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / 2;
    
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.consumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.walletLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(80));
        make.left.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.walletLabel.mas_bottom).offset(CGFloatBasedI375(5));
        make.left.mas_equalTo(self.walletLabel);
    }];
    
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(CGFloatBasedI375(-30));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    
}
-(void)setBalance:(NSString *)balance{
    _balance = balance;
    
    CGFloat balanceStr = [balance floatValue];
    _walletLabel.text = [NSString stringWithFormat:@"%.2f",balanceStr];
}
#pragma mark--headerWalletBtnClick
-(void)headerWalletBtnClick:(UIButton *)btn{
    NSLog(@"btn.tag == %ld",btn.tag);
    if(btn.tag == 100){
        [self.useBtn setTitle:@"提现" forState:UIControlStateNormal];
        _noteLabel.text = @"现金余额(元)";
    }else{
        [self.useBtn setTitle:@"去使用" forState:UIControlStateNormal];
        _noteLabel.text = @"消费余额(元)";
    }
    if (btn.tag == 100 || btn.tag == 200) {
        if (btn != _currentBtn) {
            
            btn.backgroundColor = UIColorFromRGB(0xD43F44);
            [btn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
            
            _currentBtn.backgroundColor = UIColorFromRGB(0xFFFFFF);
            [_currentBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            
            _currentBtn = btn;
            
            if (self.walletBtnBlock) {
                self.walletBtnBlock(btn.tag,self.useBtn.titleLabel.text);
            }
        }
    }
}
#pragma mark--headerWalletUseBtnClick
-(void)headerWalletUseBtnClick:(UIButton *)btn{
    if (self.walletBtnBlock) {
        self.walletBtnBlock(btn.tag,self.useBtn.titleLabel.text);
    }
}
#pragma mark--lazy
-(UIImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc]init];
        _bottomView.backgroundColor = UIColorFromRGB(0xD43F44);
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
        _bottomView.userInteractionEnabled = YES;
//        _bottomView.image = [UIImage imageNamed:@"xphb_bg"];
    }
    return _bottomView;
}
-(void)setType:(NSInteger)type{
    _type = type;
    if(_type == 2){
        self.accountBtn.backgroundColor = UIColorFromRGB(0xFFFFFF);
        self.consumeBtn.backgroundColor = UIColorFromRGB(0xD43F44);
        [self.consumeBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [ self.accountBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _currentBtn = self.consumeBtn;
        self.noteLabel.text = @"消费余额(元)";
        [self.useBtn setTitle:@"去使用" forState:UIControlStateNormal];
    }
}
-(UIButton *)accountBtn{
    if (!_accountBtn) {
        _accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _accountBtn.backgroundColor = UIColorFromRGB(0xD43F44);
        _accountBtn.tag = 100;
        [_accountBtn setTitle:@"钱包余额" forState:UIControlStateNormal];
        [_accountBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _accountBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_accountBtn addTarget:self action:@selector(headerWalletBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _accountBtn.layer.cornerRadius = CGFloatBasedI375(5);
        _accountBtn.clipsToBounds = YES;
        _currentBtn = _accountBtn;
    }
    return _accountBtn;
}
-(UIButton *)consumeBtn{
    if (!_consumeBtn) {
        _consumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _consumeBtn.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _consumeBtn.tag = 200;
        [_consumeBtn setTitle:@"消费红包" forState:UIControlStateNormal];
        [_consumeBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _consumeBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_consumeBtn addTarget:self action:@selector(headerWalletBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _consumeBtn.layer.cornerRadius = CGFloatBasedI375(5);
        _consumeBtn.clipsToBounds = YES;
    }
    return _consumeBtn;
}

-(UILabel *)walletLabel{
    if (!_walletLabel) {
        _walletLabel = [[UILabel alloc]init];
        _walletLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _walletLabel.textAlignment = NSTextAlignmentCenter;
        _walletLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(24)];
        _walletLabel.text = @"--";
    }
    return _walletLabel;
}

-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"现金余额(元)";
    }
    return _noteLabel;
}
-(UIButton *)useBtn{
    if (!_useBtn) {
        _useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _useBtn.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _useBtn.tag = 300;
        [_useBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_useBtn setTitleColor:UIColorFromRGB(0x6D43F44) forState:UIControlStateNormal];
        _useBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_useBtn addTarget:self action:@selector(headerWalletUseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _useBtn.layer.cornerRadius = CGFloatBasedI375(20);
        _useBtn.clipsToBounds = YES;
    }
    return _useBtn;
}

@end




@interface LLWalletSelectView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)LLWalletButton *obtainBtn;
@property (nonatomic,strong)LLWalletButton *useBtn;
@property (nonatomic,strong)LLWalletButton *currentBtn;

@end

@implementation LLWalletSelectView

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
    
    [self.bottomView addSubview:self.obtainBtn];
    [self.bottomView addSubview:self.useBtn];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(20)) / 2;
    
    [self.obtainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(btnWidth);
    }];
}
#pragma mark--walletSelectBtnClick
-(void)walletSelectBtnClick:(LLWalletButton *)btn{
    if(btn != _currentBtn){
        btn.isSelect = YES;
        _currentBtn.isSelect = NO;
        _currentBtn = btn;
        
        if (self.modeTypeBlock) {
            self.modeTypeBlock(btn.tag - 99);
        }
    }
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(50))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
        
    }
    return _bottomView;
}
-(LLWalletButton *)obtainBtn{
    if(!_obtainBtn){
        _obtainBtn = [LLWalletButton buttonWithType:UIButtonTypeCustom];
        _obtainBtn.textStr = @"获取记录";
        _obtainBtn.tag = 100;
        _obtainBtn.isSelect = YES;
        _currentBtn = _obtainBtn;
        [_obtainBtn addTarget:self action:@selector(walletSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _obtainBtn;
}
-(LLWalletButton *)useBtn{
    if(!_useBtn){
        _useBtn = [LLWalletButton buttonWithType:UIButtonTypeCustom];
        _useBtn.textStr = @"使用记录";
        _useBtn.tag = 101;
        _useBtn.isSelect = NO;
        [_useBtn addTarget:self action:@selector(walletSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _useBtn;
}





@end
