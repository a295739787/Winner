//
//  LLMeOrderDetailController.h
//  Winner
//
//  Created by YP on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "LLShouHouApplyViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LLMeOrderDetailController : LMHBaseViewController
@property (nonatomic,assign) RoleStatus statues;/** class **/

@property (nonatomic,strong)NSString *orderNo;
@property (nonatomic, copy)void(^tapAction)(void);
@end

NS_ASSUME_NONNULL_END
