//
//  LLMainHotCell.m
//  ShopApp
//
//  Created by lijun L on 2021/3/20.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLPinJianViewCell.h"
@interface LLPinJianViewCell ()
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

@property(nonatomic,strong)UILabel *timelable;

@end
@implementation LLPinJianViewCell

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
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.width.mas_equalTo(CGFloatBasedI375(100));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.offset(CGFloatBasedI375(18));
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
//    [self.catolable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-CGFloatBasedI375(15));
//        make.centerY.equalTo(weakself.pricelable.mas_centerY);
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
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];

    _titlelable.text = _model.name;
    _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont dinFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];
    _delable.text = FORMAT(@"推荐理由：%@",_model.recommend);
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
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
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
      
        _delable.textColor = [UIColor colorWithHexString:@"#F08716"];
        _delable.textAlignment = NSTextAlignmentLeft;
        _delable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.backView addSubview:self.delable];
        _delable.numberOfLines =2;
    }
    return _delable;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable =[[UILabel alloc]init];
        _pricelable.text = @"品鉴价¥99";
        _pricelable.attributedText = [self getAttribuStrWithStrings:@[@"品鉴价 ¥",FORMAT(@"%@",@"99")] fonts:@[[UIFont systemFontOfSize:CGFloatBasedI375(15)],[UIFont boldFontWithFontSize:CGFloatBasedI375(19)]]];
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
@end
@interface LLPinJianSectionViewCell ()
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

@property(nonatomic,strong)UILabel *timelable;

@end
@implementation LLPinJianSectionViewCell
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
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(0));
        make.left.offset(CGFloatBasedI375(10));
        make.right.mas_equalTo(-CGFloatBasedI375(10));
        make.bottom.mas_equalTo(-CGFloatBasedI375(0));
    }];
   
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.image) placeholderImage:[UIImage imageNamed:morenpic]];

}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;
        _showImage.layer.masksToBounds = YES;
        _showImage.layer.cornerRadius = CGFloatBasedI375(10);
        _showImage.image =[UIImage imageNamed:@"sp1"];
        _showImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}
@end
@interface LLPinJianPicViewCell ()
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

@property(nonatomic,strong)UILabel *timelable;

@end
@implementation LLPinJianPicViewCell
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self creatPaixufirbutton];
    }
    return self;
}
#define btnTags 200
#pragma mark - 创建界面
-(void)creatPaixufirbutton{
    NSArray *titlearr = @[@"物流配送",@"同城配送"];
    for (int i = 0; i < titlearr.count; i ++) {
        CGFloat w = (SCREEN_WIDTH-(30))/2;
        CGFloat h =CGFloatBasedI375(200);
        CGFloat x = CGFloatBasedI375(10)+(w + CGFloatBasedI375(10))*(i%2);
        CGFloat y =CGFloatBasedI375(10);
        UIImageView *btn = [[UIImageView alloc]initWithFrame:CGRectMake(x,y,w,h)];
        [self.contentView addSubview:btn];
        btn.tag = btnTags+i;
        btn.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
        [btn addGestureRecognizer:tap];
//        [self.dataArr addObject:btn];
    }
}
-(void)tapclick:(UITapGestureRecognizer *)sender{

    if(self.pushOrderBlock){
        if(_datas.count>1){
            LLGoodModel *model = _datas[(sender.view.tag-btnTags)+1];
            self.pushOrderBlock(model);
        }
       
        
    }
   
}
-(void)setDatas:(NSArray *)datas{
    _datas = datas;
    
    for( UIImageView *btn in self.contentView.subviews){
        [btn removeAllSubviews];
    }
    if(_datas.count > 1 && _datas.count < 3){
        LLGoodModel *model = _datas[1];
        UIImageView *views  = [self  viewWithTag:btnTags];
        NSString *image =model.image;
        if(image.length <= 0){
            image =model.coverImage;
        }
        [views  sd_setImageWithUrlString:FORMAT(@"%@",image ) placeholderImage:[UIImage imageNamed:morenpic]];
    }
    if(_datas.count >= 3){
        LLGoodModel *model = _datas[1];
        UIImageView *views  = [self  viewWithTag:btnTags];
        NSString *image =model.image;
        if(image.length <= 0){
            image =model.coverImage;
        }
        [views  sd_setImageWithUrlString:FORMAT(@"%@",image) placeholderImage:[UIImage imageNamed:morenpic]];
        LLGoodModel *models = _datas[2];
        NSString *image1 =models.image;
        if(image1.length <= 0){
            image1 =models.coverImage;
        }
        UIImageView *views1  = [self  viewWithTag:btnTags+1];
        [views1  sd_setImageWithUrlString:FORMAT(@"%@",image1) placeholderImage:[UIImage imageNamed:morenpic]];
    }
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage ) placeholderImage:[UIImage imageNamed:morenpic]];

}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;
        _showImage.layer.masksToBounds = YES;
        _showImage.layer.cornerRadius = CGFloatBasedI375(10);
        _showImage.image =[UIImage imageNamed:@"sp1"];
        _showImage.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.contentView addSubview:self.showImage];
    }
    return _showImage;
}
@end
@interface LLPinJianViewCountCell ()
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property (nonatomic,strong) UILabel *countNumsLabel;/** <#class#> **/
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UILabel *countlabel;
@property(nonatomic,strong)UIView *countview;
@property(nonatomic,strong)UIButton *minutelBtn;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UIButton *mineButton;
@property (nonatomic,strong) UIButton *addButton;

