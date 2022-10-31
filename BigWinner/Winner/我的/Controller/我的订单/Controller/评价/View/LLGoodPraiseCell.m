//
//  LLAllPraiseCell.m
//  ShopApp
//
//  Created by lijun L on 2021/5/24.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLGoodPraiseCell.h"
#import "LLMoreImageView.h"
#import "LEEStarRating.h"
CGFloat maxContentLabelHeight = 0;  //根据具体font而定
@interface LLGoodPraiseCell ()
@property (nonatomic,strong)  LLMoreImageView*moreImageView;/** 多张 **/
@property (nonatomic,strong) UIImageView *headImage;/** 头像 **/
@property (nonatomic,strong) UILabel *nickLabel;/** 昵称 **/
@property (nonatomic,strong) UILabel *contentLabel;/**内容  **/
@property (nonatomic,strong) UILabel *timeLabel;/**时间  **/
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *backView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *goodImage;/** 头像 **/
@property (nonatomic,strong) UILabel *goodName;/** 昵称 **/
@property (nonatomic,strong) UILabel *goodPrice;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *followBtn;
@property (nonatomic,strong) LEEStarRating *starRateView;/** <#class#> **/
@property (nonatomic,strong) UIView *viewSeparator;/** <#class#> **/
@property (nonatomic,strong)NSLayoutConstraint *cstHeightlbContent;
@property (nonatomic,strong)NSLayoutConstraint *cstHeightPicContainer;
@property (nonatomic,strong)NSLayoutConstraint *cstTopPicContainer;
@end
@implementation LLGoodPraiseCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =[UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    self.moreImageView = [[LLMoreImageView alloc] initWithWidth:SCREEN_WIDTH-20];
     [self.contentView addSubview:self.moreImageView];
    self.viewSeparator = [UIView new];
    [self.contentView addSubview:self.viewSeparator];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(40));
        make.width.offset(CGFloatBasedI375(40));
    }];

    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.headImage.mas_right).offset(CGFloatBasedI375(10));
        make.top.offset(CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(20));

    }];
    [self.starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.nickLabel.mas_right).offset(CGFloatBasedI375(10));
        make.centerY.equalTo(weakself.nickLabel.mas_centerY);
        make.width.offset(CGFloatBasedI375(150));
        make.height.offset(CGFloatBasedI375(19));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.headImage.mas_right).offset(CGFloatBasedI375(5));
        make.top.equalTo(weakself.nickLabel.mas_bottom).offset(11);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.headImage.mas_bottom).offset(11);
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.equalTo(weakself.moreImageView.mas_top).offset(-10);
    }];
    // 不然在6/6plus上就不准确了
    self.contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;

    [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(10);
        make.left.equalTo(weakself.contentLabel.mas_left);
        make.height.mas_equalTo(0);
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.equalTo(weakself.contentView.mas_bottom).offset(-8);
    }];
    [self.moreImageView setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
    [self.moreImageView setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
    _starRateView.currentScore = _model.star.floatValue;;
    [self.headImage sd_setImageWithUrlString:FORMAT(@"%@",_model.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    self.nickLabel.text = _model.nickName;
    self.timeLabel.text =_model.createTime;
//    self.goodName.text = _model.attr;
    self.contentLabel.text =_model.content;
    self.moreImageView.isPraise = YES;
    if(_model.images.length > 0){
        NSArray *datas = [_model.images componentsSeparatedByString:@","];
        self.moreImageView.picUrlArray =datas;
    }else{
        self.moreImageView.picUrlArray =@[];
    }
    CGFloat heis = [self.contentLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - CGFloatBasedI375(70), CGFLOAT_MAX) font:[UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)] lineSpacing:1.0].height;
    WS(weakself);
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(heis);
    }];
    [self.moreImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentLabel.mas_bottom).offset(CGFloatBasedI375(5));
    }];

        
