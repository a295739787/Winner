//
//  SuspensionAssistiveTouch.m
//  SuspensionAssistiveTouch
//
//  Created by Rainy on 2017/9/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kSuspensionViewDisNotificationName    @"SUSPENSIONVIEWDISAPPER_NOTIFICATIONNAME"
#define  kSuspensionViewShowNotificationName  @"SUSPENSIONVIEWSHOW_NOTIFICATIONNAME"

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kWindow          [[UIApplication sharedApplication].windows firstObject]
#define kScreenBounds    [[UIScreen mainScreen] bounds]
#define kScreenWidth     kScreenBounds.size.width
#define kScreenHeight    kScreenBounds.size.height

#define kAssistiveTouchIMG          [UIImage imageNamed:@"icon.png"]
#define kHeaderViewIMG              [UIImage imageNamed:@"header"]
#define kHeaderIMG                  [UIImage imageNamed:@"touxiang"]

#define kAlpha                0
#define kPrompt_DismisTime    0.2
#define kProportion           0.82

#import "SuspensionAssistiveTouch.h"


@interface SuspensionAssistiveTouch ()
{
  
}

@property(nonatomic,strong)UIView *backView;

@end

@implementation SuspensionAssistiveTouch

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
//        self.windowLevel = UIWindowLevelAlert + 1;
//        [self makeKeyAndVisible];
        
        _touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _touchButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [_touchButton addTarget:self action:@selector(suspensionAssistiveTouch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_touchButton];
        self.showimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _touchButton.size.width, _touchButton.size.height)];
        self.showimage.userInteractionEnabled = YES;
        
        UIButton *cleanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cleanbtn.frame = CGRectMake(frame.size.width-10, 0, 10,10);
        [cleanbtn addTarget:self action:@selector(clearns) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cleanbtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(suspensionAssistiveTouch)];
        [     self.showimage addGestureRecognizer:tap];
        [_touchButton addSubview:self.showimage];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [_touchButton addGestureRecognizer:pan];
        
        self.alpha = 1;
//        [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
        
        [kNotificationCenter addObserver:self selector:@selector(disapper:) name:kSuspensionViewDisNotificationName object:nil];
        [kNotificationCenter addObserver:self selector:@selector(suspensionAssistiveTouch) name:kSuspensionViewShowNotificationName object:nil];
    }
    return self;
}
-(void)clearns{
    
    self.alpha = 0;
}

///**解决点击子view穿透到父视图的问题*/

-(void)suspensionAssistiveTouch {
    
    [kWindow addSubview:self.backView];

}

-(void)disapper:(UITapGestureRecognizer *)tap{
    self.alpha = 1;
    self.backView.hidden = YES;
//    [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];

}

-(void)changePostion:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        originalFrame.origin.x += point.x;
    }
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [pan setTranslation:CGPointZero inView:self];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self beginPoint];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self changePoint];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self endPoint];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self endPoint];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)beginPoint {
    
    _touchButton.enabled = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        self.alpha = 1.0;
    }];
}
- (void)changePoint {
    
    BOOL isOver = NO;
    
    CGRect frame = self.frame;
    
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
        isOver = YES;
    } else if (frame.origin.x+frame.size.width > kWindow.Sw) {
        frame.origin.x = kWindow.Sw - frame.size.width;
        isOver = YES;
    }
    
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
        isOver = YES;
    } else if (frame.origin.y+frame.size.height > kWindow.Sh) {
        frame.origin.y = kWindow.Sh - frame.size.height;
        isOver = YES;
    }
    if (isOver) {
        [UIView animateWithDuration:kPrompt_DismisTime animations:^{
            self.frame = frame;
        }];
    }
    _touchButton.enabled = YES;
    
}
static CGFloat _allowance = 30;
- (void)endPoint {
    
    if (self.X <= kWindow.Sw / 2 - self.Sw/2) {
        
        if (self.Y >= kWindow.Sh - self.Sh - _allowance) {
            self.Y = kWindow.Sh - self.Sh;
        }else
        {
            if (self.Y <= _allowance) {
                self.Y = 0;
            }else
            {
                self.X = 0;
            }
        }
        
    }else
    {
        if (self.Y >= kWindow.Sh - self.Sh - _allowance) {
            self.Y = kWindow.Sh - self.Sh;
        }else
        {
            if (self.Y <= _allowance) {
                self.Y = 0;
            }else
            {
                self.X = kWindow.Sw - self.Sw;
            }
        }
    }
    
    _touchButton.enabled = YES;
    [self performSelector:@selector(setAlpha) withObject:nil afterDelay:3];
}
-(void)setAlpha {
//    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
//        
//        self.alpha = kAlpha;
//    }];
}
-(void)setX:(CGFloat)X
{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        [super setX:X];
    }];
}
-(void)setY:(CGFloat)Y
{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        [super setY:Y];
    }];
}
#pragma mark - lazy
-(UIView *)backView
{
    if (!_backView) {
        
        _backView = [[UIView alloc]initWithFrame:kScreenBounds];
        _backView.backgroundColor = [UIColor whiteColor];
//        _backView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper:)];
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}
//-(llgui *)topView
//{
//    if (!_topView) {
//
//        _topView = [[PersonalCenterMainView alloc]initWithFrame:CGRectMake(-kScreenWidth * kProportion, 0, kScreenWidth * kProportion, kScreenHeight)];
//    }
//    return _topView;
//}

@end
