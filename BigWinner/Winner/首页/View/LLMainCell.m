//
//  LLMainHotCell.m
//  ShopApp
//
//  Created by lijun L on 2021/3/20.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLMainCell.h"
@interface LLMainCell ()
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *delable;
@property(nonatomic,strong)UIImageView *allowImage;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property(nonatomic,strong)UILabel *catolable;
@property(nonatomic,strong)UIImageView *catoImage;
@property (nonatomic,strong) UIImageView *kcbzImage;/** <#class#> **/
@property (nonatomic,strong) UIView *kcbzView;/** <#class#> **/

@end
@implementation LLMainCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
        self.layer.cornerRadius = CGFloatBasedI375(5);
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(CGFloatBasedI375(0));
        make.bottom.right.mas_equalTo(CGFloatBasedI375(0));
    }];
    
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(172));
    }];
    [self.kcbzView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(CGFloatBasedI375(0));
    }];
    [self.kcbzImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.kcbzView.mas_centerY);
        make.height.width.mas_equalTo(CGFloatBasedI375(100));
        make.centerX.equalTo(weakself.kcbzView.mas_centerX);
        
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.equalTo(weakself.showImage.mas_bottom).offset(CGFloatBasedI375(8));
    }];

    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.bottom.offset(-CGFloatBasedI375(10));
    }];
    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.pricelable.mas_centerY);
    }];
    [self.redlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(CGFloatBasedI375(0));
        make.width.mas_equalTo(CGFloatBasedI375(70));
        make.height.mas_equalTo(CGFloatBasedI375(20));
    }];
//    [self.catolable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.offset(CGFloatBasedI375(0));
//    }];
//    [self.allowImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(CGFloatBasedI375(-10));
//        make.height.width.mas_equalTo(CGFloatBasedI375(15));
//        make.centerY.equalTo(weakself.catoImage.mas_centerY);
//    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.offset(CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(.5));
//    }];
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.redlable.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(10), CGFloatBasedI375(10))];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.redlable.bounds;
    maskLayer.path = maskPath.CGPath;
    self.redlable.layer.mask = maskLayer;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    _delable.text = FORMAT(@"销量%@",_model.realSalesVolume);
    _titlelable.text = _model.name;
    _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    
    self.redlable.text = FORMAT(@"单次限%ld瓶",_model.purchaseRestrictions);
    self.kcbzView.hidden =YES;
    if(_model.stock.integerValue <= 0){
        self.kcbzView.hidden =NO;
    }
 

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
- (UIView *)kcbzView{
    if(!_kcbzView){
        _kcbzView = [[UIView alloc]init];
        _kcbzView.backgroundColor = [Black_Color colorWithAlphaComponent:0.3];
        [self.showImage addSubview:_kcbzView];
        _kcbzView.hidden = YES;

    }
    return _kcbzView;;
}
-(UIImageView *)kcbzImage{
    if (!_kcbzImage) {
        _kcbzImage = [[UIImageView alloc]init];
        _kcbzImage.userInteractionEnabled = YES;
        _kcbzImage.image =[UIImage imageNamed:@"kcbz"];
        [self.kcbzView addSubview:self.kcbzImage];
    }
    return _kcbzImage;
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
-(UILabel *)redlable{
    if(!_redlable){
        _redlable =[[UILabel alloc]init];
        _redlable.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _redlable.textAlignment = NSTextAlignmentCenter;
        _redlable.font = [UIFont systemFontOfSize:CGFloatBasedI375(11)];
        [self.showImage addSubview:self.redlable];
        _redlable.size = CGSizeMake(100, 30);
        _redlable.mj_size = CGSizeMake(100, 30);
        _redlable.backgroundColor = Main_Color;
    }
    return _redlable;
}
-(UILabel *)delable{
    if(!_delable){
        _delable =[[UILabel alloc]init];
        _delable.text = @"销量0";
        _delable.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        _delable.textAlignment = NSTextAlignmentRight;
        _delable.font = [UIFont systemFontOfSize:CGFloatBasedI375(11)];
        [self.backView addSubview:self.delable];
    }
    return _delable;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable =[[UILabel alloc]init];
        _pricelable.text = @"¥99";
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
        _catolable.text = @"满100减20";
        _catolable.textColor =lightGrayFFFF_Color;
        _catolable.textAlignment = NSTextAlignmentCenter;
        _catolable.font = [UIFont systemFontOfSize:CGFloatBasedI375(10)];
        [self.catoImage addSubview:self.catolable];
    }
    return _catolable;
}
-(UIImageView *)catoImage{
    if (!_catoImage) {
        _catoImage = [[UIImageView alloc]init];
        _catoImage.userInteractionEnabled = YES;
        _catoImage.image = [UIImage imageNamed:@"maincorenm"];
        _catoImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.backView addSubview:self.catoImage];
    }
    return _catoImage;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
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
@end
