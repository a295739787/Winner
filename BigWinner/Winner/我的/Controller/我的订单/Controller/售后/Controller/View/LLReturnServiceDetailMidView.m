//
//  LLReturnServiceDetailMidView.m
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLReturnServiceDetailMidView.h"
@interface LLReturnServiceDetailMidView ()
@property (nonatomic,strong) UILabel *noticeLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *midView;/** <#class#> **/
@property (nonatomic,strong) UIView *boView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *skuLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UIButton *chatBtn;/** class **/
@property (nonatomic,strong) UIButton *phoneBtn;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIButton *kehuBtn;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView1;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView2;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView3;/** <#class#> **/
@property (nonatomic,strong) UIView *shopView;/** <#class#> **/
@property (nonatomic,strong) UILabel *shopLabel;
@property (nonatomic,strong) UIButton *deButton;/** <#class#> **/
@property (nonatomic,strong) UIView *logView;/** <#class#> **/
@property (nonatomic,strong) UILabel *logLabel;
@property (nonatomic,strong) UIImageView *logImage;
@property(nonatomic,strong)UIImageView *shopimage;
@property(nonatomic,strong)UILabel *shopName;
@end
@implementation LLReturnServiceDetailMidView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor  =  [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
//    [self.noticeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(CGFloatBasedI375(15));
//        make.top.mas_equalTo(CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(44));
//    }];
    [self.shopimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(CGFloatBasedI375(28));
        make.left.offset(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(6));

    }];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.shopimage.mas_right).offset(CGFloatBasedI375(7));
        make.height.offset(CGFloatBasedI375(44));
        make.centerY.equalTo(weakself.shopimage.mas_centerY);

    }];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.top.equalTo(weakself.shopName.mas_bottom).mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(95));
    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.midView.mas_centerY);
        make.height.width.mas_equalTo(CGFloatBasedI375(75));
    }];
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).mas_equalTo(CGFloatBasedI375(20));
        make.top.mas_equalTo(CGFloatBasedI375(12));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
    [self.skuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).mas_equalTo(CGFloatBasedI375(20));
        make.top.equalTo(weakself.nameLabel1.mas_bottom).mas_equalTo(CGFloatBasedI375(8));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).mas_equalTo(CGFloatBasedI375(20));
        make.top.equalTo(weakself.skuLabel.mas_bottom).mas_equalTo(CGFloatBasedI375(8));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.top.equalTo(weakself.midView.mas_bottom).mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(104));
    }];
    [self.lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(10));
        make.top.equalTo(weakself.boView.mas_bottom).offset(CGFloatBasedI375(0));
    }];
    [self.shopView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(90+40));
        make.top.equalTo(weakself.lineView2.mas_bottom).offset(CGFloatBasedI375(0));
    }];
    [self.shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];

    if(!_model.address){
        [self.chatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakself.mas_centerX);
            make.height.mas_equalTo(CGFloatBasedI375(44));
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.top.equalTo(weakself.lineView2.mas_bottom).offset(CGFloatBasedI375(10));
        }];

    }else{
        [self.chatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakself.mas_centerX);
            make.height.mas_equalTo(CGFloatBasedI375(44));
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.top.equalTo(weakself.shopView.mas_bottom).offset(CGFloatBasedI375(10));
        }];
    }
//    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.chatBtn.mas_right).mas_equalTo(CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(20));
//        make.width.mas_equalTo(CGFloatBasedI375(1));
//        make.centerY.equalTo(weakself.chatBtn.mas_centerY);
//    }];

//    [self.kehuBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(44));
//        make.left.equalTo(weakself.lineView.mas_right).mas_equalTo(CGFloatBasedI375(0));
//        make.centerY.equalTo(weakself.chatBtn.mas_centerY);
//    }];
    

}
#define buths 100
-(void)creatUi{
    for(UILabel *label in self.boView.subviews){
        [label removeFromSuperview];
    }
    NSArray *title = @[@"退款原因：",@"退款金额：¥ 0.00",@"申请时间：2018.4.1 19:47",@"退款编号：48746341435486"];
    for (int i = 0; i < title.count; i++) {
        CGFloat w = SCREEN_WIDTH-CGFloatBasedI375(30);
        CGFloat h = (CGFloatBasedI375(104-10))/4;
        CGFloat x = CGFloatBasedI375(15);
        CGFloat y =CGFloatBasedI375(5)+(h + CGFloatBasedI375(0))*(i%title.count);
        UILabel *labels = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        labels.text = title[i];
        labels.tag = buths+i;
        labels.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        labels.textColor =[UIColor colorWithHexString:@"#666666"];
        [self.boView addSubview:labels];
        
    }
}
#define buthshop 200
-(void)creatShopUi{
//    for(UILabel *label in self.shopView.subviews){
//        [label removeFromSuperview];
//    }
    NSArray *title = @[@"商家收货人：",@"联系电话：",@"收货地址："];
    for (int i = 0; i < title.count; i++) {
        CGFloat w = SCREEN_WIDTH-CGFloatBasedI375(30);
        CGFloat h = (CGFloatBasedI375(100-10))/3;
        CGFloat x = CGFloatBasedI375(15);
        CGFloat y =CGFloatBasedI375(40)+(h + CGFloatBasedI375(0))*(i%title.count);
        UILabel *labels = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        labels.text = title[i];
        labels.tag = buthshop+i;
        labels.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        labels.textColor =[UIColor colorWithHexString:@"#666666"];
        [self.shopView addSubview:labels];
        
    }
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self setLayout];
    [self creatUi];
    [self creatShopUi];
