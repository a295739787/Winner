//
//  LLOrderDeliverCell.m
//  ShopApp
//
//  Created by lijun L on 2021/5/21.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLOrderDeliverCell.h"
@interface LLOrderDeliverCell ()
@property (nonatomic,strong) UIView *topView;/** <#class#> **/
@property (nonatomic,strong) UIView *boView;/** <#class#> **/
@property (nonatomic,strong) UILabel *timeLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *dayLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *contentLabel;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UILabel *stausLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/

@end
@implementation LLOrderDeliverCell

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
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.width.height.mas_equalTo(CGFloatBasedI375(10));
        make.top.offset(CGFloatBasedI375(10));
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(0));
        make.centerX.equalTo(weakself.showImage.mas_centerX);
        make.bottom.equalTo(weakself.showImage.mas_top).offset(-CGFloatBasedI375(0));
        make.width.offset(CGFloatBasedI375(1));
    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(CGFloatBasedI375(0));
        make.centerX.equalTo(weakself.showImage.mas_centerX);
        make.top.equalTo(weakself.showImage.mas_bottom).offset(CGFloatBasedI375(0));
        make.width.offset(CGFloatBasedI375(1));
    }];

   
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(15));
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(15));
        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.offset(-CGFloatBasedI375(10));
        ;
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.contentLabel.mas_left).offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(.5f));
        make.bottom.offset(CGFloatBasedI375(0));
    }];
}
-(void)setDatas:(NSDictionary *)datas{
    _datas = datas;
    self.timeLabel.text = _datas[@"time"];
    self.contentLabel.text = _datas[@"status"];
}

-(void)setIndexs:(NSInteger)indexs{
    _indexs =indexs;
//    if(_indexs == 0){
//        self.showImage.image = [UIImage imageNamed:@"sh"];
//    }else if(_indexs == 1){
//        self.showImage.image = [UIImage imageNamed:@"yqs"];
//    }else if(_indexs == 2){
//        self.showImage.image = [UIImage imageNamed:@"psz"];
//    }else if(_indexs == 3){
//        self.showImage.image = [UIImage imageNamed:@"ysz"];
//    }else if(_indexs == 4){
//        self.showImage.image = [UIImage imageNamed:@"yxd"];
//    }
}
- (UIView *)boView{
    if(!_boView){
        _boView = [[UIView alloc]init];
        _boView.backgroundColor = BG_Color;
        [self.contentView addSubview:_boView];
    }
    return _boView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.backgroundColor =BG_Color;
        _showImage.layer.masksToBounds = YES;
        _showImage.layer.cornerRadius = CGFloatBasedI375(5);
//        _showImage.image = [UIImage imageNamed:morenpic];
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}
- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = BG_Color;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = Black_Color;
        _timeLabel.text = @"11111";
        _timeLabel.numberOfLines = 0;
        [self.contentView addSubview:self.timeLabel];
    }
    return _timeLabel;
}
-(UILabel *)stausLabel{
    if(!_stausLabel){
        _stausLabel = [[UILabel alloc]init];
        _stausLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _stausLabel.textAlignment = NSTextAlignmentLeft;
        _stausLabel.textColor = lightGray9999_Color;
        _stausLabel.text = @"11111";
        _stausLabel.numberOfLines = 0;
        [self.contentView addSubview:self.stausLabel];
    }
    return _stausLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"11111";
        [self.contentView addSubview:self.contentLabel];
    }
    return _contentLabel;
}
-(UILabel *)dayLabel{
    if(!_dayLabel){
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _dayLabel.textAlignment = NSTextAlignmentLeft;
        _dayLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _dayLabel.text = @"11111";
        [self.contentView addSubview:self.dayLabel];
    }
    return _dayLabel;
}
@end
@interface LLOrderDeliverTopCell ()
@property (nonatomic,strong) UIView *topView;/** <#class#> **/


@end
@implementation LLOrderDeliverTopCell

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
        self.backgroundColor = [UIColor clearColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(0));
        make.left.offset(CGFloatBasedI375(0));
        make.right.offset(-CGFloatBasedI375(0));
        make.bottom.offset(-CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(140));
    }];
    [self creatButton];
}
#define btnTags 200
-(void)setDatas:(NSDictionary *)datas{
    _datas = datas;
    UILabel *label2 = [self viewWithTag:btnTags+1];
    label2.text = FORMAT(@"承运公司：%@",_datas[@"expName"]);
    
    UILabel *label3 = [self viewWithTag:btnTags+2];
    label3.text = FORMAT(@"快递编号：%@",_datas[@"number"]);
    
    UILabel *label4 = [self viewWithTag:btnTags+3];
    label4.text = FORMAT(@"发货时间：%@",_datas[@"updateTime"]);
    
    UILabel *label1 = [self viewWithTag:btnTags];
    
    //投递状态 0快递收件(揽件)1.在途中 2.正在派件 3.已签收 4.派送失败 5.疑难件 6.退件签收
    NSInteger deliverystatus = [FORMAT(@"%@",_datas[@"deliverystatus"])integerValue];
    NSString *str;
    if(deliverystatus == 0){
        str = @"快递收件(揽件)";
    }else if(deliverystatus == 1){
        str = @"在途中";
    }else if(deliverystatus == 2){
        str = @"正在派件";
    }else if(deliverystatus == 3){
        str = @"已签收";
    }else if(deliverystatus == 4){
        str = @"派送失败";
    }else if(deliverystatus == 5){
        str = @"疑难件";
    }else if(deliverystatus == 6){
        str = @"退件签收";
    }
    label1.text = FORMAT(@"物流状态：%@",str);
}

