//
//  LLAlertView.h
//  Wisdomfamily
//
//  Created by libj on 2019/5/17.
//  Copyright © 2019 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define1.h"
NS_ASSUME_NONNULL_BEGIN

@interface LLAlertView : UIView

typedef void (^ClickCompleteBlock)(NSInteger index);

/**
 选择框
 
 @param title 标题
 @param message 副标题
 @param actionTitles 按钮数组
 @param vc 当前控制器
 */
+ (void)showWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray <NSString *>*)actionTitles inController:(UIViewController *)vc complete:(ClickCompleteBlock)cb;






/**
 两个按钮 无标题 title 副标题 ensure 确定按钮文字 cancel 取消按钮文字
 @param title 副标题
 @param ensure 确定按钮文字
 @param cancel 取消按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock;

/**
 两个按钮 有标题 title 标题  ensure 确定按钮文字 cancel 取消按钮文字 cancelBlock 取消事件
 @param title 标题
 @param ensure 确定按钮文字
 @param cancel 取消按钮文字
 @param ensureBlock 确定事件 Block
 @param cancelBlock 取消事件 cancelBlock
 */

+ ( void ) showWithTitle:(NSString *) title
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock
             cancelBlock:( void(^)(void) ) cancelBlock;
/**
 两个按钮 有标题 title 标题 message 副标题 ensure 确定按钮文字 cancel 取消按钮文字
 @param title 标题
 @param message 副标题
 @param ensure 确定按钮文字
 @param cancel 取消按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock;

/**
 两个按钮 有标题 title 标题 message 副标题 ensure 确定按钮文字 cancel 取消按钮文字 cancelBlock 取消事件
 @param title 标题
 @param message 副标题
 @param ensure 确定按钮文字
 @param cancel 取消按钮文字
 @param ensureBlock 确定事件 Block
 @param cancelBlock 取消事件 cancelBlock
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             cancelTitle:(NSString *) cancel
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock
             cancelBlock:( void(^)(void) ) cancelBlock;

/**
 只有一个按钮 有标题 title 标题 message 副标题 ensure 确定按钮文字
 @param title 标题
 @param message 副标题
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
             ensureTitle:(NSString *) ensure
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock;
/**
 只有一个按钮 无标题  message 副标题 ensure 确定按钮文字
 @param message 副标题
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithMessage:(NSString *) message
               ensureTitle:(NSString *) ensure
               ensureBlock:( void(^)( NSString * res ) ) ensureBlock;
/**
 只有一个按钮和图片 message 副标题 imgName 图片名 ensure 确定按钮文字
 @param message 副标题
 @param imgName 图片名
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithMessage:(NSString *) message
         hintImageViewName:(NSString *) imgName
               ensureTitle:(NSString *) ensure
               ensureBlock:( void(^)( NSString * res ) ) ensureBlock;
/**
 只有一个按钮和图片 title 标题 message 副标题 imgName 图片名 ensure 确定按钮文字
 @param message 副标题
 @param imgName 图片名
 @param ensure 确定按钮文字
 @param ensureBlock 确定事件 Block
 */
+ ( void ) showWithTitle:(NSString *) title
                 message:(NSString *) message
       hintImageViewName:(NSString *) imgName
             ensureTitle:(NSString *) ensure
             ensureBlock:( void(^)( NSString * res ) ) ensureBlock;

+ ( void ) showWithTitle:(NSString * __nullable ) title
                 message:(NSString * __nullable) message
             ensureTitle:(NSString * __nullable) ensure
             cancelTitle:(NSString * __nullable) cancel
       hintImageViewName:(NSString * __nullable) imgName
           alertViewType:(AlertViewType) type
             ensureBlock:( void(^ __nullable)( NSString * res ) ) ensureBlock
             cancelBlock:( void(^ __nullable)(void) ) cancelBlock;


+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray<NSString *> *)btnTitles clickBtn:(void (^)(NSInteger index))clickBtnBlock;


@end

NS_ASSUME_NONNULL_END