//    if(datas.count > 0){
//        self.moreImageView.hidden = NO;
//        self.moreImageView.data = datas;
//    }else{
//        self.moreImageView.hidden = YES;
//    }
//    [self setLayout];
}
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage =[[UIImageView alloc]init];
        [self.contentView addSubview:self.headImage];
        _headImage.userInteractionEnabled = YES;
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = CGFloatBasedI375(20);
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickhead)];
//        [_headImage addGestureRecognizer:tap];
    }
    return _headImage;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"2019-05-12 18:30 ";
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:self.timeLabel];
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}
-(UILabel *)goodName{
    if(!_goodName){
        _goodName = [[UILabel alloc]init];
        _goodName.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _goodName.textAlignment = NSTextAlignmentLeft;
        _goodName.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:self.goodName];
    }
    return _goodName;
}

- (LEEStarRating*)starRateView
{
    if (_starRateView == nil) {
        _starRateView = [[LEEStarRating alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-CGFloatBasedI375(135), CGFloatBasedI375(10), CGFloatBasedI375(100), CGFloatBasedI375(30))];
        _starRateView.checkedImage = [UIImage imageNamed:@"xing_red"];
        _starRateView.uncheckedImage = [UIImage imageNamed:@"xing_gray"];
        [self.backView addSubview:self.starRateView];
    }
    return _starRateView;
}
-(UIImageView *)goodImage{
    if(!_goodImage){
        _goodImage =[[UIImageView alloc]init];
        [self.backView addSubview:self.goodImage];
    }
    return _goodImage;
}
-(UIButton *)deleteBtn{
    if(!_deleteBtn){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.layer.cornerRadius = CGFloatBasedI375(5);
        _deleteBtn.layer.borderWidth = 1;
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.borderColor = [lightGray9999_Color CGColor];
        [_deleteBtn setTitle:@"删除评论" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:lightGray9999_Color forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        [_deleteBtn addTarget:self action:@selector(clickpush:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.deleteBtn];
        _deleteBtn.tag = 2;
    }
    return _deleteBtn;
}
-(UIButton *)followBtn{
    if(!_followBtn){
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _followBtn.layer.cornerRadius = CGFloatBasedI375(5);
        _followBtn.layer.borderWidth = 1;
        _followBtn.layer.masksToBounds = YES;
        _followBtn.tag = 2;
        _followBtn.layer.borderColor = [lightGray9999_Color CGColor];
        [_followBtn setTitle:@"追加评论" forState:UIControlStateNormal];
        [_followBtn setTitleColor:lightGray9999_Color forState:UIControlStateNormal];
        _followBtn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        [_followBtn addTarget:self action:@selector(clickpush:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.followBtn];
    }
    return _followBtn;
}
-(void)clickpush:(UIButton *)sender{

}
-(UILabel *)goodPrice{
    if(!_goodPrice){
        _goodPrice = [[UILabel alloc]init];
        _goodPrice.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _goodPrice.textAlignment = NSTextAlignmentLeft;
        _goodPrice.text = @" ";
        _goodPrice.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.backView addSubview:self.goodPrice];
        _goodPrice.numberOfLines = 0;
    }
    return _goodPrice;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:_backView];
    }
    return _backView;
}
//-(LLMoreImageView *)moreImageView{
//    if(!_moreImageView){
//        _moreImageView = [[LLMoreImageView alloc]init];
//        _moreImageView.hidden = YES;
//        [self addSubview:self.moreImageView];
//    }
//    return _moreImageView;
//}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self addSubview:_lineView];
    }
    return _lineView;
}


-(void)moreclick:(UIButton *)sender{
    
}
-(UILabel *)nickLabel{
    if(!_nickLabel){
        _nickLabel = [[UILabel alloc]init];
        _nickLabel.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(13)];
        _nickLabel.textAlignment = NSTextAlignmentLeft;
        _nickLabel.text = @"";
        [self.contentView addSubview:self.nickLabel];
        _nickLabel.adjustsFontSizeToFitWidth = YES;
        _nickLabel.userInteractionEnabled = YES;

    }
    return _nickLabel;
}
-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.text = @"拿来看也没看就洗了，发现有些不对劲，吊牌都没有，洗的时候 还有泡沫，细看领口有一处缝补的痕迹，虽然是特价买的… ";
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:self.contentLabel];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
