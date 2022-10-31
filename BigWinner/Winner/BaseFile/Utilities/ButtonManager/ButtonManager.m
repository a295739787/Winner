//
//  VoiceManager.m
//  SmartDevice
//
//  Created by admin on 16/6/3.
//  Copyright © 2016年 ALPHA. All rights reserved.
//

#import "ButtonManager.h"
#import "DWBubbleMenuButton.h"
//#import "UIHelper.h"
//#import "AFCommonEngine.h"

@interface ButtonManager ()<DWBubbleMenuViewDelegate>
//音量按钮
@property (strong, nonatomic)  DWBubbleMenuButton *downMenuButton;
//按钮图案
@property (strong, nonatomic) UIImageView *menuImageView;
//遮罩
@property (strong, nonatomic) UIView *coverView;
//要显示按钮的页面
@property (strong, nonatomic) UIView *showView;
//菜单按钮是否被选中
@property (assign, nonatomic) BOOL isMenuSelect;
///设置声音大小
@property (strong, nonatomic) NSString *setVoice;

// 横排 布局
@property (strong, nonatomic) UIView *landscapeView;
// 横排 布局
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@end

@implementation ButtonManager

+ (ButtonManager *)sharedManager
{
    static ButtonManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
+ (void)clickVoiceButtonAtIndex:(ClickBlock)clickBlock
                        Request:(RequestBlock)requestBlock {
    [[ButtonManager sharedManager] clickVoiceButtonAtIndex:clickBlock Request:requestBlock];
}
- (void)clickVoiceButtonAtIndex:(ClickBlock)clickBlock
                        Request:(RequestBlock)requestBlock {
    _requestBlock = requestBlock;
    _clickBlock = clickBlock;
    
    [self setVoiceButton];
}
- (void)setVoiceButton {
    
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _isMenuSelect = NO;
    
    CGFloat downMenuButtonWH = 47;
    CGFloat downMenuButtonX = window.frame.size.width - downMenuButtonWH - 20;
    CGFloat downMenuButtonY = window.frame.size.height-(iPhoneX?30:0) - downMenuButtonWH - 30;
    
    _downMenuButton = [[DWBubbleMenuButton alloc]initWithFrame:CGRectMake(downMenuButtonX, downMenuButtonY, downMenuButtonWH, downMenuButtonWH) expansionDirection:DirectionUp];
    _downMenuButton.delegate = self;
    _downMenuButton.buttonSpacing = 5;
    _menuImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy-icon-tj"] highlightedImage:[UIImage imageNamed:@"sy_icon_gb"]];
    _menuImageView.frame = CGRectMake(0, 0, downMenuButtonWH, downMenuButtonWH);
    _downMenuButton.homeButtonView = _menuImageView;
    
    [_downMenuButton addButtons:[self addButtonArray]];
    [window addSubview:_downMenuButton];
    
}

- (void)tapAction:(UIGestureRecognizer *)tap {
    
    if(!_isMenuSelect) return;
    [_downMenuButton dismissButtons];
   
}
//添加子按钮
- (NSArray *)addButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    NSArray *images = @[@"btn_my",@"btn_peixun", @"btn_xinxi"];
    
    for (int i = 0; i < images.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(0.f, 0.f, _downMenuButton.frame.size.width, _downMenuButton.frame.size.width);
        button.clipsToBounds = YES;
        button.tag = 100 + i;
        [button addTarget:self action:@selector(subButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsMutable addObject:button];
        
    }
    return [buttonsMutable copy];
}

//子按钮点击方法
- (void)subButtonAction:(UIButton *)sender {
    //请求音量修改接口
    [self requestSetVolumWithIndex:sender.tag - 100];
}
+ (void)hidden:(BOOL)hidden {
    
    [[ButtonManager sharedManager]downMenuButton].hidden = hidden;
}

#pragma mark - DWBubbleMenuButtonDelegate
//子按钮将要出现
- (void)bubbleMenuButtonWillExpand:(DWBubbleMenuButton *)expandableView {
    _isMenuSelect = YES;
    _menuImageView.image = [UIImage imageNamed:@"sy_icon_gb"];
    _downMenuButton.homeButtonView = _menuImageView;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    if (!_coverView) {
        //添加一个遮罩
        _coverView = [[UIView alloc]initWithFrame:window.frame];
//        _coverView.backgroundColor = [UIColor yellowColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_coverView addGestureRecognizer:tap];
        [window insertSubview:_coverView belowSubview:_downMenuButton];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_coverView addGestureRecognizer:pan];

    }
//    _clickBlock(999);
    [self addLandscapeButton];

}
//子按钮将要消失
- (void)bubbleMenuButtonWillCollapse:(DWBubbleMenuButton *)expandableView {
    _isMenuSelect = NO;
    _menuImageView.image = [UIImage imageNamed:@"sy-icon-tj"];
    _downMenuButton.homeButtonView = _menuImageView;
    if (_coverView) {
        [_coverView removeFromSuperview];
        _coverView = nil;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _landscapeView.frame= CGRectMake(_downMenuButton.left, SCREEN_HEIGHT-(iPhoneX?30:0) - 47/2 - 30, 0, 0);
       
    } completion:^(BOOL finished) {
        _rightButton.hidden = YES;
        _leftButton.hidden = YES;
    }];
