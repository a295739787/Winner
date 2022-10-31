//
//  LLGoodDetailHeadView.m
//  ShopApp
//
//  Created by lijun L on 2021/3/23.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLGoodDetailHeadView.h"
#import "SJXSignTextView.h"
@interface LLGoodDetailHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic ,strong) SJXSignTextView *limitTextView;
@end
@implementation LLGoodDetailHeadView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}

-(void)setModel:(LLGoodModel *)model{
    _model = model;
    
    if (_model.purchaseRestrictions > 0) {
        self.limitTextView.text = FORMAT(@"单次限%ld瓶",_model.purchaseRestrictions);
        [self.limitTextView setHidden:NO];
    }else{
        [self.limitTextView setHidden:YES];
    }

    self.pricelable.attributedText = [self getAttribuStrWithStrings:@[@"￥",FORMAT(@"%.2f",_model.salesPrice.floatValue)] fonts:@[ [UIFont systemFontOfSize:CGFloatBasedI375(13)], [UIFont boldFontWithFontSize:CGFloatBasedI375(17)]] colors:@[ Main_Color, Main_Color]];
//    
    if(_model.scribingPrice.length  > 0){
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:FORMAT(@"￥%.2f",_model.scribingPrice.floatValue)];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,str.length)];
        self.oldpricelable.attributedText = str;
    }
    self.titlelable.text = _model.name;
    self.salelable.text = FORMAT(@"销量%@",_model.realSalesVolume);
    NSArray *images = [_model.images componentsSeparatedByString:@","];
    NSMutableArray *tempimage = [NSMutableArray array];
    if(images.count > 0){
        for(NSString *str in images){
            if([str containsString:@"http"]){
                [tempimage addObject:FORMAT(@"%@",str)];
            }else{
                [tempimage addObject:FORMAT(@"%@%@",API_IMAGEHOST,str)];
            }
        }
    }
    self.sycleview.imageURLStringsGroup = tempimage;
//    CGFloat heights = [ _model.goods_name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - CGFloatBasedI375(24), CGFLOAT_MAX) font:[UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)] lineSpacing:2.0].height;
//
//    CGFloat h =SCREEN_WIDTH+CGFloatBasedI375(60)+heights;
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(h);
//   }];
}
- (void)setLayout {
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    WS(weakself);
    [self.sycleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(CGFloatBasedI375(0));
        make.height.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.sycleview.mas_bottom).offset(CGFloatBasedI375(12));
        make.left.offset(CGFloatBasedI375(12));
        make.height.offset(CGFloatBasedI375(20));
    }];
    [self.oldpricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.pricelable.mas_centerY);
        make.left.equalTo(weakself.pricelable.mas_right).offset(CGFloatBasedI375(10));
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.pricelable.mas_bottom).offset(CGFloatBasedI375(8));
        make.left.offset(CGFloatBasedI375(12));
//        make.height.offset(CGFloatBasedI375(40));
        make.right.mas_equalTo(CGFloatBasedI375(-12));
        make.bottom.offset(CGFloatBasedI375(-10));
    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(CGFloatBasedI375(0));
//        make.left.offset(CGFloatBasedI375(0));
//        make.right.mas_equalTo(CGFloatBasedI375(0));
//        make.height.offset(CGFloatBasedI375(10));
//    }];

//    [self.addlable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(CGFloatBasedI375(-12));
//        make.height.offset(CGFloatBasedI375(40));
//        make.bottom.offset(CGFloatBasedI375(0));
//    }];
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(CGFloatBasedI375(-15));
//        make.centerY.equalTo(weakself.pricelable.mas_centerY);
//    }];
    [self.salelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(-15));
        make.height.offset(CGFloatBasedI375(20));
        make.centerY.equalTo(weakself.pricelable.mas_centerY);
    }];
    
    
}
-(SDCycleScrollView *)sycleview{
    if(!_sycleview){
      _sycleview= [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@""]];
           _sycleview.autoScrollTimeInterval = 4;
        _sycleview.backgroundColor = White_Color;
        _sycleview.currentPageDotColor = UIColor.redColor;
    
   [self addSubview:_sycleview];
           _sycleview.delegate = self;
    }
    return _sycleview;
}
-(UILabel *)oldpricelable{
    if(!_oldpricelable){
        _oldpricelable =[[UILabel alloc]init];
        _oldpricelable.text = @"¥0.00";
        _oldpricelable.textColor =lightGray9999_Color;
        _oldpricelable.textAlignment = NSTextAlignmentLeft;
        _oldpricelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self addSubview:self.oldpricelable];

    }
    return _oldpricelable;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont boldSystemFontOfSize:CGFloatBasedI375(17)];
        [self addSubview:self.titlelable];
        _titlelable.numberOfLines =0;
    }
    return _titlelable;
}
-(UILabel *)salelable{
    if(!_salelable){
        _salelable =[[UILabel alloc]init];
        _salelable.text = @"已售：0 件";
        _salelable.textColor = [UIColor colorWithHexString:@"#666666"];
        _salelable.textAlignment = NSTextAlignmentLeft;
        _salelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self addSubview:self.salelable];
    }
    return _salelable;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self addSubview:_lineView];
    }
    return _lineView;
}
-(UILabel *)addlable{
    if(!_addlable){
        _addlable =[[UILabel alloc]init];
        _addlable.textColor = [UIColor colorWithHexString:@"#666666"];
        _addlable.textAlignment = NSTextAlignmentRight;
        _addlable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self addSubview:self.addlable];
    }
    return _addlable;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable =[[UILabel alloc]init];
        _pricelable.text = @"价格 ￥0";
        _pricelable.textColor =Main_Color;
        _pricelable.textAlignment = NSTextAlignmentLeft;
        _pricelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self addSubview:self.pricelable];
    }
    return _pricelable;
}
-(UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shareimage"] forState:UIControlStateNormal];
        [self addSubview:self.shareBtn];
    }
    return _shareBtn;
}
-(SJXSignTextView *)limitTextView{
    
    if (!_limitTextView) {
        _limitTextView = [[SJXSignTextView alloc] init];
        _limitTextView.frame = CGRectMake(0, 0, 80, 80);
        _limitTextView.directionType = TextDirectionTypeLeft;
        _limitTextView.textColor = [UIColor whiteColor];
        _limitTextView.bgColor = [UIColor redColor];
        _limitTextView.textFont = 10;
        [_limitTextView setHidden:YES];
        [self addSubview:_limitTextView];
    }
    return _limitTextView;
}

