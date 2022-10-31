//
//  LLStockOrderDetailTopView.m
//  Winner
//
//  Created by YP on 2022/3/22.
//

#import "LLStockOrderDetailTopView.h"

@interface LLStockOrderDetailTopView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *statusImgView;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong) CountDown *countDownForBtn;/** <#class#> **/
@property (nonatomic,strong) UILabel *timelable;/** <#class#> **/

@end

@implementation LLStockOrderDetailTopView

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
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.bottomView addSubview:self.statusImgView];
    [self.bottomView addSubview:self.stateLabel];
    [self.bottomView addSubview:self.timelable];
    [self.statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.height.mas_equalTo(CGFloatBasedI375(16));
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.statusImgView);
        make.left.equalTo(self.statusImgView.mas_right).mas_equalTo(CGFloatBasedI375(5));
    }];
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    self.timelable.hidden = YES;
    if(_model.taskStatus  == 2 || _model.taskStatus == 5){
        self.timelable.hidden = NO;
        self.stateLabel.text = @"待抢单";
        self.statusImgView.image = [UIImage imageNamed:@"djd"];
        _countDownForBtn = [[CountDown alloc] init];
        NSString *newdata = [NSString getCurrentTimes];
        long long startLongLong = [newdata longLongValue];
        
        NSInteger str = [NSString timeSwitchTimestamp:_model.stayTaskTime];
         [self startLongLongStartStamp:startLongLong longlongFinishStamp:[_model.stayTaskTimestamp longLongValue]];
    }else if(_model.taskStatus == 3){
        self.stateLabel.text = @"已接单";
        self.statusImgView.image = [UIImage imageNamed:@"sc_yfh"];
    }
//    else if(_model.taskStatus == 5){//已转单
//        self.stateLabel.text = @"交易关闭";
//        self.statusImgView.image = [UIImage imageNamed:@"sc-qxdd"];
//        
//    }
    else{
        self.stateLabel.text = @"交易成功";
        self.statusImgView.image = [UIImage imageNamed:@"sc_jycc"];
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
   
    self.timelable.text = FORMAT(@"%@:%@",minuteStr,secondStr);
   
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIColorFromRGB(0x443415);
    }
    return _bottomView;
}
-(UIImageView *)statusImgView{
    if (!_statusImgView) {
        _statusImgView = [[UIImageView alloc]init];
//        _statusImgView.backgroundColor = [UIColor redColor];
    }
    return _statusImgView;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
       
    }
    return _stateLabel;
}
-(UILabel *)timelable{
    if(!_timelable){
        _timelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#ffffff"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont boldFontWithFontSize:CGFloatBasedI375(16)] text:@"00:00"];
    }
    return _timelable;
}
@end





@interface LLStockOrderDetailFooterView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *brokerageLabel;
@property (nonatomic,strong)UILabel *brokerageText;
@property (nonatomic,strong)UILabel *serviceLabel;
@property (nonatomic,strong)UILabel *serviceText;

@property (nonatomic,strong)UILabel *noteLabel;
@end

