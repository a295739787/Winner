//
//  LLStockOrderDetailTableCell.m
//  Winner
//
//  Created by YP on 2022/3/22.
//

#import "LLStockOrderDetailTableCell.h"

@interface LLStockOrderDetailTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *adressImgView;
@property (nonatomic,strong)UILabel *adressLabel;
@property (nonatomic,strong)UILabel *moneylabel;
@property (nonatomic,strong)UIImageView *rightImgView;

@end

@implementation LLStockOrderDetailTableCell

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
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.bottom.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.adressImgView];
    [self.bottomView addSubview:self.adressLabel];
    [self.bottomView addSubview:self.moneylabel];
    [self.bottomView addSubview:self.rightImgView];
    
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(34));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(95));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.adressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.adressLabel);
        make.height.width.mas_equalTo(CGFloatBasedI375(15));
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.adressLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moneylabel);
        make.height.mas_equalTo(CGFloatBasedI375(14));
        make.width.mas_equalTo(CGFloatBasedI375(13));
        make.right.mas_equalTo(self.moneylabel.mas_left).offset(-5);
    }];
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    _adressLabel.text = _model.appAddressInfoVo.locations;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    _adressLabel.attributedText = [[NSAttributedString alloc] initWithString:FORMAT(@"%@%.2fkm",_model.appAddressInfoVo.locations,_model.appAddressInfoVo.distanceSphere.floatValue/1000) attributes:attributes];

    self.moneylabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.judgeTaskPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];

}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}

-(UIImageView *)adressImgView{
    if (!_adressImgView) {
        _adressImgView = [[UIImageView alloc]init];
        _adressImgView.image =[UIImage imageNamed:@"dz"];
    }
    return _adressImgView;
}
-(UILabel *)adressLabel{
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc]init];
        _adressLabel.textColor = UIColorFromRGB(0x443415);
        _adressLabel.textAlignment = NSTextAlignmentLeft;
        _adressLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _adressLabel.numberOfLines = 2;
    }
    return _adressLabel;
}
-(UIImageView *)rightImgView{
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc]init];
        _rightImgView.image =[UIImage imageNamed:@"yj"];
    }
    return _rightImgView;
}
-(UILabel *)moneylabel{
    if (!_moneylabel) {
        _moneylabel = [[UILabel alloc]init];
        _moneylabel.textColor = UIColorFromRGB(0xD40006);
        _moneylabel.textAlignment = NSTextAlignmentRight;
        _moneylabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _moneylabel.text = @"￥21.90";
    }
    return _moneylabel;
}

@end




@interface LlStockReceiveAdresstablecell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *adresslabel;

@end

@implementation LlStockReceiveAdresstablecell

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
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    self.nameLabel.text = FORMAT(@"%@",_model.appAddressInfoVo.receiveName);
    self.phoneLabel.text = FORMAT(@"%@",[NSString setPhoneMidHid:_model.appAddressInfoVo.receivePhone]);
    self.adresslabel.text = FORMAT(@"%@%@%@%@",_model.appAddressInfoVo.province,_model.appAddressInfoVo.city,_model.appAddressInfoVo.area,_model.appAddressInfoVo.address);

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




@interface LLStockGoodsListTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *goodsSpecLabel;
@property (nonatomic,strong)UILabel *goodsCountLabel;
@property (nonatomic,strong)UILabel *goodsPriceLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong) UILabel *typeLabel;/** <#class#> **/

@end

@implementation LLStockGoodsListTableCell

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
        make.bottom.top.mas_equalTo(0);
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(CGFloatBasedI375(-10));
    }];
    
    [self.bottomView addSubview:self.goodsImgView];
    [self.bottomView addSubview:self.goodsNameLabel];
    [self.bottomView addSubview:self.goodsSpecLabel];
    [self.bottomView addSubview:self.goodsCountLabel];
    [self.bottomView addSubview:self.goodsPriceLabel];
    [self.bottomView addSubview:self.line];
    [self.goodsImgView addSubview:self.typeLabel];
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(80));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
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
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    LLGoodModel *listmodel = [_model.appOrderListGoodsVos firstObject];
    [self.goodsImgView  sd_setImageWithUrlString:FORMAT(@"%@",listmodel.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.goodsSpecLabel.text = FORMAT(@"%@",listmodel.specsValName);
    self.goodsNameLabel.text = listmodel.name;
    self.goodsCountLabel.text = FORMAT(@"x%@",listmodel.goodsNum);
    
    self.goodsPriceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",listmodel.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    
    self.typeLabel.hidden = YES;
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
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}


@end



@interface LLStockoOrderTimeTableCell ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *timeImgView;
@property (nonatomic,strong)UILabel *arriveLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)CountDown* countDownForBtn;/** <#class#> **/

