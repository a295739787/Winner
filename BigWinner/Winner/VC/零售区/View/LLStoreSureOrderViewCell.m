//
//  LLShopCarCell.m
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import "LLStoreSureOrderViewCell.h"
@interface LLStoreSureOrderViewCell ()
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UIImageView *numsImageview;
@property (nonatomic,strong) UILabel *priceLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIButton *selectButton;/** <#class#> **/
@property(nonatomic,strong)UILabel *countlabel;

@end
@implementation LLStoreSureOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(CGFloatBasedI375(0));

    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.width.offset(CGFloatBasedI375(80));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];

    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.showImage.mas_top).offset(CGFloatBasedI375(0));
        make.right.offset(CGFloatBasedI375(-10));
//        make.height.offset(CGFloatBasedI375(40));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(12));
    }];

    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.nameLabel1.mas_left);
        make.right.offset(CGFloatBasedI375(-20/2));
        make.height.offset(CGFloatBasedI375(25));
    }];

    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.nameLabel1.mas_left);
        make.height.offset(CGFloatBasedI375(1));
    }];
 
  
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nameLabel1.mas_left);
//        make.width.equalTo(CGFloatBasedI375(50));
        make.bottom.equalTo(weakself.showImage.mas_bottom).offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(14));
    }];

    [self.countlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.priceLabel.mas_centerY);
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
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.detailsLabel.text = FORMAT(@"%@",_model.specsValName);
    self.countlabel.text = FORMAT(@"x%@",_model.goodsNum); 
    self.nameLabel1.text = _model.name;
    self.priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
}
#pragma mark ============= 懒加载 =============

-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        [self.contentView addSubview:self.backView];
    }
    return _backView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.contentMode = UIViewContentModeScaleAspectFill;
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;
        _showImage.layer.masksToBounds = YES;
        _showImage.layer.cornerRadius = CGFloatBasedI375(8);
        _showImage.image = [UIImage imageNamed:morenpic];
        [self.backView addSubview:self.showImage];
    }
    return _showImage;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.backView addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
    }
    return _nameLabel1;
}

-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(12)];
        _priceLabel.textColor =Main_Color;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.userInteractionEnabled = YES;
        [self.backView addSubview:self.priceLabel];
        _priceLabel.text = @"¥ 169.00";
    }
    return _priceLabel;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview:self.detailsLabel];
        _detailsLabel.text = @"1支装(500ML)";

    }
    return _detailsLabel;
}

-(UIView *)lineview
{
    if (_lineview == nil) {
        _lineview = [[UIView alloc]init];
        [_lineview setBackgroundColor:lightGrayF5F5_Color];
         [self.backView addSubview: self.lineview];
    }
    return _lineview;
}

-(UILabel *)countlabel{
    if(!_countlabel){
        _countlabel = [[UILabel alloc]init];
        _countlabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        _countlabel.textAlignment = NSTextAlignmentRight;
        _countlabel.text = @"x1";
        _countlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.backView addSubview:self.countlabel];
//        _countlabel.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _countlabel;
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
        [self.showImage addSubview:_typeLabel];
    }
    return _typeLabel;
}
@end
@interface LLStoreSureOrderViewAddressCell ()
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UIImageView *numsImageview;
@property (nonatomic,strong) UILabel *deLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UIImageView *allowview;

@property (nonatomic,strong) UIView *backNoView;
@property (nonatomic,strong) UIImageView *addImage;
@property (nonatomic,strong) UILabel *addnameLabel1;
@property (nonatomic,strong) UIImageView *allowImageview;
@property (nonatomic,strong) UILabel *noLabel;