@implementation LLStockOrderDetailFooterView

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
    
    [self.bottomView addSubview:self.brokerageLabel];
    [self.bottomView addSubview:self.brokerageText];
    [self.bottomView addSubview:self.serviceLabel];
    [self.bottomView addSubview:self.serviceText];
    [self.bottomView addSubview:self.noteLabel];
    
    [self.brokerageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(20));
    }];
    
    [self.brokerageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.brokerageLabel);
    }];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.brokerageLabel.mas_bottom).offset(CGFloatBasedI375(20));
    }];
    
    
    [self.serviceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.centerY.mas_equalTo(self.serviceLabel);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(self.serviceLabel.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    self.brokerageText.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.judgeTaskPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ UIColorFromRGB(0x443415), UIColorFromRGB(0x443415)]];
    self.serviceText.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.deliveryFeePrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ UIColorFromRGB(0x443415), UIColorFromRGB(0x443415)]];
    if(_model.orderType == 1 && _model.expressType.integerValue == 2){//同城
        NSString *notice = @"满1000";
        if(_model.totalPrice.floatValue < 1000){
            notice = @"不满1000";
        }
        self.serviceText.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.freight.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ UIColorFromRGB(0x443415), UIColorFromRGB(0x443415)]];

        self.noteLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前订单",FORMAT(@"%@",notice),@"，满足",FORMAT(@"%@",@"同城20KM"),@"内，支付",FORMAT(@"%.2f",_model.freight.floatValue),@"配送费配送"]  colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color]];
        
    }else{
    

    self.noteLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",FORMAT(@"%@",@"5-10KM"),@"服务范围内加价",FORMAT(@"%@",@"10.00元"),@"配送费；"]  colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color]];
    NSString *deliveryFeePrice = FORMAT(@"加价%.2f元",_model.deliveryFeePrice.length <=0?0.00:_model.deliveryFeePrice.floatValue);

    if(_model.feePriceSize == 0){//当前收货地址在5KM服务范围内￥0.00元配送费；
        self.noteLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",@"5KM",@"服务范围内",deliveryFeePrice,@"配送费；"]  colors:@[UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999)]];
    }else if(_model.feePriceSize == 1){//当前收货地址在5-10KM服务范围内加价￥10.00元配送费；
        self.noteLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",@"5-10KM",@"服务范围内",deliveryFeePrice,@"配送费；"]  colors:@[UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999)]];
    }else{
        self.noteLabel.attributedText = [self getAttribuStrWithStrings:@[@"当前收货地址在",@"10-15KM",@"服务范围内",deliveryFeePrice,@"配送费；"]  colors:@[UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999), Main_Color,UIColorFromRGB(0x999999)]];
    }
    }

}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(10), 0, SCREEN_WIDTH - CGFloatBasedI375(20), CGFloatBasedI375(107))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(5), CGFloatBasedI375(5))];

       CAShapeLayer *cornerRadiusLayer = [ [CAShapeLayer alloc ] init];
       cornerRadiusLayer.frame = self.bottomView.bounds;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        self.bottomView.layer.mask = cornerRadiusLayer;
    }
    return _bottomView;
}

-(UILabel *)brokerageLabel{
    if (!_brokerageLabel) {
        _brokerageLabel = [[UILabel alloc]init];
        _brokerageLabel.textColor = UIColorFromRGB(0x443415);
        _brokerageLabel.textAlignment = NSTextAlignmentLeft;
        _brokerageLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _brokerageLabel.text = @"商品佣金";
    }
    return _brokerageLabel;
}
-(UILabel *)brokerageText{
    if (!_brokerageText) {
        _brokerageText = [[UILabel alloc]init];
        _brokerageText.textColor = UIColorFromRGB(0x443415);
        _brokerageText.textAlignment = NSTextAlignmentRight;
        _brokerageText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _brokerageText.text = @"¥0.00";
    }
    return _brokerageText;
}
-(UILabel *)serviceLabel{
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc]init];
        _serviceLabel.textColor = UIColorFromRGB(0x443415);
        _serviceLabel.textAlignment = NSTextAlignmentLeft;
        _serviceLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _serviceLabel.text = @"配送服务费";
    }
    return _serviceLabel;
}
-(UILabel *)serviceText{
    if (!_serviceText) {
        _serviceText = [[UILabel alloc]init];
        _serviceText.textColor = UIColorFromRGB(0x443415);
        _serviceText.textAlignment = NSTextAlignmentRight;
        _serviceText.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _serviceText.text = @"¥0.00";
    }
    return _serviceText;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x999999);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _noteLabel.text = @"当前收货地址在5-15KM服务范围内加价10.00元配送费";
    }
    return _noteLabel;
}



@end




@interface LLStockOrderBottomView ()

