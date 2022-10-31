//
//  LLMainPeisongCell.m
//  Winner
//
//  Created by 廖利君 on 2022/3/4.
//

#import "LLMainPeisongCell.h"
@interface LLMainPeisongCell ()
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UIImageView *addImage;
@property(nonatomic,strong)UILabel *addlable;
@property(nonatomic,strong)UILabel *attrlable;
@property(nonatomic,strong)UILabel *pricelable;

@property(nonatomic,strong)UIImageView *priceImage;
@property(nonatomic,strong)UILabel *prilable;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *backMidView ;/** <#class#> **/
@property(nonatomic,strong)UILabel *addresslable;
@property(nonatomic,strong)UILabel *phonelable;
@property(nonatomic,strong)UILabel *namelable;
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property(nonatomic,strong)UILabel *stocklable;
@property(nonatomic,strong)UILabel *countlable;
@property (nonatomic,strong) UIButton *sureButton1;/** <#class#> **/
@property (nonatomic,strong) UILabel *typeLabel;/** <#class#> **/

@end
@implementation LLMainPeisongCell

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
        make.top.offset(CGFloatBasedI375(0));
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(-CGFloatBasedI375(10));
        make.bottom.mas_equalTo(-CGFloatBasedI375(0));
    }];
    [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(14));
        make.width.mas_equalTo(CGFloatBasedI375(13));
    }];
    [self.addlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.addImage.mas_right).offset(CGFloatBasedI375(5));
        make.centerY.equalTo(weakself.addImage.mas_centerY);
        make.right.equalTo(weakself.priceImage.mas_left).offset(-CGFloatBasedI375(5));

    }];
    [self.prilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.addImage.mas_centerY);
        make.width.mas_equalTo(CGFloatBasedI375(60));

    }];
    [self.priceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.prilable.mas_left).offset(-CGFloatBasedI375(0));
        make.centerY.equalTo(weakself.addImage.mas_centerY);
        make.height.mas_equalTo(CGFloatBasedI375(14));
        make.width.mas_equalTo(CGFloatBasedI375(13));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(.5));
        make.top.offset(CGFloatBasedI375(44));

    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.equalTo(weakself.lineView.mas_bottom).offset(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(80));
        make.width.mas_equalTo(CGFloatBasedI375(80));
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.showImage.mas_top).offset(CGFloatBasedI375(3));
        make.right.offset(-CGFloatBasedI375(15));

    }];
    [self.attrlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(15));

    }];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.attrlable.mas_bottom).offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(15));

    }];
    [self.countlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.pricelable.mas_centerY);
    }];
    [self.backMidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.showImage.mas_bottom).offset(CGFloatBasedI375(15));
        make.right.left.offset(-CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(66));

    }];
    [self.namelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(15));
    }];
    [self.phonelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.namelable.mas_right).offset(CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.namelable.mas_centerY);
    }];
    [self.addresslable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.equalTo(weakself.namelable.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(-CGFloatBasedI375(15));
        make.right.equalTo(weakself.sureButton2.mas_left).offset(-CGFloatBasedI375(2));

    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(60));
    }];
    [self.sureButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.sureButton.mas_left).offset(-CGFloatBasedI375(8));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(60));
    }];
    [self.sureButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.sureButton1.mas_left).offset(-CGFloatBasedI375(8));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(50));
    }];
    [self.stocklable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.sureButton.mas_left).offset(-CGFloatBasedI375(6));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
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
-(void)setIsOver:(BOOL)isOver{
    _isOver = isOver;
    WS(weakself);
//    if(_isOver){
//        NSLog(@"哈哈 超时了");
//        [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(weakself.sureButton1.mas_left).offset(-CGFloatBasedI375(2));
//        }];
//    }else{
//        NSLog(@"不不");
//        [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(weakself.sureButton2.mas_left).offset(-CGFloatBasedI375(2));
//        }];
//    }
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self layoutIfNeeded];
    LLGoodModel *listmodel = [_model.appOrderListGoodsVos firstObject];
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",listmodel.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.attrlable.text = FORMAT(@"%@",listmodel.specsValName);
    self.countlable.text = FORMAT(@"x%@",listmodel.goodsNum);
    _titlelable.text = listmodel.name;
    _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",listmodel.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    self.namelable.text = FORMAT(@"%@",_model.appAddressInfoVo.receiveName);
    self.phonelable.text =[NSString setPhoneMidHid:_model.appAddressInfoVo.receivePhone];
    self.addresslable.text = FORMAT(@"%@%@%@%@",_model.appAddressInfoVo.province,_model.appAddressInfoVo.city,_model.appAddressInfoVo.area,_model.appAddressInfoVo.address);
    self.timelable.text = FORMAT(@"配送时间%@分钟",_model.expressTime);
    self.stocklable.text = FORMAT(@"库存:%@",_model.stock);
    self.prilable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.judgeTaskPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    _addlable.attributedText = [[NSAttributedString alloc] initWithString:FORMAT(@"%@%.2fkm",_model.appAddressInfoVo.locations,_model.appAddressInfoVo.distanceSphere.floatValue/1000) attributes:attributes];
    NSLog(@"distanceSpher == %@   ==%.2f",_model.appAddressInfoVo.distanceSphere,_model.appAddressInfoVo.distanceSphere.floatValue/1000);