@end
@implementation LLStoreSureOrderViewAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.backNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(CGFloatBasedI375(0));
    }];
    [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.width.offset(CGFloatBasedI375(24));
        make.centerY.equalTo(weakself.backNoView.mas_centerY);
    }];
    [self.allowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(10));
        make.width.offset(CGFloatBasedI375(5));
        make.centerY.equalTo(weakself.backNoView.mas_centerY);
    }];
    [self.addnameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.backNoView.mas_centerY);
        make.right.offset(CGFloatBasedI375(-10));
        make.left.equalTo(weakself.addImage.mas_right).offset(CGFloatBasedI375(10));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(CGFloatBasedI375(0));

    }];
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(14));
        make.left.offset(CGFloatBasedI375(15));
        make.width.offset(CGFloatBasedI375(60));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(14));
        make.left.equalTo(weakself.nameLabel1.mas_right).offset(CGFloatBasedI375(15));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(3));
        make.centerX.equalTo(weakself.nameLabel1.mas_centerX);
        make.width.offset(CGFloatBasedI375(33));
        make.height.offset(CGFloatBasedI375(16));
    }];
    [self.deLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.phoneLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.equalTo(weakself.phoneLabel.mas_left);
//        make.width.offset(CGFloatBasedI375(150));
        make.right.offset(-CGFloatBasedI375(50));
    }];
    [self.allowview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(10));
        make.width.offset(CGFloatBasedI375(5));
        make.centerY.equalTo(weakself.detailsLabel.mas_centerY);
    }];
 

}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    if(_model){
        self.backNoView.hidden = YES;
        self.backView.hidden = NO;
        self.nameLabel1.text = _model.receiveName;
        self.phoneLabel.text = [NSString setPhoneMidHid: _model.receivePhone];
        self.deLabel.text = FORMAT(@"%@%@%@%@%@",_model.province,_model.city,_model.area,_model.locations,_model.address);
        self.detailsLabel.hidden = YES;
        if ([_model.isDefault boolValue] == YES) {
            self.detailsLabel.hidden = NO;
        }
    }else{
        self.backNoView.hidden = NO;
        self.backView.hidden = YES;
    }
    
}
#pragma mark ============= 懒加载 =============
-(UIView *)backNoView{
    if(!_backNoView){
        _backNoView = [[UIView alloc]init];
        _backNoView.hidden = YES;
        _backNoView.backgroundColor = White_Color;
        [self.contentView addSubview:self.backNoView];
    }
    return _backNoView;
}
-(UIImageView *)addImage{
    if (!_addImage) {
        _addImage = [[UIImageView alloc]init];;
        _addImage.image = [UIImage imageNamed:@"tjdz"];
        [self.backNoView addSubview:self.addImage];
    }
    return _addImage;
}
-(UIImageView *)allowImageview{
    if (!_allowImageview) {
        _allowImageview = [[UIImageView alloc]init];;
        _allowImageview.image = [UIImage imageNamed:@"more_gray"];
        [self.backNoView addSubview:self.allowImageview];
    }
    return _allowImageview;
}
-(UIImageView *)allowview{
    if (!_allowview) {
        _allowview = [[UIImageView alloc]init];;
        _allowview.image = [UIImage imageNamed:@"more_gray"];
        [self.backView addSubview:self.allowview];
    }
    return _allowview;
}
-(UILabel *)addnameLabel1{
    if(!_addnameLabel1){
        _addnameLabel1 = [[UILabel alloc]init];
        _addnameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _addnameLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
        _addnameLabel1.textAlignment = NSTextAlignmentLeft;
        _addnameLabel1.userInteractionEnabled = YES;
        [self.backNoView addSubview:self.addnameLabel1];
        _addnameLabel1.text = @"添加收货地址";
    }
    return _addnameLabel1;
}

-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
  
        _backView.backgroundColor = White_Color;
        [self.contentView addSubview:self.backView];
    }
    return _backView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.contentMode = UIViewContentModeScaleAspectFill;
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;
        _showImage.layer.masksToBounds = YES;
        _showImage.layer.cornerRadius = CGFloatBasedI375(8);
        _showImage.image = [UIImage imageNamed:morenpic];
        [self.backView addSubview:self.showImage];
    }
    return _showImage;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.backView addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
    
    }
    return _nameLabel1;
}
-(UILabel *)phoneLabel{
    if(!_phoneLabel){
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _phoneLabel.textColor =[UIColor colorWithHexString:@"#443415"];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.userInteractionEnabled = YES;
        [self.backView addSubview:self.phoneLabel];
        _phoneLabel.text = @"185****6666";
    
    }
    return _phoneLabel;
}
-(UILabel *)deLabel{
    if(!_deLabel){
        _deLabel = [[UILabel alloc]init];
        _deLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _deLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        _deLabel.textAlignment = NSTextAlignmentLeft;
        _deLabel.userInteractionEnabled = YES;
        _deLabel.numberOfLines = 2;
        [self.backView addSubview:self.deLabel];
        _deLabel.text = @"广东省广州市天河区林和西路中泰北塔159号1501室";
    
    }
    return _deLabel;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.textColor = Main_Color;
        _detailsLabel.layer.masksToBounds = YES;
        _detailsLabel.layer.cornerRadius = CGFloatBasedI375(2.5);
        _detailsLabel.layer.borderColor =[Main_Color CGColor];
        _detailsLabel.layer.borderWidth = .5f;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:self.detailsLabel];
        _detailsLabel.text = @"默认";

    }
    return _detailsLabel;
}

