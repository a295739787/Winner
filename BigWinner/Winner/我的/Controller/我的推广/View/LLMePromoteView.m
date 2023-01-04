//
//  LLMePromoteView.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLMePromoteView.h"
#import "LLMePromoteController.h"
@interface LLMePromoteView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *bottomLabel;
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)UILabel *incomeLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIImageView *nextImg;
@property (nonatomic,strong)UIImageView *centerimg;
@property (nonatomic,strong)UIButton *inviteBtn;
@property (nonatomic,strong)UIImageView *noteImg;
@property (nonatomic,strong)UILabel *detailsLabel;

@end

@implementation LLMePromoteView

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
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.noteImg];
    
    
    [self.noteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.height.mas_equalTo(CGFloatBasedI375(34));
    }];
    [self.bottomView addSubview:self.sureButton];

    [self.bottomView addSubview:self.countLabel];
    [self.bottomView addSubview:self.bottomLabel];
    [self.bottomView addSubview:self.nextBtn];
    [self.nextBtn addSubview:self.incomeLabel];
    [self.nextBtn addSubview:self.rightLabel];
    [self.nextBtn addSubview:self.nextImg];
    [self.bottomView addSubview:self.centerimg];
    [self.bottomView addSubview:self.inviteBtn];
    [self.bottomView addSubview:self.detailsLabel];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(CGFloatBasedI375(0));
        make.width.mas_equalTo(CGFloatBasedI375(50));
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(40));
        make.left.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countLabel);
        make.top.mas_equalTo(self.countLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(40));
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];
    
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(28));
        make.top.mas_equalTo(0);
    }];

    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.incomeLabel);
        make.top.mas_equalTo(self.incomeLabel.mas_bottom).offset(CGFloatBasedI375(6));
    }];

    [self.nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nextBtn);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];

    [self.centerimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(40));
        make.centerX.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(CGFloatBasedI375(1.5));
        make.height.mas_equalTo(CGFloatBasedI375(50));
    }];

    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.bottom.mas_equalTo(CGFloatBasedI375(-40));
        make.width.mas_equalTo(CGFloatBasedI375(140));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.top.mas_equalTo(self.inviteBtn.mas_bottom).offset(CGFloatBasedI375(10));

    }];
}
-(void)setTeamModel:(PromoteTeamModel *)teamModel{
    
    NSString *teamNum = [teamModel.teamNum length] <= 0 ? @"0" : teamModel.teamNum;
    NSString *totalPrice = [teamModel.totalPrice length] <= 0 ? @"0.00" : teamModel.totalPrice;
    
    CGFloat totalPriceStr = [totalPrice floatValue];
    
    _countLabel.text = teamNum;
    _incomeLabel.text = [NSString stringWithFormat:@"%.2f",totalPriceStr];
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [[UIButton alloc]init];
//        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

#pragma mark--nextBtnClick
-(void)nextBtnClick:(UIButton *)btn{
    if (self.promoteBlock) {
        self.promoteBlock();
    }
}
#pragma mark--inviteBtnClick
-(void)inviteBtnClick:(UIButton *)bbtn{
    LLMePromoteController *vc = [[LLMePromoteController alloc]init];
    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIColorFromRGB(0xD43F44) ;
    }
    return _bottomView;
}
-(UIImageView *)noteImg{
    if (!_noteImg) {
        _noteImg = [[UIImageView alloc]init];
        _noteImg.backgroundColor = [UIColor clearColor];
        _noteImg.image = [UIImage imageNamed:@"sm"];
    }
    return _noteImg;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont dinFontWithFontSize:24];
        _countLabel.text = @"-";
    }
    return _countLabel;
}
-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _bottomLabel.text = @"累计团队成员(人)";
    }
    return _bottomLabel;
}
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = [UIColor clearColor];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
-(UILabel *)incomeLabel{
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc]init];
        _incomeLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        _incomeLabel.font = [UIFont dinFontWithFontSize:24];
        _incomeLabel.text = @"-";
    }
    return _incomeLabel;
}
-(UILabel *)detailsLabel{
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.text = @"待激活推广佣金";
        _detailsLabel.userInteractionEnabled = YES;
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
          NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_detailsLabel.text attributes:attribtDic];
        _detailsLabel.attributedText = attribtStr;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_detailsLabel addGestureRecognizer:tap];
      
    }
    return _detailsLabel;
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    LLMePromoteDetailVC *vc = [[LLMePromoteDetailVC alloc]init];
    vc.status = 2;
    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _rightLabel.text = @"累计已到佣金(元)";
    }
    return _rightLabel;
}
-(UIImageView *)nextImg{
    if (!_nextImg) {
        _nextImg= [[UIImageView alloc]init];
        _nextImg.backgroundColor = [UIColor clearColor];
        _nextImg.image = [UIImage imageNamed:@"allowimag"];
    }
    return _nextImg;
}
-(UIImageView *)centerimg{
    if (!_centerimg) {
        _centerimg= [[UIImageView alloc]init];
        _centerimg.backgroundColor = [UIColor clearColor];
        _centerimg.image = [UIImage imageNamed:@"line_m"];
    }
    return _centerimg;
}
-(UIButton *)inviteBtn{
    if (!_inviteBtn) {
        _inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _inviteBtn.backgroundColor = [UIColor whiteColor];;
        [_inviteBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
        [_inviteBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _inviteBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        [_inviteBtn addTarget:self action:@selector(inviteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _inviteBtn.layer.cornerRadius = CGFloatBasedI375(20);
        _inviteBtn.clipsToBounds = YES;
    }
    return _inviteBtn;
}


@end



@interface LLPromoteHeaderView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLPromoteHeaderView

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
    [self.bottomView addSubview:self.headerImgView];
    [self.bottomView addSubview:self.nameLabel];
    [self.bottomView addSubview:self.phoneLabel];
    [self.bottomView addSubview:self.stateLabel];
    [self.bottomView addSubview:self.line];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(20));
        make.left.mas_equalTo(CGFloatBasedI375(70));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(70));
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(CGFloatBasedI375(-5));
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(0.5);
    }];
    
}
-(void)setListModel:(PromoteDetailModel *)listModel{
    _listModel = listModel;
    
    [_headerImgView sd_setImageWithUrlString:FORMAT(@"%@",_listModel.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    _nameLabel.text = _listModel.nickName;
    _phoneLabel.text = [NSString setPhoneMidHid:_listModel.account];
    if ([_listModel.status intValue] == 1) {
        _stateLabel.text = @"待结算";
        _stateLabel.textColor = UIColorFromRGB(0xD40006);
    }else{
        _stateLabel.text = @"已结算";
        _stateLabel.textColor = UIColorFromRGB(0x443415);
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
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
        _headerImgView.backgroundColor = [UIColor whiteColor];
        _headerImgView.layer.cornerRadius = CGFloatBasedI375(22);
        _headerImgView.clipsToBounds = YES;
    }
    return _headerImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0x443415);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _nameLabel.text = @"吴晓晓";
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _phoneLabel.text = @"137****4182";
    }
    return _phoneLabel;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = UIColorFromRGB(0xD40006);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _stateLabel.text = @"待结算";
    }
    return _stateLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF2F2F2);
    }
    return _line;
}

