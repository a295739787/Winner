//
//  Define1.h
//  MathBox
//
//  Created by libj on 2019/11/24.
//  Copyright © 2019 lijun L. All rights reserved.
//

#ifndef Define1_h
#define Define1_h

#import "UILabel+AlertActionFont.h"
#import "UIView+Style.h"
#import "UIView+HSConfiguration.h"


#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 6s 7系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6p 6sp 7p系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)
#define k_Height_NavContentBar 44.0f
#define k_Height_StatusBar (IS_PhoneXAll? 44.0 : 20.0)
#define k_Height_NavBar (IS_PhoneXAll ? 88.0 : 64.0)
#define k_Height_TabBar (IS_PhoneXAll ? 83.0 : 49.0)
#define k_Height_BottomBar (IS_PhoneXAll ? 34.0 : 0.0)

#define kLLTabBarHeight (kDevice_Is_iPhoneX ? 83 : 49)


//定义UIImage对象
#define UIImageName(name) [UIImage imageNamed:name]
#define FORMAT(f, ...)      [NSString stringWithFormat:f, ## __VA_ARGS__]


#define MBColor(string) [UIColor colorWithHexString:string]

//----------------------字体----------------------------

#define FontSize(size) [UIFont fontWithFontSize:CGFloatBasedI375(size)]
#define FontBoldSize(size) [UIFont boldFontWithFontSize:CGFloatBasedI375(size)]

///主线程操作
#define SL_DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(),mainQueueBlock);
#define SL_GCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define sl_GCDWithMain(block) dispatch_async(dispatch_get_main_queue(),block)

#define LLChatName @"chatname"
#define LLChatNickName @"chatnickname"

typedef NS_ENUM(NSInteger, AlertViewType) {
    AlertView_TwoButton,   // 两个按钮
    AlertView_OneButton,   // 一个按钮
    AlertView_OneButtonAndImage, // 一个按钮和图片
    AlertView_TwoButtonAndImage, // 一个按钮和图片
};

typedef NS_ENUM(NSInteger, TestCheckType) {
    TestCheckType_result = 0,   // 查看解析
    TestCheckType_test = 1,     // 考试
};


//----------------------弱引用  BLOCK----------------------------
/** 弱引用 **/
#define WS(weakself) __weak __typeof(&*self)weakself = self
//BLOCK相关
#define WEAKSELF    @weakify(self)
#define STRONGSELF  @strongify(self)
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); }

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

//----------------------强引用  BLOCK----------------------------

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* Define1_h */