-(UIView *)lineview
{
    if (_lineview == nil) {
        _lineview = [[UIView alloc]init];
        [_lineview setBackgroundColor:lightGrayF5F5_Color];
         [self.backView addSubview: self.lineview];
    }
    return _lineview;
}


@end
@interface LLStoreSureOrderViewCommonCell ()


@end
@implementation LLStoreSureOrderViewCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.titlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.addnameLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(10));
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.conTX mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.top.bottom.offset(CGFloatBasedI375(0));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    
}
-(void)setTagindex:(NSInteger)tagindex{
    _tagindex = tagindex;
}
-(void)setStatus:(RoleStatus)status{
    _status = status;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
}
-(void)setCounts:(NSInteger)counts{
    _counts = counts;
}
-(void)setIndexs:(NSInteger)indexs{
    _indexs = indexs;
    self.detailsLabel.hidden  = YES;
    self.conTX.hidden  = YES;
    self.addnameLabel1.hidden = YES;
    if(_status == RoleStatusRedBag){
        if(_indexs == 0){
            self.titlelable.text = @"购买数量";
            self.detailsLabel.text = @"0";
            self.detailsLabel.hidden  = NO;
            self.detailsLabel.text = _model.goodsNum;
        }else if(_indexs == 1){
            self.titlelable.text = @"商品总价";
            self.detailsLabel.text = @"¥ 0.00";
            self.detailsLabel.hidden  = NO;
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"",FORMAT(@"%.2f",_model.totalPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];

        }
    }else if(_status == RoleStatusPingjian){
        if(_indexs == 0){
            self.titlelable.text = @"商品总价";
            self.detailsLabel.hidden  = NO;
            if(_model.goodsPrice.length > 0){
                self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.goodsPrice.floatValue*_counts)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
            }

        }else if(_indexs == 1){
            
            self.titlelable.text = FORMAT(@"我的库存(剩余库存: %@)",_model.stock);
            self.detailsLabel.hidden  = NO;
            if(_model.stock.length > 0){
                CGFloat stocks = _model.stock.integerValue*_model.totalPrice.floatValue;
                NSString *notics = @"";
                if(_model.stockPrice.floatValue > 0){
                    notics = @"-￥";
                }
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[notics,FORMAT(@"%.2f",_model.stockPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
            }

        }else if(_indexs == 2){
            self.titlelable.text = @"配送费";
            self.detailsLabel.hidden  = NO;
            if(_model.freight.length > 0){
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.freight.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
            }
        }else if(_indexs == 3){
            self.titlelable.text = @"备注";
            self.conTX.hidden  = NO;
        }
    }else if(_status == RoleStatusStockPeisong){
        if(_indexs == 0){
            self.titlelable.text = @"商品总价";
            self.detailsLabel.hidden  = NO;
            if(_model.goodsPrice.length > 0){

            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.goodsPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
            }

        }else if(_indexs == 2){
            self.titlelable.text = @"配送库存";
            self.detailsLabel.hidden  = NO;
            if(_model.stock.length > 0){
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"",FORMAT(@"%@",_model.stock)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
            }

        }else if(_indexs == 1){
           
            self.titlelable.text = @"配送费";
            self.detailsLabel.hidden  = NO;
            if(_model.freight.length > 0){
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.freight.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
            }
        }else if(_indexs == 3){
            self.titlelable.text = @"备注";
            self.conTX.hidden  = NO;
        }
    }else if(_status == RoleStatusStore){//零售区
        self.titlelable.hidden  = NO;
        if(_indexs == 0){
            self.titlelable.text = @"商品总价";
            self.detailsLabel.hidden  = NO;
 
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.totalPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
        }else if(_indexs == 1){
            self.titlelable.text = @"消费红包";
            self.detailsLabel.hidden  = NO;
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"-￥",FORMAT(@"%.2f",_model.redPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
        }else if(_indexs == 2){
            self.titlelable.text = @"配送费";
            self.detailsLabel.text = @"¥ 10.00";
            self.detailsLabel.hidden  = NO;
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.freight.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];

        }else if(_indexs == 3){
            if(_tagindex == 1){//配送
                self.titlelable.text = @"备注";
                self.conTX.hidden  = NO;
            }else{//同城
                self.titlelable.hidden = YES;
                self.conTX.hidden  = YES;
                self.detailsLabel.hidden  = YES;
                self.addnameLabel1.hidden  = NO;
                if(_model){
                    if(!self.model.shopInfoVo){
                        self.addnameLabel1.text = @"同城20KM内无推广点不可下单";
                        self.addnameLabel1.textColor = [UIColor colorWithHexString:@"#999999"];
                    }else{
                        NSString *notice = @"满1000";
                        if(_model.totalPrice.floatValue < 1000){
                            notice = @"不满1000";
                            
                        }
                        self.addnameLabel1.attributedText = [self getAttribuStrWithStrings:@[@"当前订单",FORMAT(@"%@",notice),@"，满足",FORMAT(@"%@",@"同城20KM"),@"内，支付",FORMAT(@"%.2f",_model.freight.floatValue),@"配送费配送"]  colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color]];
                    }
                }
            }
        }else if(_indexs == 4){
            self.titlelable.text = @"备注";
            self.conTX.hidden  = NO;
        }
    }else{
        self.titlelable.hidden  = NO;
        if(_indexs == 0){
            self.titlelable.text = @"商品总价";
            self.detailsLabel.hidden  = NO;
 
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.totalPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
        }else if(_indexs == 1){
            self.titlelable.text = @"消费红包";
            self.detailsLabel.hidden  = NO;
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"-￥",FORMAT(@"%.2f",_model.redPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];
        }else if(_indexs == 2){
            self.titlelable.text = @"配送费";
            self.detailsLabel.text = @"¥ 10.00";
            self.detailsLabel.hidden  = NO;
            self.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.freight.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#443415"], [UIColor colorWithHexString:@"#443415"]]];

        }else if(_indexs == 3){
            self.titlelable.text = @"备注";
            self.conTX.hidden  = NO;
        }
    }
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
    }
    return _titlelable;
}
-(UILabel *)addnameLabel1{
    if(!_addnameLabel1){
        _addnameLabel1 = [[UILabel alloc]init];
        _addnameLabel1.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _addnameLabel1.textAlignment = NSTextAlignmentLeft;
        _addnameLabel1.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.addnameLabel1];
        _addnameLabel1.numberOfLines  = 0;
        _addnameLabel1.hidden = YES;
    }
    return _addnameLabel1;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#443415"];
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.detailsLabel];

    }
    return _detailsLabel;
}
-(UITextField *)conTX{
    if(!_conTX){
        _conTX = [[UITextField alloc]init];
        _conTX.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _conTX.textAlignment = NSTextAlignmentRight;
        _conTX.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.conTX];
        _conTX.placeholder = @"输入备注信息";
        [_conTX addTarget:self action:@selector(textfiledChange) forControlEvents:UIControlEventEditingChanged];

    }
    return _conTX;
}

