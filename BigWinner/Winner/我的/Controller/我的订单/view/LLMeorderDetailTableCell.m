//
//  LLMeorderDetailTableCell.m
//  Winner
//
//  Created by YP on 2022/3/12.
//

#import "LLMeorderDetailTableCell.h"
#import "LLMeOrderDetailHeaderView.h"

@interface LLMeorderDetailTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *adresslabel;

@end

@implementation LLMeorderDetailTableCell

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
        make.left.top.mas_equalTo(CGFloatBasedI375(10));
        make.right.bottom.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    [self.bottomView addSubview:self.topLabel];
    [self.bottomView addSubview:self.nameLabel];
    [self.bottomView addSubview:self.phoneLabel];
    [self.bottomView addSubview:self.adresslabel];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topLabel);
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(CGFloatBasedI375(30));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(CGFloatBasedI375(10));
        make.centerY.mas_equalTo(self.nameLabel);
    }];
    
    [self.adresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-30));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        
    }];
    
}
-(void)setAdressModel:(LLappAddressInfoVo *)adressModel{
    
    NSString *receiveName = adressModel.receiveName;
    NSString *receivePhone = adressModel.receivePhone;
    NSString *province = adressModel.province;
    NSString *city = adressModel.city;
    NSString *area = adressModel.area;
    NSString *address = adressModel.address;
    
    _nameLabel.text = receiveName;
    _phoneLabel.text = [NSString setPhoneMidHid:receivePhone];
    _adresslabel.text = [NSString stringWithFormat:@"%@%@%@%@",province,city,area,address];
    
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
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textColor = UIColorFromRGB(0x443415);
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _topLabel.text = @"收货人信息";
    }
    return _topLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0x443415);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = UIColorFromRGB(0x443415);
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _phoneLabel;
}
-(UILabel *)adresslabel{
    if (!_adresslabel) {
        _adresslabel = [[UILabel alloc]init];
        _adresslabel.textColor = UIColorFromRGB(0x443415);
        _adresslabel.textAlignment = NSTextAlignmentLeft;
        _adresslabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _adresslabel.numberOfLines = 0;
    }
    return _adresslabel;
}

@end


@interface LLMeOrderDetailListTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UILabel *goodsCountLabel;
@property (nonatomic,strong)UILabel *goodsPriceLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong) UILabel *typeLabel;/** <#class#> **/

@end

@implementation LLMeOrderDetailListTableCell

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
        make.height.mas_equalTo(CGFloatBasedI375(110));
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsSpecLabel];
    [self.bottomView addSubview:self.goodsCountLabel];
    [self.bottomView addSubview:self.noteLabel];
    [self.bottomView addSubview:self.goodsPriceLabel];
    [self.bottomView addSubview:self.line];
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
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(105));
        make.top.mas_equalTo(self.goodsSpecLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.noteLabel);
        make.left.mas_equalTo(self.noteLabel.mas_right).offset(3);
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
-(void)setGoodsModel:(LLappOrderListGoodsVos *)goodsModel{
    _goodsModel = goodsModel;
    NSString *coverImage = _goodsModel.coverImage;
    NSString *name = _goodsModel.name;
    NSString *specsValName = _goodsModel.specsValName;
    NSString *salesPrice = _goodsModel.salesPrice;
    NSString *goodsNum = _goodsModel.goodsNum;
    
    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameLabel.text = name;
    _goodsSpecLabel.text = specsValName;
    _goodsPriceLabel.text = salesPrice;
    _goodsCountLabel.text = [NSString stringWithFormat:@"X%@",goodsNum];
    if(_model.orderType.integerValue == 2){//惊喜红包
        self.noteLabel.hidden = YES;
        self.goodsPriceLabel.text = @"库存提货";
        self.goodsPriceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
}
-(void)setModel:(LLMeOrderDetailModel *)model{
    _model = model;
    self.typeLabel.hidden = YES;
    if(_model.orderType.integerValue == 3){
        self.typeLabel.hidden = NO;
        self.typeLabel.text = @"品鉴";
        self.typeLabel.backgroundColor = [[UIColor colorWithHexString:@"#443415"]colorWithAlphaComponent:0.8];
        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(CGFloatBasedI375(35));
        }];
    
    }else if(_model.expressType.integerValue == 2 && _model.orderType.integerValue != 4){
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
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.mj_size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
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
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.textColor = UIColorFromRGB(0x4FFFFFF);
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(11)];
        _typeLabel.text = @"品鉴";
        _typeLabel.mj_size = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(30));
        _typeLabel.size = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(30));
        _typeLabel.hidden = YES;
        _typeLabel.backgroundColor = [[UIColor colorWithHexString:@"#443415"]colorWithAlphaComponent:0.8];

    }
    return _typeLabel;
}
@end




@interface LLMeorderDetailInfotableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *goodsImgLabel;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsNameText;
@property (nonatomic,strong)UILabel *starLabel;
@property (nonatomic,strong)UILabel *starText;
@property (nonatomic,strong)UILabel *evaluateLabel;
@property (nonatomic,strong)UILabel *evaluateText;
@property (nonatomic,strong)LLMeOrderEvaluateFooterView *evaluateImgView;
@property (nonatomic,strong)LLMeOrderEvaluateStarView *starImgView;

@end

@implementation LLMeorderDetailInfotableCell

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
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.top.bottom.mas_equalTo(0);
    }];
    
    
    [self.bottomView addSubview:self.goodsImgLabel];
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsNameText];
    [self.bottomView addSubview:self.starLabel];
    [self.bottomView addSubview:self.evaluateLabel];
    [self.bottomView addSubview:self.evaluateText];
    [self.bottomView addSubview:self.evaluateImgView];
    [self.bottomView addSubview:self.starImgView];
    
    [self.goodsImgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-11));
        make.centerY.mas_equalTo(self.goodsImgLabel);
        make.width.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(55));
    }];
    
    [self.goodsNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-11));
        make.centerY.mas_equalTo(self.goodsNameLabel);
        make.left.mas_equalTo(CGFloatBasedI375(130));
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(85));
    }];
    
    [self.starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.starLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.width.mas_equalTo(CGFloatBasedI375(15 * 5));
        make.height.mas_equalTo(CGFloatBasedI375(10));
    }];
    
    [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(115));
    }];
    
    [self.evaluateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-11));
        make.top.mas_equalTo(self.evaluateLabel);
        make.left.mas_equalTo(CGFloatBasedI375(130));
    }];
    
    CGFloat rowHeight = (SCREEN_WIDTH - CGFloatBasedI375(20) - CGFloatBasedI375(15 * 2) - CGFloatBasedI375(10 * 2)) / 3;
    [self.evaluateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.evaluateText.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(rowHeight);
        make.bottom.mas_equalTo(-20);
    }];
    
}

