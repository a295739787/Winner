//
//  WRCustomNavigationBar.m
//  CodeDemo
//
//  Created by wangrui on 2017/10/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar

#import "WRCustomNavigationBar.h"
#import "sys/utsname.h"

#define kWRDefaultTitleSize 18
#define kWRDefaultTitleColor [UIColor blackColor]
#define kWRDefaultBackgroundColor [UIColor whiteColor]
#define kWRScreenWidth [UIScreen mainScreen].bounds.size.width
@interface UIViewController ()
@end
@implementation UIViewController (WRRoute)

- (void)wr_toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (UIViewController*)wr_currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self wr_currentViewControllerFrom:rootViewController];
}

+ (UIViewController*)wr_currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self wr_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self wr_currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self wr_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end

@interface WRCustomNavigationBar ()
@property (nonatomic, strong) UIButton    *leftButton;
@property (nonatomic, strong) UIButton    *rightButton;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIView      *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UILabel *countsL;/** <#class#> **/
@property (nonatomic,strong) UILabel *redLabel;
@end

@implementation WRCustomNavigationBar

+ (instancetype)CustomNavigationBar {
    WRCustomNavigationBar *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, kWRScreenWidth, [WRCustomNavigationBar navBarBottom])];
    return navigationBar;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.backgroundView.backgroundColor = White_Color;
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLable];
    [self addSubview:self.rightButton];
    [self addSubview:self.bottomLine];
    [self addSubview:self.rightView];
    [self addSubview:self.showImage];
    [self addSubview:self.redLabel];
    [self updateFrame];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = kWRDefaultBackgroundColor;
}

// TODO:这边结合 WRCellView 会不会更好呢？
-(void)updateFrame {
//    NSInteger top = ([WRCustomNavigationBar isIphoneX]) ? 44 : 20;
    NSInteger top = iphoneXTop+20;
    NSInteger margin = 0;
    NSInteger buttonHeight = 35;
    NSInteger buttonWidth = 35;
    NSInteger titleLabelHeight = 44;
//    NSInteger titleLabelWidth = 180;

    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
//    self.leftButton.frame = CGRectMake(margin + 15, top, buttonWidth, buttonHeight);
//    self.rightButton.frame = CGRectMake(kWRScreenWidth - 80 - margin, top, 80, buttonHeight);
    
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(buttonHeight);
        make.width.mas_equalTo(buttonWidth);
    }];
    
    [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-12);
        make.bottom.mas_equalTo(self.rightButton.mas_top).offset(12);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(13);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightButton.mas_centerY);
        make.height.mas_equalTo(buttonHeight);
        make.left.equalTo(margin + 15);
        make.width.mas_equalTo(buttonWidth);
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightButton.mas_centerY);
        make.height.mas_equalTo(titleLabelHeight);
        make.centerX.mas_equalTo(self);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH-100);
    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightButton.mas_centerY);
        make.width.mas_equalTo(105);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(30);
        
    }];
//    self.titleLable.frame = CGRectMake((kWRScreenWidth - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    self.bottomLine.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), kWRScreenWidth, 0.5);
}

#pragma mark - 导航栏左右按钮事件
-(void)clickBack {
    if (self.onClickLeftButton) {
        self.onClickLeftButton();
    } else {
        UIViewController *currentVC = [UIViewController wr_currentViewController];
        [currentVC wr_toLastViewController];
    }
}
-(void)clickRight {
    if (self.onClickRightButton) {
        self.onClickRightButton();
    }
}

-(void)clickRightView:(UIButton *)sender {
    if (self.onClickRightView) {
        self.onClickRightView(sender.tag-1000);
    }
}

- (void)wr_setBottomLineHidden:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}

- (void)wr_setBackgroundAlpha:(CGFloat)alpha {
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)wr_setTintColor:(UIColor *)color {
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.titleLable setTextColor:color];
}