- (void)textfiledChange {
    if ([self.delegate respondsToSelector:@selector(getData:indexs:)]) {
        [self.delegate getData:self.conTX.text indexs:0];
    }

}
@end
@interface LLStoreSureOrderViewDeliverCell ()
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UIImageView *numsImageview;
@property (nonatomic,strong) UILabel *priceLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIButton *selectButton;/** <#class#> **/
@property(nonatomic,strong)UILabel *countlabel;

@property (nonatomic,strong) UIView *backNoView;
@property (nonatomic,strong) UILabel *addrightLabel1;
@property (nonatomic,strong) UILabel *addnameLabel1;

@end
@implementation LLStoreSureOrderViewDeliverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.backNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(CGFloatBasedI375(0));
    }];
 
    [self.addnameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.backNoView.mas_centerY);
        make.left.offset(CGFloatBasedI375(15));
    }];
    
       [self.addrightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.offset(-CGFloatBasedI375(10));
           make.centerY.equalTo(weakself.backNoView.mas_centerY);
       }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(CGFloatBasedI375(0));

    }];
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.backView.mas_centerY);
        make.right.offset(CGFloatBasedI375(-10));
    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.addrightLabel1.mas_left).offset(-CGFloatBasedI375(5));
        make.height.width.offset(CGFloatBasedI375(24));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(1));
    }];

}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
 
}
-(void)setStatus:(RoleStatus)status{
    _status = status;
    if(_status == RoleStatusRedBag){
        self.backNoView.hidden = NO;
        self.backView.hidden = YES;
        self.addnameLabel1.text = @"所属地区";
//        self.addrightLabel1.text = @"您所在定位深圳地区暂未开放";
        if(_model){
            self.addrightLabel1.text = FORMAT(@"%@",_model.city);
            self.addrightLabel1.textColor =BlackTitleFont443415;
        }else{
            self.addrightLabel1.text = @"您所在定位地区暂未开放";
            self.addrightLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
        }
    }else{
        self.backNoView.hidden = NO;
        self.backView.hidden = YES;
        self.addnameLabel1.text = @"配送门店";
        if(_model){
            self.showImage.hidden = NO;
            self.addrightLabel1.hidden = NO;
            self.addrightLabel1.text = FORMAT(@"%@",_model.name);
            self.addrightLabel1.textColor =BlackTitleFont443415;
            [self.showImage sd_setImageWithUrlString:_model.shopPhoto];
        }else{
            self.addrightLabel1.text = @"添加收货地址后进行分配";
            self.addrightLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
        }
    }
}
#pragma mark ============= 懒加载 =============
-(UIView *)backNoView{
    if(!_backNoView){
        _backNoView = [[UIView alloc]init];
        _backNoView.backgroundColor = White_Color;
        [self.contentView addSubview:self.backNoView];
        _backNoView.hidden = YES;
    }
    return _backNoView;
}
-(UILabel *)addrightLabel1{
    if(!_addrightLabel1){
        _addrightLabel1 = [[UILabel alloc]init];
        _addrightLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _addrightLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
        _addrightLabel1.textAlignment = NSTextAlignmentLeft;
        _addrightLabel1.userInteractionEnabled = YES;
        [self.backNoView addSubview:self.addrightLabel1];
//        _addrightLabel1.text = @"添加收货地址后进行分配";
    }
    return _addrightLabel1;
}
-(UILabel *)addnameLabel1{
    if(!_addnameLabel1){
        _addnameLabel1 = [[UILabel alloc]init];
        _addnameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _addnameLabel1.textColor = BlackTitleFont443415;
        _addnameLabel1.textAlignment = NSTextAlignmentLeft;
        _addnameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.addnameLabel1];
        _addnameLabel1.text = @"配送门店";
    }
    return _addnameLabel1;
}

