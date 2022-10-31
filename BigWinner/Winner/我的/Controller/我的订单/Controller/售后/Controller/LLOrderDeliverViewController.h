//
//  LLOrderDeliverViewController.h
//  ShopApp
//
//  Created by lijun L on 2021/5/21.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LMHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLOrderDeliverViewController : LMHBaseViewController
@property (nonatomic,strong) LLGoodModel *derModel;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,copy) NSString *orderNo;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
