//
//  LLStorePayViewController.h
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLStorePayViewController : LMHBaseViewController
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,assign) BOOL judgePriceType;/** class **/
@property (nonatomic,assign) NSInteger feePriceSize;/** class **/

@end

NS_ASSUME_NONNULL_END
