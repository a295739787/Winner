//
//  UIAlertController+HCAdd.m
//  HCKit
//
//  Created by Caoyq on 16/6/1.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "UIAlertController+HCAdd.h"
#import "UILabel+AlertActionFont.h"
@implementation UIAlertController (HCAdd)

+ (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message BtnTitles:(NSArray<NSString *> *)btnTitles ClickBtn:(void (^)(NSInteger index))clickBtnBlock {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (btnTitles.count == 1) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitles[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickBtnBlock) {
                clickBtnBlock(0);
            }
        }];
        [alert addAction:action];
    }else if (btnTitles.count == 2){
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:btnTitles[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickBtnBlock) {
                clickBtnBlock(0);
            }
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitles[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickBtnBlock) {
                clickBtnBlock(1);
            }
        }];
           [action setValue:Main_Color forKey:@"titleTextColor"];
        [cancel setValue:[UIColor colorWithHexString:@"#9999999"] forKey:@"titleTextColor"];

        [alert addAction:cancel];
        [alert addAction:action];
    }else{
        for (int index = 0; index < btnTitles.count; index++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitles[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (clickBtnBlock) {
                    clickBtnBlock(index);
                }
            }];
            [alert addAction:action];
            
        }
    }
    
    
    NSMutableParagraphStyle *paragraphStyleTitle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyleTitle.alignment = NSTextAlignmentCenter;
    paragraphStyleTitle.lineSpacing = 2;//行间距

    NSDictionary *attributeTitle = @{
                                     NSFontAttributeName:[UIFont fontWithFontSize:18],
                                     NSParagraphStyleAttributeName:paragraphStyleTitle,
                                     NSForegroundColorAttributeName:[UIColor HexString:@"#333333"],
                                     };//字体大小 行间距  颜色
    //修改title

    [alert setValue:[[NSAttributedString alloc]initWithString:title attributes:attributeTitle] forKey:@"attributedTitle"];
    
    //修改message
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 4;//行间距
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithFontSize:13], NSParagraphStyleAttributeName:paragraphStyle};//字体大小 行间距  颜色

    [alert setValue:[[NSAttributedString alloc]initWithString:message attributes:attributes] forKey:@"attributedMessage"];
    [[self getCurrentViewController] presentViewController:alert animated:YES completion:nil];
#endif
}

+ (void)showActionSheetWithTitle:(NSString *)title Message:(NSString *)message cancelBtnTitle:(NSString *)cancelBtnTitle OtherBtnTitles:(NSArray<NSString *> *)otherBtnTitles ClickBtn:(void(^)(NSInteger index))clickBtnBlock{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        clickBtnBlock(0);
    }];
    [alert addAction:cancel];
    for (int index = 0; index < otherBtnTitles.count; index++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherBtnTitles[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            clickBtnBlock(index+1);
        }];
        [action setValue:Black_Color forKey:@"titleTextColor"];

        [alert addAction:action];
    }
    [[self getCurrentViewController] presentViewController:alert animated:YES completion:nil];
#endif
}

/**
 * 获取当前呈现的ViewController
 */
+ (UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
