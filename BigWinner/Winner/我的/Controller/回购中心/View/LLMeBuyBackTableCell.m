//
//  LLMeBuyBackTableCell.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeBuyBackTableCell.h"

@interface LLMeBuyBackTableCell ()

@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UIView *noteView;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UILabel *notePriceLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *rateLabel;
@property (nonatomic,strong)UIImageView *rateImgView;
@property (nonatomic,strong)UIButton *buybackBtn;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLMeBuyBackTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.goodsImgView];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.goodsSpecLabel];
    [self.contentView addSubview:self.noteView];
    [self.noteView addSubview:self.noteLabel];
    [self.contentView addSubview:self.notePriceLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.rateLabel];
    [self.contentView addSubview:self.rateImgView];
    [self.contentView addSubview:self.buybackBtn];
    [self.contentView addSubview:self.line];
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImgView);
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(CGFloatBasedI375(58));
    }];
    
    
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(CGFloatBasedI375(3));
        make.right.mas_equalTo(CGFloatBasedI375(-3));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.noteView.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.rateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.rateLabel.mas_right).offset(CGFloatBasedI375(5));
        make.width.mas_equalTo(CGFloatBasedI375(6));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.buybackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(CGFloatBasedI375(-18));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(50));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
#pragma mark--buybackBtnClick
-(void)buybackBtnClick:(UIButton *)btn{
    if (self.buybackBtnBlock) {
        self.buybackBtnBlock(_listModel.ID);
    }
}
-(void)setIsbuyHidden:(BOOL)isbuyHidden{
    _buybackBtn.hidden = isbuyHidden;
}
-(void)setListModel:(LLStorageListModel *)listModel{
  
    _listModel = listModel;
    
    NSString *coverImage = _listModel.coverImage;
    NSString *name = _listModel.name;
    NSString *specsValName = _listModel.specsValName;
    CGFloat range = [_listModel.range floatValue];
    NSString *rangeType = _listModel.rangeType;
    CGFloat buyBackPrice = [_listModel.buyBackPrice floatValue];
    NSString *goodsNum = _listModel.goodsNum;

    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _rateLabel.text = [NSString stringWithFormat:@"%.2f%%",range];
    
//    CGFloat totalPrice = 0.0;
    if ([rangeType intValue] ==  1) {
        //上升
        _rateImgView.image = [UIImage imageNamed:@"rise"];
        _rateLabel.textColor = UIColorFromRGB(0xD40006);
//        totalPrice = buyBackPrice + buyBackPrice * range;
        
    }else{
        //下降
        _rateImgView.image = [UIImage imageNamed:@"drop"];
        _rateLabel.textColor = UIColorFromRGB(0x4BBA6D);
//        totalPrice = buyBackPrice - buyBackPrice * range;
    }
    _priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",buyBackPrice)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ BlackTitleFont443415, BlackTitleFont443415]];
    
    if ([goodsNum intValue] == 0) {
        _buybackBtn.backgroundColor = UIColorFromRGB(0xCCCCCC);
        _buybackBtn.enabled = NO;
    }else{
        _buybackBtn.backgroundColor = UIColorFromRGB(0xD40006);
        _buybackBtn.enabled = YES;
    }
    
}
-(void)setBackBuyModel:(LLBackBuyPodModel *)backBuyModel{
    _backBuyModel = backBuyModel;
    NSString *coverImage = _backBuyModel.coverImage;
    NSString *name = _backBuyModel.name;
    NSString *specsValName = _backBuyModel.specsValName;
    CGFloat range = [_backBuyModel.range floatValue];
    NSString *rangeType = _backBuyModel.rangeType;
    CGFloat buyBackPrice = [_backBuyModel.buyBackPrice floatValue];

    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _rateLabel.text = [NSString stringWithFormat:@"%.2f%%",range];
    
    CGFloat totalPrice = 0.0;
    if ([rangeType intValue] ==  1) {
        //上升
        _rateImgView.image = [UIImage imageNamed:@"rise"];
        _rateLabel.textColor = UIColorFromRGB(0xD40006);
        totalPrice = buyBackPrice + buyBackPrice * range;
        
    }else{
        //下降
        _rateImgView.image = [UIImage imageNamed:@"drop"];
        _rateLabel.textColor = UIColorFromRGB(0x4BBA6D);
        totalPrice = buyBackPrice - buyBackPrice * range;
    }
    _priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",buyBackPrice)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ BlackTitleFont443415, BlackTitleFont443415]];
    
}