@end

@implementation LLStockoOrderTimeTableCell

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
        make.right.mas_equalTo(CGFloatBasedI375(-10));
        make.bottom.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.timeImgView];
    [self.bottomView addSubview:self.arriveLabel];
    [self.bottomView addSubview:self.timeLabel];
    
   
    [self.arriveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.bottom.mas_equalTo(CGFloatBasedI375(-15));
        make.left.mas_equalTo(CGFloatBasedI375(33));
    }];
    
    [self.timeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    
    _countDownForBtn = [[CountDown alloc] init];
    NSString *newdata = [NSString getCurrentTimes];
    long long startLongLong = [newdata longLongValue];
    NSInteger str = [NSString timeSwitchTimestamp:_model.taskPlanTime];
    NSLog(@"newdata == %@",newdata);
    NSLog(@"_model.next_time == %ld",str);

     [self startLongLongStartStamp:startLongLong longlongFinishStamp:[_model.taskPlanTimestamp longLongValue]];
    NSString *times =_model.taskPlanTime;
    if(times.length > 18){
        times =  [times substringWithRange:NSMakeRange(11, 5)];
    }
    self.arriveLabel.text = FORMAT(@"请在当日%@分前送达",times);
    
    if(_model.isTimeout){
        self.arriveLabel.text = @"当前订单已超时";
    }
}


///此方法用两个时间戳做参数进行倒计时
-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
__weak __typeof(self) weakSelf= self;
[self.countDownForBtn countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
[weakSelf refreshUIDay:day hour:hour minute:minute second:second];
}];
}
-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
NSString *dayStr;
NSString *hourStr;
NSString *minuteStr;
NSString *secondStr;

if (day==0) {
dayStr = @"0";
}else{
dayStr = [NSString stringWithFormat:@"%ld",(long)day];
}
if (hour<10&&hour) {
hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
}else{
hourStr= [NSString stringWithFormat:@"%ld",(long)hour];
}
if (minute<10) {
minuteStr= [NSString stringWithFormat:@"0%ld",(long)minute];
}else{
minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
}
if (second<10) {
secondStr= [NSString stringWithFormat:@"0%ld",(long)second];
}else{
secondStr = [NSString stringWithFormat:@"%ld",(long)second];
}

self.timeLabel.text = FORMAT(@"还剩%@:%@",minuteStr,secondStr);
    if(minute <=0 &&  second <= 0 && hour <=0){
        self.timeLabel.text = @"订单已超时";
        self.timeLabel.textColor = Main_Color;
    }
//    self.titlelable.text =FORMAT(@"请在%@%@%@%@内完成付款",dayStr, hourStr,minuteStr,secondStr);

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

-(UIImageView *)timeImgView{
    if (!_timeImgView) {
        _timeImgView = [[UIImageView alloc]init];
        _timeImgView.image = [UIImage imageNamed:@"time"];
    }
    return _timeImgView;
}
-(UILabel *)arriveLabel{
    if (!_arriveLabel) {
        _arriveLabel = [[UILabel alloc]init];
        _arriveLabel.textColor = UIColorFromRGB(0x443415);
        _arriveLabel.textAlignment = NSTextAlignmentLeft;
        _arriveLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
    }
    return _arriveLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = UIColorFromRGB(0x443415);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _timeLabel.text = @"还剩10小时05分钟";
    }
    return _timeLabel;
}


@end
@interface LLStockoOrderMapTableCell ()<MAMapViewDelegate,AMapSearchDelegate>
// 地图
@property (nonatomic, strong) MAMapView            *mapView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong) UIImageView *mainImage;/** <#class#> **/
// 自定义大头针
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
// 防止重复点击
@property (nonatomic, assign) BOOL                  isMapViewRegionChangedFromTableView;
// 是否正在定位
@property (nonatomic, assign) BOOL                  isLocated;

// 定位
@property (nonatomic, strong) UIButton             *locationBtn;

// 用户自定义大头针
@property (nonatomic, strong) UIImage              *imageLocated;
@property (nonatomic, strong) UIImage              *imageNotLocate;

@end

