//
//  LLStorePayHeadView.m
//  Winner
//
//  Created by mac on 2022/2/3.
//

#import "LLStorePayHeadView.h"
#import "CountDown.h"
#import "NSString+Extension.h"
@interface LLStorePayHeadView ()
@property(nonatomic,strong)UIImageView *showimage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UILabel *deLabel;
@property(nonatomic,strong)UIImageView *allowImage;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (strong, nonatomic)  CountDown *countDownForBtn;

@end
@implementation LLStorePayHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    
    [self.showimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(30));
        make.width.height.offset(CGFloatBasedI375(85));
        make.centerX.equalTo(weakself.mas_centerX);
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(CGFloatBasedI375(-10));
        make.top.equalTo(weakself.showimage.mas_bottom).mas_equalTo(CGFloatBasedI375(20));
    }];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titlelable.mas_bottom).mas_equalTo(CGFloatBasedI375(15));
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(CGFloatBasedI375(-10));
    }];
    [self.deLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.pricelable.mas_bottom).mas_equalTo(CGFloatBasedI375(10));
        make.width.offset(CGFloatBasedI375(130));
        make.height.offset(CGFloatBasedI375(24));
        make.centerX.equalTo(weakself.mas_centerX);
    }];
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _countDownForBtn = [[CountDown alloc] init];
    _titlelable.text = FORMAT(@"订单号:%@",_dataDic[@"orderNo"]);
    self.pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",[_dataDic[@"payPrice"] floatValue])] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(20)], [UIFont boldFontWithFontSize:CGFloatBasedI375(30)]] colors:@[ Main_Color, Main_Color]];

    NSString *newdata = [NSString getCurrentTimes];
    long long startLongLong = [newdata longLongValue];
    [self startLongLongStartStamp:startLongLong longlongFinishStamp:[_dataDic[@"stayPayTimestamp"] longLongValue]];
}
-(void)setTimeDic:(NSDictionary *)timeDic{
    _timeDic = timeDic;
    self.pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",[_timeDic[@"totalPrice"] floatValue])] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(20)], [UIFont boldFontWithFontSize:CGFloatBasedI375(30)]] colors:@[ Main_Color, Main_Color]];
    NSInteger orderStatus = [FORMAT(@"%@",_timeDic[@"orderStatus"]) integerValue];
    if(orderStatus == 1){
        self.pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",[_timeDic[@"actualPrice"] floatValue])] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(20)], [UIFont boldFontWithFontSize:CGFloatBasedI375(30)]] colors:@[ Main_Color, Main_Color]];

    }
       
    _titlelable.text = FORMAT(@"订单号:%@",_timeDic[@"orderNo"]);
    _countDownForBtn = [[CountDown alloc] init];
    NSString *newdata = [NSString getCurrentTimes];
    long long startLongLong = [newdata longLongValue];
//    NSInteger str = [NSString timeSwitchTimestamp:_timeDic[@"stayPayTime"]];
//    long long finishLongLong = [str longLongValue];
    NSLog(@"newdata == %@",newdata);
//    NSLog(@"_model.next_time == %ld",str);

     [self startLongLongStartStamp:startLongLong longlongFinishStamp:[_timeDic[@"stayPayTimestamp"] longLongValue]];
}
-(void)endTimes{
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
    if(minute <=0 && second<= 0 && hour <=0){
        [self.countDownForBtn destoryTimer];
        if(self.tapAction){
            self.tapAction();
        }
    }else{
    _deLabel.text = FORMAT(@"剩余支付时间: %@:%@",minuteStr,secondStr);
    }
//    self.titlelable.text =FORMAT(@"请在%@%@%@%@内完成付款",dayStr, hourStr,minuteStr,secondStr);

}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable = [[UILabel alloc]init];
        _pricelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(30)];
        _pricelable.textAlignment = NSTextAlignmentCenter;
        _pricelable.textColor = BlackTitleFont443415;
        [self addSubview:self.pricelable];
        _pricelable.numberOfLines  = 0;