#pragma mark - 左右按钮
- (void)wr_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.leftButton.hidden = NO;
    if(normal){
        [self.leftButton setImage:normal forState:UIControlStateNormal];
    }else{
        [self.leftButton setImage:[UIImage imageNamed:@"backlohin"] forState:UIControlStateNormal];
        
    }
    [self.leftButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)wr_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self wr_setLeftButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)wr_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self wr_setLeftButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)wr_setLeftButtonWithImage:(UIImage *)image {
    [self wr_setLeftButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)wr_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self wr_setLeftButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

- (void)wr_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.rightButton.hidden = NO;
    [self.rightButton setImage:normal forState:UIControlStateNormal];
    [self.rightButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)wr_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self wr_setRightButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)wr_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self wr_setRightButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)wr_setRightButtonWithImage:(UIImage *)image {
    [self wr_setRightButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)wr_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self wr_setRightButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}
-(void)setCountStr:(NSString *)countStr{
    _countStr = countStr;
    self.countsL.text = _countStr;
}
- (void)wr_setRightButtonWithImages:(NSArray <UIImage*>*)images show:(BOOL)isshow count:(NSString *)counts {
    UIButton *lastButton;
    for(UIButton *btn in self.rightView.subviews){
        [btn removeFromSuperview];
    }
    for (int i = 0; i<images.count; i++) {
        UIButton *rightButton = [[UIButton alloc] init];
        [rightButton addTarget:self action:@selector(clickRightView:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:images[i] forState:UIControlStateNormal];
        rightButton.tag = 1000+i;
        rightButton.imageView.contentMode = UIViewContentModeCenter;
        [self.rightView addSubview:rightButton];
        UILabel *noticelabel = [[UILabel alloc]init];
        noticelabel.backgroundColor = Main_Color;
        noticelabel.layer.masksToBounds = YES;
        noticelabel.layer.cornerRadius = CGFloatBasedI375(8);
        noticelabel.hidden = YES;
        self.countsL = noticelabel;
        noticelabel.textColor = White_Color;
        noticelabel.textAlignment = NSTextAlignmentCenter;
        noticelabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(10)];
        noticelabel.text = FORMAT(@"%@",counts);
        [self.rightView addSubview:noticelabel];
        if(isshow){
            if(i == 1){
                noticelabel.hidden = NO;
                if([counts isEqual:@"0"]){
                    noticelabel.hidden = YES;
                }
           
            }
        }
        if (lastButton) {
            [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(lastButton.mas_left).offset(-24);
                make.centerY.equalTo(self.rightView);
                make.left.equalTo(self.rightView);
                
            }];
        }else{
            [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightView);
                make.centerY.equalTo(self.rightView);
            }];
        }
        [noticelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.offset(CGFloatBasedI375(16));
            make.centerY.equalTo(rightButton.mas_top).offset(5);
            make.centerX.equalTo(rightButton.mas_right);

        }];
        lastButton = rightButton;
    }
    
}
- (void)wr_setRightButtonWithRedImages:(NSArray <UIImage*>*)images  {
    UIButton *lastButton;
    for (int i = 0; i<images.count; i++) {
        UIButton *rightButton = [[UIButton alloc] init];
        [rightButton addTarget:self action:@selector(clickRightView:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:images[i] forState:UIControlStateNormal];
        rightButton.tag = 1000+i;
        rightButton.imageView.contentMode = UIViewContentModeCenter;
        [self.rightView addSubview:rightButton];
        UILabel *noticelabel = [[UILabel alloc]init];
        noticelabel.backgroundColor = Main_Color;
        noticelabel.layer.masksToBounds = YES;
        noticelabel.layer.cornerRadius = CGFloatBasedI375(6);
        [rightButton addSubview:noticelabel];
        
        if (lastButton) {
            [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(lastButton.mas_left).offset(-24);
                make.centerY.equalTo(self.rightView);
                make.left.equalTo(self.rightView);
                
            }];
        }else{
            [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightView);
                make.centerY.equalTo(self.rightView);
            }];
        }
        [noticelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.offset(12);
            make.centerY.equalTo(rightButton.mas_top);
            make.centerX.equalTo(rightButton.mas_right);

        }];
        lastButton = rightButton;
    }
    
}
- (void)wr_setRightButtonWithImages:(NSArray <UIImage*>*)images  {
    NSInteger top = iphoneXTop+20;
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(top);
        make.height.mas_equalTo(44);
        make.width.equalTo(images.count*40);
    }];
    UIButton *lastButton;
    for(UIButton *btn in self.rightView.subviews){
        [btn removeFromSuperview];
    }
    for (int i = 0; i<images.count; i++) {
        UIButton *rightButton = [[UIButton alloc] init];
        [rightButton addTarget:self action:@selector(clickRightView:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:images[i] forState:UIControlStateNormal];
        rightButton.tag = 1000+i;
        rightButton.imageView.contentMode = UIViewContentModeCenter;
        [self.rightView addSubview:rightButton];
//
        
        if (lastButton) {
            [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(lastButton.mas_left).offset(0);
                make.centerY.equalTo(self.rightView);
//                make.left.equalTo(self.rightView);
                make.width.equalTo(40);
            }];
        }else{
            [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rightView);
                make.centerY.equalTo(self.rightView);
                make.width.equalTo(40);
            }];
        }
        lastButton = rightButton;
    }
    
}