@property (nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *timelable;
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property(nonatomic,strong)UILabel *stocklable;
@property (nonatomic,strong) UIButton *sureButton1;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton2;/** <#class#> **/
@property (nonatomic,strong) CountDown *countDownForBtn;/** <#class#> **/

@end

@implementation LLStockOrderBottomView

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
    WS(weakself);
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(10));
        make.right.equalTo(weakself.sureButton2.mas_left).offset(-CGFloatBasedI375(5));

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
        make.right.equalTo(weakself.sureButton.mas_left).offset(-CGFloatBasedI375(12));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
    }];

}
-(void)setModel:(LLGoodModel *)model{
    _model = model;

    self.sureButton1.hidden = YES;
    self.sureButton2.hidden = YES;
    self.stocklable.hidden = YES;
    self.sureButton.userInteractionEnabled = YES;
    WS(weakself);
//    [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakself.sureButton.mas_left).offset(-CGFloatBasedI375(2));
//    }];
    if(_model.taskStatus == 2 || _model.taskStatus == 5){//抢单
        self.stocklable.hidden = NO;
        self.sureButton.backgroundColor = Main_Color;
        self.sureButton.layer.borderColor = [Main_Color CGColor];
        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
        [self.sureButton setTitle:@"抢单" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        LLGoodModel *listmodel = [_model.appOrderListGoodsVos firstObject];
        if(_model.stock.integerValue == 0 || _model.stock.integerValue < listmodel.goodsNum.integerValue){
            self.sureButton.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
            self.sureButton.userInteractionEnabled = NO;
            self.sureButton.layer.borderColor = [[UIColor clearColor] CGColor];
            self.sureButton.layer.borderWidth = CGFloatBasedI375(0);
            [self.sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        }
        self.stocklable.text = FORMAT(@"库存:%@",_model.stock);
        self.timelable.text = FORMAT(@"配送时间%@分钟",_model.expressTime);  
    }else if(_model.taskStatus == 3){
        self.timelable.text = FORMAT(@"还剩%@分钟",_model.expressTime);

        self.stocklable.hidden = YES;
        self.sureButton1.hidden = NO;
        self.sureButton2.hidden = NO;
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
        _countDownForBtn = [[CountDown alloc] init];
        NSString *newdata = [NSString getCurrentTimes];
        long long startLongLong = [newdata longLongValue];
        NSInteger str = [NSString timeSwitchTimestamp:_model.taskPlanTime];
        NSLog(@"newdata == %@",newdata);
        NSLog(@"_model.next_time == %ld",str);
        [self getNowTimeWithString:_model];
         [self startLongLongStartStamp:startLongLong longlongFinishStamp:[_model.taskPlanTimestamp longLongValue]];
        [self.timelable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakself.sureButton2.mas_left).offset(-CGFloatBasedI375(2));
        }];
    }
//    else if(_model.taskStatus == 5){//已转单
//        self.stocklable.hidden = YES;
//        self.timelable.hidden = YES;
//        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
//        self.sureButton.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
//        self.sureButton.userInteractionEnabled = NO;
//        self.sureButton.layer.borderColor = [[UIColor clearColor] CGColor];
//        self.sureButton.layer.borderWidth = CGFloatBasedI375(0);
//        [self.sureButton setTitle:@"已转单" forState:UIControlStateNormal];
//
//    }
    else{
        
        self.stocklable.hidden = YES;
        self.sureButton.backgroundColor = [UIColor clearColor];
        [self.sureButton setTitle:@"查看佣金" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:BlackTitleFont443415 forState:UIControlStateNormal];
        self.sureButton.layer.borderColor = [lightGray9999_Color CGColor];
        self.sureButton.layer.borderWidth = CGFloatBasedI375(.5f);
        NSString *times =_model.completeTime;
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




}
#pragma mark 已转单 倒计时
-(void)getNowTimeWithString:(LLGoodModel *)models{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger strend = [NSString timeSwitchTimestamp:models.taskTimestamp]+300;
    NSString *newdata = [NSString getCurrentTimes];
    NSInteger startLongLong = [newdata integerValue];
    if(strend- startLongLong <= 0){
        self.sureButton2.hidden = YES;
    }
    NSTimeInterval time=strend+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];


//    NSInteger str = [NSString timeSwitchTimestamp:models.taskTime];
    // 截止时间date格式
    NSDate  *expireDate = [NSDate dateForString:currentDateStr];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
  
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];

    NSInteger days = (NSInteger)(timeInterval/(3600*24));
    NSInteger hours = (NSInteger)((timeInterval-days*24*3600)/3600);
    NSInteger minutes = (NSInteger)(timeInterval-days*24*3600-hours*3600)/60;
    NSInteger seconds = (NSInteger)(timeInterval-days*24*3600-hours*3600-minutes*60);
    NSLog(@"timeInterval == %ld",minutes);
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;

    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%ld",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%ld",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%ld", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%ld",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        self.sureButton2.hidden = YES;
    }
