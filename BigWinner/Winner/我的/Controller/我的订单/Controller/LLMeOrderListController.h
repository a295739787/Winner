//
//  LLMeOrderListController.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMeOrderListController : LMHBaseViewController

@property (assign, nonatomic) NSInteger orderStatus;

@property (assign, nonatomic) NSInteger index;

@property (nonatomic,assign) RoleStatus status;/** class **/

@property (nonatomic,assign) BOOL payui;
@end

NS_ASSUME_NONNULL_END