//    _addlable.text =FORMAT(@"%@%@km",_model.appAddressInfoVo.locations,_model.appAddressInfoVo.distanceSphere);
    self.sureButton1.hidden = YES;
    self.sureButton2.hidden = YES;
    self.sureButton.userInteractionEnabled = YES;
    //判断
    self.typeLabel.hidden = YES;
    WS(weakself);
    if(_model.taskStatus == 2 || _model.taskStatus == 5){//抢单
        self.stocklable.hidden = NO;
        self.sureButton.backgroundColor = Main_Color;
        self.sureButton.layer.borderColor = [Main_Color CGColor];
        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
        if(_model.stock.integerValue == 0 || _model.stock.integerValue < listmodel.goodsNum.integerValue){
            self.sureButton.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
            self.sureButton.userInteractionEnabled = NO;
            self.sureButton.layer.borderColor = [[UIColor clearColor] CGColor];
            self.sureButton.layer.borderWidth = CGFloatBasedI375(0);
        }
        [self.sureButton setTitle:@"抢单" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];

    }else if(_model.taskStatus == 3){
        self.stocklable.hidden = YES;
        self.sureButton1.hidden = NO;
        self.sureButton.backgroundColor = [UIColor clearColor];
        self.sureButton.userInteractionEnabled = YES;
        self.sureButton.layer.borderColor = [Main_Color CGColor];
        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
        [self.sureButton setTitleColor:Main_Color forState:UIControlStateNormal];
        [self.sureButton setTitle:@"提货核销" forState:UIControlStateNormal];
        
        self.sureButton2.backgroundColor = [UIColor clearColor];
        self.sureButton2.userInteractionEnabled = YES;
        [self.sureButton2 setTitleColor:BlackTitleFont443415 forState:UIControlStateNormal];
        self.sureButton2.layer.borderColor = [lightGray9999_Color CGColor];
        self.sureButton2.layer.borderWidth = CGFloatBasedI375(.5f);
        if(_model.taskStatus == 5){//已转单
            self.sureButton2.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
            self.sureButton2.userInteractionEnabled = NO;
            self.sureButton2.layer.borderColor = [[UIColor clearColor] CGColor];
            self.sureButton2.layer.borderWidth = CGFloatBasedI375(0);
    
        }
     
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSInteger strend = [NSString timeSwitchTimestamp:_model.taskTime]+300;
        NSString *newdata = [NSString getCurrentTimes];
        NSInteger startLongLong = [newdata integerValue];
        BOOL isShow = NO;
        if(strend- startLongLong <= 0){
            self.sureButton2.hidden = YES;
            [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakself.sureButton1.mas_left).offset(-CGFloatBasedI375(2));
            }];
        }else{
            [self.timelable mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(CGFloatBasedI375(15));
                make.bottom.mas_equalTo(-CGFloatBasedI375(15));
                make.right.equalTo(weakself.sureButton2.mas_left).offset(-CGFloatBasedI375(2));

            }];