#pragma mark--lazy
-(UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc]init];
    }
    return _goodsImgView;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        _goodsNameLabel.textColor = UIColorFromRGB(0x443415);
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _goodsNameLabel.text = @"大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒";
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}
-(UILabel *)goodsSpecLabel{
    if (!_goodsSpecLabel) {
        _goodsSpecLabel = [[UILabel alloc]init];
        _goodsSpecLabel.textColor = UIColorFromRGB(0x999999);
        _goodsSpecLabel.textAlignment = NSTextAlignmentLeft;
        _goodsSpecLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsSpecLabel.text = @"1支装(500ML)";
    }
    return _goodsSpecLabel;
}
-(UIView *)noteView{
    if (!_noteView) {
        _noteView = [[UIView alloc]init];
        _noteView.backgroundColor = [UIColor whiteColor];
        _noteView.layer.cornerRadius = CGFloatBasedI375(3);
        _noteView.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _noteView.clipsToBounds = YES;
        _noteView.layer.borderWidth = 0.5;
    }
    return _noteView;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0xD40006);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(10)];
        _noteLabel.text = @"回购价";
    }
    return _noteLabel;
}
-(UILabel *)notePriceLabel{
    if (!_notePriceLabel) {
        _notePriceLabel = [[UILabel alloc]init];
        _notePriceLabel.textColor = UIColorFromRGB(0x443415);
        _notePriceLabel.textAlignment = NSTextAlignmentCenter;
        _notePriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _notePriceLabel.text = @"¥";
    }
    return _notePriceLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0x443415);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _priceLabel.text = @"0.00";
    }
    return _priceLabel;
}
-(UILabel *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc]init];
        _rateLabel.textColor = UIColorFromRGB(0xD40006);
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        _rateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _rateLabel.text = @"0.00%";
    }
    return _rateLabel;
}
-(UIImageView *)rateImgView{
    if (!_rateImgView) {
        _rateImgView = [[UIImageView alloc]init];
        _rateImgView.backgroundColor = [UIColor whiteColor];
        _rateImgView.image = [UIImage imageNamed:@"rise"];
    }
    return _rateImgView;
}
-(UIButton *)buybackBtn{
    if (!_buybackBtn) {
        _buybackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buybackBtn.backgroundColor = UIColorFromRGB(0xD40006);
        [_buybackBtn setTitle:@"回购" forState:UIControlStateNormal];
        [_buybackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buybackBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        [_buybackBtn addTarget:self action:@selector(buybackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _buybackBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _buybackBtn.clipsToBounds = YES;
    }
    return _buybackBtn;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

@end


@interface LLBuybackSuccessTableCell ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;


@end

@implementation LLBuybackSuccessTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(124));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftLabel.text = leftStr;
}
-(void)setRightStr:(NSString *)rightStr{
    _rightLabel.text = rightStr;
}

#pragma mark--lazy
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = UIColorFromRGB(0x443415);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x443415);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _rightLabel.numberOfLines = 0;
    }
    return _rightLabel;
}



@end


@interface LLBuybackRecordTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UIView *noteView;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UILabel *notePriceLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *countLabel;


@end

@implementation LLBuybackRecordTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsSpecLabel];
    [self.bottomView addSubview:self.noteView];
    [self.noteView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.notePriceLabel];
    [self.bottomView addSubview:self.priceLabel];
    [self.bottomView addSubview:self.countLabel];
    
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImgView);
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(CGFloatBasedI375(58));
    }];
    
    
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(CGFloatBasedI375(3));
        make.right.mas_equalTo(CGFloatBasedI375(-3));
    }];
    
    [self.notePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.noteView.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.notePriceLabel.mas_right).offset(CGFloatBasedI375(3));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
}

-(void)setListModel:(LLBackBuyListModel *)listModel{
    
    NSString *coverImage = listModel.coverImage;
    NSString *name = listModel.name;
    NSString *specsValName = listModel.specsValName;
    NSString *backPrice = listModel.backPrice;
    NSString *backNum = listModel.backNum;
    
    
    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _priceLabel.text = backPrice;
    _countLabel.text = [NSString stringWithFormat:@"X%@",backNum];

}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), 0, SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(110))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
        
    }
    return _bottomView;
}

