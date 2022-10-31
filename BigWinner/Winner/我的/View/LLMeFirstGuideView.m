//
//  LLMeFirstGuideView.m
//  Winner
//
//  Created by YP on 2022/3/26.
//

#import "LLMeFirstGuideView.h"

@interface LLMeFirstGuideView ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIImageView *imgView;


@end

@implementation LLMeFirstGuideView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self addSubview:self.bottomView];
    [self addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(114));
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH - CGFloatBasedI375(30));
//        make.height.mas_equalTo(CGFloatBasedI375(257));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(60));
    }];
}
-(void)setType:(NSString *)type{
    _type = type;
    
    if ([type intValue] == 1) {
        _imgView.image = [UIImage imageNamed:@"guide_psy"];
    }else{
        _imgView.image = [UIImage imageNamed:@"guide_tgd"];
    }
}

-(void)hidden{
    [self removeFromSuperview];
}
-(void)show{
    [[NSUserDefaults standardUserDefaults] setObject:@"guide_psy_status" forKey:@"guide_psy_status"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)tap{
   
    
    [self hidden];
}

#pragma mark--clazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.6;
    }
    return _bottomView;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//        tap.numberOfTapsRequired = 1;
//        [_imgView addGestureRecognizer:tap];
    }
    return _imgView;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.imgView addSubview:self.sureButton];
    }
    return _sureButton;
}
-(void)clickTap:(UIButton *)sender{
    
}

@end
