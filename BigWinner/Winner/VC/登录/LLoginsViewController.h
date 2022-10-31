//
//  LLoginViewController.h
//  NovaProfile
//
//  Created by lijun L on 2020/1/6.
//  Copyright © 2020 lijun L. All rights reserved.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLoginsViewController : LMHBaseViewController
@property (nonatomic,assign) BOOL isThree ;/** class **/
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/

/// 是否隐藏系统的导航栏
@property (nonatomic, assign) BOOL isHiddenNavgationBar;


@end

NS_ASSUME_NONNULL_END
