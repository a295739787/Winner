//
//  LLMeOrderDetailHeaderView.m
//  Winner
//
//  Created by YP on 2022/3/12.
//

#import "LLMeOrderDetailHeaderView.h"

@interface LLMeOrderDetailHeaderView ()

@property (nonatomic,strong)UIImageView *bottomView;
@property (nonatomic,strong)UIImageView *typeImgView;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)CountDown* countDownForBtn;/** <#class#> **/

@end

@implementation LLMeOrderDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.typeImgView];
    [self.bottomView addSubview:self.statusLabel];
    [self.bottomView addSubview:self.timeLabel];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    [self.typeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(13));
        make.centerY.mas_equalTo(self.bottomView);
        make.width.height.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(40));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    
}
-(void)setDetailModel:(LLMeOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    //订单类型（1零售商品、2惊喜红包商品、3品鉴商品、4配送库存提货）
    if(_detailModel.orderType.integerValue == 3){
        if(_detailModel.taskStatus == 2 && _detailModel.orderStatus.integerValue == 2){//待接单
            self.timeLabel.hidden = NO;
            _typeImgView.image = [UIImage imageNamed:@"djd"];
         
            if(_detailModel.feePriceSize == 0){//当前收货地址在5KM服务范围内￥0.00元配送费；
                self.statusLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前订",@"5KM",@"范围内等待接单"] colors:@[ White_Color, Main_Color,White_Color]];
            }else if(_detailModel.feePriceSize == 1){//当前收货地址在5-10KM服务范围内加价￥10.00元配送费；
                self.statusLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前订",@"5-10KM",@"范围内等待接单"] colors:@[ White_Color, Main_Color,White_Color]];
            }else if(_detailModel.feePriceSize == 2){//当前收货地址在5-10KM服务范围内加价￥10.00元配送费；
                self.statusLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前订",@"10-15KM",@"范围内等待接单"] colors:@[ White_Color, Main_Color,White_Color]];
            }else{
                self.statusLabel.attributedText = [self getAttribuStrWithStrings:@[@"超出15KM范围或还是没人接单，订单自动取消并原路返回支付金额"] colors:@[ Main_Color]];
            }
            _countDownForBtn = [[CountDown alloc] init];
            NSString *newdata = [NSString getCurrentTimes];
            long long startLongLong = [newdata longLongValue];
            if(_detailModel.stayTaskTime.length <= 0){
            }

            NSInteger str = [NSString timeSwitchTimestamp:_detailModel.stayTaskTime];
//            [JXUIKit showErrorWithStatus:FORMAT(@"当前的时间戳 == %@  stayTaskTime的时间戳 == %ld  总共时间戳 == %ld",newdata,str,str - startLongLong)];

            [self startLongLongStartStamp:startLongLong longlongFinishStamp:[_detailModel.stayTaskTimestamp longLongValue]];
        }else  if(_detailModel.taskStatus == 3){//待提货
            self.statusLabel.text= @"配送员已接单，正努力飞奔中";
            _typeImgView.image = [UIImage imageNamed:@"sc_yfh"];
            if(_detailModel.appDeliveryClerkDistanceVo){
                self.statusLabel.text= @"配送员已接单，正努力飞奔中";
            }else   if(_detailModel.shopDistanceVo){
                self.statusLabel.text= @"推广员已接单，正努力飞奔中";
            }
        }else  if(_detailModel.taskStatus == 5){//已转单
            self.statusLabel.text= @"已转单";
            _typeImgView.image = [UIImage imageNamed:@"sc_yfh"];
        }else  if(_detailModel.orderStatus.integerValue == 6){//已转单
            self.statusLabel.text= @"交易关闭，取消订单";
            _typeImgView.image = [UIImage imageNamed:@"sc_yfh"];
        }else  if(_detailModel.orderStatus.integerValue == 4){//待评价
            self.statusLabel.text= @"评个分鼓励一下吧";
            _typeImgView.image = [UIImage imageNamed:@"dpj"];
        }
    }    else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        if(_detailModel.taskStatus == 3 && _detailModel.orderStatus.integerValue == 2){//待提货
           self.statusLabel.text= @"推广点已接单，请耐心等待";
           _typeImgView.image = [UIImage imageNamed:@"sc_yfh"];
       }else  if(_detailModel.orderStatus.integerValue == 4){//待评价
           self.statusLabel.text= @"评个分鼓励一下吧";
           _typeImgView.image = [UIImage imageNamed:@"dpj"];
       }else  if(_detailModel.orderStatus.integerValue == 1){//待评价
           _typeImgView.image = [UIImage imageNamed:@"dd_dfk"];
           _statusLabel.text = @"等待买家付款";
       }
        //订单状态（状态：1待付款，2待发货，3待收货，4已收货/待评价，5售后中，6已取消，7已完成）
    }else if(_detailModel.orderType.integerValue == 2){//惊喜红包  库存提货
        [self setOrderStatus:_detailModel.orderStatus];
        
    }
}
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
//    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
}
-(void)destyTimes{
    if(self.countDownForBtn){
        [self.countDownForBtn destoryTimer];
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

    if (minute<10) {
        minuteStr= [NSString stringWithFormat:@"0%ld",minute];
    }else{
        minuteStr = [NSString stringWithFormat:@"%ld",minute];
    }
    if (second<10) {
        secondStr= [NSString stringWithFormat:@"0%ld",second];
    }else{
        secondStr = [NSString stringWithFormat:@"%ld",second];
    }
  
   self.timeLabel.text = FORMAT(@"%@:%@",minuteStr,secondStr);
    if(minute <= 0 && second <= 0 && hour <= 0){//品鉴
        self.timeLabel.hidden = YES;
        if(self.tapAddAction){
            self.tapAddAction(_detailModel);
        }
        if(self.countDownForBtn){
            [self.countDownForBtn destoryTimer];
        }
    }else{
        self.timeLabel.hidden = NO;

    }

}
-(void)setOrderStatus:(NSString *)orderStatus{
    //订单状态（状态：1待付款，2待发货，3待收货，4已收货/待评价，5售后中，6已取消，7已完成

    if ([orderStatus intValue] == 0) {
        //已完成
        _typeImgView.image = [UIImage imageNamed:@"sc_jycc"];
        _statusLabel.text = @"交易成功";
        
    }else if ([orderStatus intValue] == 1){
        //待付款
        _typeImgView.image = [UIImage imageNamed:@"dd_dfk"];
        _statusLabel.text = @"等待买家付款";
        
    }else if ([orderStatus intValue] == 2){
        //待发货
        _typeImgView.image = [UIImage imageNamed:@"sc_dfh"];
        _statusLabel.text = @"等待卖家发货";
        
    }else if ([orderStatus intValue] == 3){
        //待收货
        _typeImgView.image = [UIImage imageNamed:@"sc_yfh"];
        _statusLabel.text = @"卖家已发货";
        
    }else if ([orderStatus intValue] == 4){
        //待评价
        _typeImgView.image = [UIImage imageNamed:@"dpj"];
        _statusLabel.text = @"评个分鼓励一下吧";
        
    }else if ([orderStatus intValue] == 6){
        //待评价
        _typeImgView.image = [UIImage imageNamed:@"dd_dfk"];
        _statusLabel.text = @"交易关闭，取消订单";
        
    }else if ([orderStatus intValue] == 5){
        _typeImgView.image = [UIImage imageNamed:@"dd_dfk"];
        _statusLabel.text = @"售后中";
        
    }else if ([orderStatus intValue] == 7){
        //待评价
        _typeImgView.image = [UIImage imageNamed:@"dd_dfk"];
        _statusLabel.text = @"交易完成";
        
    }
}
#pragma mark--lazy
-(UIImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.image = [UIImage imageNamed:@"order_bg"];
    }
    return _bottomView;
}
-(UIImageView *)typeImgView{
    if (!_typeImgView) {
        _typeImgView = [[UIImageView alloc]init];
        _typeImgView.backgroundColor = [UIColor clearColor];
    }
    return _typeImgView;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _statusLabel.text = @"等待买家付款";
    }
    return _statusLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _timeLabel.text = @"";
        _timeLabel.hidden = YES;
    }
    return _timeLabel;
}
@end