@implementation LLStockoOrderMapTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)setModel:(LLMeOrderDetailModel *)model{
    _model = model;
//    long lon =[_model.appAddressInfoVo.longitude longLongValue];;
//    long lat =[_model.appAddressInfoVo.latitude longLongValue];;
//    NSLog(@"%@  lat == %ld",_model.appAddressInfoVo.longitude,lat);
    self.isLocated = YES;
    
    if(_model.shopDistanceVo){
        CGFloat las =_model.shopDistanceVo.latitude.floatValue;
        NSString *lastr = FORMAT(@"%.5f",las);
        
        CGFloat lon =_model.shopDistanceVo.longitude.floatValue;
        NSString *lontr = FORMAT(@"%.5f",lon);
        long lat =[_model.shopDistanceVo.latitude longLongValue];;
        NSLog(@"%@  lat == %ld",_model.shopDistanceVo.longitude,lat);
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(lastr.floatValue, lontr.floatValue)];
        CurrentLocationAnnotation *annotion = [[CurrentLocationAnnotation alloc]init];
        annotion.coordinate = CLLocationCoordinate2DMake(lastr.floatValue, lontr.floatValue);
        [self.mapView addAnnotation:annotion];
    }else if(_model.appDeliveryClerkDistanceVo){
        CGFloat las =_model.appDeliveryClerkDistanceVo.latitude.floatValue;
        NSString *lastr = FORMAT(@"%.5f",las);
        
        CGFloat lon =_model.appDeliveryClerkDistanceVo.longitude.floatValue;
        NSString *lontr = FORMAT(@"%.5f",lon);
        long lat =[_model.appDeliveryClerkDistanceVo.latitude longLongValue];;
        NSLog(@"%@  lat == %ld",_model.appDeliveryClerkDistanceVo.longitude,lat);
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(lastr.floatValue, lontr.floatValue)];
        CurrentLocationAnnotation *annotion = [[CurrentLocationAnnotation alloc]init];
        annotion.coordinate = CLLocationCoordinate2DMake(lastr.floatValue, lontr.floatValue);
        [self.mapView addAnnotation:annotion];
    }

    
    
    
}
-(void)setPerimodel:(LLGoodModel *)perimodel{
    _perimodel = perimodel;
    
    CGFloat las =_perimodel.appAddressInfoVo.latitude.floatValue;
    NSString *lastr = FORMAT(@"%.5f",las);
    
    CGFloat lon =_perimodel.appAddressInfoVo.longitude.floatValue;
    NSString *lontr = FORMAT(@"%.5f",lon);
    long lat =[_perimodel.appAddressInfoVo.latitude longLongValue];;
    NSLog(@"%@  lat == %ld",_perimodel.appAddressInfoVo.longitude,lat);
    self.isLocated = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(lastr.floatValue, lontr.floatValue)];
    CurrentLocationAnnotation *annotion = [[CurrentLocationAnnotation alloc]init];
    annotion.coordinate = CLLocationCoordinate2DMake(lastr.floatValue, lontr.floatValue);
    [self.mapView addAnnotation:annotion];
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.height.mas_equalTo(CGFloatBasedI375(130));
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
    }];
    [self initMapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.offset(-CGFloatBasedI375(0));
        make.top.mas_equalTo(CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(130));
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
    }];

}
/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    // 自定义坐标
    if ([annotation isKindOfClass:[CurrentLocationAnnotation class]])
    {
        static NSString *reuseIndetifier = @"CustomAnnotationView";
        CustomMapAnnotationViews *annotationView = (CustomMapAnnotationViews *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomMapAnnotationViews alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        NSString *img =@"";
        if(_perimodel){
            img = _perimodel.appAddressInfoVo.headIcon;
            if(![_perimodel.appAddressInfoVo.headIcon containsString:@"http"]){
                img = FORMAT(@"%@%@",API_IMAGEHOST,_perimodel.appAddressInfoVo.headIcon);
            }
            UIImage *images = [self base64Toimage:img];
            if(images == nil){
                images = [UIImage imageNamed:@"headimages"];
            }
            annotationView.imageView.frame = CGRectMake(0, 0, CGFloatBasedI375(40), CGFloatBasedI375(40));
            annotationView.imageView.image = images;
//            [annotationView.imageView sd_setImageWithUrlString:img];
            annotationView.imageView.backgroundColor = Red_Color;
            annotationView.imageView.layer.masksToBounds = YES;
            annotationView.imageView.layer.cornerRadius = CGFloatBasedI375(40/2);
        }else if(_model.shopDistanceVo){
            if(![_model.shopDistanceVo.shopPhoto containsString:@"http"]){
                img = FORMAT(@"%@%@",API_IMAGEHOST,_model.shopDistanceVo.shopPhoto);
            }
      
            UIImage *images = [self base64Toimage:img];
            if(images == nil){
                images = [UIImage imageNamed:@"headimages"];
            }
            annotationView.imageView.frame = CGRectMake(0, 0, CGFloatBasedI375(40), CGFloatBasedI375(40));
            annotationView.imageView.image = images;
            annotationView.imageView.layer.masksToBounds = YES;
            annotationView.imageView.layer.cornerRadius = CGFloatBasedI375(40/2);
            NSLog(@" annotationView.imageView == %@", annotationView.imageView);
            
        }else if(_model.appDeliveryClerkDistanceVo){
            if(![_model.appDeliveryClerkDistanceVo.photo containsString:@"http"]){
                img = FORMAT(@"%@%@",API_IMAGEHOST,_model.appDeliveryClerkDistanceVo.photo);
            }
            
            UIImage *images = [self base64Toimage:img];
            if(images == nil){
                images = [UIImage imageNamed:@"headimages"];
            }
            annotationView.imageView.frame = CGRectMake(0, 0, CGFloatBasedI375(40), CGFloatBasedI375(40));
            annotationView.imageView.image = images;
            annotationView.imageView.layer.masksToBounds = YES;
            annotationView.imageView.layer.cornerRadius = CGFloatBasedI375(40/2);
        }
         
         
        
        NSLog(@"img == %@   12 == %@",img,[self base64Toimage:img]);

        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
        
    }
    return nil;
}
//首页面的订单
-(UIImage *)base64Toimage:(NSString * )strImage{
    
    NSURL *url = [NSURL URLWithString: strImage];

    NSData *data = [NSData dataWithContentsOfURL: url];

    UIImage *image = [UIImage imageWithData: data];

    return image;
//    NSString *strImgDataNew = strImage;
//    //进行首尾空字符串的处理
//    strImgDataNew = [strImgDataNew stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
//    strImgDataNew = [strImgDataNew stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSArray *components = [strImgDataNew componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
//    //去掉头部的前缀//data:image/jpeg;base64, （可根据实际数据情况而定，如果数据有固定的前缀，就执行下面的方法，如果没有就注销掉或删除掉）
//    // str = [str substringFromIndex:23];   //23 是根据前缀的具体字符长度而定的。
//    strImgDataNew = [components componentsJoinedByString:@" "];//按单空格分割
//    NSString*encodedImageStr = strImgDataNew;
//
//    //进行字符串转data数据 -------NSDataBase64DecodingIgnoreUnknownCharacters
//    NSURL *url = [NSURL URLWithString: encodedImageStr];
//    NSData *data = [NSData dataWithContentsOfURL: url];
////    NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    UIImage*decodedImage = [UIImage imageWithData:data];
//
//    return decodedImage;
}

