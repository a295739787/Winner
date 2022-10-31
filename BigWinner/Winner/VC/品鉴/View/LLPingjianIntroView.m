//
//  LLPingjianIntroView.m
//  Winner
//
//  Created by mac on 2022/2/9.
//

#import "LLPingjianIntroView.h"
@interface LLPingjianIntroView ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *noticeLabel;/** class **/
@property (nonatomic,strong) UIImageView *showImage;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton;/** class **/
@property (nonatomic,strong) UIButton *closeButton;/** <#class#> **/
@property (nonatomic,strong) UIScrollView *scollview;/** <#class#> **/
@property (nonatomic,strong) UIScrollView *picView;

@end
@implementation LLPingjianIntroView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){

        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideActionSheetView)];
        tap.delegate = self;
        tap.cancelsTouchesInView = YES;
        [self addGestureRecognizer:tap];
        [self  setLayout];
    }
    return self;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.left.mas_equalTo(CGFloatBasedI375(0));
        make.bottom.mas_equalTo(-DeviceXTabbarHeigh(77));
        make.top.mas_equalTo(CGFloatBasedI375(77));
     }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.width.height.mas_equalTo(CGFloatBasedI375(40));
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
     }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(CGFloatBasedI375(37.5));
        make.right.mas_equalTo(-CGFloatBasedI375(37.5));
        make.top.mas_equalTo(CGFloatBasedI375(0));
        make.bottom.equalTo(weakself.sureButton.mas_top).offset(-CGFloatBasedI375(18));

     }];
}
///**解决点击子view穿透到父视图的问题*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.backView]) {
        return NO;
    }
    return YES;
}
- (void)setModel:(LLGoodModel *)model{
    _model = model;
    [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",_model.judgeImage) placeholderImage:[UIImage imageNamed:morenpic]];

}
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor =[UIColor clearColor];
        _backView.userInteractionEnabled = YES;
        [self addSubview:_backView];
    }
    return _backView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]init];
//        _showImage.image =[UIImage imageNamed:@"pj_xqt"];
        [self.backView addSubview:self.showImage];
    }
    return _showImage;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setImage:[UIImage imageNamed:@"pj_close"] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(hideActionSheetView) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.sureButton];
    }
    return _sureButton;
}
- (void)showActionSheetView {
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
    
}

- (void)hideActionSheetView {
    [self removeFromSuperview];
}

@end