-(void)creatButton{
    [self layoutIfNeeded];
    for(UILabel *btn in self.topView.subviews){
        [btn removeFromSuperview];
    }
    NSArray *tiles = @[@"物流状态：",@"承运公司：",@"快递编号：",@"发货时间："];
    for (int i = 0; i < tiles.count; i++) {
        CGFloat w = SCREEN_WIDTH-CGFloatBasedI375(70);
        CGFloat h = CGFloatBasedI375(30);
        CGFloat x =CGFloatBasedI375(15);
        CGFloat y = CGFloatBasedI375(10)+(h + CGFloatBasedI375(0))*(i% tiles.count);
        UILabel *button = [[UILabel alloc]init];;
        button.text = tiles[i];
        button.tag = btnTags+i;
        button.frame = CGRectMake(x, y, w, h);
        button.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        button.textAlignment = NSTextAlignmentLeft;
        button.textColor = BlackTitleFont443415;
        [self.topView addSubview:button];
        button.numberOfLines  = 0;
        
    }
}
-(void)setIndexs:(NSInteger)indexs{
    _indexs =indexs;
//    if(_indexs == 0){
//        self.showImage.image = [UIImage imageNamed:@"sh"];
//    }else if(_indexs == 1){
//        self.showImage.image = [UIImage imageNamed:@"yqs"];
//    }else if(_indexs == 2){
//        self.showImage.image = [UIImage imageNamed:@"psz"];
//    }else if(_indexs == 3){
//        self.showImage.image = [UIImage imageNamed:@"ysz"];
//    }else if(_indexs == 4){
//        self.showImage.image = [UIImage imageNamed:@"yxd"];
//    }
}

- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = White_Color;
        [self.contentView addSubview:_topView];
        _topView.layer.masksToBounds = YES;
        _topView.layer.cornerRadius = CGFloatBasedI375(4);
    }
    return _topView;
}

@end
@interface LLGoodcarDetCell ()
@property (nonatomic,strong) UILabel *titlelable;/** <#class#> **/
@property (nonatomic,strong) UILabel *dayLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *contentLabel;/** <#class#> **/

@end
@implementation LLGoodcarDetCell

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
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);

    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.width.mas_equalTo(CGFloatBasedI375(190));
        make.centerY.equalTo(weakself.contentView.mas_centerY);

    }];
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-CGFloatBasedI375(10));
            make.centerY.equalTo(weakself.contentView.mas_centerY);

        }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titlelable.mas_right).offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.right.equalTo(weakself.dayLabel.mas_left).offset(-CGFloatBasedI375(5));


        ;
    }];

}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
//    self.titlelable.text =_model.goods_name;
//    self.dayLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.goods_amount.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ [UIColor colorWithHexString:@"#333333"], [UIColor colorWithHexString:@"#333333"]]];
//    self.contentLabel.text = FORMAT(@"x%@",_model.num);
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.titlelable];
        _titlelable.numberOfLines = 2;
    }
    return _titlelable;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        _contentLabel.text = @"111111111";
    }
    return _contentLabel;
}
-(UILabel *)dayLabel{
    if(!_dayLabel){
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _dayLabel.textAlignment = NSTextAlignmentLeft;
        _dayLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.dayLabel];
        _dayLabel.text = @"111111111";
    }
    return _dayLabel;
}
@end
@interface LLGoodcarDeView ()
@property (nonatomic,strong) UILabel *titlelable;/** <#class#> **/
@property (nonatomic,strong) UILabel *dayLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *contentLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *orderlable;/** <#class#> **/

@end
@implementation LLGoodcarDeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setLayout];
    }
    return self;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
//    self.orderlable.text = FORMAT(@"下单时间：%@",_model.order.created_at);
}
-(void)setLayout{
    WS(weakself);
    [self.orderlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(40));
        make.top.offset(CGFloatBasedI375(0));

    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.width.mas_equalTo(CGFloatBasedI375(190));
        make.top.equalTo(weakself.orderlable.mas_bottom).offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(40));

    }];
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-CGFloatBasedI375(10));
            make.centerY.equalTo(weakself.titlelable.mas_centerY);

        }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titlelable.mas_right).offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.titlelable.mas_centerY);
        make.right.equalTo(weakself.dayLabel.mas_left).offset(-CGFloatBasedI375(5));


        ;
    }];

}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.titlelable];
        _titlelable.numberOfLines = 2;
        _titlelable.text = @"产品";
    }
    return _titlelable;
}

-(UILabel *)orderlable{
    if(!_orderlable){
        _orderlable = [[UILabel alloc]init];
        _orderlable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _orderlable.textAlignment = NSTextAlignmentCenter;
        _orderlable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.orderlable];
        _orderlable.numberOfLines = 2;
        _orderlable.backgroundColor  = [UIColor whiteColor];
        _orderlable.text = @"下单时间：";
    }
    return _orderlable;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(14)];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
        _contentLabel.text = @"数量";
    }
    return _contentLabel;
}
-(UILabel *)dayLabel{
    if(!_dayLabel){
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(14)];
        _dayLabel.textAlignment = NSTextAlignmentLeft;
        _dayLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.dayLabel];
        _dayLabel.text = @"单价";
    }
    return _dayLabel;
}
@end
