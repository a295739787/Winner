//
//  LLShopCarCell.m
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import "LLShopCarCell.h"
@interface LLShopCarCell ()
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UIImageView *numsImageview;
@property (nonatomic,strong) UILabel *priceLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIButton *selectButton;/** <#class#> **/
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
@implementation LLShopCarCell

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
        self.backgroundColor = [UIColor clearColor];
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(CGFloatBasedI375(0));

    }];

    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.centerY.equalTo(weakself.backView.mas_centerY);
        make.height.width.offset(CGFloatBasedI375(20));
    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.selectButton.mas_right).offset(CGFloatBasedI375(15));
        make.height.width.offset(CGFloatBasedI375(80));
        make.centerY.equalTo(weakself.backView.mas_centerY);
    }];

    [self.nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.showImage.mas_top).offset(CGFloatBasedI375(0));
        make.right.offset(CGFloatBasedI375(-10));
//        make.height.offset(CGFloatBasedI375(40));
        make.left.equalTo(weakself.showImage.mas_right).offset(CGFloatBasedI375(12));
    }];

    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel1.mas_bottom).offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.nameLabel1.mas_left);
        make.right.offset(CGFloatBasedI375(-20/2));
        make.height.offset(CGFloatBasedI375(25));
    }];

    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(CGFloatBasedI375(0));
        make.left.equalTo(weakself.nameLabel1.mas_left);
        make.height.offset(CGFloatBasedI375(1));
    }];
 
  
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nameLabel1.mas_left);
//        make.width.equalTo(CGFloatBasedI375(50));
        make.bottom.equalTo(weakself.showImage.mas_bottom).offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(14));
    }];
//    [self.priceoldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.priceLabel.mas_right).offset(CGFloatBasedI375(8));
//        make.centerY.equalTo(weakself.priceLabel.mas_centerY);
////        make.right.equalTo(weakself.countview.mas_left).offset(CGFloatBasedI375(-5));
//    }];
    [self.countview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(-15));
        make.width.offset(CGFloatBasedI375(80));
        make.height.offset(CGFloatBasedI375(40));
        make.centerY.equalTo(weakself.priceLabel.mas_centerY);
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

-(void)setIndexPath:(NSIndexPath *)IndexPath{
    _IndexPath = IndexPath;
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    self.selectButton.selected = _model.isSelect;
    self.countlabel.text = _model.goodsNum;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.coverImage) placeholderImage:[UIImage imageNamed:morenpic]];
    self.detailsLabel.text = FORMAT(@"%@",_model.specsValName);
    self.nameLabel1.text = _model.name;
    self.priceLabel.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(12)], [UIFont dinFontWithFontSize:CGFloatBasedI375(16)]] colors:@[ Main_Color, Main_Color]];

}
#pragma mark ============= 懒加载 =============

-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        [self.contentView addSubview:self.backView];
    }
    return _backView;
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
        [self.backView addSubview:self.showImage];
    }
    return _showImage;
}

-(UILabel *)nameLabel1{
    if(!_nameLabel1){
        _nameLabel1 = [[UILabel alloc]init];
        _nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        _nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        _nameLabel1.textAlignment = NSTextAlignmentLeft;
        _nameLabel1.userInteractionEnabled = YES;
        [self.backView addSubview:self.nameLabel1];
        _nameLabel1.numberOfLines = 2;
        _nameLabel1.text = @"大赢家 初心 500ml单瓶装 酱香型白酒";
    }
    return _nameLabel1;
}

-(UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(12)];
        _priceLabel.textColor =Main_Color;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.userInteractionEnabled = YES;
        [self.backView addSubview:self.priceLabel];
        _priceLabel.text = @"¥ 169.00";
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
        [self.backView addSubview:self.detailsLabel];
        _detailsLabel.text = @"1支装(500ML)";

    }
    return _detailsLabel;
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
        [self.backView addSubview:self.countNumsLabel];
    }
    return _countNumsLabel;
}
-(UIButton *)selectButton{
    if(!_selectButton){
        _selectButton = [UIButton buttonWithTitle:@"" atBackgroundNormalImageName:@"xz_gray" atBackgroundSelectedImageName:@"xz_red" atTarget:self atAction:@selector(clickSelectBtn:)];
        [_selectButton setEnlargeEdge:30];
        [self.backView addSubview:self.selectButton];
    }
    return _selectButton;
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
-(UIView *)lineview
{
    if (_lineview == nil) {
        _lineview = [[UIView alloc]init];
        [_lineview setBackgroundColor:lightGrayF5F5_Color];
         [self.backView addSubview: self.lineview];
    }
    return _lineview;
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

-(void)selectBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.ClickRowBlock) {
        self.ClickRowBlock(sender.selected);
    }
}
-(void)mintes{
    NSInteger count = [self.countlabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
//    self.countlabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.CutBlock) {
        self.CutBlock(self.countlabel,_IndexPath.row,count);
    }
}
-(void)add{
    NSInteger count = [self.countlabel.text integerValue];
    count++;
//    self.countlabel.text = [NSString stringWithFormat:@"%ld", count];
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

-(void)clickSelectBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
               if (sender.selected) {
                   sender.selected = YES;
               } else {
                   sender.selected = NO;
               }
               if (self.ClickRowBlock) {
                   self.ClickRowBlock(sender.selected);
               }
}

@end