#pragma mark--lazy
-(UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc]init];
        _goodsImgView.backgroundColor = [UIColor redColor];
    }
    return _goodsImgView;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        _goodsNameLabel.textColor = UIColorFromRGB(0x443415);
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _goodsNameLabel.text = @"大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒";
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}
-(UILabel *)goodsSpecLabel{
    if (!_goodsSpecLabel) {
        _goodsSpecLabel = [[UILabel alloc]init];
        _goodsSpecLabel.textColor = UIColorFromRGB(0x999999);
        _goodsSpecLabel.textAlignment = NSTextAlignmentLeft;
        _goodsSpecLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsSpecLabel.text = @"1支装(500ML)";
    }
    return _goodsSpecLabel;
}
-(UIView *)noteView{
    if (!_noteView) {
        _noteView = [[UIView alloc]init];
        _noteView.backgroundColor = [UIColor whiteColor];
        _noteView.layer.cornerRadius = CGFloatBasedI375(3);
        _noteView.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _noteView.clipsToBounds = YES;
        _noteView.layer.borderWidth = 0.5;
    }
    return _noteView;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0xD40006);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(10)];
        _noteLabel.text = @"回购价";
    }
    return _noteLabel;
}
-(UILabel *)notePriceLabel{
    if (!_notePriceLabel) {
        _notePriceLabel = [[UILabel alloc]init];
        _notePriceLabel.textColor = UIColorFromRGB(0x443415);
        _notePriceLabel.textAlignment = NSTextAlignmentCenter;
        _notePriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _notePriceLabel.text = @"¥";
    }
    return _notePriceLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0x443415);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _priceLabel.text = @"0.00";
    }
    return _priceLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0x999999);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _countLabel.text = @"X2";
    }
    return _countLabel;
}



@end




@interface LLBuybackRecordDetailTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UIView *noteView;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UILabel *notePriceLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLBuybackRecordDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.bottom.mas_equalTo(0);
    }];
    
    
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsSpecLabel];
    [self.bottomView addSubview:self.noteView];
    [self.noteView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.notePriceLabel];
    [self.bottomView addSubview:self.priceLabel];
    [self.bottomView addSubview:self.countLabel];
    [self.bottomView addSubview:self.line];
    
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImgView);
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.goodsSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(CGFloatBasedI375(58));
    }];
    
    
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(CGFloatBasedI375(3));
        make.right.mas_equalTo(CGFloatBasedI375(-3));
    }];
    
    [self.notePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.noteView.mas_right).offset(CGFloatBasedI375(5));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.left.mas_equalTo(self.notePriceLabel.mas_right).offset(CGFloatBasedI375(3));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noteView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}
-(void)setDetailModel:(LLBackBuyDetailModel *)detailModel{
    

    NSString *coverImage = detailModel.coverImage;
    NSString *name = detailModel.name;
    NSString *specsValName = detailModel.specsValName;
    NSString *backPrice = detailModel.backPrice;
    NSString *backNum = detailModel.backNum;
    
    
    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _priceLabel.text = backPrice;
    _countLabel.text = [NSString stringWithFormat:@"X%@",backNum];
    
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UIImageView *)goodsImgView{
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc]init];
    }
    return _goodsImgView;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        _goodsNameLabel.textColor = UIColorFromRGB(0x443415);
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _goodsNameLabel.text = @"大赢家 进取 500ml单瓶装 酱香型白酒 家庭聚会 商务 必选白酒";
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}
-(UILabel *)goodsSpecLabel{
    if (!_goodsSpecLabel) {
        _goodsSpecLabel = [[UILabel alloc]init];
        _goodsSpecLabel.textColor = UIColorFromRGB(0x999999);
        _goodsSpecLabel.textAlignment = NSTextAlignmentLeft;
        _goodsSpecLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsSpecLabel.text = @"1支装(500ML)";
    }
    return _goodsSpecLabel;
}
-(UIView *)noteView{
    if (!_noteView) {
        _noteView = [[UIView alloc]init];
        _noteView.backgroundColor = [UIColor whiteColor];
        _noteView.layer.cornerRadius = CGFloatBasedI375(3);
        _noteView.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _noteView.clipsToBounds = YES;
        _noteView.layer.borderWidth = 0.5;
    }
    return _noteView;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0xD40006);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(10)];
        _noteLabel.text = @"回购价";
    }
    return _noteLabel;
}
-(UILabel *)notePriceLabel{
    if (!_notePriceLabel) {
        _notePriceLabel = [[UILabel alloc]init];
        _notePriceLabel.textColor = UIColorFromRGB(0x443415);
        _notePriceLabel.textAlignment = NSTextAlignmentCenter;
        _notePriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _notePriceLabel.text = @"¥";
    }
    return _notePriceLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorFromRGB(0x443415);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _priceLabel.text = @"0.00";
    }
    return _priceLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = UIColorFromRGB(0x999999);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _countLabel.text = @"X2";
    }
    return _countLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}