-(void)setGoodsModel:(LLappOrderListGoodsVos *)goodsModel{
    _goodsModel = goodsModel;
    NSString *coverImage = _goodsModel.coverImage;
    NSString *name = _goodsModel.name;
    
    
    [_goodsImgView sd_setImageWithUrlString:FORMAT(@"%@",coverImage) placeholderImage:[UIImage imageNamed:@""]];
    _goodsNameText.text = name;
    
    LLappOrderEvaluateVo *evalatVoModel = [LLappOrderEvaluateVo yy_modelWithJSON:goodsModel.appOrderEvaluateVo];

    _evaluateText.text = evalatVoModel.content;
    _starImgView.star = evalatVoModel.star;
    
    
    if ([evalatVoModel.images length] <= 0) {
        
        self.evaluateImgView.hidden = YES;
        
        [self.evaluateText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(CGFloatBasedI375(-11));
            make.top.mas_equalTo(self.evaluateLabel);
            make.left.mas_equalTo(CGFloatBasedI375(130));
            make.bottom.mas_equalTo(-20);
        }];
    }else{
        
        self.evaluateImgView.hidden = NO;
        self.evaluateImgView.datas =[evalatVoModel.images componentsSeparatedByString:@","];
        [self.evaluateText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(CGFloatBasedI375(-11));
            make.top.mas_equalTo(self.evaluateLabel);
            make.left.mas_equalTo(CGFloatBasedI375(130));
        }];
        NSArray *images = [evalatVoModel.images componentsSeparatedByString:@","];;
        CGFloat rowHeight = (SCREEN_WIDTH - CGFloatBasedI375(20) - CGFloatBasedI375(15 * 2) - CGFloatBasedI375(10 * 2)) / 3;
        CGFloat gargInheiGht = CGFloatBasedI375(15);
        if(images.count % 3 == 0){
            rowHeight = rowHeight* (images.count/3);
            gargInheiGht = gargInheiGht*(images.count/3);
        }else{
            rowHeight = rowHeight* (images.count/3+1);
            gargInheiGht = gargInheiGht*(images.count/3+1);
        }

        [self.evaluateImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.evaluateText.mas_bottom).offset(CGFloatBasedI375(10));
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(rowHeight+gargInheiGht);
            make.bottom.mas_equalTo(-20);
        }];
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
-(UILabel *)goodsImgLabel{
    if (!_goodsImgLabel) {
        _goodsImgLabel = [[UILabel alloc]init];
        _goodsImgLabel.textColor = UIColorFromRGB(0x443415);
        _goodsImgLabel.textAlignment = NSTextAlignmentLeft;
        _goodsImgLabel.text = @"商品图片";
        _goodsImgLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _goodsImgLabel;
}
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
        _goodsNameLabel.text = @"商品名称";
        _goodsNameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _goodsNameLabel;
}
-(UILabel *)goodsNameText{
    if (!_goodsNameText) {
        _goodsNameText = [[UILabel alloc]init];
        _goodsNameText.textColor = UIColorFromRGB(0x443415);
        _goodsNameText.textAlignment = NSTextAlignmentRight;
        _goodsNameText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _goodsNameText;
}
-(UILabel *)starLabel{
    if (!_starLabel) {
        _starLabel = [[UILabel alloc]init];
        _starLabel.textColor = UIColorFromRGB(0x443415);
        _starLabel.textAlignment = NSTextAlignmentLeft;
        _starLabel.text = @"星级评分";
        _starLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _starLabel;
}
-(UILabel *)evaluateLabel{
    if (!_evaluateLabel) {
        _evaluateLabel = [[UILabel alloc]init];
        _evaluateLabel.textColor = UIColorFromRGB(0x443415);
        _evaluateLabel.textAlignment = NSTextAlignmentLeft;
        _evaluateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _evaluateLabel.text = @"评价内容";
    }
    return _evaluateLabel;
}
-(UILabel *)evaluateText{
    if (!_evaluateText) {
        _evaluateText = [[UILabel alloc]init];
        _evaluateText.textColor = UIColorFromRGB(0x443415);
        _evaluateText.textAlignment = NSTextAlignmentRight;
        _evaluateText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _evaluateText.text = @"口感很不错，喝起来很舒服，不像别的很辣口，总体包装也不错";
        _evaluateText.numberOfLines = 0;
    }
    return _evaluateText;
}
-(LLMeOrderEvaluateFooterView *)evaluateImgView{
    if (!_evaluateImgView) {
        _evaluateImgView = [[LLMeOrderEvaluateFooterView alloc]init];
    }
    return _evaluateImgView;
}
-(LLMeOrderEvaluateStarView *)starImgView{
    if (!_starImgView) {
        _starImgView = [[LLMeOrderEvaluateStarView alloc]init];
    }
    return _starImgView;
}

@end




@interface LlmeOrderDetailOrderInfoTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *leftlabel;
@property (nonatomic,strong)UILabel *rightLabel;

@end

@implementation LlmeOrderDetailOrderInfoTableCell

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
    [self.bottomView addSubview:self.leftlabel];
    [self.bottomView addSubview:self.rightLabel];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(7));
        make.bottom.mas_equalTo(CGFloatBasedI375(-7));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(110));
    }];
    
    [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(5));
    }];
    
    
}
-(void)setLeftStr:(NSString *)leftStr{
    _leftlabel.text = leftStr;
}
-(void)setRightStr:(NSString *)rightStr{
    _rightLabel.text = rightStr;
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel = [[UILabel alloc]init];
        _leftlabel.textColor = UIColorFromRGB(0x443415);
        _leftlabel.textAlignment = NSTextAlignmentLeft;
        _leftlabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _leftlabel;
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
@interface LLMeorderDetailPeiSongtableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *adresslabel;
@property (nonatomic,strong)UIImageView *headImage;

@end

@implementation LLMeorderDetailPeiSongtableCell

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
        make.left.top.mas_equalTo(CGFloatBasedI375(10));
        make.height.equalTo(CGFloatBasedI375(150));
        make.right.bottom.mas_equalTo(CGFloatBasedI375(-10));
    }];
    [self.bottomView addSubview:self.headImage];

    [self.bottomView addSubview:self.topLabel];
    [self.bottomView addSubview:self.nameLabel];
    [self.bottomView addSubview:self.phoneLabel];
    [self.bottomView addSubview:self.adresslabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.equalTo(CGFloatBasedI375(24));
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(CGFloatBasedI375(15));

    }];
   
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.headImage);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(CGFloatBasedI375(10));
        make.centerY.mas_equalTo(self.nameLabel);
    }];
    [self.adresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(20));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
    

}
-(void)setModel:(LLMeOrderDetailModel *)model{
    _model = model;
    if(_model.appDeliveryClerkDistanceVo){
        _topLabel.text = @"配送员信息";
        [self.headImage sd_setImageWithUrlString:_model.appDeliveryClerkDistanceVo.photo];
        self.nameLabel.text = _model.appDeliveryClerkDistanceVo.realName;
        self.phoneLabel.text = [NSString setPhoneMidHid:_model.appDeliveryClerkDistanceVo.telePhone];
        self.adresslabel.attributedText = [self getAttribuStrWithStrings:@[@"配送员已出发，预计当日",_model.createTime,@" 到达收货目的地，请注意电话接听，祝您购物愉快，谢谢！"] colors:@[[UIColor colorWithHexString:@"#666666"],Main_Color,[UIColor colorWithHexString:@"#666666"]]];
       
    }else   if(_model.shopDistanceVo){
        _topLabel.text = @"推广员信息";
        [self.headImage sd_setImageWithUrlString:_model.shopDistanceVo.shopPhoto];
        self.nameLabel.text = _model.shopDistanceVo.name;
        self.phoneLabel.text = [NSString setPhoneMidHid:_model.shopDistanceVo.telePhone];
        NSString *times =model.createTime;
        if(times.length > 18){
            times =  [times substringWithRange:NSMakeRange(11, 5)];
        }
        self.adresslabel.attributedText = [self getAttribuStrWithStrings:@[@"推广点已接单，预计",FORMAT(@"当日%@分",times),@" 到达收货目的地， 请注意电话接听，祝您购物愉快，谢谢！"] colors:@[[UIColor colorWithHexString:@"#666666"],Main_Color,[UIColor colorWithHexString:@"#666666"]]];
    
    }

    if(_model.orderType.integerValue == 1 && _model.expressType.integerValue == 2){
        
        if(_model.shopDistanceVo){
            _topLabel.text = @"推广员信息";
            [self.headImage sd_setImageWithUrlString:_model.shopDistanceVo.shopPhoto];
            self.nameLabel.text = _model.shopDistanceVo.name;
            self.phoneLabel.text = [NSString setPhoneMidHid:_model.shopDistanceVo.telePhone];
            NSString *times =model.createTime;
            if(times.length > 18){
                times =  [times substringWithRange:NSMakeRange(11, 5)];
            }
            self.adresslabel.attributedText = [self getAttribuStrWithStrings:@[@"推广点已接单，预计",FORMAT(@"当日%@分",times),@" 到达收货目的地， 请注意电话接听，祝您购物愉快，谢谢！"] colors:@[[UIColor colorWithHexString:@"#666666"],Main_Color,[UIColor colorWithHexString:@"#666666"]]];
        
        }else if(_model.appDeliveryClerkDistanceVo){
            _topLabel.text = @"配送员信息";
            self.nameLabel.text = _model.appDeliveryClerkDistanceVo.realName;
            self.phoneLabel.text = [NSString setPhoneMidHid:_model.appDeliveryClerkDistanceVo.telePhone];
            self.adresslabel.attributedText = [self getAttribuStrWithStrings:@[@"配送员已出发，预计当日",_model.createTime,@" 到达收货目的地，请注意电话接听，祝您购物愉快，谢谢！"] colors:@[[UIColor colorWithHexString:@"#666666"],Main_Color,[UIColor colorWithHexString:@"#666666"]]];
        }
    }
    
}
//-(void)setAdressModel:(LLappAddressInfoVo *)adressModel{
//
//    NSString *receiveName = adressModel.receiveName;
//    NSString *receivePhone = adressModel.receivePhone;
//    NSString *province = adressModel.province;
//    NSString *city = adressModel.city;
//    NSString *area = adressModel.area;
//    NSString *address = adressModel.address;
//
//    _nameLabel.text = receiveName;
//    _phoneLabel.text = [NSString setPhoneMidHid:receivePhone];
//    _adresslabel.text = [NSString stringWithFormat:@"%@%@%@%@",province,city,area,address];
//
//}

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
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc]init];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = CGFloatBasedI375(12);
    }
    return _headImage;;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textColor = UIColorFromRGB(0x443415);
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _topLabel.text = @"配送员信息";
    }
    return _topLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0x443415);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = UIColorFromRGB(0x443415);
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    }
    return _phoneLabel;
}
-(UILabel *)adresslabel{
    if (!_adresslabel) {
        _adresslabel = [[UILabel alloc]init];
        _adresslabel.textColor = UIColorFromRGB(0x443415);
        _adresslabel.textAlignment = NSTextAlignmentLeft;
        _adresslabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _adresslabel.numberOfLines = 0;
    }
    return _adresslabel;
}

@end
