//
//  LLSureOrderCell.m
//  ShopApp
//
//  Created by lijun L on 2021/3/22.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLReturnServiceCell.h"
@interface LLReturnServiceCell ()
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UILabel *priceLabel;/** class **/
@property (nonatomic,strong) UIView *lineview;
@property(nonatomic,strong)UILabel *countNumsLabel;
@property (nonatomic,strong) UIImageView *showImage;
@property(nonatomic,strong)UILabel *biaoqianlabel;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/

@end
@implementation LLReturnServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setModel:(LLMeOrderListModel *)model{
    _model = model;
    
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.detailsLabel.text = FORMAT(@"%@",_model.specsValName);
    self.nameLabel1.text = _model.name;
    self.priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont boldFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    self.countNumsLabel.text  = FORMAT(@"x%@",_model.goodsNum);
//    self.nameLabel1.text =_model.goods_name;
//
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.image) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    self.detailsLabel.text = FORMAT(@"%@",_model.goods_sku_name);
//    self.priceLabel.text =FORMAT(@"¥ %.2f ",_model.goods_amount.floatValue );
//    self.countNumsLabel.text =FORMAT(@"x %@ ",_model.num);
}
-(void)setRefundModel:(LLGoodModel *)refundModel{
    _refundModel = refundModel;
        
//    self.nameLabel1.text =_refundModel.refund.good.goods_name;
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_refundModel.refund.good.image) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    self.detailsLabel.text = FORMAT(@"%@",_refundModel.refund.good.goods_sku_name);
//    self.priceLabel.text =FORMAT(@"¥ %.2f ",_refundModel.refund.good.goods_amount.floatValue);
//    self.countNumsLabel.text =FORMAT(@"x %@ ",_refundModel.refund.good.num);
}
-(void)setServiceModel:(LLGoodModel *)serviceModel{
    _serviceModel = serviceModel;
//    self.nameLabel1.text =_serviceModel.service.good.goods_name;
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_serviceModel.service.good.image) placeholderImage:[UIImage imageNamed:morenpic]];
//
//    self.detailsLabel.text = FORMAT(@"%@",_serviceModel.service.good.goods_sku_name);
//    self.priceLabel.text =FORMAT(@"¥ %.2f ",_serviceModel.service.good.goods_amount.floatValue);
//    self.countNumsLabel.text =FORMAT(@"x %@ ",_serviceModel.service.good.num);
}
-(void)setLayout{
    WS(weakself);
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.width.offset(CGFloatBasedI375(75));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];

    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(15));
        make.right.offset(CGFloatBasedI375(-35));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(20));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(5));
        make.left.equalTo(weakself.nameLabel1.mas_left);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.detailsLabel.mas_bottom).offset(CGFloatBasedI375(5));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(20));
    }];
    [self.countNumsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nameLabel1.mas_centerY);
        make.right.offset(CGFloatBasedI375(-10));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(3));
    }];
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
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"洗脸刷洁面乳礼盒装 360度刷洁面乳 礼盒装 360度";
        NSString *titleString = @"我是标题！我是标题！我是标！我是标题！";
        //创建  NSMutableAttributedString 富文本对象
        NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString:titleString];
        //创建一个小标签的Label
        NSString *aa = @"精选";
        CGFloat aaW = 12*aa.length +6;
        UILabel *aaL = [UILabel new];
        aaL.frame = CGRectMake(0, 0, aaW*3, 16*3);
        aaL.text = aa;
        aaL.font = [UIFont boldSystemFontOfSize:12*3];
        aaL.textColor = [UIColor whiteColor];
        aaL.backgroundColor = [UIColor colorWithHexString:@"#FF839C"];
        aaL.clipsToBounds = YES;
        aaL.layer.cornerRadius = 3*3;
        aaL.textAlignment = NSTextAlignmentCenter;
        //调用方法，转化成Image
        UIImage *image = [self imageWithUIView:aaL];
        //创建Image的富文本格式
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.bounds = CGRectMake(0, -2.5, aaW, 16); //这个-2.5是为了调整下标签跟文字的位置
        attach.image = image;
        //添加到富文本对象里
        NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面
        self.nameLabel1.attributedText =maTitleString;
        //[maTitleString appendAttributedString:imageStr];//加入文字后面
        //[maTitleString insertAttributedString:imageStr atIndex:4];//加入文字第4的位置

        //注意 ：创建这个Label的时候，frame，font，cornerRadius要设置成所生成的图片的3倍，也就是说要生成一个三倍图，否则生成的图片会虚，同学们可以试一试。

      
    }
    return _nameLabel1;
}
//view转成image
- (UIImage*) imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(12)];
        _priceLabel.textColor =[UIColor colorWithHexString:@"#FF4545"];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.userInteractionEnabled = YES;
        _priceLabel.text = @"¥ 79 可抵扣20%";

        [self.contentView addSubview:self.priceLabel];
    }
    return _priceLabel;
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
        [self.contentView addSubview:self.detailsLabel];
        _detailsLabel.text = @"白色礼盒装";
    }
    return _detailsLabel;
}
-(UILabel *)biaoqianlabel{
    if(!_biaoqianlabel){
        _biaoqianlabel = [[UILabel alloc]init];
        _biaoqianlabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(11)];
        _biaoqianlabel.textColor =[UIColor colorWithHexString:@"#ffffff"];
        _biaoqianlabel.userInteractionEnabled = YES;
        _biaoqianlabel.textAlignment = NSTextAlignmentCenter;
        _biaoqianlabel.layer.masksToBounds = YES;
        _biaoqianlabel.layer.cornerRadius = CGFloatBasedI375(1);
        _biaoqianlabel.adjustsFontSizeToFitWidth = YES;
        _biaoqianlabel.backgroundColor= [UIColor colorWithHexString:@"#ECB95C"];
        [self.contentView addSubview:self.biaoqianlabel];
        _biaoqianlabel.text = @"优选";
    }
    return _biaoqianlabel;
}
-(UILabel *)countNumsLabel{
    if(!_countNumsLabel){
        _countNumsLabel = [[UILabel alloc]init];
        _countNumsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _countNumsLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        _countNumsLabel.textAlignment = NSTextAlignmentLeft;
        _countNumsLabel.userInteractionEnabled = YES;
        _countNumsLabel.adjustsFontSizeToFitWidth = YES;
        _countNumsLabel.text = @"×1";
        _countNumsLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.countNumsLabel];
    }
    return _countNumsLabel;
}
@end
@interface LLReturnServiceComCell ()

