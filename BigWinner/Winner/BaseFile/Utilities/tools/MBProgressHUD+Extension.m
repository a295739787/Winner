//
//  MBProgressHUD+Extension.m
//  QiongLiao
//
//  Created by appleKaiFa on 15/9/17.
//  Copyright (c) 2017年 LiJun All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@interface MBProgressHUD ()

@end

@implementation MBProgressHUD (Extension)

static MBProgressHUD *HUD;


#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
//    hud.color = [UIColor blackColor];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (!window.isKeyWindow)continue;
            view = window;
            break;
        }
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.backgroundColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}

+ (void)showActivityIndicator {
    
//    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_top)];
    HUD.opaque = YES;
    [[[UIApplication sharedApplication].windows firstObject] addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.userInteractionEnabled = YES;
    HUD.offset = CGPointMake(0, -64);
    [HUD showAnimated:YES];
}

+ (void)hideActivityIndicator {
    [HUD hideAnimated:YES];
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

#pragma mark - Getter & Setter


@end