@end
@interface LLGoodSectionPraiseView ()
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UIImageView *allowimage;
@property(nonatomic,strong)UILabel *delable;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView1;/** <#class#> **/

@end
@implementation LLGoodSectionPraiseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);

    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(CGFloatBasedI375(12));
        make.height.mas_equalTo(CGFloatBasedI375(40));
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
     }];
    [self.allowimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(CGFloatBasedI375(-17));
         make.centerY.equalTo(weakself.titlelable.mas_centerY);
     }];
    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.allowimage.mas_left).offset(CGFloatBasedI375(-5));
        make.centerY.equalTo(weakself.titlelable.mas_centerY);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(1));
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
     }];
}
-(void)setTotals:(NSString *)totals{
    _totals = totals;
    _titlelable.text =FORMAT(@"商品评价(%@)",_totals);
    if(_totals.integerValue == 0){
        _delable.hidden = YES;
        self.allowimage.hidden = YES;
    }else{
        _delable.hidden = NO;
        self.allowimage.hidden = NO;
    }
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.text = @"商品评价(0)";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.titlelable];
    }
    return _titlelable;
}
-(UILabel *)delable{
    if(!_delable){
        _delable = [[UILabel alloc]init];
        _delable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _delable.textAlignment = NSTextAlignmentRight;
        _delable.textColor =[UIColor colorWithHexString:@"#999999"];
        _delable.text = @"查看全部评论";
        [self addSubview:self.delable];
    }
    return _delable;
}
-(UIImageView *)allowimage{
    if(!_allowimage){
        _allowimage = [[UIImageView alloc]init];
        [self addSubview:_allowimage];
        _allowimage.image = [UIImage imageNamed:allowimageGray];
    }
    return _allowimage;
    
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self addSubview:_lineView];
    }
    return _lineView;
}
- (UIView *)lineView1{
    if(!_lineView1){
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = BG_Color;
        [self addSubview:_lineView1];
    }
    return _lineView1;
}
@end
@interface LLGoodSectionDetilasView ()
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UIImageView *showleftimage;
@property(nonatomic,strong)UIImageView *showrightimage;

@end
@implementation LLGoodSectionDetilasView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = White_Color;
        [self setLayout];
    }
    return self;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);

    [self.showleftimage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(CGFloatBasedI375(60));
        make.height.mas_equalTo(CGFloatBasedI375(11));
        make.width.mas_equalTo(CGFloatBasedI375(90));
        make.centerY.equalTo(weakself.mas_centerY);

     }];
    [self.showrightimage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(-CGFloatBasedI375(60));
        make.height.mas_equalTo(CGFloatBasedI375(11));
        make.width.mas_equalTo(CGFloatBasedI375(90));
        make.centerY.equalTo(weakself.mas_centerY);

     }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.showrightimage.mas_left).offset(CGFloatBasedI375(-5));
        make.left.equalTo(weakself.showleftimage.mas_right).offset(CGFloatBasedI375(5));
         make.centerY.equalTo(weakself.mas_centerY);
     }];
 
}

-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.text = @"商品详情";
        _titlelable.textColor = [UIColor colorWithHexString:@"#837D71"];
        [self addSubview:self.titlelable];
    }
    return _titlelable;
}

-(UIImageView *)showleftimage{
    if(!_showleftimage){
        _showleftimage = [[UIImageView alloc]init];
        [self addSubview:_showleftimage];
        _showleftimage.image = [UIImage imageNamed:@"spxq_left"];
    }
    return _showleftimage;
    
}
-(UIImageView *)showrightimage{
    if(!_showrightimage){
        _showrightimage = [[UIImageView alloc]init];
        [self addSubview:_showrightimage];
        _showrightimage.image = [UIImage imageNamed:@"spxq_right"];
    }
    return _showrightimage;
    
}
@end