//            [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(weakself.sureButton2.mas_left).offset(-CGFloatBasedI375(2));
//            }];
        }
        
        
//        if(_model.judgeTaskPrice.length <= 0){
//            [JXUIKit showErrorWithStatus:FORMAT(@"佣金是 == %@",_model.judgeTaskPrice)];
//        }
        if(_model.isTimeout){
            self.timelable.text = @"当前订单已超时";
        }
    }
//    else if(_model.taskStatus == 5){//已转单
//        self.stocklable.hidden = YES;
//        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
//        self.sureButton.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
//        self.sureButton.userInteractionEnabled = NO;
//        self.sureButton.layer.borderColor = [[UIColor clearColor] CGColor];
//        self.sureButton.layer.borderWidth = CGFloatBasedI375(0);
//        [self.sureButton setTitle:@"已转单" forState:UIControlStateNormal];
        
//    }
    else{
        self.stocklable.hidden = YES;
        self.sureButton.backgroundColor = [UIColor clearColor];
        [self.sureButton setTitle:@"查看佣金" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:BlackTitleFont443415 forState:UIControlStateNormal];
        self.sureButton.layer.borderColor = [lightGray9999_Color CGColor];
        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
        NSString *times =model.completeTime;
        if(times.length > 18){
            times =  [times substringWithRange:NSMakeRange(11, 5)];
        }
        if(_model.isTimeout){
            self.timelable.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"当日%@分送达,",times),FORMAT(@"超时%@分钟",_model.timeoutTime)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(14)], [UIFont systemFontOfSize:CGFloatBasedI375(14)]] colors:@[ UIColorFromRGB(0x443415), Main_Color]];
        }else{
            self.timelable.text = FORMAT(@"当日%@分送达，准时送达",times);
        }
        [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakself.sureButton.mas_left).offset(-CGFloatBasedI375(2));
        }];
    }

    if(_model.platform == 1){//商品来源（1品鉴商品，2同城配送）
        self.typeLabel.hidden = NO;
        self.typeLabel.text = @"品鉴";
        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(CGFloatBasedI375(40));
        }];
    }else if(_model.platform == 2){
        self.typeLabel.hidden = NO;
        self.typeLabel.text = @"同城配送";
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

-(void)setState:(NSInteger)state{
    _state = state;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatBasedI375(10);
        [self.contentView addSubview:_backView];
    }
    return _backView;;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;
        _showImage.image =[UIImage imageNamed:@"sp1"];
        _showImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.backView addSubview:self.showImage];
    }
    return _showImage;
}
-(UIImageView *)priceImage{
    if (!_priceImage) {
        _priceImage = [[UIImageView alloc]init];
        _priceImage.userInteractionEnabled = YES;
        _priceImage.clipsToBounds = YES;
        _priceImage.image =[UIImage imageNamed:@"yj"];
        _priceImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.backView addSubview:self.priceImage];
    }
    return _priceImage;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.backView addSubview:_lineView];
    }
    return _lineView;;
}
-(UIImageView *)addImage{
    if (!_addImage) {
        _addImage = [[UIImageView alloc]init];
        _addImage.userInteractionEnabled = YES;
        _addImage.clipsToBounds = YES;
        _addImage.image =[UIImage imageNamed:@"dz"];
        _addImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.backView addSubview:self.addImage];
    }
    return _addImage;
}
//-(UIImageView *)allowImage{
//    if (!_allowImage) {
//        _allowImage = [[UIImageView alloc]init];
//        _allowImage.userInteractionEnabled = YES;
//        _allowImage.image =[UIImage imageNamed:@"mainallow"];
//        [self.backView addSubview:self.allowImage];
//    }
//    return _allowImage;
//}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"银色星芒刺绣网纱底 裤红色棉麻…";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.backView addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}
-(UILabel *)addlable{
    if(!_addlable){
        _addlable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"中泰北塔-东北门 12KM"];
        [self.backView addSubview:self.addlable];
    }
    return _addlable;
}
- (UIView *)backMidView{
    if(!_backMidView){
        _backMidView = [[UIView alloc]init];
        _backMidView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        [self.backView addSubview:_backMidView];
    }
    return _backMidView;;
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
        [self.showImage addSubview:_typeLabel];
        self.typeLabel.backgroundColor = [[UIColor colorWithHexString:@"#443415"]colorWithAlphaComponent:0.8];
    }
    return _typeLabel;
}