@property (nonatomic,strong) UIView *lineView;

@end
@implementation LLReturnServiceComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];

    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(15));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(15));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(4));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(15));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(1));
    }];
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
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];

      
    }
    return _nameLabel1;
}
//view转成image
- (UIImage*) imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detailsLabel];
        _detailsLabel.text = @"";
    }
    return _detailsLabel;
}

@end
@interface LLReturnApplyComCell ()

@property (nonatomic,strong) UIView *lineView;

@end
@implementation LLReturnApplyComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 20, 6, 11)];;
        imageView.image = [UIImage imageNamed:@"allowimag"];
        self.accessoryView = imageView;
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.offset(CGFloatBasedI375(15));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.right.offset(-CGFloatBasedI375(10));
        make.left.equalTo(weakself.nameLabel1.mas_right).offset(CGFloatBasedI375(10));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(CGFloatBasedI375(0.5f));
        make.left.right.bottom.offset(CGFloatBasedI375(0));
    }];
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"售后类型";

      
    }
    return _nameLabel1;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        _detailsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.detailsLabel];
        _detailsLabel.text = @"请选择";
        _detailsLabel.numberOfLines = 0;
    }
    return _detailsLabel;
}

@end
@interface LLReturnApplyComMonCell ()

@property (nonatomic,strong) UIView *lineView;

@end
@implementation LLReturnApplyComMonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.offset(CGFloatBasedI375(15));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.equalTo(weakself.nameLabel1.mas_right).offset(CGFloatBasedI375(3));
    }];

}
- (void)setMoney:(NSString *)money{
    _money = money;
    _detailsLabel.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"￥%.2f",_money.floatValue),@""] fonts:@[[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:11]] colors:@[Main_Color,[UIColor colorWithHexString:@"#999999"]]];
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"退款金额：";

      
    }
    return _nameLabel1;
}

-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detailsLabel];

    }
    return _detailsLabel;
}

@end
@interface LLReturnApplyComTextCell ()

@property (nonatomic,strong) UIView *lineView;

@end
@implementation LLReturnApplyComTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(10));
        make.left.offset(CGFloatBasedI375(15));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nameLabel1.mas_centerY);
        make.top.bottom.offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.nameLabel1.mas_right).offset(CGFloatBasedI375(3));
        make.right.offset(-CGFloatBasedI375(15));
    }];

}


-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"退款说明：";

      
    }
    return _nameLabel1;
}

-(UITextField *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UITextField alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        _detailsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.detailsLabel];
        _detailsLabel.placeholder = @"请输入退款说明备注…";
    }
    return _detailsLabel;
}

@end
@interface LLReturnApplyComPicCell ()

@property (nonatomic,strong) UIView *lineView;

@end
@implementation LLReturnApplyComPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(10));
        make.left.offset(CGFloatBasedI375(15));
    }];
    [self.picBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.mas_equalTo(CGFloatBasedI375(-15));
        make.height.mas_equalTo(CGFloatBasedI375(50));
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(8));
    }];
    [self.picBtnView addSubview:self.picView];
}
- (UIView *)picBtnView{
    if(!_picBtnView){
        _picBtnView = [[UIView alloc]init];
        [self addSubview:_picBtnView];
    }
    return _picBtnView;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"上传凭证：";

      
    }
    return _nameLabel1;
}
- (LLReturnPicView *)picView{
    if(!_picView){
        _picView = [[LLReturnPicView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-CGFloatBasedI375(30), CGFloatBasedI375(65))];
        WS(weakself);
        _picView.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
            if(weakself.selectBlock){
                weakself.selectBlock(image, @"", heights);
            }
        };
    }
    return _picView;
}
@end
@implementation LLReturnShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.right.offset(-CGFloatBasedI375(15));
        make.width.height.offset(CGFloatBasedI375(30));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(1));
    }];
}


