//
//  LLMainHotCell.m
//  ShopApp
//
//  Created by lijun L on 2021/3/20.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLSurpriseRegBagRecordViewCell.h"
@interface LLSurpriseRegBagRecordViewCell ()
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *delable;
@property(nonatomic,strong)UIImageView *allowImage;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property(nonatomic,strong)UILabel *catolable;
@property(nonatomic,strong)UIImageView *catoImage;
@property(nonatomic,strong)UILabel *statuslable;
@property (nonatomic,strong) UIImageView *statusImage;/** <#class#> **/

@property(nonatomic,strong)UILabel *timelable;

@end
@implementation LLSurpriseRegBagRecordViewCell

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
        make.left.top.offset(CGFloatBasedI375(10));
        make.right.mas_equalTo(-CGFloatBasedI375(10));
        make.bottom.mas_equalTo(-CGFloatBasedI375(0));
    }];
    [self.timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(14));
        make.top.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(45));
    }];
    [self.statuslable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(14));
        make.top.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];
    [self.statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(14));
        make.centerY.equalTo(weakself.timelable.mas_centerY);
        make.height.mas_equalTo(CGFloatBasedI375(24));
        make.width.mas_equalTo(CGFloatBasedI375(75));
    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.width.mas_equalTo(CGFloatBasedI375(80));
        make.bottom.offset(-CGFloatBasedI375(15));

    }];
    
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.equalTo(weakself.showImage.mas_top).offset(CGFloatBasedI375(3));
    }];
    
    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.equalTo(weakself.delable.mas_bottom).offset(CGFloatBasedI375(10));
    }];
//    [self.catoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.pricelable.mas_right).offset(CGFloatBasedI375(5));
////        make.width.mas_equalTo(CGFloatBasedI375(70));
////        make.height.mas_equalTo(CGFloatBasedI375(15));
//        make.bottom.equalTo(weakself.showImage.mas_bottom).offset(-CGFloatBasedI375(10));
//    }];
    [self.catolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.pricelable.mas_centerY);
    }];
//    [self.allowImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(CGFloatBasedI375(-10));
//        make.height.width.mas_equalTo(CGFloatBasedI375(15));
//        make.centerY.equalTo(weakself.catoImage.mas_centerY);
//    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.offset(CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(.5));
//    }];
}
//-(void)setModel:(LLGoodModel *)model{
//    _model = model;
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.image) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    _titlelable.text = _model.goods_name;
//    _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.price.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
//
//}
-(void)setDatas:(NSDictionary *)datas{
    _datas= datas;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_datas[@"appOrderListGoodsVO"][@"coverImage"]) placeholderImage:[UIImage imageNamed:morenpic]];
    _delable.text = FORMAT(@"%@",_datas[@"appOrderListGoodsVO"][@"specsValName"]);
    _titlelable.text =  _datas[@"appOrderListGoodsVO"][@"name"];
    self.statuslable.text = FORMAT(@"%@:%@",_datas[@"queueName"], _datas[@"ranking"]);
    self.timelable.text = _datas[@"createTime"];
    self.catolable.text = FORMAT(@"x%@",_datas[@"appOrderListGoodsVO"][@"goodsNum"]);
    _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%@",_datas[@"appOrderListGoodsVO"][@"totalPrice"])] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    NSInteger redStatus = [FORMAT(@"%@",_datas[@"redStatus"])integerValue];
    if(redStatus == 1){//红包到账状态（1未到账、2已到账）
        self.statusImage.hidden = YES;
        self.statuslable.hidden = NO;
    }else{
        self.statusImage.hidden = NO;
        self.statuslable.hidden = YES;
    }
    
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;

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
-(UIImageView *)allowImage{
    if (!_allowImage) {
        _allowImage = [[UIImageView alloc]init];
        _allowImage.userInteractionEnabled = YES;
        _allowImage.image =[UIImage imageNamed:@"mainallow"];
        [self.backView addSubview:self.allowImage];
    }
    return _allowImage;
}
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
-(UILabel *)timelable{
    if(!_timelable){
        _timelable =[[UILabel alloc]init];
        _timelable.text = @"2021-08-15 14:03:22";
        _timelable.textColor = BlackTitleFont443415;
        _timelable.textAlignment = NSTextAlignmentLeft;
        _timelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self.backView addSubview:self.timelable];
    }
    return _timelable;
}
-(UILabel *)statuslable{
    if(!_statuslable){
        _statuslable =[[UILabel alloc]init];
        _statuslable.text = @"东莞:第2008";
        _statuslable.textColor = [UIColor colorWithHexString:@"#666666"];
        _statuslable.textAlignment = NSTextAlignmentRight;
        _statuslable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self.backView addSubview:self.statuslable];
    }
    return _statuslable;
}
-(UILabel *)delable{
    if(!_delable){
        _delable =[[UILabel alloc]init];
        _delable.text = @"销量0";
        _delable.textColor = [UIColor colorWithHexString:@"#999999"];
        _delable.textAlignment = NSTextAlignmentLeft;
        _delable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.backView addSubview:self.delable];
    }
    return _delable;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable =[[UILabel alloc]init];
        _pricelable.text = @"¥0";
        _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"¥",FORMAT(@"%@",@"99")] fonts:@[[UIFont systemFontOfSize:CGFloatBasedI375(15)],[UIFont boldFontWithFontSize:CGFloatBasedI375(19)]]];
        _pricelable.textColor =Main_Color;
        _pricelable.textAlignment = NSTextAlignmentLeft;
//        _pricelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(10)];
        [self.backView addSubview:self.pricelable];
    }
    return _pricelable;
}
-(UILabel *)catolable{
    if(!_catolable){
        _catolable =[[UILabel alloc]init];
        _catolable.text = @"x2";
        _catolable.textColor = [UIColor colorWithHexString:@"#666666"];
        _catolable.textAlignment = NSTextAlignmentRight;
        _catolable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.backView addSubview:self.catolable];
    }
    return _catolable;
}
-(UIImageView *)catoImage{
    if (!_catoImage) {
        _catoImage = [[UIImageView alloc]init];
        _catoImage.userInteractionEnabled = YES;
        _catoImage.image = [UIImage imageNamed:@"maincorenm"];
        _catoImage.backgroundColor = [UIColor colorWithHexString:@"#666666"];
        [self.backView addSubview:self.catoImage];
    }
    return _catoImage;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatBasedI375(10);
        [self addSubview:_backView];
    }
    return _backView;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.backView addSubview:_lineView];
    }
    return _lineView;
}
-(UIImageView *)statusImage{
    if (!_statusImage) {
        _statusImage = [[UIImageView alloc]init];
        _statusImage.userInteractionEnabled = YES;
        _statusImage.image = [UIImage imageNamed:@"state_hbydz"];
        [self.backView addSubview:self.statusImage];
//        _statusImage.backgroundColor = Red_Color;
        _statusImage.hidden = YES;
    }
    return _statusImage;
}
@end
