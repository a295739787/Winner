//
//  LLGoodDetailViewController.h
//  Winner
//
//  Created by mac on 2022/2/9.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLGoodDetailViewController : LMHBaseViewController
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/

@property (nonatomic,copy) NSString *ID ;/** <#class#> **/
@property (nonatomic, copy) NSString *stocks;
@property (nonatomic, copy) NSString *distDistGoodsId;

@end

NS_ASSUME_NONNULL_END