-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentCenter;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"售后类型";

      
    }
    return _nameLabel1;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
-(UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton new];
        [_selectBtn setImage:UIImageName(@"unselected") forState:0];
        [_selectBtn setImage:UIImageName(@"seleted") forState:UIControlStateSelected];
//        [_selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.selectBtn];
        _selectBtn.userInteractionEnabled  =NO;
    }
    return _selectBtn;
}
@end
@implementation LLReturnApplyOnmonyComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(10));
        make.left.offset(CGFloatBasedI375(15));

    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.right.offset(-CGFloatBasedI375(15));
        make.top.bottom.offset(CGFloatBasedI375(0));
    }];
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.right.offset(-CGFloatBasedI375(0));
        make.bottom.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(.5f));
    }];
}

-(UILabel *)noticeLabel{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _noticeLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
        _noticeLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:self.noticeLabel];
        _noticeLabel.text = @"可修改，最多￥139.00，含发货邮费￥0.00";
        _noticeLabel.numberOfLines = 0;
      
    }
    return _noticeLabel;
}
-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"商家已同意您的退款申请，请按照以下地址退货";
        _nameLabel1.numberOfLines = 0;
      
    }
    return _nameLabel1;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;;
}
-(UITextField *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UITextField alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _detailsLabel.textColor =Main_Color;
        _detailsLabel.textAlignment = NSTextAlignmentRight;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.keyboardType = UIKeyboardTypePhonePad;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.detailsLabel];
    }
    return _detailsLabel;
}

@end
@implementation LLReturnShowComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    WS(weakself);
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.contentView.mas_centerY);
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));

    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(1));
    }];
}


-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.text = @"商家已同意您的退款申请，请按照以下地址退货";
        _nameLabel1.numberOfLines = 0;
      
    }
    return _nameLabel1;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end

@interface LLogCell ()
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UILabel *timelavel;/** class **/
@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UIImageView *showImage;

@end
@implementation LLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
//    self.nameLabel1.text = _model.remark;
//    self.detailsLabel.text = _model.created_at;
}
-(void)setRows:(NSInteger)rows{
    _rows = rows;
    if(_rows == 0){
        self.lineView1.hidden = YES;
        self.lineView.hidden = NO;
        self.showImage.image = [UIImage imageNamed:@"greenimage"];
    }else{
        self.lineView1.hidden = NO;
        self.showImage.image = [UIImage imageNamed:@"grayimage"];
    }
}
-(void)setLayout{
    WS(weakself);
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(0));
        make.width.mas_equalTo(CGFloatBasedI375(1));
        make.height.mas_equalTo(CGFloatBasedI375(25));
        make.left.offset(CGFloatBasedI375(37));

    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.lineView1.mas_centerX);
        make.height.width.offset(CGFloatBasedI375(15));
        make.top.equalTo(weakself.lineView1.mas_bottom).offset(CGFloatBasedI375(0));
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(0));
        make.width.mas_equalTo(CGFloatBasedI375(1));
        make.height.mas_equalTo(CGFloatBasedI375(100));

        make.centerX.equalTo(weakself.showImage.mas_centerX);
    }];
    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(15));
        make.right.offset(CGFloatBasedI375(-13));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(20));
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nameLabel1.mas_left).offset(CGFloatBasedI375(0));
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(8));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
        make.width.mas_equalTo(CGFloatBasedI375(1));
        make.centerX.equalTo(weakself.showImage.mas_centerX);
        make.top.equalTo(weakself.showImage.mas_bottom).offset(CGFloatBasedI375(0));
    }];

}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];;
        _showImage.image = [UIImage imageNamed:@"grayimage"];
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#A0A0A0"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

-(UILabel *)timelavel{
    if(!_timelavel){
        _timelavel = [[UILabel alloc]init];
        _timelavel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(12)];
        _timelavel.textColor =[UIColor colorWithHexString:@"#A0A0A0"];
        _timelavel.textAlignment = NSTextAlignmentLeft;
        _timelavel.userInteractionEnabled = YES;

        [self.contentView addSubview:self.timelavel];
    }
    return _timelavel;
}
-(UILabel *)detailsLabel{
    if(!_detailsLabel){
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _detailsLabel.textColor =[UIColor colorWithHexString:@"#A0A0A0"];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        _detailsLabel.userInteractionEnabled = YES;
        _detailsLabel.adjustsFontSizeToFitWidth = YES;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detailsLabel];
    }
    return _detailsLabel;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.contentView addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 0;
      
    }
    return _nameLabel1;
}
- (UIView *)lineView1{
    if(!_lineView1){
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [UIColor colorWithHexString:@"#A0A0A0"];
        [self.contentView addSubview:_lineView1];
    }
    return _lineView1;
}

@end
