//
//  LLSorageView.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLSorageView.h"

@interface LLSorageView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIButton *addCarBtn;


@end

@implementation LLSorageView

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
    [self.bottomView addSubview:self.leftLabel];
    [self.bottomView addSubview:self.addBtn];
    [self.bottomView addSubview:self.countLabel];
    [self.bottomView addSubview:self.deleteBtn];
    [self.bottomView addSubview:self.addCarBtn];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(44));
        make.height.mas_equalTo(CGFloatBasedI375(24));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.addBtn.mas_left).offset(-15);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.countLabel.mas_left).offset(-15);
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
}

-(void)setGoodsNum:(NSString *)goodsNum{
    _goodsNum = goodsNum;
    _countLabel.text = goodsNum;
  
    self.leftLabel.hidden = YES;
    self.addCarBtn.hidden = YES;
    if([UserModel sharedUserInfo].isShop){
        self.leftLabel.hidden = NO;
        self.addCarBtn.hidden = NO;
    }
}

#pragma mark--addBtnClick
-(void)addBtnClick:(UIButton *)btn{
    NSInteger count = [_countLabel.text intValue];
    if (count < [_goodsNum intValue]) {
        count ++;
    }
    _countLabel.text = [NSString stringWithFormat:@"%ld",count];
    
    if (self.LLStorageCountBlock) {
        self.LLStorageCountBlock(count);
    }
}
#pragma mark--deleteBtnClick
-(void)deleteBtnClick:(UIButton *)btn{
    NSInteger count = [_countLabel.text intValue];
    
    count--;
    if (count <= 0) {
        return;
    }
    _countLabel.text = [NSString stringWithFormat:@"%ld",count];
    if (self.LLStorageCountBlock) {
        self.LLStorageCountBlock(count);
    }
}
#pragma mark--addCarBtnClick
-(void)addCarBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [btn setImage:[UIImage imageNamed:@"button_open"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"button_close"] forState:UIControlStateNormal];
    }
    if (self.LLStorageAddCarBtnBlock) {
        self.LLStorageAddCarBtnBlock(btn.selected);
    }
}

#pragma mark--alzy
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"提供数量";
    }
    return _titleLabel;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _leftLabel.text = @"加入配送库存";
    }
    return _leftLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.layer.cornerRadius = CGFloatBasedI375(10);
        _addBtn.clipsToBounds = YES;
    }
    return _addBtn;
}
-(UIButton *)addCarBtn{
    if (!_addCarBtn) {
        _addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCarBtn.backgroundColor = [UIColor whiteColor];
        _addCarBtn.selected = NO;
        [_addCarBtn setImage:[UIImage imageNamed:@"button_close"] forState:UIControlStateNormal];
        [_addCarBtn addTarget:self action:@selector(addCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCarBtn;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0x443415);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _countLabel.text = @"1";
    }
    return _countLabel;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [_deleteBtn setTitle:@"—" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(8)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.layer.cornerRadius = CGFloatBasedI375(10);
        _deleteBtn.clipsToBounds = YES;
    }
    return _deleteBtn;
}

@end


@interface LLStorageBottomView ()

@property (nonatomic,strong)UIButton *confirmBtn;



@end

@implementation LLStorageBottomView

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
        make.top.mas_equalTo(CGFloatBasedI375(6));
        make.height.mas_equalTo(CGFloatBasedI375(38));
    }];
}
#pragma mark--confirmBtnClick
-(void)confirmBtnClick:(UIButton *)btnn{
    if (self.LLStorageConfirmBtnBlock) {
        self.LLStorageConfirmBtnBlock();
    }
}

#pragma mark--lazy
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = UIColorFromRGB(0xD40006 );
        [_confirmBtn setTitle:@"确认提货" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = CGFloatBasedI375(19);
        _confirmBtn.clipsToBounds = YES;
    }
    return _confirmBtn;
}

@end
