//
//  LLShopCarBoView.m
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import "LLShopCarBoView.h"
@interface LLShopCarBoView ()
@property(nonatomic,strong)UILabel *nameLabel1;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UIView *backView;


@end
@implementation LLShopCarBoView
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
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(10));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(3));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(6));
        make.height.offset(CGFloatBasedI375(38));
        make.width.offset(CGFloatBasedI375(105));
    }];
    [self.deleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(6));
        make.height.offset(CGFloatBasedI375(38));
        make.left.offset(CGFloatBasedI375(15));
    }];
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    _priceStr = _model.totalPrice;
    NSString *price =   [NSString isBlankString:  [NSString stringWithFormat:@"%@",_priceStr]]?@"":[NSString stringWithFormat:@"%@",_priceStr];
    CGFloat temp = price.floatValue;
    price = [NSString stringWithFormat:@"%.2f",temp];
    if(_model.freight.integerValue == 0){
        _detailsLabel.text = FORMAT(@"共%@瓶，含配送费",_model.goodsNum);
    }else{
        _detailsLabel.text = FORMAT(@"共%@瓶，含配送费",_model.goodsNum);
    }
    CGFloat stock = _model.stock.floatValue;
    if(_model.stockPrice.floatValue >= price.floatValue){
        price = @"0.0";
    }else{
        price = FORMAT(@"%.2f",price.floatValue-_model.stockPrice.floatValue+_model.freight.floatValue);
    }
    self.nameLabel1.attributedText = [self getAttribuStrWithStrings:@[@"合计: ",@"￥",_model.totalPrice] fonts:@[[UIFont systemFontOfSize:CGFloatBasedI375(14)], [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[  [UIColor colorWithHexString:@"#333333"],Main_Color, Main_Color]];
}
-(void)setPriceStr:(NSString *)priceStr{
    _priceStr = priceStr;
    NSString *price =   [NSString isBlankString:  [NSString stringWithFormat:@"%@",_priceStr]]?@"":[NSString stringWithFormat:@"%@",_priceStr];
    CGFloat temp = price.floatValue;
    price = [NSString stringWithFormat:@"%.2f",temp];
    self.nameLabel1.attributedText = [self getAttribuStrWithStrings:@[@"合计: ",@"￥",price] fonts:@[[UIFont systemFontOfSize:CGFloatBasedI375(14)], [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[  [UIColor colorWithHexString:@"#333333"],Main_Color, Main_Color]];

}
-(void)setStatus:(RoleStatus)status{
    _status = status;
    if(_status == RoleStatusRedBag){
        self.detailsLabel.hidden = YES;
    }
}
-(void)setIsEditing:(BOOL)isEditing{
    _isEditing = isEditing;
    if(_isEditing){
        self.detailsLabel.hidden = YES;
        self.sureButton.hidden = YES;
        self.nameLabel1.hidden = YES;
        self.deleButton.hidden = NO;
    }else{
        self.detailsLabel.hidden = NO;
        self.sureButton.hidden = NO;
        self.nameLabel1.hidden = NO;
        self.deleButton.hidden = YES;
    }
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.detailsLabel];
     

    }
    return _detailsLabel;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#443415"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"合计 0.00";
    }
    return _nameLabel1;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithTitle:@"下单" atBackgroundNormalImageName:@"unselect" atBackgroundSelectedImageName:@"shopcarselect" atTarget:self atAction:nil];
        _sureButton.backgroundColor = Main_Color;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = CGFloatBasedI375(19);
        [_sureButton setTitleColor:White_Color forState:UIControlStateNormal];
        [self addSubview:self.sureButton];
    }
    return _sureButton;
}
-(UIButton *)deleButton{
    if(!_deleButton){
        _deleButton = [[UIButton alloc]init];
        [_deleButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleButton.backgroundColor = Main_Color;
        _deleButton.layer.masksToBounds = YES;
        _deleButton.hidden = YES;
        _deleButton.layer.cornerRadius = CGFloatBasedI375(19);
        [_deleButton setTitleColor:White_Color forState:UIControlStateNormal];
        [self addSubview:self.deleButton];
    }
    return _deleButton;
}
@end
@interface LLSupriceRedbagView ()
@property(nonatomic,strong)UILabel *nameLabel1;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *delable;

@property (nonatomic,strong) UILabel *detailsLabel;

@end
@implementation LLSupriceRedbagView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
  
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.mas_centerY);
        make.height.width.offset(CGFloatBasedI375(14));
    }];
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.sureButton.mas_right).offset(CGFloatBasedI375(5));
        make.centerY.equalTo(weakself.sureButton.mas_centerY);
    }];

 
}


-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.detailsLabel];
        _detailsLabel.text = @"";

    }
    return _detailsLabel;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _nameLabel1.textColor =Main_Color;
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"购买须知：惊喜活动商品下单购买后不能退货退款请知悉。";
    }
    return _nameLabel1;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithTitle:@"" atBackgroundNormalImageName:@"xz_red" atBackgroundSelectedImageName:@"xz_red" atTarget:self atAction:nil];
        [self addSubview:self.sureButton];
    }
    return _sureButton;
}

@end
