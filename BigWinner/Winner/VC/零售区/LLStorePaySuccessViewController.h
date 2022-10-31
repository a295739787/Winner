//
//  LLStorePaySuccessViewController.h
//  Winner
//
//  Created by mac on 2022/2/4.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLStorePaySuccessViewController : LMHBaseViewController
@property (nonatomic,copy) NSString *orderNo;/** <#class#> **/
@property (nonatomic,assign) BOOL payui;/** class **/
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,assign) BOOL judgePriceType;/** class **/

@end

NS_ASSUME_NONNULL_END
