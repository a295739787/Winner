//
//  LLPingjianSureOrderViewController.h
//  Winner
//
//  Created by mac on 2022/2/9.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLPingjianSureOrderViewController : LMHBaseViewController
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *valueModel;/** <#class#> **/
@property (nonatomic, copy) NSString *goodsSpecsPriceId;
@property (nonatomic, copy) NSString *goodsNum;
@property (nonatomic, copy) NSString *distDistGoodsId;

@end

NS_ASSUME_NONNULL_END
