//
//  LLStoreSureOrderHeadView.m
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LLStoreSureOrderHeadView.h"
@interface LLStoreSureOrderHeadView ()
@property(nonatomic,strong)UIImageView *showImage;
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *delable;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end
@implementation LLStoreSureOrderHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self creatPaixufirbutton];
    }
    return self;
}
#pragma mark - 创建界面
-(void)creatPaixufirbutton{
    NSArray *titlearr = @[@"物流配送",@"同城配送"];
    NSArray *imager = @[@"tcps_white",@"tcps_gray"];
    NSArray *imagerSe = @[@"wlps_white",@"tcps_gray"];
    for (int i = 0; i < titlearr.count; i ++) {
        CGFloat w = (SCREEN_WIDTH-(30+10))/2;
        CGFloat h =CGFloatBasedI375(34);
        CGFloat x = CGFloatBasedI375(15)+(w + CGFloatBasedI375(10))*(i%2);
        CGFloat y =CGFloatBasedI375(5);
        LLStoreSureOrderLitterView *btn = [[LLStoreSureOrderLitterView alloc]initWithFrame:CGRectMake(x,y,w,h)];
        btn.tag = i;
        btn.titles = titlearr[i];
        btn.images = imager[i];
        [self addSubview:btn];
        if(i == 0){
            btn.backgroundColor = Main_Color;
            btn.images = imagerSe[i];
            btn.titlelable.textColor = lightGrayFFFF_Color;
        }
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = CGFloatBasedI375(17);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
        [btn addGestureRecognizer:tap];
        [self.dataArr addObject:btn];
    }
}
-(void)tapclick:(UITapGestureRecognizer *)sender{
    NSArray *imagerSe = @[@"wlps_gray",@"tcps_gray"];
    for(NSInteger i = 0;i<self.dataArr.count;i++){
        LLStoreSureOrderLitterView *btn = self.dataArr[i];
        btn.backgroundColor =  [UIColor colorWithHexString:@"#FAFAFA"];
        btn.images = imagerSe[i];
        btn.titlelable.textColor = [UIColor colorWithHexString:@"#443415"];
    }

    LLStoreSureOrderLitterView *view = (LLStoreSureOrderLitterView *)sender.view;
    view.backgroundColor = Main_Color;
    NSArray *imager = @[@"wlps_white",@"tcps_white"];
    view.images = imager[sender.view.tag];
    view.titlelable.textColor = lightGrayFFFF_Color;
    if(self.tapClick){
        self.tapClick(sender.view.tag+1);
    }
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
@end
@interface LLStoreSureOrderLitterView ()
@property(nonatomic,strong)UIImageView *showimage;
@end
@implementation LLStoreSureOrderLitterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        [self setLayout];
    }
    return self;
}
-(void)setImages:(NSString *)images{
    _images = images;
    self.showimage.image = [UIImage imageNamed:_images];
}
-(void)setTitles:(NSString *)titles{
    _titles = titles;
    self.titlelable.text = _titles;
}
-(void)setLayout{
    WS(weakself);
    [self.showimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(CGFloatBasedI375(18));
        make.height.offset(CGFloatBasedI375(18));
        make.centerY.equalTo(weakself.mas_centerY);
        make.left.offset(CGFloatBasedI375(43));

    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.showimage.mas_right).offset(CGFloatBasedI375(4));
        make.right.offset(CGFloatBasedI375(-1));
        make.centerY.equalTo(weakself.mas_centerY);

    }];
}
- (UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        _showimage.userInteractionEnabled =NO;
        [self addSubview:self.showimage];
    }
    return _showimage;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.text = @"";
        _titlelable.textColor = [UIColor colorWithHexString:@"#443415"];
        [self addSubview:self.titlelable];
        _titlelable.adjustsFontSizeToFitWidth = YES;
    }
    return _titlelable;
}
@end