@interface LLMeOrderDetailTitleView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation LLMeOrderDetailTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(44))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
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

@end




@interface LLMeorderDetailPayInfoView ()

@property (nonatomic,strong)UIView *bottomView;

//商品总额
@property (nonatomic,strong)UILabel *totleLabel;
@property (nonatomic,strong)UILabel *totleText;
//消费红包
@property (nonatomic,strong)UILabel *redPacketLabel;
@property (nonatomic,strong)UILabel *redPacketText;
//运费
@property (nonatomic,strong)UILabel *fareLabel;
@property (nonatomic,strong)UILabel *fareText;
//应付金额
@property (nonatomic,strong)UILabel *payLabel;
@property (nonatomic,strong)UILabel *paytext;

@property (nonatomic,strong)UILabel *noticetext;


@end

@implementation LLMeorderDetailPayInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.totleLabel];
    [self.bottomView addSubview:self.totleText];
    [self.bottomView addSubview:self.redPacketLabel];
    [self.bottomView addSubview:self.redPacketText];
    [self.bottomView addSubview:self.fareLabel];
    [self.bottomView addSubview:self.fareText];
    [self.bottomView addSubview:self.noticetext];
    [self.bottomView addSubview:self.payLabel];
    [self.bottomView addSubview:self.paytext];
    
    [self.totleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.totleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totleLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.redPacketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(45));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.redPacketText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.redPacketLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
    [self.fareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(75));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.fareText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.fareLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    [self.noticetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fareLabel.mas_bottom).mas_equalTo(CGFloatBasedI375(10));
        make.left.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-CGFloatBasedI375(8));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.paytext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.payLabel);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
    }];
    
}
-(void)setDetailModel:(LLMeOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    NSString *actualPrice = _detailModel.actualPrice;
    NSString *freight = _detailModel.freight;
    NSString *redPrice = _detailModel.redPrice;
    NSString *totalPrice = _detailModel.totalPrice;
    
    _totleText.text = [NSString stringWithFormat:@"¥ %@",totalPrice];
    
    _redPacketText.text = [NSString stringWithFormat:@"¥ %@",redPrice];
    if(_detailModel.redPrice.length > 0)
    {
        _redPacketText.text = [NSString stringWithFormat:@"-¥ %@",redPrice];
    }
    _fareText.text = [NSString stringWithFormat:@"¥ %@",freight];
    _paytext.text = [NSString stringWithFormat:@"¥ %@",actualPrice];
    self.paytext.hidden = YES;
    if(_detailModel.orderType.integerValue == 3){//品鉴
        self.redPacketLabel.text = @"我的库存";
        self.redPacketText.text = [NSString stringWithFormat:@"-¥ %@",_detailModel.stockTotalPrice.length <=0?@"0":_detailModel.stockTotalPrice];
        self.fareLabel.text = @"配运费";
        self.payLabel.text = @"实付金额";
        self.noticetext.hidden = NO;
        self.paytext.hidden = NO;
        _fareText.text = [NSString stringWithFormat:@"¥ %.2f",_detailModel.deliveryFeePrice.length <=0?0.00:_detailModel.deliveryFeePrice.floatValue];
        self.bottomView.backgroundColor= White_Color;
       NSString *deliveryFeePrice = FORMAT(@"加价%.2f元",_detailModel.deliveryFeePrice.length <=0?0.00:_detailModel.deliveryFeePrice.floatValue);
        self.bottomView.height = CGFloatBasedI375(170);
                if(_detailModel.feePriceSize == 0){//当前收货地址在5KM服务范围内￥0.00元配送费；
                    self.noticetext.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",@"5KM",@"服务范围内",deliveryFeePrice,@"配送费；"]  colors:@[UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999)]];
                }else if(_detailModel.feePriceSize == 1){//当前收货地址在5-10KM服务范围内加价￥10.00元配送费；
                    self.noticetext.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",@"5-10KM",@"服务范围内",deliveryFeePrice,@"配送费；"]  colors:@[UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999)]];
                }else{
                    self.noticetext.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",@"10-15KM",@"服务范围内",deliveryFeePrice,@"配送费；"]  colors:@[UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999)]];
                }
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;

    }else     if(_detailModel.orderType.integerValue == 1 && _detailModel.expressType.integerValue == 2){//同城
        if((_detailModel.taskStatus == 3 && _detailModel.orderStatus.integerValue != 6) || _detailModel.orderStatus.integerValue == 4){  //待提货  待评价
            self.redPacketLabel.text = @"我的库存";
            self.redPacketText.text = [NSString stringWithFormat:@"-¥ %@",_detailModel.stockTotalPrice.length <=0?@"0":_detailModel.stockTotalPrice];
            self.fareLabel.text = @"配运费";
            self.payLabel.text = @"实付金额";
            self.noticetext.hidden = NO;
            self.paytext.hidden = NO;
            self.paytext.text = FORMAT(@"¥ %@",_detailModel.actualPrice);
            self.paytext.textColor = Main_Color;
            self.bottomView.backgroundColor= White_Color;
            _fareText.text = [NSString stringWithFormat:@"¥ %.2f",_detailModel.freight.length <=0?0.00:_detailModel.freight.floatValue];

            self.bottomView.height = CGFloatBasedI375(170);
            NSString *notice = @"满1000";
            if(_detailModel.actualPrice.floatValue < 1000){
                notice = @"不满1000";
            }
            self.noticetext.attributedText = [self getAttribuStrWithStrings:@[@"当前订单",FORMAT(@"%@",notice),@"，满足",FORMAT(@"%@",@"同城20KM"),@"内，支付",FORMAT(@"%.2f",_detailModel.freight.floatValue),@"配送费配送"]  colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color]];
            //  当前订单已满1000，满足同城20KM内，支付0元配送费；
            UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];
            
            CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
            cornerRadiusLayer.frame = self.bottomView.bounds;
            cornerRadiusLayer.path = cornerRadiusPath.CGPath;
            self.bottomView.layer.mask = cornerRadiusLayer;
        }else{
            self.paytext.hidden = NO;
        }
    }else{
        self.paytext.hidden = NO;
    }
    
}