#pragma mark - Initialization
// 主视图
- (void)initMapView
{
//    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-CGFloatBasedI375(20), CGFloatBasedI375(120))];
    self.mapView = [[MAMapView alloc] init];
    self.mapView.delegate = self;
    [self.bottomView addSubview:self.mapView];
    
    self.isLocated = NO;
    
    
    // 自己的坐标
//    self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hb"]];
//    self.centerAnnotationView.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.centerAnnotationView.bounds) / 2);
//
//    [self.mapView addSubview:self.centerAnnotationView];
    
    
    self.imageLocated = [UIImage imageNamed:@"hb"];
    self.imageNotLocate = [UIImage imageNamed:@"hb"];
    self.locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.mapView.bounds) - 40, CGRectGetHeight(self.mapView.bounds) - 50, 32, 32)];
    self.locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.locationBtn.backgroundColor = [UIColor whiteColor];
    
    self.locationBtn.layer.cornerRadius = 3;
//    [self.locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    
    [self.bottomView addSubview:self.locationBtn];
    
    self.mapView.zoomLevel = 10;              ///缩放级别（默认3-19，有室内地图时为3-20）
    self.mapView.showsUserLocation = YES;    ///是否显示用户位置
    self.mapView.showsCompass =NO;          /// 是否显示指南针
    self.mapView.showsScale = NO;           ///是否显示比例尺
    self.mapView.minZoomLevel =14;          /// 限制最小缩放级别
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = CGFloatBasedI375(5);
        _bottomView.clipsToBounds = YES;
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}
-(UIImageView *)mainImage{
    if(!_mainImage){
        _mainImage = [[UIImageView alloc]init];
        _mainImage.backgroundColor = Red_Color;
        _mainImage.layer.masksToBounds = YES;
        _mainImage.layer.cornerRadius = CGFloatBasedI375(5);
        [self.contentView addSubview:_mainImage];
    }
    return _mainImage;
}

@end