@end


@interface LLPromoteFooterView ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;


@end

@implementation LLPromoteFooterView

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
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(13));
        make.top.mas_equalTo(CGFloatBasedI375(5));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(5));
    }];
    
}
-(void)setListModel:(PromoteDetailModel *)listModel{
    _listModel = listModel;
    
    NSString *profitPrice = [_listModel.profitPrice length] <= 0 ? @"0.00" : _listModel.profitPrice;
    NSString *activatedPrice = [_listModel.activatedPrice length] <= 0 ? @"0.00" : _listModel.activatedPrice;
    
    CGFloat profitPriceStr = [profitPrice floatValue];
    CGFloat activatedPriceStr = [activatedPrice floatValue];
    
    
    if ([_listModel.status intValue] == 1) {
        //待结算
        _leftLabel.text = @"待结算金额";
        _rightLabel.text = [NSString stringWithFormat:@"¥%.2f",profitPriceStr];
        _rightLabel.textColor = UIColorFromRGB(0xD40006);
    }else{
        //已结算部分，3已结算完成
        _leftLabel.text = @"已激活金额";
        _rightLabel.text = [NSString stringWithFormat:@"¥%.2f",activatedPriceStr];
        _rightLabel.textColor = UIColorFromRGB(0x666666);
    }
}
#pragma mark--lazy
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x666666);
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x666666);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _rightLabel;
}

-(void)clickTap:(UIButton *)sender{
    
}
@end
