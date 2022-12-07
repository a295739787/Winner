//
//  LLStorageController.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger,  MyLiquorCardOption) {
    popView         = 0,
    popRootView     = 1 << 0,
};

@interface LLStorageController : LMHBaseViewController
@property (nonatomic ,assign) MyLiquorCardOption popViewOption;

@end

NS_ASSUME_NONNULL_END
