//
//  LLReturnServiceDetailHeadView.m
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLReturnServiceDetailHeadView.h"
@interface LLReturnServiceDetailHeadView ()
@property (nonatomic,strong) UIView *topView;/** <#class#> **/
@property (nonatomic,strong) UILabel *label1;/** <#class#> **/
@property (nonatomic,strong) UILabel *noticeLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *label2;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *coview1;/** <#class#> **/
@property (nonatomic,strong) UIView *coview2;/** <#class#> **/
@property (nonatomic,strong) UIView *coview3;/** <#class#> **/
@property (nonatomic,strong) UILabel *colabel1;/** <#class#> **/
@property (nonatomic,strong) UILabel *colabel2;/** <#class#> **/
@property (nonatomic,strong) UILabel *colabel3;/** <#class#> **/
@property (nonatomic,strong) UIButton *chatBtn;/** <#class#> **/
@property (nonatomic,strong) UIButton *phoneBtn;/** <#class#> **/
@property (nonatomic,strong) UIButton *kehuBtn;/** <#class#> **/

@end
@implementation LLReturnServiceDetailHeadView

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
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(58));
        make.top.mas_equalTo(CGFloatBasedI375(0));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(-CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(2));
        make.top.equalTo(weakself.noticeLabel.mas_bottom).mas_equalTo(CGFloatBasedI375(0));
    }];
    [self.coview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.mas_equalTo(CGFloatBasedI375(4));
        make.height.mas_equalTo(CGFloatBasedI375(4));
        make.top.equalTo(weakself.lineView.mas_bottom).mas_equalTo(CGFloatBasedI375(19));
    }];
    [self.colabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.coview1.mas_right).mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.coview1.mas_centerY);
    }];
    [self.coview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.mas_equalTo(CGFloatBasedI375(4));
        make.height.mas_equalTo(CGFloatBasedI375(4));
        make.top.equalTo(weakself.coview1.mas_bottom).mas_equalTo(CGFloatBasedI375(16));
    }];
    [self.colabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.coview2.mas_right).mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.coview2.mas_centerY);
    }];
    [self.coview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.width.mas_equalTo(CGFloatBasedI375(4));
        make.height.mas_equalTo(CGFloatBasedI375(4));
        make.top.equalTo(weakself.coview2.mas_bottom).mas_equalTo(CGFloatBasedI375(16));
    }];
    [self.colabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.coview3.mas_right).mas_equalTo(CGFloatBasedI375(10));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.equalTo(weakself.coview3.mas_top).mas_equalTo(-CGFloatBasedI375(5));
    }];
//    [self.phoneBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-CGFloatBasedI375(15));
//        make.height.mas_equalTo(CGFloatBasedI375(28));
//        make.width.mas_equalTo(CGFloatBasedI375(75));
//        make.top.equalTo(weakself.colabel3.mas_bottom).offset(CGFloatBasedI375(15));
//    }];
//    [self.chatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakself.kehuBtn.mas_left).offset(-CGFloatBasedI375(10));
//        make.height.mas_equalTo(CGFloatBasedI375(28));
//        make.width.mas_equalTo(CGFloatBasedI375(75));
//        make.centerY.equalTo(weakself.kehuBtn.mas_centerY);
//    }];
//    [self.phoneBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakself.chatBtn.mas_left).offset(-CGFloatBasedI375(10));
//        make.height.mas_equalTo(CGFloatBasedI375(28));
//        make.width.mas_equalTo(CGFloatBasedI375(75));
//        make.centerY.equalTo(weakself.kehuBtn.mas_centerY);
//    }];

    
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
//     [self startLongLongStartStamp:startLongLong longlongFinishStamp:finishLongLong];
    
}

-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSString *dayStr;
    NSString *hourStr;
    NSString *minuteStr;
    NSString *secondStr;

    if (day==0) {
        dayStr = @"0天";
    }else{
        dayStr = [NSString stringWithFormat:@"%ld天",(long)day];
    }
    if (hour<10&&hour) {
        hourStr = [NSString stringWithFormat:@"0%ld时",(long)hour];
    }else{
        hourStr= [NSString stringWithFormat:@"%ld时",(long)hour];
    }
    if (minute<10) {
        minuteStr= [NSString stringWithFormat:@"0%ld分",(long)minute];
    }else{
        minuteStr = [NSString stringWithFormat:@"%ld分",(long)minute];
    }
    if (second<10) {
        secondStr= [NSString stringWithFormat:@"0%ld秒",(long)second];
    }else{
        secondStr = [NSString stringWithFormat:@"%ld秒",(long)second];
    }
    self.label2.text =FORMAT(@"还剩%@%@%@%@",dayStr,hourStr, minuteStr,secondStr);

}
/*
 RefundNormal uint8 = 1        //    申请退款
     RefundAgree uint8 = 2            //    同意退款
     RefundExpress uint8 = 3        //    买家已发货
     RefundReject uint8 = 50        //    拒绝退款
     RefundBuyerAppeal uint8 = 60    //    买家申诉
     RefundSellerAppeal uint8 = 61    //    商家申诉
     RefundCancel uint8 = 20        //    取消退款
     RefundComplete uint8 = 100    //    退款已完成    [商家收货或商家同意退款(仅限未发货订单)]
 */