@end



@interface LLBuybackRecordInfoTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UILabel *numberTitleLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *buyTimeTitleLabel;
@property (nonatomic,strong)UILabel *buyTimeLabel;
@property (nonatomic,strong)UILabel *backTimeTitleLabel;
@property (nonatomic,strong)UILabel *backTimeLabel;


@end

@implementation LLBuybackRecordInfoTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.line];
    [self.bottomView addSubview:self.numberTitleLabel];
    [self.bottomView addSubview:self.numberLabel];
    [self.bottomView addSubview:self.buyTimeTitleLabel];
    [self.bottomView addSubview:self.buyTimeLabel];
    [self.bottomView addSubview:self.backTimeTitleLabel];
    [self.bottomView addSubview:self.backTimeLabel];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(44));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.numberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.line.mas_bottom).offset(CGFloatBasedI375(20));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.numberTitleLabel);
    }];
    
    [self.buyTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.numberTitleLabel.mas_bottom).offset(CGFloatBasedI375(20));
    }];
    
    [self.buyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.buyTimeTitleLabel);
    }];
    
    [self.backTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.buyTimeTitleLabel.mas_bottom).offset(CGFloatBasedI375(20));
    }];
    
    [self.backTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.backTimeTitleLabel);
    }];
}

-(void)setDetailModel:(LLBackBuyDetailModel *)detailModel{
    
    NSString *orderNo = detailModel.orderNo;
    NSString *createTime = detailModel.createTime;
//    NSString *coverImage = detailModel.coverImage;
    
    _numberLabel.text = orderNo;
    _buyTimeLabel.text = createTime;
    _backTimeLabel.text = createTime;
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"订单信息";
    }
    return _titleLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}
-(UILabel *)numberTitleLabel{
    if (!_numberTitleLabel) {
        _numberTitleLabel = [[UILabel alloc]init];
        _numberTitleLabel.textColor = UIColorFromRGB(0x443415);
        _numberTitleLabel.textAlignment = NSTextAlignmentCenter;
        _numberTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _numberTitleLabel.text = @"订单编号";
    }
    return _numberTitleLabel;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = UIColorFromRGB(0x443415);
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _numberLabel.text = @"HG20210715040210003";
    }
    return _numberLabel;
}

-(UILabel *)buyTimeTitleLabel{
    if (!_buyTimeTitleLabel) {
        _buyTimeTitleLabel = [[UILabel alloc]init];
        _buyTimeTitleLabel.textColor = UIColorFromRGB(0x443415);
        _buyTimeTitleLabel.textAlignment = NSTextAlignmentCenter;
        _buyTimeTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _buyTimeTitleLabel.text = @"下单时间";
    }
    return _buyTimeTitleLabel;
}
-(UILabel *)buyTimeLabel{
    if (!_buyTimeLabel) {
        _buyTimeLabel = [[UILabel alloc]init];
        _buyTimeLabel.textColor = UIColorFromRGB(0x443415);
        _buyTimeLabel.textAlignment = NSTextAlignmentRight;
        _buyTimeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _buyTimeLabel.text = @"2021-12-02 12:07:55";
    }
    return _buyTimeLabel;
}
-(UILabel *)backTimeTitleLabel{
    if (!_backTimeTitleLabel) {
        _backTimeTitleLabel = [[UILabel alloc]init];
        _backTimeTitleLabel.textColor = UIColorFromRGB(0x443415);
        _backTimeTitleLabel.textAlignment = NSTextAlignmentCenter;
        _backTimeTitleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _backTimeTitleLabel.text = @"回购时间";
    }
    return _backTimeTitleLabel;
}
-(UILabel *)backTimeLabel{
    if (!_backTimeLabel) {
        _backTimeLabel = [[UILabel alloc]init];
        _backTimeLabel.textColor = UIColorFromRGB(0x443415);
        _backTimeLabel.textAlignment = NSTextAlignmentRight;
        _backTimeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _backTimeLabel.text = @"2021-12-02 12:08:35";
    }
    return _backTimeLabel;
}


@end