@end
@implementation LLPinJianViewCountCell
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
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.width.offset(CGFloatBasedI375(80));
        make.centerY.equalTo(weakself.contentView.mas_centerY);
    }];

    [self.countview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(-15));
        make.width.offset(CGFloatBasedI375(80));
        make.height.offset(CGFloatBasedI375(40));
        make.centerY.equalTo(weakself.titlelable.mas_centerY);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(0));
        make.width.offset(CGFloatBasedI375(30));
        make.height.offset(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.countview.mas_centerY);
    }];

    [self.countlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.countview.mas_centerX);
        make.width.offset(CGFloatBasedI375(40));
        make.height.offset(CGFloatBasedI375(18));
        make.centerY.equalTo(weakself.countview.mas_centerY);
    }];

    [self.minutelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.width.offset(CGFloatBasedI375(30));
        make.height.offset(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.countview.mas_centerY);
    }];

}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
//    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage ) placeholderImage:[UIImage imageNamed:morenpic]];

}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
        _titlelable.text = @"数量";
    }
    return _titlelable;
}
-(UIView *)line2
{
    if (_line2 == nil) {
        _line2 = [[UIView alloc]init];
        [_line2 setBackgroundColor:[UIColor colorWithHexString:@"#DDDDDD"] ];
         [self.countview addSubview: self.line2];
    }
    return _line2;
}
-(UIView *)line1
{
    if (_line1 == nil) {
        _line1 = [[UIView alloc]init];
        [_line1 setBackgroundColor:[UIColor colorWithHexString:@"#DDDDDD"] ];
         [self.countview addSubview: self.line1];
    }
    return _line1;
}

- (UIButton *)minutelBtn{
    if(!_minutelBtn){
        _minutelBtn = [[UIButton alloc]init];
        [_minutelBtn setImage:[UIImage imageNamed:@"jian_1"] forState:UIControlStateNormal];
        [_minutelBtn addTarget:self action:@selector(mintes) forControlEvents:UIControlEventTouchUpInside];
        [self.countview addSubview:self.minutelBtn];
        [_minutelBtn setEnlargeEdge:10];
    }
    return _minutelBtn;
}

-(void)setIndexPath:(NSIndexPath *)IndexPath{
    _IndexPath = IndexPath;
}
-(void)mintes{
    NSInteger count = [self.countlabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    self.countlabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.CutBlock) {
        self.CutBlock(self.countlabel,_IndexPath.row,count);
    }
}
-(void)add{
    NSInteger count = [self.countlabel.text integerValue];
    count++;
    if(count > _model.goodsStock.integerValue){
        [JXUIKit showErrorWithStatus:@"商品库存不足"];
        return;;
    }
    self.countlabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.AddBlock) {
        self.AddBlock( self.countlabel,_IndexPath.row,count);
    }
}
- (UIButton *)addBtn{
    if(!_addBtn){
        _addBtn = [[UIButton alloc]init];
        [_addBtn setImage:[UIImage imageNamed:@"jia_1"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setEnlargeEdge:10];
        [self.countview addSubview:self.addBtn];
    }
    return _addBtn;
}
-(UILabel *)countlabel{
    if(!_countlabel){
        _countlabel = [[UILabel alloc]init];
        _countlabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        _countlabel.textAlignment = NSTextAlignmentCenter;
        _countlabel.text = @"1";
        _countlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.countview addSubview:self.countlabel];
//        _countlabel.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _countlabel;
}
-(UIView *)countview{
    if(!_countview){
        _countview = [[UIView alloc]init];
        [self addSubview:self.countview];
//        _countview.layer.masksToBounds = YES;
//        _countview.layer.cornerRadius = CGFloatBasedI375(2);
//        _countview.layer.borderColor = [[UIColor colorWithHexString:@"#DDDDDD"] CGColor];
//        _countview.layer.borderWidth =.5f;
    }
    return _countview;
}

@end