//        _pricelable.text = @"¥ 268.00";
    }
    return _pricelable;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
        _titlelable.text = @"订单号:20211206014001";
    }
    return _titlelable;
}
-(UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        [self addSubview:_showimage];
        _showimage.image = [UIImage imageNamed:@"syt_logo"];
    }
    return _showimage;
    
}
-(UILabel *)deLabel{
    if (!_deLabel) {
        _deLabel = [[UILabel alloc]init];
        _deLabel.textColor = UIColorFromRGB(0xffffff);
        _deLabel.textAlignment = NSTextAlignmentCenter;
        _deLabel.backgroundColor = Main_Color;
        _deLabel.layer.masksToBounds = YES;
        _deLabel.layer.cornerRadius = CGFloatBasedI375(12);
        _deLabel.text = @"剩余支付时间: ";
        _deLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self addSubview:_deLabel];
    }
    return _deLabel;
}
@end
@interface LLStorePaySuccessHeadView ()
@property(nonatomic,strong)UIImageView *showimage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UILabel *deLabel;
@property(nonatomic,strong)UIImageView *allowImage;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@end
@implementation LLStorePaySuccessHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    
    [self.showimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(40));
        make.width.offset(CGFloatBasedI375(105));
        make.height.offset(CGFloatBasedI375(92));
        make.centerX.equalTo(weakself.mas_centerX);
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(CGFloatBasedI375(-10));
        make.top.equalTo(weakself.showimage.mas_bottom).mas_equalTo(CGFloatBasedI375(20));
    }];

}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(18)];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.textColor = BlackTitleFont443415;
        [self addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
        _titlelable.text = @"支付成功";
    }
    return _titlelable;
}
-(UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        [self addSubview:_showimage];
        _showimage.image = [UIImage imageNamed:@"zfcg"];
    }
    return _showimage;
    
}

@end
@interface LLPayViewStyleCell ()
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@end
@implementation LLPayViewStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setLayout];
    }
    return self;
}
//-(void)setModel:(LLGoodModel *)model{
//    _model = model;
//    if([_model.logo containsString:@"http"]){
//    [self.showimage sd_setImageWithUrlString:FORMAT(@"%@",_model.logo) placeholderImage:[UIImage imageNamed:morenpic]];
//    }else{
//        self.showimage.image = [UIImage imageNamed:_model.logo];
//    }
//        self.titlelable.text = _model.bank_name;
//}
-(void)setIsSelects:(BOOL)isSelects{
    _isSelects = isSelects;
    self.sureButton.selected  = _isSelects;
}
-(void)setLayout{
    WS(weakself);
    
    [self.showimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(20));
        make.width.height.offset(CGFloatBasedI375(30));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showimage.mas_right).offset(CGFloatBasedI375(10));
        make.right.offset(CGFloatBasedI375(-100));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.width.mas_equalTo(CGFloatBasedI375(20));
        make.height.mas_equalTo(CGFloatBasedI375(20));
    }];
  
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.right.equalTo(weakself.sureButton.mas_left).offset(CGFloatBasedI375(-10));
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(1));
    }];
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
-(UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        [self.contentView addSubview:_showimage];

    }
    return _showimage;
    
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel *)deLabel{
    if (!_deLabel) {
        _deLabel = [[UILabel alloc]init];
        _deLabel.textColor = UIColorFromRGB(0x666666);
        _deLabel.textAlignment = NSTextAlignmentLeft;
        _deLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.contentView addSubview:_deLabel];
    }
    return _deLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = UIColorFromRGB(0x999999);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setImage:[UIImage imageNamed:@"xz_gray"] forState:UIControlStateNormal];
        [_sureButton setImage:[UIImage imageNamed:@"xz_red"] forState:UIControlStateSelected];
        _sureButton.userInteractionEnabled = NO;
//        [_sureButton addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureButton];
    }
    return _sureButton;
}
@end
