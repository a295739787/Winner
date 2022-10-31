//
//  LLMeOrderListTableCell.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeOrderListTableCell.h"

@interface LLMeOrderListTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UILabel *goodsCountLabel;
@property (nonatomic,strong)UILabel *goodsPriceLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIView *line;

@property (nonatomic,strong)UIView *typeNoteView;

@end

@implementation LLMeOrderListTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(0);
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsSpecLabel];
    [self.bottomView addSubview:self.goodsCountLabel];
    [self.bottomView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.goodsPriceLabel];
    [self.bottomView addSubview:self.line];
//    [self.goodsImgView addSubview:self.typeNoteView];
    [self.goodsImgView addSubview:self.typeLabel];
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(18));
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.right.mas_equalTo(CGFloatBasedI375(-40));
    }];
    [self.goodsSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(105));
    }];
//    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(CGFloatBasedI375(105));
//        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
//    }];
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(105));
    }];
    
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-13));
        make.centerY.mas_equalTo(self.goodsPriceLabel);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.equalTo(CGFloatBasedI375(40));
        make.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    [self layoutIfNeeded];
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.typeLabel.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

   CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
   cornerRadiusLayer.frame = self.typeLabel.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.typeLabel.layer.mask = cornerRadiusLayer;
    
}
-(void)setAppOrderListGoodsVo:(LLMeOrderListModel *)appOrderListGoodsVo{
    
    
    NSString *coverImage = appOrderListGoodsVo.coverImage;
    NSString *name = appOrderListGoodsVo.name;
    NSString *specsValName = appOrderListGoodsVo.specsValName;
    NSString *salesPrice = appOrderListGoodsVo.salesPrice;
    NSString *goodsNum = appOrderListGoodsVo.goodsNum;
    
    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _goodsPriceLabel.text = salesPrice;
    _goodsCountLabel.text = [NSString stringWithFormat:@"X%@",goodsNum];
    
}

-(void)setType:(NSInteger)type{
    _type = type;
    if (_type == 0) {
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(CGFloatBasedI375(15));
            make.right.mas_equalTo(CGFloatBasedI375(-15));
        }];
        
    }else{
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(CGFloatBasedI375(10));
            make.right.mas_equalTo(CGFloatBasedI375(-10));
        }];
    }
    
}
-(void)setModel:(LLMeOrderListModel *)model{
    _model = model;
    [self.goodsImgView  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.goodsSpecLabel.text = FORMAT(@"%@",_model.specsValName);
    self.goodsNameLabel.text = _model.name;
    self.goodsPriceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    self.goodsCountLabel.text  = FORMAT(@"x%@",_model.goodsNum);
    self.line.hidden = NO;
    if(_faModel.orderType.integerValue == 2){//惊喜红包  库存提货
        self.goodsPriceLabel.text = @"库存提货";
        self.line.hidden = YES;
        self.goodsPriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    
    

}
-(void)setIssmodel:(LLMeOrderListModel *)issmodel{
    _issmodel = issmodel;
    [self.goodsImgView  sd_setImageWithUrlString:FORMAT(@"%@",_issmodel.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.goodsNameLabel.text = FORMAT(@"%@",_issmodel.specsValName);
    self.goodsCountLabel.text = FORMAT(@"x%@",_issmodel.goodsNum);
    self.goodsNameLabel.text = _issmodel.name;
    self.goodsPriceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_issmodel.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    
}

-(void)setFaModel:(LLMeOrderListModel *)faModel{
    _faModel = faModel;
    
    self.typeLabel.hidden = YES;
    self.typeNoteView.hidden = YES;
    if(_faModel.orderType.integerValue == 3){
        self.typeLabel.hidden = NO;
        self.typeLabel.text = @"品鉴";
        self.typeNoteView.width = CGFloatBasedI375(35);
        self.typeLabel.backgroundColor = [[UIColor colorWithHexString:@"#443415"]colorWithAlphaComponent:0.8];
        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(CGFloatBasedI375(35));
        }];
    
    }else if(_faModel.expressType.integerValue == 2){
        self.typeNoteView.hidden = NO;
        self.typeLabel.hidden = NO;
        self.typeLabel.text = @"同城配送";
        self.typeLabel.backgroundColor = [Main_Color colorWithAlphaComponent:0.9];
        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(CGFloatBasedI375(60));
        }];
    }
    [self layoutIfNeeded];
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.typeLabel.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

   CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
   cornerRadiusLayer.frame = self.typeLabel.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.typeLabel.layer.mask = cornerRadiusLayer;
}
-(void)setOrderType:(NSString *)orderType{
    _orderType = orderType;
//    if ([_orderType intValue] == 3) {
//        self.typeNoteView.hidden = NO;
//        self.typeLabel.hidden = NO;
//
//    }else{
//        self.typeNoteView.hidden = YES;
//        self.typeLabel.hidden = YES;
//    }
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
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
-(UILabel *)goodsCountLabel{
    if (!_goodsCountLabel) {
        _goodsCountLabel = [[UILabel alloc]init];
        _goodsCountLabel.textColor = UIColorFromRGB(0x999999);
        _goodsCountLabel.textAlignment = NSTextAlignmentRight;
        _goodsCountLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _goodsCountLabel.text = @"X1";
    }
    return _goodsCountLabel;
}
-(UILabel *)goodsPriceLabel{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc]init];
        _goodsPriceLabel.textColor = UIColorFromRGB(0x443415);
        _goodsPriceLabel.textAlignment = NSTextAlignmentCenter;
        _goodsPriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _goodsPriceLabel.text = @"149.00";
    }
    return _goodsPriceLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x443415);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"¥";
    }
    return _noteLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}

-(UIView *)typeNoteView{
    if (!_typeNoteView) {
        _typeNoteView = [[UIView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(60), CGFloatBasedI375(35), CGFloatBasedI375(20))];
        _typeNoteView.backgroundColor = [[UIColor colorWithHexString:@"#443415"]colorWithAlphaComponent:0.8];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.typeNoteView.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.typeNoteView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.typeNoteView.layer.mask = cornerRadiusLayer;
    }
    return _typeNoteView;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.textColor = UIColorFromRGB(0x4FFFFFF);
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(11)];
        _typeLabel.text = @"品鉴";
        _typeLabel.mj_size = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(30));
        _typeLabel.size = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(30));
        

    }
    return _typeLabel;
}


@end
