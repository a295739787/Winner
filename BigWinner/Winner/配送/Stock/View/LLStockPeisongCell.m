//
//  LLMePersongCell.m
//  Winner
//
//  Created by 廖利君 on 2022/3/5.
//

#import "LLStockPeisongCell.h"
@interface LLStockPeisongCell ()
@property (nonatomic ,strong) UIView *mainView;
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *attrlable;
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic,strong) UIButton *stockDetailButton;
@property(nonatomic,strong)UILabel *stocklable;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UILabel *pricelable;/** <#class#> **/

@end
@implementation LLStockPeisongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor HexString:@"#F2F2F2"];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
 
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.right.offset(-10);
        make.bottom.offset(0);
    }];
    
    WS(weakself);
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(15));
        make.height.mas_equalTo(CGFloatBasedI375(80));
        make.width.mas_equalTo(CGFloatBasedI375(80));
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.showImage.mas_top).offset(CGFloatBasedI375(3));
        make.right.offset(-CGFloatBasedI375(15));

    }];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(15));

    }];
//    if([UserModel sharedUserInfo].isClerk){//是否存在配送员
        self.pricelable.hidden = NO;
        [self.attrlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
            make.top.equalTo(weakself.pricelable.mas_bottom).offset(CGFloatBasedI375(5));
            make.right.offset(-CGFloatBasedI375(15));
            
        }];
//    }else{//是否存在推广点
//        self.pricelable.hidden = NO;
//        [self.attrlable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
//            make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(5));
//            make.right.offset(-CGFloatBasedI375(15));
//            
//        }];
//    }
    [self.stocklable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.attrlable.mas_bottom).offset(CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(15));

    }];
    
    [self.stockDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.offset(-CGFloatBasedI375(18));
        make.height.mas_equalTo(CGFloatBasedI375(30));
        make.width.mas_equalTo(CGFloatBasedI375(80));
    }];
    
//    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakself.sureButton.mas_left).offset(-10);
//        make.bottom.offset(-CGFloatBasedI375(18));
//        make.height.mas_equalTo(CGFloatBasedI375(30));
//        make.width.mas_equalTo(CGFloatBasedI375(80));
//    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-CGFloatBasedI375(0));
//        make.bottom.top.offset(-CGFloatBasedI375(0));
//        make.height.mas_equalTo(CGFloatBasedI375(1));
//    }];
}

-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.attrlable.text = FORMAT(@"%@",_model.specsValName);
    _titlelable.text = _model.name;
    _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.purchasePrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];

    self.stocklable.text = FORMAT(@"库存:%@  |  待入库: %@",_model.goodsNum,_model.stayStock);
}
-(UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 5;
        [self.contentView addSubview:self.mainView];
    }
    return  _mainView;
}
-(UILabel *)attrlable{
    if(!_attrlable){
        _attrlable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#999999"] textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(12) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"1支装(500ML)"];
        [self.mainView addSubview:self.attrlable];
    }
    return _attrlable;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;
        _showImage.image =[UIImage imageNamed:@"sp1"];
        _showImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.mainView addSubview:self.showImage];
    }
    return _showImage;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"银色星芒刺绣网纱底 裤红色棉麻…";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.mainView addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}
-(UILabel *)stocklable{
    if(!_stocklable){
        _stocklable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#999999"] textAlignment:NSTextAlignmentLeft numberOfLines:2 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"库存:1  |  待入库: 0"];
        [self.mainView addSubview:self.stocklable];
       
    }
    return _stocklable;
}

-(UIButton *)stockDetailButton{
    if(!_stockDetailButton){
        _stockDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stockDetailButton.layer.cornerRadius = CGFloatBasedI375(15);
        _stockDetailButton.layer.masksToBounds = YES;
        _stockDetailButton.layer.borderWidth = 1;
        _stockDetailButton.layer.borderColor = [UIColor HexString:@"#999999"].CGColor;
        _stockDetailButton.tag = 101;
        [_stockDetailButton setTitle:@"库存明细" forState:UIControlStateNormal];
        _stockDetailButton.backgroundColor = [UIColor whiteColor];
        NSLog(@"[UserModel sharedUserInfo].userIdentity  == %ld",[UserModel sharedUserInfo].userIdentity );
        [_stockDetailButton setTitleColor:[UIColor colorWithHexString:@"#443415"] forState:UIControlStateNormal];
        _stockDetailButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_stockDetailButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:self.stockDetailButton];
    }
    return _stockDetailButton;
}

-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.cornerRadius = CGFloatBasedI375(15);
        _sureButton.layer.masksToBounds = YES;
        _sureButton.tag = 102;
        [_sureButton setTitle:@"去采购" forState:UIControlStateNormal];
        _sureButton.backgroundColor = Main_Color;
        NSLog(@"[UserModel sharedUserInfo].userIdentity  == %ld",[UserModel sharedUserInfo].userIdentity );

        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
//        [self.mainView addSubview:self.sureButton];
    }
    return _sureButton;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#443415"] textAlignment:NSTextAlignmentLeft numberOfLines:1 fontSize:CGFloatBasedI375(14) font:[UIFont boldFontWithFontSize:CGFloatBasedI375(14)] text:@"¥ 119.00"];
        _pricelable.hidden = YES;
        [self.mainView addSubview:self.pricelable];
    }
    return _pricelable;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
//        [self.contentView addSubview:_lineView];
    }
    return _lineView;;
}
-(void)clickTap:(UIButton *)sender{
  
    if (self.delegate && [self.delegate respondsToSelector:@selector(joinStockDetailAndShop:dataSource:)]) {
        [self.delegate joinStockDetailAndShop:sender dataSource:self.model];
    }
}
@end