//    self.nameLabel1.text = _model.refund.good.goods_name;
//    self.skuLabel.text = _model.refund.good.goods_sku_name;
//    self.priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.refund.good.goods_amount.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
//    [self.shopimage  sd_setImageWithUrlString:FORMAT(@"%@",_model.shop.shop_logo) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:FORMAT(@"%@  ",_model.shop.shop_name)];
//    //NSTextAttachment可以将要插入的图片作为特殊字符处理
//    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//    //定义图片内容及位置和大小
//    attch.image = [UIImage imageNamed:@"allowimag"];
//    attch.bounds = CGRectMake(0, 0, 6, 11);
//    //创建带有图片的富文本
//    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//    [attri appendAttributedString:string];
//    self.shopName.attributedText = attri;
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.refund.good.image) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    UILabel *label1 = [self viewWithTag:buths];
//    label1.text = FORMAT(@"退款原因：%@",_model.refund.reason[@"reason"]);
//    UILabel *label2 = [self viewWithTag:buths+1];
//    label2.text = FORMAT(@"退款金额：￥%.2f",_model.refund.refund_amount.floatValue);
//    UILabel *label3 = [self viewWithTag:buths+2];
//    label3.text = FORMAT(@"申请时间：%@",_model.refund.created_at);
//    UILabel *label4 = [self viewWithTag:buths+3];
//    label4.text = FORMAT(@"退款编号：%@",_model.refund.ID);
//    UILabel *labelshop1 = [self viewWithTag:buthshop];
//    labelshop1.text = FORMAT(@"商家收货人：%@",_model.address.link_name);
//    UILabel *labelshop2 = [self viewWithTag:buthshop+1];
//    labelshop2.text = FORMAT(@"联系电话：%@",_model.address.phone);
//    UILabel *labelshop3 = [self viewWithTag:buthshop+2];
//    labelshop3.text = FORMAT(@"收货地址：%@",_model.address.fully_address);
//    self.logView.hidden = YES;
//    if(_model.refund.state == 100){
//        self.logView.hidden = NO;
//    }
//    if(_model.address){
//        self.shopView.hidden = NO;
//    }else{
//        self.shopView.hidden = YES;
//    }

}
-(UILabel *)shopLabel{
    if(!_shopLabel){
        _shopLabel = [[UILabel alloc]init];
        _shopLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _shopLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        _shopLabel.textAlignment = NSTextAlignmentLeft;
        _shopLabel.userInteractionEnabled = YES;
        [self.shopView addSubview:self.shopLabel];
        _shopLabel.text = @"商家信息";
    }
    return _shopLabel;
}
-(UILabel *)noticeLabel{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _noticeLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
        _noticeLabel.userInteractionEnabled = YES;
        [self addSubview:self.noticeLabel];
        _noticeLabel.text = @"商品信息";
    }
    return _noticeLabel;
}
- (UIView *)midView{
    if(!_midView){
        _midView = [[UIView alloc]init];
        _midView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        [self addSubview:_midView];
        _midView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickde)];
        [_midView addGestureRecognizer:tap];
    }
    return _midView;
}
- (UIImageView *)shopimage{
    if(!_shopimage){
        _shopimage = [[UIImageView alloc]init];
        _shopimage.image =[UIImage imageNamed:morenpic];
        [self addSubview:self.shopimage];
        _shopimage.layer.masksToBounds = YES;
        _shopimage.layer.cornerRadius = CGFloatBasedI375(28)/2;
    }
    return _shopimage;
}
-(UILabel *)shopName{
    if(!_shopName){
        _shopName = [[UILabel alloc]init];
        _shopName.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _shopName.textAlignment = NSTextAlignmentLeft;
        _shopName.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.shopName];
        _shopName.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickshop)];
        [_shopName addGestureRecognizer:tap];
    }
    return _shopName;
}
-(void)clickshop{
//    LLShopMainViewController *vc = [[LLShopMainViewController alloc]init];
//    vc.pid = _model.shop.ID;
//    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}
-(void)clickde{
//    LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
//    LLGoodModel *mo = [[LLGoodModel alloc]init];
//    mo.goods_id = _model.refund.good.goods_id;
//    mo.sku_id = _model.refund.good.sku_id;
//    mo.shop_id= _model.refund.shop.shop_id;
//    vc.valueModel = mo;
//    [[UIViewController getCurrentController].navigationController pushViewController:vc animated:YES];
}
- (UIView *)shopView{
    if(!_shopView){
        _shopView = [[UIView alloc]init];
        [self addSubview:_shopView];
    }
    return _shopView;
}
- (UIView *)boView{
    if(!_boView){
        _boView = [[UIView alloc]init];
        _boView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_boView];
    }
    return _boView;
}
- (UIView *)lineView2{
    if(!_lineView2){
        _lineView2 = [[UIView alloc]init];
        _lineView2.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:_lineView2];
    }
    return _lineView2;
}
- (UIView *)logView{
    if(!_logView){
        _logView = [[UIView alloc]init];
        _logView.hidden = YES;
        _logView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_logView];
    }
    return _logView;
}
-(UILabel *)logLabel{
    if(!_logLabel){
        _logLabel = [[UILabel alloc]init];
        _logLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _logLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        _logLabel.textAlignment = NSTextAlignmentLeft;
        _logLabel.userInteractionEnabled = YES;
        [self.midView addSubview:self.logLabel];
        _logLabel.text = @"退款日志";
      
    }
    return _logLabel;
}