-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        
        _backView.backgroundColor = White_Color;
        [self.contentView addSubview:self.backView];
    }
    return _backView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.userInteractionEnabled = YES;
        _showImage.hidden = YES;
        _showImage.layer.masksToBounds = YES;
        _showImage.layer.cornerRadius = CGFloatBasedI375(12);
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.backView addSubview:self.nameLabel1];
//        _nameLabel1.hidden = YES;
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"广州烟酒行";
    }
    return _nameLabel1;
}

-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(12)];
        _priceLabel.textColor =Main_Color;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.userInteractionEnabled = YES;
        [self.backView addSubview:self.priceLabel];
        _priceLabel.text = @"¥ 169.00";
    }
    return _priceLabel;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview:self.detailsLabel];
        _detailsLabel.text = @"1支装(500ML)";

    }
    return _detailsLabel;
}

-(UIView *)lineview
{
    if (_lineview == nil) {
        _lineview = [[UIView alloc]init];
        [_lineview setBackgroundColor:BG_Color];
         [self.backView addSubview: self.lineview];
    }
    return _lineview;
}

-(UILabel *)countlabel{
    if(!_countlabel){
        _countlabel = [[UILabel alloc]init];
        _countlabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        _countlabel.textAlignment = NSTextAlignmentRight;
        _countlabel.text = @"x1";
        _countlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.backView addSubview:self.countlabel];
//        _countlabel.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _countlabel;
}

@end
