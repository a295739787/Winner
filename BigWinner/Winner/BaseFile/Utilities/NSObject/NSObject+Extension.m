//
//  NSObject+Extension.m
//  PieLifeApp
//
//  Created by libj on 2019/8/7.
//  Copyright © 2019 Libj. All rights reserved.
//

#import "NSObject+Extension.h"
#import "UIView+HSConfiguration.h"

@implementation NSObject (Extension)

- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs colors:(NSArray <UIColor*>*)colors{
    
    NSMutableAttributedString *attriStr;
    for (int i = 0; i<strs.count; i++) {
        NSString *str = strs[i];
        UIColor *color = colors[i];
        if (i == 0) {
            attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:color}];
        }
        else{
            NSMutableAttributedString *appendStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:color}];
            [attriStr appendAttributedString:appendStr];
        }
    }
    return attriStr;
}

- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs fonts:(NSArray <UIFont*>*)fonts{
    
    NSMutableAttributedString *attriStr;
    for (int i = 0; i<strs.count; i++) {
        NSString *str = strs[i];
        UIFont *font = fonts[i];
        if (i == 0) {
            attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
        }
        else{
            NSMutableAttributedString *appendStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
            [attriStr appendAttributedString:appendStr];
        }
    }
    return attriStr;
}

- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs fonts:(NSArray <UIFont*>*)fonts lineSpacing:(CGFloat)lineSpacing{
    
    NSMutableAttributedString *attriStr;
    for (int i = 0; i<strs.count; i++) {
        NSString *str = strs[i];
        UIFont *font = fonts[i];
        if (i == 0) {
            attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
        }
        else{
            NSMutableAttributedString *appendStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font}];
            [attriStr appendAttributedString:appendStr];
        }
    }
    //    attriStr.yy_lineSpacing = lineSpacing;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attriStr.length)];
    return attriStr;
}
- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs fonts:(NSArray <UIFont*>*)fonts colors:(NSArray <UIColor*>*)colors {
    
    NSMutableAttributedString *attriStr;
    for (int i = 0; i<strs.count; i++) {
        NSString *str = strs[i];
        UIFont *font = fonts[i];
        UIColor *color = colors[i];
        if (i == 0) {
            attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
        }
        else{
            NSMutableAttributedString *appendStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
            [attriStr appendAttributedString:appendStr];
        }
    }
    return attriStr;
}



- (UIViewController *)currentViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) {
        
    }
    // modal展现方式的底层视图不同
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = [secondView controller];
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}

//
- (CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.width);
}
//
//- (NSDictionary *)dictWtihKeyValue:(LLGoodModel *)model {
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"订单编号："] =  [NSString isBlankString:  [NSString stringWithFormat:@"%@",model.order.ID]]?@"":[NSString stringWithFormat:@"%@",model.order.ID];
//    dict[@"创建时间："] =  [NSString isBlankString:  [NSString stringWithFormat:@"%@",model.order.created_at]]?@"":[NSString stringWithFormat:@"%@",model.order.created_at];
//    dict[@"付款时间："] =  [NSString isBlankString:  [NSString stringWithFormat:@"%@",model.order.pay_time]]?@"":[NSString stringWithFormat:@"%@",model.order.pay_time];
//    dict[@"发货时间："] =  [NSString isBlankString:  [NSString stringWithFormat:@"%@",model.order.express_time]]?@"":[NSString stringWithFormat:@"%@",model.order.express_time];
//   
//    dict[@"付款方式："] =  [NSString isBlankString:  [NSString stringWithFormat:@"%@",model.order.pay_type_object.name]]?@"":[NSString stringWithFormat:@"%@",model.order.pay_type_object.name];
//    return dict;
//}
#pragma mark 判断是否打开定位
- (BOOL)determineWhetherTheAPPOpensTheLocation{
    [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] ==kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        return YES;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lat"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lng"];
        return NO;
    }else{
        return NO;
    }
}
@end