#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(150))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}

-(UILabel *)totleLabel{
    if (!_totleLabel) {
        _totleLabel = [[UILabel alloc]init];
        _totleLabel.textColor = UIColorFromRGB(0x443415);
        _totleLabel.textAlignment = NSTextAlignmentLeft;
        _totleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _totleLabel.text = @"商品总额";
    }
    return _totleLabel;
}
-(UILabel *)noticetext{
    if (!_noticetext) {
        _noticetext = [[UILabel alloc]init];
        _noticetext.textColor = UIColorFromRGB(0x443415);
        _noticetext.textAlignment = NSTextAlignmentLeft;
        _noticetext.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noticetext.text = @"";
        _noticetext.hidden = YES;
    }
    return _noticetext;
}
-(UILabel *)totleText{
    if (!_totleText) {
        _totleText = [[UILabel alloc]init];
        _totleText.textColor = UIColorFromRGB(0x443415);
        _totleText.textAlignment = NSTextAlignmentRight;
        _totleText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _totleText.text = @"¥ 149.00";
    }
    return _totleText;
}

-(UILabel *)redPacketLabel{
    if (!_redPacketLabel) {
        _redPacketLabel = [[UILabel alloc]init];
        _redPacketLabel.textColor = UIColorFromRGB(0x443415);
        _redPacketLabel.textAlignment = NSTextAlignmentLeft;
        _redPacketLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _redPacketLabel.text = @"消费红包";
    }
    return _redPacketLabel;
}

-(UILabel *)redPacketText{
    if (!_redPacketText) {
        _redPacketText = [[UILabel alloc]init];
        _redPacketText.textColor = UIColorFromRGB(0x443415);
        _redPacketText.textAlignment = NSTextAlignmentCenter;
        _redPacketText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _redPacketText.text = @"¥ 149.00";
    }
    return _redPacketText;
}

-(UILabel *)fareLabel{
    if (!_fareLabel) {
        _fareLabel = [[UILabel alloc]init];
        _fareLabel.textColor = UIColorFromRGB(0x443415);
        _fareLabel.textAlignment = NSTextAlignmentLeft;
        _fareLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _fareLabel.text = @"运费";
    }
    return _fareLabel;
}

