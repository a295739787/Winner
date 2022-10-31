//
//  LLBuyBackBuyController.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLBuyBackBuyController : LMHBaseViewController

@property (nonatomic,strong)NSString *ID;
@property (nonatomic, copy)void(^tapAction)(void);

@end

NS_ASSUME_NONNULL_END