-(UILabel *)label1{
    if(!_label1){
        _label1 = [[UILabel alloc]init];
        _label1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _label1.textColor =[UIColor colorWithHexString:@"#ffffff"];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.userInteractionEnabled = YES;
        [self.topView addSubview:self.label1];
        _label1.text = @"";
    }
    return _label1;
}
-(UILabel *)label2{
    if(!_label2){
        _label2 = [[UILabel alloc]init];
        _label2.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _label2.textColor =[UIColor colorWithHexString:@"#ffffff"];
        _label2.textAlignment = NSTextAlignmentLeft;
        _label2.userInteractionEnabled = YES;
        [self.topView addSubview:self.label2];
  
    }
    return _label2;
}
-(UILabel *)colabel1{
    if(!_colabel1){
        _colabel1 = [[UILabel alloc]init];
        _colabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _colabel1.textColor =[UIColor colorWithHexString:@"#999999"];
        _colabel1.textAlignment = NSTextAlignmentLeft;
        _colabel1.userInteractionEnabled = YES;
        [self addSubview:self.colabel1];
        _colabel1.numberOfLines = 2;
        _colabel1.text = @"商家同意后，请按照给出的退货地址，并记录退货运单号";
    }
    return _colabel1;
}
-(UILabel *)colabel2{
    if(!_colabel2){
        _colabel2 = [[UILabel alloc]init];
        _colabel2.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _colabel2.textColor =[UIColor colorWithHexString:@"#999999"];
        _colabel2.textAlignment = NSTextAlignmentLeft;
        _colabel2.userInteractionEnabled = YES;
        [self addSubview:self.colabel2];
        _colabel2.numberOfLines = 2;
        _colabel2.text = @"如商家拒绝，您可以修改申请后再次发起，商家会重新处理";
    }
    return _colabel2;
}
-(UILabel *)colabel3{
    if(!_colabel3){
        _colabel3 = [[UILabel alloc]init];
        _colabel3.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _colabel3.textColor =[UIColor colorWithHexString:@"#999999"];
        _colabel3.textAlignment = NSTextAlignmentLeft;
        _colabel3.userInteractionEnabled = YES;
        [self addSubview:self.colabel3];
        _colabel3.numberOfLines = 2;
        _colabel3.text = @"如商家超时未处理，退货申请将达成，请按系统给出的退货地 址退货";
    }
    return _colabel3;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel *)noticeLabel{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _noticeLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
        _noticeLabel.userInteractionEnabled = YES;
        [self addSubview:self.noticeLabel];
        _noticeLabel.numberOfLines = 2;
        self.noticeLabel.attributedText = [self getAttribuStrWithStrings:@[@"您已成功发起退款申请，请耐心等待商家处理，",@"商家同意退货后， 选择上门取件，慢必赔"] colors:@[[UIColor colorWithHexString:@"#333333"],Main_Color]];
        [UILabel changeLineSpaceForLabel:_noticeLabel WithSpace:4];
    }
    return _noticeLabel;
}
- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = Main_Color;
        [self addSubview:_topView];
    }
    return _topView;
}
- (UIView *)coview1{
    if(!_coview1){
        _coview1 = [[UIView alloc]init];
        _coview1.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _coview1.layer.masksToBounds = YES;
        _coview1.layer.cornerRadius = CGFloatBasedI375(2);
        [self addSubview:_coview1];
    }
    return _coview1;
}
- (UIView *)coview2{
    if(!_coview2){
        _coview2 = [[UIView alloc]init];
        _coview2.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _coview2.layer.masksToBounds = YES;
        _coview2.layer.cornerRadius = CGFloatBasedI375(2);
        [self addSubview:_coview2];
    }
    return _coview2;
}
- (UIView *)coview3{
    if(!_coview3){
        _coview3 = [[UIView alloc]init];
        _coview3.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _coview3.layer.masksToBounds = YES;
        _coview3.layer.cornerRadius = CGFloatBasedI375(2);
        [self addSubview:_coview3];
    }
    return _coview3;
}
-(UIButton *)chatBtn{
    if(!_chatBtn){
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatBtn setTitle:@"客服介入" forState:UIControlStateNormal];
        [_chatBtn setTitleColor:Black_Color forState:UIControlStateNormal];
        _chatBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _chatBtn.backgroundColor = White_Color;
        _chatBtn.layer.masksToBounds = YES;
        _chatBtn.layer.cornerRadius = CGFloatBasedI375(14);
        _chatBtn.layer.borderColor = [[UIColor colorWithHexString:@"#dddddd"] CGColor];
        _chatBtn.layer.borderWidth = 1.0f;//        [_chatBtn addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.chatBtn];
    }
    return _chatBtn;
}
-(UIButton *)phoneBtn{
    if(!_phoneBtn){
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"撤销申请" forState:UIControlStateNormal];
        [_phoneBtn setTitleColor:Black_Color forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _phoneBtn.backgroundColor = White_Color;
        _phoneBtn.layer.masksToBounds = YES;
        _phoneBtn.layer.cornerRadius = CGFloatBasedI375(14);
        _phoneBtn.layer.borderColor = [[UIColor colorWithHexString:@"#dddddd"] CGColor];
        _phoneBtn.layer.borderWidth = 1.0f;
        [_phoneBtn addTarget:self action:@selector(clickoushda:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.phoneBtn];
    }
    return _phoneBtn;
}
-(void)clickoushda:(UIButton *)sender{
    if(_clickpush){
        self.clickpush(_model, sender.titleLabel.text);
    }
}
-(UIButton *)kehuBtn{
    if(!_kehuBtn){
        _kehuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kehuBtn setTitle:@"修改申请" forState:UIControlStateNormal];
        [_kehuBtn setTitleColor:Main_Color forState:UIControlStateNormal];
        _kehuBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _kehuBtn.backgroundColor = White_Color;
        _kehuBtn.layer.masksToBounds = YES;
        _kehuBtn.layer.cornerRadius = CGFloatBasedI375(14);
        _kehuBtn.layer.borderColor = [Main_Color CGColor];
        _kehuBtn.layer.borderWidth = 1.0f;
//        [_chatBtn addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.kehuBtn];
    }
    return _kehuBtn;
}
@end
@interface LLReturnServiceDetailTopView ()
@property (nonatomic,strong) UIView *topView;/** <#class#> **/
@property (nonatomic,strong) UILabel *label1;/** <#class#> **/
@property (nonatomic,strong) UILabel *label2;/** <#class#> **/

