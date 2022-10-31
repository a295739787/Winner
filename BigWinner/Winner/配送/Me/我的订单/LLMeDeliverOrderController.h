//
//  LLMeDeliverOrderController.h
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMeDeliverOrderController : LMHBaseViewController

@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger orderStatus;
@property (nonatomic,assign) RoleStatus status;/** class **/


@property (nonatomic,assign) BOOL payui;

@end

NS_ASSUME_NONNULL_END