//    [UIView animateWithDuration:0.3 animations:^{
//        _landscapeView.frame= CGRectMake(_downMenuButton.left, SCREEN_HEIGHT-(iPhoneX?30:0) - 47/2 - 30, 0, 0);
//    }];
}

- (void)requestSetVolumWithIndex:(NSInteger)index
{
    _clickBlock(index);
    [_downMenuButton dismissButtons];
}

//移除播放按钮
+ (void)dissMiss {
    [[ButtonManager sharedManager] dissMiss];
}
- (void)dissMiss {
    if (_downMenuButton) {
        [_downMenuButton removeFromSuperview];
        _downMenuButton = nil;
    }
    
    //取消网络请求
//    [HttpEngine cancelNetworkRequest];
}
- (void)dealloc {
    NSLog(@"BroadcastMainViewController dealloc");
}

///通知回调
- (void)kRobotNIMVoiceNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     _requestBlock(nil);
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//取消全部 延迟方法。
    
}
////定时30秒 未返回数据则提示失败
-(void)failBackNIMVoice{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [UIHelper alertWithTitle:@"设置失败"];
    _requestBlock(nil);
    
}

-(void)addLandscapeButton{
    
    if (!_landscapeView) {
        _landscapeView = [[UIView alloc]init];
        _landscapeView.frame= CGRectMake(_downMenuButton.left, _downMenuButton.top, 0, 0);
        _landscapeView.backgroundColor = [UIColor whiteColor];
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    WS(weakself);
    [UIView animateWithDuration:0.3 animations:^{
       weakself.landscapeView.frame = CGRectMake(30, _downMenuButton.top+2, _downMenuButton.right-30-2, _downMenuButton.height-2) ;
        weakself.rightButton.hidden = NO;
        weakself.leftButton.hidden = NO;
    } completion:^(BOOL finished) {
       
    }];
    
    [_leftButton setImage:[UIImage imageNamed:@"fbfw-gclw-icon"] forState:UIControlStateNormal];
    [_leftButton setTitle:@"工厂劳务" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor HexString:@"DB2A21"] forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(0.f, 0.f, (_landscapeView.width-50)/2, _landscapeView.height);
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _leftButton.clipsToBounds = YES;
    _leftButton.tag = 110;
    _leftButton.imageView.left = 25;
    [_leftButton addTarget:self action:@selector(subButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_landscapeView addSubview:_leftButton];
    
    [_rightButton setImage:[UIImage imageNamed:@"fbfw-jj-icon"] forState:UIControlStateNormal];
    [_rightButton  setTitle:@"家居生活" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor HexString:@"DB2A21"] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _rightButton.frame = CGRectMake( (_landscapeView.width-50)/2, 0.f,  (_landscapeView.width-50)/2, _landscapeView.height);
    _rightButton.clipsToBounds = YES;
    _rightButton.imageView.left = 25;
    _rightButton.tag = 111;
    [_rightButton addTarget:self action:@selector(subButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_landscapeView addSubview:_rightButton];
    
    [_landscapeView draCirlywithColor:[UIColor lightTextColor] andRadius:_landscapeView.height/2];
//    _landscapeView.clipsToBounds = YES;
//    _landscapeView.layer.shadowColor = [UIColor HexString:@"333333"].CGColor;
//    _landscapeView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//    _landscapeView.layer.cornerRadius = _landscapeView.height/2;
//    _landscapeView.layer.shadowOffset = CGSizeZero;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_landscapeView];
    [window addSubview:_downMenuButton];
}

@end
