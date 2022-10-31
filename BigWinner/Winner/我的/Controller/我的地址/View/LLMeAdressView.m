//
//  LLMeAdressView.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeAdressView.h"

@interface LLMeAdressView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *addAdressBtn;
@property (nonatomic,strong)UIButton *saveAdressBtn;
@property (nonatomic,strong)UIButton *deleteAdressBtn;
@property (nonatomic,strong)UIButton *saveBtn;

@end

@implementation LLMeAdressView

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
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.addAdressBtn];
    [self.bottomView addSubview:self.saveAdressBtn];
    [self.bottomView addSubview:self.deleteAdressBtn];
    [self.bottomView addSubview:self.saveBtn];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    [self.addAdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
    }];
    
    [self.saveAdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
    }];
    
    CGFloat btnWidth = (SCREEN_WIDTH - CGFloatBasedI375(15) * 3) / 2;
    
    [self.deleteAdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.height.mas_equalTo(CGFloatBasedI375(36));
        make.width.mas_equalTo(btnWidth);
    }];
    
    
    self.addAdressBtn.hidden = YES;
    self.saveAdressBtn.hidden = YES;
    self.deleteAdressBtn.hidden = YES;
    self.saveBtn.hidden = YES;
    
}

-(void)setAdressType:(NSInteger)adressType{
    
    if (adressType == 100) {
        self.addAdressBtn.hidden = NO;
        self.saveAdressBtn.hidden = YES;
        self.deleteAdressBtn.hidden = YES;
        self.saveBtn.hidden = YES;
    }else if (adressType == 200){
        self.addAdressBtn.hidden = YES;
        self.saveAdressBtn.hidden = NO;
        self.deleteAdressBtn.hidden = YES;
        self.saveBtn.hidden = YES;
    }else{
        self.addAdressBtn.hidden = YES;
        self.saveAdressBtn.hidden = YES;
        self.deleteAdressBtn.hidden = NO;
        self.saveBtn.hidden = NO;
    }
}



#pragma mark--footerOrderBtnClick
-(void)footerOrderBtnClick:(UIButton *)btn{
    if (self.adressBtnBlock) {
        self.adressBtnBlock(btn.tag);
    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UIButton *)addAdressBtn{
    if (!_addAdressBtn) {
        _addAdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAdressBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _addAdressBtn.tag = 100;
        [_addAdressBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
        [_addAdressBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _addAdressBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_addAdressBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addAdressBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _addAdressBtn.clipsToBounds = YES;
    }
    return _addAdressBtn;
}
-(UIButton *)saveAdressBtn{
    if (!_saveAdressBtn) {
        _saveAdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveAdressBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _saveAdressBtn.tag = 200;
        [_saveAdressBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveAdressBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _saveAdressBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_saveAdressBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveAdressBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _saveAdressBtn.clipsToBounds = YES;
    }
    return _saveAdressBtn;
}
-(UIButton *)deleteAdressBtn{
    if (!_deleteAdressBtn) {
        _deleteAdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteAdressBtn.backgroundColor = UIColorFromRGB(0xF0EEEB);
        _deleteAdressBtn.tag = 300;
        [_deleteAdressBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteAdressBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _deleteAdressBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_deleteAdressBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteAdressBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _deleteAdressBtn.clipsToBounds = YES;
    }
    return _deleteAdressBtn;
}
-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _saveBtn.tag = 400;
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_saveBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _saveBtn.clipsToBounds = YES;
    }
    return _saveBtn;
}


@end


@interface LLMeAdressDeleteView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIView *hLine;
@property (nonatomic,strong)UIView *vLine;

@end

@implementation LLMeAdressDeleteView

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
    
    [self addSubview:self.bottomView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.noteLabel];
    [self.contentView addSubview:self.cancleBtn];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.hLine];
    [self.contentView addSubview:self.vLine];
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CGFloatBasedI375(280));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(24));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.noteLabel.mas_bottom).offset(CGFloatBasedI375(25));
        make.width.mas_equalTo(CGFloatBasedI375(140));
        make.height.mas_equalTo(CGFloatBasedI375(45));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.centerY.mas_equalTo(self.cancleBtn);
        make.width.mas_equalTo(CGFloatBasedI375(140));
        make.height.mas_equalTo(CGFloatBasedI375(45));
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(CGFloatBasedI375(45));
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(CGFloatBasedI375(-45));
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(CGFloatBasedI375(280));
    }];
    
}
-(void)hidden{
    [self removeFromSuperview];
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
#pragma mark--deleteAdressBtnClick
-(void)deleteAdressBtnClick:(UIButton *)btn{
    [self hidden];
    if (btn.tag == 200) {
        if (self.deleteBtnBlock) {
            self.deleteBtnBlock();
        }
    }
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
-(void)setTextStr:(NSString *)textStr{
    _noteLabel.text = textStr;
}
-(void)setRightStr:(NSString *)rightStr{
    [_deleteBtn setTitle:rightStr forState:UIControlStateNormal];
}

#pragma mark--tap
-(void)tap{
    
    [self hidden];
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.6;
        _bottomView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.numberOfTapsRequired = 1;
        [_bottomView addGestureRecognizer:tap];
        
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
       
    }
    return _titleLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x666666);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        _cancleBtn.tag = 100;
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_cancleBtn addTarget:self action:@selector(deleteAdressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        _deleteBtn.tag = 200;
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_deleteBtn addTarget:self action:@selector(deleteAdressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
-(UIView *)hLine{
    if (!_hLine) {
        _hLine = [[UIView alloc]init];
        _hLine.backgroundColor =UIColorFromRGB(0xD5D5D5);
    }
    return _hLine;
}
-(UIView *)vLine{
    if (!_vLine) {
        _vLine = [[UIView alloc]init];
        _vLine.backgroundColor = UIColorFromRGB(0xD5D5D5);
    }
    return _vLine;
}

@end
