//
//  LLMeDeliverListVC.h
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMeDeliverListVC : LMHBaseViewController

@property (assign, nonatomic) NSInteger orderStatus;
@property (nonatomic,assign) BOOL payui;/** class **/
@property (nonatomic,assign) RoleStatus status;/** class **/

@property (assign, nonatomic) NSInteger index;
@end

NS_ASSUME_NONNULL_END