//    return [NSString stringWithFormat:@"%@:%@",minutesStr,secondsStr];
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

        self.timelable.text = FORMAT(@"还剩%@:%@",minuteStr,secondStr);
    if(minute <=0 &&  second <= 0 && hour <=0){
        self.timelable.text = @"订单已超时";
        self.timelable.textColor = Main_Color;
    }
    //    self.titlelable.text =FORMAT(@"请在%@%@%@%@内完成付款",dayStr, hourStr,minuteStr,secondStr);
    
}
-(void)clickTap:(UIButton *)sender{
    if(self.tapAction){
        self.tapAction(_model, sender.titleLabel.text);
    }
}

-(UILabel *)timelable{
    if(!_timelable){
        _timelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(15) font:[UIFont boldFontWithFontSize:CGFloatBasedI375(16)] text:@"配送时间0分钟"];
        [self addSubview:self.timelable];
    }
    return _timelable;
}
-(UILabel *)stocklable{
    if(!_stocklable){
        _stocklable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentRight numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"库存:0"];
        [self addSubview:self.stocklable];
    }
    return _stocklable;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton.layer.masksToBounds = YES;
        [_sureButton setTitle:@"抢单" forState:UIControlStateNormal];
//        _sureButton.backgroundColor = Main_Color;
        _sureButton.layer.borderColor =[Main_Color CGColor];
        _sureButton.layer.borderWidth = 1.f;
        [_sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureButton];
    }
    return _sureButton;
}
-(UIButton *)sureButton1{
    if(!_sureButton1){
        _sureButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton1.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton1.layer.masksToBounds = YES;
        [_sureButton1 setTitle:@"联系客户" forState:UIControlStateNormal];
   
        _sureButton1.layer.borderWidth = 1.f;
        _sureButton1.hidden = YES;
        _sureButton1.layer.borderColor =[lightGray9999_Color CGColor];
        [_sureButton1 setTitleColor:[UIColor colorWithHexString:@"#443415"] forState:UIControlStateNormal];
        _sureButton1.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [_sureButton1 addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureButton1];
    }
    return _sureButton1;
}
-(UIButton *)sureButton2{
    if(!_sureButton2){
        _sureButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton2.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton2.layer.masksToBounds = YES;
        [_sureButton2 setTitle:@"转单" forState:UIControlStateNormal];
        _sureButton2.layer.borderColor =[lightGray9999_Color CGColor];
        _sureButton2.layer.borderWidth = 1.f;
        _sureButton2.hidden = YES;
        [_sureButton2 setTitleColor:[UIColor colorWithHexString:@"#443415"] forState:UIControlStateNormal];
        _sureButton2.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [_sureButton2 addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureButton2];
    }
    return _sureButton2;
}
@end
