//
//  LLBuyBackView.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLBuyBackView.h"

@interface LLBuyBackView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *countTtitleLabel;
@property (nonatomic,strong)UILabel *storeCountLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UIButton *deleteBtn;

@end

@implementation LLBuyBackView

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
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.countTtitleLabel];
    [self.bottomView addSubview:self.storeCountLabel];
    [self.bottomView addSubview:self.line];
    [self.bottomView addSubview:self.leftLabel];
    [self.bottomView addSubview:self.addBtn];
    [self.bottomView addSubview:self.countLabel];
    [self.bottomView addSubview:self.deleteBtn];
    
    [self.countTtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.storeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(44));
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLabel);
        make.right.mas_equalTo(self.addBtn.mas_left).offset(-15);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftLabel);
        make.right.mas_equalTo(self.countLabel.mas_left).offset(-15);
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
}
-(void)setBackBuyModel:(LLBackBuyPodModel *)backBuyModel{
    _backBuyModel = backBuyModel;
    _storeCountLabel.text = _backBuyModel.goodsNum;
    self.countLabel.text = _backBuyModel.goodsNum;
}
#pragma mark--addBtnClick
-(void)addBtnClick:(UIButton *)btn{
    NSInteger count = [_countLabel.text intValue];
    if(count >_backBuyModel.goodsNum.integerValue ){
        return;;
    }
    if (count < [_backBuyModel.goodsNum intValue]) {
        count++;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count];
    
    if (self.LLBackBuyCountBtnBlock) {
        self.LLBackBuyCountBtnBlock(count);
    }
}
#pragma mark--deleteBtnClick
-(void)deleteBtnClick:(UIButton *)btn{
    
    NSInteger count = [_countLabel.text intValue];

    if (count > 1) {
        count--;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count];

    if (self.LLBackBuyCountBtnBlock) {
        self.LLBackBuyCountBtnBlock(count);
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
-(UILabel *)countTtitleLabel{
    if (!_countTtitleLabel) {
        _countTtitleLabel = [[UILabel alloc]init];
        _countTtitleLabel.textColor = UIColorFromRGB(0x443415);
        _countTtitleLabel.textAlignment = NSTextAlignmentCenter;
        _countTtitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _countTtitleLabel.text = @"我的库存";
    }
    return _countTtitleLabel;
}
-(UILabel *)storeCountLabel{
    if (!_storeCountLabel) {
        _storeCountLabel = [[UILabel alloc]init];
        _storeCountLabel.textColor = UIColorFromRGB(0x443415);
        _storeCountLabel.textAlignment = NSTextAlignmentRight;
        _storeCountLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _storeCountLabel.text = @"1";
    }
    return _storeCountLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _leftLabel.text = @"回购数量";
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




@interface LLBuybackBottomView ()

@property (nonatomic,strong)UILabel *totleLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIButton *confirmBtn;

@end

@implementation LLBuybackBottomView

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
    
    [self addSubview:self.totleLabel];
    [self addSubview:self.noteLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.confirmBtn];
    
    [self.totleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(18));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.totleLabel);
        make.left.mas_equalTo(self.totleLabel.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.noteLabel);
        make.left.mas_equalTo(self.noteLabel.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(6));
        make.width.mas_equalTo(CGFloatBasedI375(105));
        make.height.mas_equalTo(CGFloatBasedI375(36));
    }];
    
}
#pragma mark--confirmBtnClick
-(void)confirmBtnClick:(UIButton *)btn{
    if (self.buybackBlock) {
        self.buybackBlock();
    }
}
-(void)setBuyBackPrice:(NSString *)buyBackPrice{
    _priceLabel.text = buyBackPrice;
}
#pragma mark--lazy
-(UILabel *)totleLabel{
    if (!_totleLabel) {
        _totleLabel = [[UILabel alloc]init];
        _totleLabel.textColor = UIColorFromRGB(0x443415);
        _totleLabel.textAlignment = NSTextAlignmentCenter;
        _totleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _totleLabel.text = @"合计";
    }
    return _totleLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0xD40006);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"¥";
    }
    return _noteLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0xD40006);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _priceLabel.text = @"0.00";
    }
    return _priceLabel;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = UIColorFromRGB(0xD40006);
        [_confirmBtn setTitle:@"确认回购" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = CGFloatBasedI375(18);
        _confirmBtn.clipsToBounds = YES;
    }
    return _confirmBtn;
}

@end




@interface LLBuybackConfirmView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *totleTitleLabel;
@property (nonatomic,strong)UILabel *totleLabel;
@property (nonatomic,strong)UILabel *countTitleLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong)UIView *hLine;
@property (nonatomic,strong)UIView *vLine;


@end