-(UILabel *)fareText{
    if (!_fareText) {
        _fareText = [[UILabel alloc]init];
        _fareText.textColor = UIColorFromRGB(0x443415);
        _fareText.textAlignment = NSTextAlignmentRight;
        _fareText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _fareText.text = @"¥ 149.00";
    }
    return _fareText;
}

-(UILabel *)payLabel{
    if (!_payLabel) {
        _payLabel = [[UILabel alloc]init];
        _payLabel.textColor = UIColorFromRGB(0x443415);
        _payLabel.textAlignment = NSTextAlignmentLeft;
        _payLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _payLabel.text = @"应付金额";
    }
    return _payLabel;
}

-(UILabel *)paytext{
    if (!_paytext) {
        _paytext = [[UILabel alloc]init];
        _paytext.textColor = UIColorFromRGB(0xD40006);
        _paytext.textAlignment = NSTextAlignmentRight;
        _paytext.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _paytext.text = @"¥ 149.00";
    }
    return _paytext;
}


@end



@interface LLmeOrderDetailInfoFooterView ()

@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic ,strong) UIView *infoView;
@property (nonatomic ,strong) UIImageView *serviceImageView;
@property (nonatomic ,strong) UILabel *serviceLabel;
@property (nonatomic ,strong) UIButton *serviceButton;


@end

@implementation LLmeOrderDetailInfoFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_showInfo == YES) {
        [self addSubview: self.infoView];
        [self.infoView addSubview:self.questionLabel];
        [self.infoView addSubview:self.serviceImageView];
        [self.infoView addSubview:self.serviceLabel];
        [self.infoView addSubview:self.serviceButton];
        
        self.infoView.frame = CGRectMake(0, CGRectGetMaxY(self.bottomView.frame)+20, self.frame.size.width, 50);
        self.questionLabel.frame = CGRectMake(self.infoView.frame.size.width * 0.264, (self.infoView.frame.size.height-14)/2, 95, 14);
        self.serviceImageView.frame = CGRectMake(CGRectGetMaxX(self.questionLabel.frame)+7, (self.infoView.frame.size.height-18)/2, 21, 18);
        self.serviceLabel.frame = CGRectMake(CGRectGetMaxX(self.serviceImageView.frame)+5, (self.infoView.frame.size.height-14)/2, 60, 14);
        
        self.serviceButton.frame = CGRectMake(0, 0, self.infoView.frame.size.width, self.infoView.frame.size.height);
    }
}
-(void)buttonCilck:(UIButton *)sender{
    if (self.serviceBlock) {
        self.serviceBlock();
    }
}
#pragma mark--lazy
- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc]init];
        _infoView.backgroundColor = UIColor.clearColor;
    }
    return  _infoView;
}
- (UIButton *)serviceButton{
    if (!_serviceButton) {
        _serviceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_serviceButton addTarget:self action:@selector(buttonCilck:) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return _serviceButton;
}
- (UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.textColor = [UIColor HexString:@"#999999"];
        _questionLabel.font = [UIFont systemFontOfSize:14];
        _questionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _questionLabel;
}
- (UIImageView *)serviceImageView{
    if (!_serviceImageView) {
        _serviceImageView = [[UIImageView alloc]init];
        _serviceImageView.contentMode = UIViewContentModeScaleAspectFill;
        _serviceImageView.image = [UIImage imageNamed:@"service_red"];
    }
    return _serviceImageView;
}
- (UILabel *)serviceLabel{
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc]init];
        _serviceLabel.textColor = [UIColor HexString:@"#333333"];
        _serviceLabel.font = [UIFont systemFontOfSize:14];
        _serviceLabel.textAlignment = NSTextAlignmentLeft;
        _serviceLabel.text = @"联系客服";
    }
    return _serviceLabel;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(15))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}


@end


@interface LLMeorderDetailBottomView ()

@property (nonatomic,strong)UIView *bottomView;
//待付款
@property (nonatomic,strong)UIButton *cancleBtn;
//待发货
@property (nonatomic,strong)UIButton *applyBtn;
//待收货
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong)UIButton *lookBtn;
@property (nonatomic,strong)UIButton *aftermarkBtn;
//待评价
@property (nonatomic,strong)UIButton *evaluateBtn;
//已完成
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIButton *applyBillBtn;


@end

@implementation LLMeorderDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.paytext];

    [self addSubview:self.payBtn];
    [self addSubview:self.cancleBtn];
    [self addSubview:self.applyBtn];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.lookBtn];
    [self addSubview:self.aftermarkBtn];
    [self addSubview:self.evaluateBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.applyBillBtn];

    
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-105));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-105));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.aftermarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-195));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    [self.paytext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
   
    }];
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    [self.applyBillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-195));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.width.mas_equalTo(CGFloatBasedI375(80));
        make.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    
    
    
    self.payBtn.hidden = YES;
    self.cancleBtn.hidden = YES;
    self.applyBtn.hidden = YES;
    self.confirmBtn.hidden = YES;
    self.lookBtn.hidden = YES;
    self.aftermarkBtn.hidden = YES;
    self.evaluateBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    self.applyBillBtn.hidden = YES;
}