#pragma mark - setter
-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    self.showImage.hidden = NO;
    self.showImage.image = [UIImage imageNamed:_imageStr];
}
-(void)setMarkerNumber:(NSString *)markerNumber{
    _markerNumber = markerNumber;
    self.redLabel.hidden = NO;
    self.redLabel.text = _markerNumber;
}
-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.hidden = NO;
    self.titleLable.text = _title;
}
- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    self.titleLable.textColor = _titleLabelColor;
}
- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    self.titleLable.font = _titleLabelFont;
}
-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    self.backgroundImageView.hidden = YES;
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = _barBackgroundColor;
}
- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {
    self.backgroundView.hidden = YES;
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = _barBackgroundImage;
}

#pragma mark - getter
-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeCenter;
        _leftButton.hidden = YES;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _leftButton;
}
-(UIImageView *)showImage{
    if(!_showImage){
        _showImage = [[UIImageView alloc]init];
        _showImage.userInteractionEnabled = YES;
        _showImage.hidden = YES;
    }
    return _showImage;
    }
-(UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
        _rightButton.hidden = YES;
    }
    return _rightButton;
}
-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = kWRDefaultTitleColor;
        _titleLable.font = [UIFont systemFontOfSize:kWRDefaultTitleSize];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.hidden = YES;
    }
    return _titleLable;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:(CGFloat)(218.0/255.0) green:(CGFloat)(218.0/255.0) blue:(CGFloat)(218.0/255.0) alpha:1.0];
    }
    return _bottomLine;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}
-(UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}
- (UIView *)rightView {
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
    }
    return _rightView;
}
+ (int)navBarBottom {
    CGFloat orY = SCREEN_top;
    
   
//    if([NSString isPhoneXxxx]){
//        orY += CGFloatBasedI375(30);
//    }
    return orY;
//    return orY + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}
+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}

-(UILabel *)redLabel{
    if (!_redLabel) {
        _redLabel = [[UILabel alloc]init];
        _redLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _redLabel.textAlignment = NSTextAlignmentCenter;
        _redLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(9)];
        _redLabel.layer.masksToBounds = YES;
        _redLabel.text = @"9";
        _redLabel.adjustsFontSizeToFitWidth = YES;
        _redLabel.layer.cornerRadius = 6.5;
        _redLabel.backgroundColor = Red_Color;
        _redLabel.hidden = YES;
    }
    return _redLabel;
}

@end


