@implementation LLBuybackConfirmView

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
    [self.contentView addSubview:self.totleTitleLabel];
    [self.contentView addSubview:self.totleLabel];
    [self.contentView addSubview:self.countTitleLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.cancleBtn];
    [self.contentView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.hLine];
    [self.contentView addSubview:self.vLine];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CGFloatBasedI375(280));
        make.height.mas_equalTo(CGFloatBasedI375(156));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.totleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(68));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(20));
    }];
    
    [self.totleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totleTitleLabel);
        make.left.mas_equalTo(self.totleTitleLabel.mas_right).offset(2);
    }];
    
    [self.countTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(75));
        make.top.mas_equalTo(self.totleTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.countTitleLabel);
        make.left.mas_equalTo(self.countTitleLabel.mas_right).offset(2);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(CGFloatBasedI375(140));
        make.height.mas_equalTo(CGFloatBasedI375(45));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
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
-(void)setTotalCount:(NSString *)totalCount{
    _countLabel.text = [NSString stringWithFormat:@"%@件",totalCount];
}
-(void)setTotlePrice:(NSString *)totlePrice{
    _totleLabel.text = [NSString stringWithFormat:@"¥%@",totlePrice];
}

-(void)hidden{
    [self removeFromSuperview];
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
#pragma mark--tap
-(void)tap{
    [self hidden];
}
#pragma mark--deleteAdressBtnClick
-(void)buybackBtnClick:(UIButton *)btn{
    [self hidden];
    if (btn.tag == 200) {
        if (self.confirmBtnBlock) {
            self.confirmBtnBlock();
        }
    }
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
        _titleLabel.text = @"是否确认回购";
    }
    return _titleLabel;
}
-(UILabel *)totleTitleLabel{
    if (!_totleTitleLabel) {
        _totleTitleLabel = [[UILabel alloc]init];
        _totleTitleLabel.textColor = UIColorFromRGB(0x666666);
        _totleTitleLabel.textAlignment = NSTextAlignmentCenter;
        _totleTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _totleTitleLabel.text = @"回购商品总价:";
    }
    return _totleTitleLabel;
}
-(UILabel *)totleLabel{
    if (!_totleLabel) {
        _totleLabel = [[UILabel alloc]init];
        _totleLabel.textColor = UIColorFromRGB(0xD40006);
        _totleLabel.textAlignment = NSTextAlignmentCenter;
        _totleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _totleLabel.text = @"¥ 0.00";
    }
    return _totleLabel;
}
-(UILabel *)countTitleLabel{
    if (!_countTitleLabel) {
        _countTitleLabel = [[UILabel alloc]init];
        _countTitleLabel.textColor = UIColorFromRGB(0x666666);
        _countTitleLabel.textAlignment = NSTextAlignmentCenter;
        _countTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _countTitleLabel.text = @"回购商品数量:";
    }
    return _countTitleLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0xD40006);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _countLabel.text = @"1件";
    }
    return _countLabel;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        _cancleBtn.tag = 100;
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_cancleBtn addTarget:self action:@selector(buybackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        _confirmBtn.tag = 200;
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_confirmBtn addTarget:self action:@selector(buybackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
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



@interface LLBuybackSuccessHeaderView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UILabel *noteLabel;

@end

@implementation LLBuybackSuccessHeaderView

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
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    [self.bottomView addSubview:self.imgView];
    [self.bottomView addSubview:self.textLabel];
    [self.bottomView addSubview:self.noteLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.top.mas_equalTo(CGFloatBasedI375(40));
        make.width.height.mas_equalTo(CGFloatBasedI375(70));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(CGFloatBasedI375(20));
        make.centerX.mas_equalTo(self.bottomView);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.centerX.mas_equalTo(self.bottomView);
    }];
    
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.image = [UIImage imageNamed:@"zfcg"];
    }
    return _imgView;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x443415);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(18)];
        _textLabel.text = @"回购成功";
    }
    return _textLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x999999);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _noteLabel.text = @"回购商品金额在我的余额明细中可查看";
    }
    return _noteLabel;
}


@end


@interface LLBuybackRecordHeaderView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLBuybackRecordHeaderView

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
    [self.bottomView addSubview:self.textLabel];
    [self.bottomView addSubview:self.imgView];
    [self.bottomView addSubview:self.line];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(CGFloatBasedI375(75));
        make.height.mas_equalTo(CGFloatBasedI375(24));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), CGFloatBasedI375(10), SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(44))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromRGB(0x443415);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _textLabel.text = @"2021-12-02 12:08:35";
    }
    return _textLabel;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.image = [UIImage imageNamed:@"label_spyhg"];
    }
    return _imgView;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}


@end

@interface LLBuybackRecoderFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@end

@implementation LLBuybackRecoderFooterView

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
    
    [self.bottomView addSubview:self.leftLabel];
    [self.bottomView addSubview:self.priceLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
}
-(void)setDetailModel:(LLBackBuyDetailModel *)detailModel{
    
    NSString *backTotalPrice = detailModel.backTotalPrice;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@.00",backTotalPrice];
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), 0, SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(52))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;;
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _leftLabel.text = @"回购商品总额";
    }
    return _leftLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0x443415);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _priceLabel.text = @"¥129.00";
    }
    return _priceLabel;
}



@end
    
    
    
