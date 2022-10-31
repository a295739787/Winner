//
//  LLStoreSureOrderViewController.h
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLStoreSureOrderViewController : LMHBaseViewController
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *valueModel;/** <#class#> **/
@property (nonatomic, copy) NSString *goodsNum;
@property (nonatomic, copy) NSString *goodsSpecsPriceId;
@end

NS_ASSUME_NONNULL_END