@end
@implementation LLReturnServiceDetailTopView

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
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(75));
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(44));
        make.top.mas_equalTo(CGFloatBasedI375(18));
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(44));
        make.top.equalTo(weakself.label1.mas_bottom).mas_equalTo(CGFloatBasedI375(3));
    }];
 
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    WS(weakself);
    
//    self.label1.text = _model.refund.state_txt;
//    if(_model.refund.state == 20 || _model.refund.state == 90 || _model.refund.state == 60 || _model.refund.state == 4 || _model.refund.state == 61 || _model.refund.state == 100){
//         self.label2.hidden = YES;
//        [self.label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(CGFloatBasedI375(44));
//            make.centerY.equalTo(weakself.topView.mas_centerY);
//        }];
//    }else    if(_model.refund.state == 1 || _model.refund.state == 2 || _model.refund.state == 3 || _model.refund.state == 50){
//        self.label2.hidden = NO;
//
//        NSString *newdata = [NSString getCurrentTimes];
//        long long startLongLong = [newdata longLongValue];
//        long long finishLongLong = [_model.refund.next_time longLongValue];
//         [self startLongLongStartStamp:startLongLong longlongFinishStamp:finishLongLong];
//   }

    
}

-(UILabel *)label1{
    if(!_label1){
        _label1 = [[UILabel alloc]init];
        _label1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _label1.textColor =[UIColor colorWithHexString:@"#ffffff"];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.userInteractionEnabled = YES;
        [self.topView addSubview:self.label1];
        _label1.text = @"请等待商家处理";
    }
    return _label1;
}
-(UILabel *)label2{
    if(!_label2){
        _label2 = [[UILabel alloc]init];
        _label2.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _label2.textColor =[UIColor colorWithHexString:@"#ffffff"];
        _label2.textAlignment = NSTextAlignmentLeft;
        _label2.userInteractionEnabled = YES;
        [self.topView addSubview:self.label2];
        _label2.text = @"";
    }
    return _label2;
}

- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = Main_Color;
        [self addSubview:_topView];
    }
    return _topView;
}

@end
