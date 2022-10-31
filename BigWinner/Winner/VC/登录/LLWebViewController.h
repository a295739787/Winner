//
//  PLWebViewController.h
//  PieLifeApp
//
//  Created by libj on 2019/8/2.
//  Copyright © 2019 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LLWebViewController : LMHBaseViewController
@property (nonatomic, assign) BOOL isCanShare;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *htmlStr;
@property (nonatomic, copy) NSString *name;
/// 是否隐藏系统的导航栏
@property (nonatomic, assign) BOOL isHiddenNavgationBar;
@end

NS_ASSUME_NONNULL_END