-(UILabel *)prilable{
    if(!_prilable){
        _prilable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:Main_Color textAlignment:NSTextAlignmentRight numberOfLines:1 fontSize:CGFloatBasedI375(14) font:[UIFont boldFontWithFontSize:CGFloatBasedI375(14)] text:@"￥0.00"];
        [self.backView addSubview:self.prilable];
        _prilable.adjustsFontSizeToFitWidth = YES;
    }
    return _prilable;
}
-(UILabel *)attrlable{
    if(!_attrlable){
        _attrlable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#999999"] textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(12) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"1支装(500ML)"];
        [self.backView addSubview:self.attrlable];
    }
    return _attrlable;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(14) font:[UIFont boldFontWithFontSize:CGFloatBasedI375(14)] text:@"¥ 119.00"];
        [self.backView addSubview:self.pricelable];
    }
    return _pricelable;
}
-(UILabel *)countlable{
    if(!_countlable){
        _countlable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#666666"] textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"x1"];
        [self.backView addSubview:self.countlable];
    }
    return _countlable;
}
-(UILabel *)namelable{
    if(!_namelable){
        _namelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"大赢家 "];
        [self.backMidView addSubview:self.namelable];
    }
    return _namelable;
}
-(UILabel *)phonelable{
    if(!_phonelable){
        _phonelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@""];
        [self.backMidView addSubview:self.phonelable];
    }
    return _phonelable;
}
-(UILabel *)addresslable{
    if(!_addresslable){
        _addresslable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@""];
        [self.backMidView addSubview:self.addresslable];
    }
    return _addresslable;
}

-(UILabel *)timelable{
    if(!_timelable){
        _timelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(15) font:[UIFont boldFontWithFontSize:CGFloatBasedI375(16)] text:@""];
        [self.backView addSubview:self.timelable];
    }
    return _timelable;
}
-(UILabel *)stocklable{
    if(!_stocklable){
        _stocklable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentRight numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"库存:1"];
        [self.backView addSubview:self.stocklable];
    }
    return _stocklable;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton.layer.masksToBounds = YES;
        [_sureButton setTitle:@"抢单" forState:UIControlStateNormal];
        _sureButton.backgroundColor = Main_Color;
        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.sureButton];
    }
    return _sureButton;
}
-(UIButton *)sureButton1{
    if(!_sureButton1){
        _sureButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton1.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton1.layer.masksToBounds = YES;
        [_sureButton1 setTitle:@"联系客户" forState:UIControlStateNormal];
        _sureButton1.backgroundColor = [UIColor clearColor];
        _sureButton1.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [_sureButton1 addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.sureButton1];
        [self.sureButton1 setTitleColor:BlackTitleFont443415 forState:UIControlStateNormal];
        self.sureButton1.layer.borderColor = [lightGray9999_Color CGColor];
        self.sureButton1.layer.borderWidth = CGFloatBasedI375(.5f);
        _sureButton1.hidden = YES;
    }
    return _sureButton1;
}
-(UIButton *)sureButton2{
    if(!_sureButton2){
        _sureButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton2.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton2.layer.masksToBounds = YES;
        _sureButton2.hidden = YES;
        [_sureButton2 setTitle:@"转单" forState:UIControlStateNormal];
        _sureButton2.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [_sureButton2 addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.sureButton2 setTitleColor:BlackTitleFont443415 forState:UIControlStateNormal];
        self.sureButton2.layer.borderColor = [lightGray9999_Color CGColor];
        self.sureButton2.layer.borderWidth = CGFloatBasedI375(.5f);
        [self.backView addSubview:self.sureButton2];
    }
    return _sureButton2;
}
-(void)clickTap:(UIButton *)sender{
    if(self.tapAction){
        self.tapAction(_model, sender.titleLabel.text);
    }
}
@end
