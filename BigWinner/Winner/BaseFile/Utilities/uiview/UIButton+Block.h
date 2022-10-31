//
//  UIButton+Block.h
//  ZCBusManage
//
//  Created by wfg on 2019/8/22.
//  Copyright © 2019 zhiqiang meng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Block)
- (void)addAction:(ButtonBlock)block;
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;
@end

NS_ASSUME_NONNULL_END