-(UIImageView *)logImage{
    if (!_logImage) {
        _logImage = [[UIImageView alloc]init];;
        _logImage.image = [UIImage imageNamed:@""];
        [self.logView addSubview:self.logImage];
    }
    return _logImage;
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
        [self.midView addSubview:self.showImage];
    }
    return _showImage;
}
-(UILabel *)skuLabel{
    if(!_skuLabel){
        _skuLabel = [[UILabel alloc]init];
        _skuLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        _skuLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        _skuLabel.textAlignment = NSTextAlignmentLeft;
        _skuLabel.userInteractionEnabled = YES;
        [self.midView addSubview:self.skuLabel];
      
    }
    return _skuLabel;
}
-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        _priceLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.userInteractionEnabled = YES;
        [self.midView addSubview:self.priceLabel];
      
    }
    return _priceLabel;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.midView addSubview:self.nameLabel1];
      
    }
    return _nameLabel1;
}
-(UIButton *)deButton{
    if(!_deButton){
        _deButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deButton.layer.cornerRadius = CGFloatBasedI375(15);
        _deButton.layer.borderWidth = 1;
        _deButton.layer.masksToBounds = YES;
        _deButton.layer.borderColor = [Main_Color CGColor];
        [_deButton setTitle:@"回寄商品" forState:UIControlStateNormal];
        [_deButton setTitleColor:Main_Color forState:UIControlStateNormal];
        _deButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
//        [_sureButton addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self.shopView addSubview:self.deButton];
    }
    return _deButton;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_lineView];
    }
    return _lineView;
}
- (UIView *)lineView1{
    if(!_lineView1){
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_lineView1];
    }
    return _lineView1;
}
-(UIButton *)chatBtn{
    if(!_chatBtn){
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatBtn setImage:[UIImage imageNamed:@"content_contact"] forState:UIControlStateNormal];
        [_chatBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
        [_chatBtn setTitleColor:Black_Color forState:UIControlStateNormal];
        _chatBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _chatBtn.backgroundColor = White_Color;
        [_chatBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
        [_chatBtn addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.chatBtn];
    }
    return _chatBtn;
}

-(void)requestzujiForUrl{
//    LLGoodModel *model = [[LLGoodModel alloc]init];
//    model.goods_name =_model.refund.good.goods_name;
//    model.ID =_model.refund.ID;;
//    model.price_min =_model.refund.good.goods_amount;
//    model.goods_image =_model.refund.good.image;
//    model.order_sn =_model.refund.ID;;
//    model.state_txt =_model.refund.state_txt;;
//    model.created_at =_model.refund.created_at;;
//    model.isOrder = 2;
//    model.seller_id =_model.refund.seller.ID;
//    model.state =_model.refund.state;;
//    EMChatViewController *chatController = [[EMChatViewController alloc]initWithConversationId:FORMAT(@"%@",_model.seller.third_username) conversationType:EMConversationTypeChat];
//    chatController.title =FORMAT(@"%@",_model.seller.nick);
//        chatController.modalPresentationStyle = 0;
//    chatController.roleStatus = RoleGoodDetailStatus;
//    chatController.model = model;
//    [[UIViewController getCurrentController].navigationController pushViewController:chatController animated:YES];
}
-(UIButton *)phoneBtn{
    if(!_phoneBtn){
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setImage:[UIImage imageNamed:@"content_phone"] forState:UIControlStateNormal];
        [_phoneBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        [_phoneBtn setTitleColor:Black_Color forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _phoneBtn.backgroundColor = White_Color;
        [_phoneBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
//        [_chatBtn addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.phoneBtn];
    }
    return _phoneBtn;
}
-(UIButton *)kehuBtn{
    if(!_kehuBtn){
        _kehuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kehuBtn setImage:[UIImage imageNamed:@"content_phone"] forState:UIControlStateNormal];
        [_kehuBtn setTitle:@"商城客服" forState:UIControlStateNormal];
        [_kehuBtn setTitleColor:Black_Color forState:UIControlStateNormal];
        _kehuBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _kehuBtn.backgroundColor = White_Color;
        [_kehuBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
//        [_chatBtn addTarget:self action:@selector(requestzujiForUrl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.kehuBtn];
    }
    return _kehuBtn;
}
@end