#pragma mark--footerOrderBtnClick
-(void)footerOrderBtnClick:(UIButton *)btn{
    if(self.ActionBlock){
        self.ActionBlock(btn.titleLabel.text);
    }
}
-(void)setDetailModel:(LLMeOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    self.paytext.hidden = YES;
    self.paytext.text = FORMAT(@"提货码: %@",_detailModel.writeCode);
    
    if(_detailModel.orderType.integerValue == 3){//品鉴区域
        if(self.detailModel.taskStatus == 3){//待提货
            self.payBtn.hidden = NO;
            self.paytext.hidden = NO;
            self.cancleBtn.hidden = YES;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = YES;
            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = YES;
            self.deleteBtn.hidden = YES;
            self.applyBillBtn.hidden = YES;
      
            self.payBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            [self.payBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
            if(_detailModel.appDeliveryClerkDistanceVo){
                [self.payBtn setTitle:@"联系配送员" forState:UIControlStateNormal];
            }else   if(_detailModel.shopDistanceVo){
                [self.payBtn setTitle:@"联系推广员" forState:UIControlStateNormal];
            }
        }else if (self.detailModel.orderStatus.integerValue == 4){
            self.payBtn.hidden = NO;
            self.paytext.hidden = YES;
            self.cancleBtn.hidden = YES;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = YES;
            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = YES;
            self.deleteBtn.hidden = YES;
            self.applyBillBtn.hidden = YES;
      
            [self.payBtn setTitle:@"去评价" forState:UIControlStateNormal];
            self.payBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
            self.payBtn.layer.borderWidth = CGFloatBasedI375(1);
            [self.payBtn setTitleColor:Main_Color forState:UIControlStateNormal];
        }else if (self.detailModel.taskStatus == 2 && self.detailModel.orderStatus.integerValue != 6){
            self.payBtn.hidden = NO;
            self.paytext.hidden = YES;
            self.cancleBtn.hidden = YES;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = YES;
            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = YES;
            self.deleteBtn.hidden = YES;
            self.applyBillBtn.hidden = YES;
            [self.payBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            self.payBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            [self.payBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
            if(self.detailModel.stockNum > 0){
                [self.payBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            }
         
            if ( self.detailModel.orderStatus.integerValue == 5){
               self.payBtn.hidden = NO;
               self.paytext.hidden = YES;
               self.cancleBtn.hidden = YES;
               self.applyBtn.hidden = YES;
               self.confirmBtn.hidden = YES;
               self.lookBtn.hidden = YES;
               self.aftermarkBtn.hidden = YES;
               self.evaluateBtn.hidden = YES;
               self.deleteBtn.hidden = YES;
               self.applyBillBtn.hidden = YES;
               [self.payBtn setTitle:@"售后中" forState:UIControlStateNormal];
               self.payBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
               [self.payBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
               
            }else{
                if(!self.detailModel.isAfter){
                    self.payBtn.hidden = YES;
                }
            }
        
            
        }else if (self.detailModel.orderStatus.integerValue == 6){
            self.payBtn.hidden = YES;
            self.paytext.hidden = YES;
            self.cancleBtn.hidden = YES;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = YES;
            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = YES;
            self.deleteBtn.hidden = NO;
            self.applyBillBtn.hidden = YES;

            
        }
    } else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        if(_detailModel.taskStatus == 3 && _detailModel.orderStatus.integerValue == 2){//待提货
            self.payBtn.hidden = NO;
            self.paytext.hidden = NO;
            self.cancleBtn.hidden = NO;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = YES;
            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = YES;
            self.deleteBtn.hidden = YES;
            self.applyBillBtn.hidden = YES;
            [self.payBtn setTitle:@"联系推广员" forState:UIControlStateNormal];
            [self.cancleBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            self.payBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            [self.payBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
            if(!self.detailModel.isAfter){
                self.cancleBtn.hidden = YES;
            }
        }else  if(_detailModel.orderStatus.integerValue == 4){//待评价
            self.payBtn.hidden = YES;
            self.paytext.hidden = YES;
            self.cancleBtn.hidden = YES;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = NO;
            [self.lookBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = NO;
            self.deleteBtn.hidden = YES;
            self.applyBillBtn.hidden = YES;
            if(!self.detailModel.isAfter){
                self.lookBtn.hidden = YES;
            }
        }else  if(_detailModel.orderStatus.integerValue == 1){//待评价
            self.payBtn.hidden = NO;
            self.paytext.hidden = YES;
            self.cancleBtn.hidden = NO;
            self.applyBtn.hidden = YES;
            self.confirmBtn.hidden = YES;
            self.lookBtn.hidden = YES;
            [self.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];

            self.aftermarkBtn.hidden = YES;
            self.evaluateBtn.hidden = YES;
            self.deleteBtn.hidden = YES;
            self.applyBillBtn.hidden = YES;
        }
    }else if((_detailModel.orderType.integerValue == 1 &&_detailModel.expressType.integerValue ==1) && _detailModel.orderStatus.integerValue == 2 ){//零售的快递 待发货
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = NO;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = NO;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
        [self.applyBtn setTitle:@"修改地址" forState:UIControlStateNormal];
        [self.lookBtn setTitle:@"申请退款" forState:UIControlStateNormal];

    }else if((_detailModel.orderType.integerValue == 1 &&_detailModel.expressType.integerValue ==1) && _detailModel.orderStatus.integerValue == 1 ){//零售的快递 待付款
        self.payBtn.hidden = NO;
        self.cancleBtn.hidden = NO;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = YES;
        self.aftermarkBtn.hidden = NO;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
        [self.payBtn setTitle:@"修改地址" forState:UIControlStateNormal];
        [self.cancleBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [self.aftermarkBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    }else if(_detailModel.orderType.integerValue == 2 && _detailModel.orderStatus.integerValue == 2 ){//库存待发货
        self.payBtn.hidden = NO;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = YES;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
        [self.payBtn setTitle:@"修改地址" forState:UIControlStateNormal];
    }else if(_detailModel.orderType.integerValue == 2 && _detailModel.orderStatus.integerValue == 1 ){//库存待发货
        self.payBtn.hidden = NO;
        self.cancleBtn.hidden = NO;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = YES;
        self.aftermarkBtn.hidden = NO;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
        [self.payBtn setTitle:@"修改地址" forState:UIControlStateNormal];
        [self.cancleBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [self.aftermarkBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    }else if(_detailModel.orderType.integerValue == 4 && _detailModel.orderStatus.integerValue == 7 ){//已完成
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = NO;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
        self.applyBillBtn.hidden = YES;
        self.aftermarkBtn.hidden = YES;
        [self.lookBtn setTitle:@"申请开票" forState:UIControlStateNormal];
    }
    
  
        
        
}
-(void)setOrderStatus:(NSString *)orderStatus{
    //订单状态（状态：1待付款，2待发货，3待收货，4已收货/待评价，5售后中，6已取消，7已完成）
    if ([orderStatus intValue] == 0) {
        //已完成
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = NO;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
        self.applyBillBtn.hidden = NO;
        
    }else if ([orderStatus intValue] == 1){
        //待付款
        self.payBtn.hidden = NO;
        self.cancleBtn.hidden = NO;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = YES;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
    }else if ([orderStatus intValue] == 2){
        //待发货
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = NO;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = YES;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
    }else if ([orderStatus intValue] == 3){
        //待收货
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = NO;
        self.lookBtn.hidden = NO;
        self.aftermarkBtn.hidden = NO;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
    }else if ([orderStatus intValue] == 4){
        //待评价
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = NO;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = NO;
        self.deleteBtn.hidden = YES;
        self.applyBillBtn.hidden = YES;
        if(_detailModel.orderType.integerValue == 4){//配送列表库存
            self.evaluateBtn.hidden = NO;
            self.aftermarkBtn.hidden = YES;
            self.lookBtn.hidden = YES;
        }
    }else if ([orderStatus intValue] == 6){
        //已取消
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = YES;
        self.aftermarkBtn.hidden = YES;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
        self.applyBillBtn.hidden = YES;
    }else if ([orderStatus intValue] == 7){
        //已完成
        self.payBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.applyBtn.hidden = YES;
        self.confirmBtn.hidden = YES;
        self.lookBtn.hidden = NO;
        self.aftermarkBtn.hidden = NO;
        self.evaluateBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
        self.applyBillBtn.hidden = YES;
        if(_detailModel.orderAfterStatus.integerValue == 1){//售后状态(1待审核，2待收货，3已通过，4已拒绝)
            [self.aftermarkBtn setTitle:@"审核中" forState:UIControlStateNormal];
            if(_detailModel.afterType.integerValue == 1){
                [self.aftermarkBtn setTitle:@"退款中" forState:UIControlStateNormal];
            }else{
                [self.aftermarkBtn setTitle:@"审核中" forState:UIControlStateNormal];
            }
        }else if(_detailModel.orderAfterStatus.integerValue == 2){
            [self.aftermarkBtn setTitle:@"待收货" forState:UIControlStateNormal];
        }else if(_detailModel.orderAfterStatus.integerValue == 3){
            [self.aftermarkBtn setTitle:@"退款中" forState:UIControlStateNormal];
        }else if(_detailModel.orderAfterStatus.integerValue == 4){
            [self.aftermarkBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        }
        [self.aftermarkBtn setTitle:@"申请开票" forState:UIControlStateNormal];
//        if(_detailModel.orderType.integerValue == 4){
////                   _leftBtn.hidden = YES;
//                   [self.aftermarkBtn setTitle:@"申请开票" forState:UIControlStateNormal];
////                   [_rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
//               }
    }
 
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _detailModel.writeCode;
}
-(UILabel *)paytext{
    if (!_paytext) {
        _paytext = [[UILabel alloc]init];
        _paytext.textColor = UIColorFromRGB(0x443415);
        _paytext.textAlignment = NSTextAlignmentLeft;
        _paytext.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(13)];
        _paytext.text = @"提货码:";
        _paytext.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_paytext addGestureRecognizer:tap];
      
    }
    return _paytext;
}
#pragma mark--lazy
-(UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.backgroundColor = [UIColor whiteColor];
        [_payBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _payBtn.tag = 100;
        [_payBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _payBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _payBtn.clipsToBounds = YES;
        _payBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _payBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _payBtn;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _cancleBtn.tag = 101;
        [_cancleBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _cancleBtn.clipsToBounds = YES;
        _cancleBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _cancleBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _cancleBtn;
}

-(UIButton *)applyBtn{
    if (!_applyBtn) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.backgroundColor = [UIColor whiteColor];
        [_applyBtn setTitle:@"申请退款" forState:UIControlStateNormal];
     
        _applyBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _applyBtn.tag = 102;
        [_applyBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _applyBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _applyBtn.clipsToBounds = YES;
        _applyBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        [_applyBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _applyBtn.layer.borderWidth = CGFloatBasedI375(1);
        
    }
    return _applyBtn;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor whiteColor];
        [_confirmBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _confirmBtn.tag = 103;
        [_confirmBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _confirmBtn.clipsToBounds = YES;
        _confirmBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _confirmBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _confirmBtn;
}
-(UIButton *)lookBtn{
    if (!_lookBtn) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookBtn.backgroundColor = [UIColor whiteColor];
        [_lookBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _lookBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _lookBtn.tag = 104;
        [_lookBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _lookBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _lookBtn.clipsToBounds = YES;
        _lookBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _lookBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _lookBtn;
}
-(UIButton *)aftermarkBtn{
    if (!_aftermarkBtn) {
        _aftermarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _aftermarkBtn.backgroundColor = [UIColor whiteColor];
        [_aftermarkBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        [_aftermarkBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _aftermarkBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _aftermarkBtn.tag = 105;
        [_aftermarkBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _aftermarkBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _aftermarkBtn.clipsToBounds = YES;
        _aftermarkBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _aftermarkBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _aftermarkBtn;
}
-(UIButton *)evaluateBtn{
    if (!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _evaluateBtn.backgroundColor = [UIColor whiteColor];
        [_evaluateBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [_evaluateBtn setTitleColor:UIColorFromRGB(0xD40006) forState:UIControlStateNormal];
        _evaluateBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _evaluateBtn.tag = 106;
        [_evaluateBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _evaluateBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _evaluateBtn.clipsToBounds = YES;
        _evaluateBtn.layer.borderColor = UIColorFromRGB(0xD40006).CGColor;
        _evaluateBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _evaluateBtn;
}

-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        [_deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _deleteBtn.tag = 107;
        [_deleteBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _deleteBtn.clipsToBounds = YES;
        _deleteBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _deleteBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _deleteBtn;
}

-(UIButton *)applyBillBtn{
    if (!_applyBillBtn) {
        _applyBillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyBillBtn.backgroundColor = [UIColor whiteColor];
        [_applyBillBtn setTitle:@"申请开票" forState:UIControlStateNormal];
        [_applyBillBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _applyBillBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _applyBillBtn.tag = 108;
        [_applyBillBtn addTarget:self action:@selector(footerOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _applyBillBtn.layer.cornerRadius = CGFloatBasedI375(15);
        _applyBillBtn.clipsToBounds = YES;
        _applyBillBtn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        _applyBillBtn.layer.borderWidth = CGFloatBasedI375(1);
    }
    return _applyBillBtn;
}


@end




@interface LlmeOrderGoodsInfoheaderView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UILabel *evaluateLabel;

@end

@implementation LlmeOrderGoodsInfoheaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.line];
    [self.bottomView addSubview:self.evaluateLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(15));
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.line.mas_bottom).offset(CGFloatBasedI375(15));
    }];
    
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(90))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x443415);
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titleLabel.text = @"商品信息";
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
-(UILabel *)evaluateLabel{
    if (!_evaluateLabel) {
        _evaluateLabel = [[UILabel alloc]init];
        _evaluateLabel.textColor = UIColorFromRGB(0x443415);
        _evaluateLabel.textAlignment = NSTextAlignmentLeft;
        _evaluateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _evaluateLabel.text = @"星际评分";
    }
    return _evaluateLabel;
}

@end






@interface LLMeOrderEvaluateFooterView ()<JJPhotoDelegate>

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UILabel *evaluateLabel;
@property (nonatomic,strong) NSMutableArray *imageArray;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *imageViewArray;/** <#class#> **/
@end

@implementation LLMeOrderEvaluateFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bottomView];
        [self createUI];
    }
    return self;
}
-(void)setDatas:(NSArray *)datas{
    _datas = datas;
    [self createUI];
    
    NSArray *images =_datas;;
    CGFloat rowHeight = (SCREEN_WIDTH - CGFloatBasedI375(20) - CGFloatBasedI375(15 * 2) - CGFloatBasedI375(10 * 2)) / 3;
    CGFloat gargInheiGht = CGFloatBasedI375(15);
    if(images.count % 3 == 0){
        rowHeight = rowHeight* (images.count/3);
        gargInheiGht = gargInheiGht*(images.count/3);
    }else{
        rowHeight = rowHeight* (images.count/3+1);
        gargInheiGht = gargInheiGht*(images.count/3+1);
    }
    self.bottomView.height = rowHeight+gargInheiGht;
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

   CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
   cornerRadiusLayer.frame = self.bottomView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.bottomView.layer.mask = cornerRadiusLayer;
}
#pragma mark--createUI
-(void)createUI{
    [self.imageViewArray removeAllObjects];
    [self.imageArray removeAllObjects];
    for(NSInteger i =0;i<_datas.count;i++){
        if([_datas[i] containsString:@"http"]){
            NSString *problemImages =[NSString stringWithFormat:@"%@",_datas[i]];
            [self.imageArray addObject:problemImages];
        }else{
            NSString *problemImages =[NSString stringWithFormat:@"%@%@",apiQiUrl,_datas[i]];
            [self.imageArray addObject:problemImages];
        }
    }

    
    for(UIImageView *img  in self.bottomView.subviews){
        [img removeAllSubviews];
    }
    CGFloat rowHeight = (SCREEN_WIDTH - CGFloatBasedI375(20) - CGFloatBasedI375(15 * 2) - CGFloatBasedI375(10 * 2)) / 3;
    for (int i = 0; i < _datas.count; i++) {
        
        [[self.bottomView viewWithTag:100 + i] removeFromSuperview];
        CGFloat w = rowHeight;
        CGFloat h = rowHeight;
        CGFloat x = CGFloatBasedI375(15)+(w + CGFloatBasedI375(10))*(i% 3);
        CGFloat y =CGFloatBasedI375(10)+(h + CGFloatBasedI375(10))*(i/3);
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(x, y, w, h);
        imgView.backgroundColor = [UIColor redColor];
        imgView.layer.cornerRadius = CGFloatBasedI375(10);
        imgView.clipsToBounds = YES;
        [self.imageViewArray addObject:imgView];
        [imgView sd_setImageWithUrlString:_datas[i]];
        imgView.tag = 100 + i;
        [self.bottomView addSubview:imgView];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showpic:)];
        [imgView addGestureRecognizer:tap];
    }
}

//聊天图片放大浏览
-(void)showpic:(UITapGestureRecognizer *)tap
{
    NSLog(@"imageViewArray == %@  imageArray == %@",self.imageViewArray,self.imageArray);
    NSInteger view = tap.view.tag;
    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    mg.delegate = self;
    [mg showNetworkPhotoViewer:self.imageViewArray urlStrArr:self.imageArray selecImageindex:view-100];
    
    
}
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

-(NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)imageViewArray{
    if(!_imageViewArray){
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        CGFloat rowHeight = (SCREEN_WIDTH - CGFloatBasedI375(20) - CGFloatBasedI375(15 * 2) - CGFloatBasedI375(10 * 2)) / 3;
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - CGFloatBasedI375(20), rowHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}


@end



@interface LLMeOrderEvaluateStarView ()


@end

@implementation LLMeOrderEvaluateStarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 5; i++) {
        
        [[self viewWithTag:100 + i]removeFromSuperview];
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake((CGFloatBasedI375(10) + CGFloatBasedI375(5)) * i, 0, CGFloatBasedI375(10), CGFloatBasedI375(10));
        imgView.backgroundColor = [UIColor whiteColor];
        imgView.image = [UIImage imageNamed:@"xing_gray"];
        imgView.tag = 100 + i;
        [self addSubview:imgView];
    }
}

-(void)setStar:(NSString *)star{
    
    int starindex = [star intValue];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *imgView = [self viewWithTag:100 + i];
        if (i <= starindex) {
            imgView.image = [UIImage imageNamed:@"xing_red"];
        }else{
            imgView.image = [UIImage imageNamed:@"xing_gray"];
        }
    }
}


@end





//


@interface LLMeOrderDetailOrderReceiveView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titeleLabel;
@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UIButton *contactBtn;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic, weak) NSTimer  *timer;
@property (nonatomic,strong) UIButton *button2;/** <#class#> **/

@property (nonatomic,assign) NSInteger counts;/** <#class#> **/

@end

@implementation LLMeOrderDetailOrderReceiveView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.counts = 3;
        [self createUI];
    }
    return self;
}

#pragma mark--createUI
-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CGFloatBasedI375(280));
    }];
    
    [self.contentView addSubview:self.titeleLabel];
    [self.contentView addSubview:self.headerImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.contactBtn];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titeleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(CGFloatBasedI375(20));
    }];
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titeleLabel.mas_bottom).offset(CGFloatBasedI375(24));
        make.width.height.mas_equalTo(CGFloatBasedI375(34));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.headerImgView.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.width.height.mas_equalTo(CGFloatBasedI375(30));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contactBtn.mas_bottom).offset(CGFloatBasedI375(25));
        make.height.mas_equalTo(0.5);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.line.mas_bottom).offset(0);
        make.height.mas_equalTo(CGFloatBasedI375(45));
        make.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark--contactBtnClick
-(void)contactBtnClick:(UIButton *)btn{
    
    
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hidden{
    if(self.timer){
        [self.timer invalidate];
    }
    [self removeFromSuperview];
}
-(void)setModel:(LLMeOrderDetailModel *)model{
    _model= model;
    [self.headerImgView sd_setImageWithUrlString:_model.appDeliveryClerkDistanceVo.coverImage];
    self.nameLabel.text = _model.appDeliveryClerkDistanceVo.realName;
    _phoneLabel.text = [NSString setPhoneMidHid:_model.appDeliveryClerkDistanceVo.telePhone];
    [self startTimer];
}

-(void)startTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerAction) userInfo:nil repeats:YES];  //注意关闭重复执行
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: UITrackingRunLoopMode];
}
/** 定时器方法 **/
-(void)TimerAction{
    self.counts--;
    if(self.counts == 0){
        if(self.timer){
            [self.timer invalidate];
        }
        [self hidden];
        UINavigationController *navC =  [UIViewController getCurrentController].navigationController;
        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
        for (UIViewController *vc in navC.viewControllers) {
            [viewControllers addObject:vc];
            if ([vc isKindOfClass:[LLMeOrderListController class]]) {
                break;
            }
        }
        if (viewControllers.count == navC.viewControllers.count) {
            [[UIViewController getCurrentController].navigationController popViewControllerAnimated:YES];
        }
        else {
            [navC setViewControllers:viewControllers animated:YES];
        }

    }else{
        _timeLabel.text = FORMAT(@"%ldS后返回订单列表",self.counts);
    }
    
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.6;
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
-(UILabel *)titeleLabel{
    if (!_titeleLabel) {
        _titeleLabel = [[UILabel alloc]init];
        _titeleLabel.textColor = UIColorFromRGB(0x443415);
        _titeleLabel.textAlignment = NSTextAlignmentCenter;
        _titeleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _titeleLabel.text = @"配送员已接单";
    }
    return _titeleLabel;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
        _headerImgView.layer.cornerRadius = CGFloatBasedI375(17);
        _headerImgView.clipsToBounds = YES;
    }
    return _headerImgView;
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
-(UIButton *)contactBtn{
    if (!_contactBtn) {
        _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactBtn.backgroundColor = [UIColor whiteColor];
        [_contactBtn setImage:[UIImage imageNamed:@"icon_lxpsy"] forState:UIControlStateNormal];
        [_contactBtn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBtn;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0x09141F);
        _line.alpha = 0.3;
    }
    return _line;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _timeLabel.text = @"3S后返回订单列表";
        _timeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_timeLabel addGestureRecognizer:tap];
     
    }
    return _timeLabel;
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    [self hidden];
}

@end
