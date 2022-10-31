//
//  LLEvaulateViewController.h
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderDetailModel.h"
#import "LLMeOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LLEvaulateViewController : LMHBaseViewController

@property (nonatomic,strong)NSArray<LLappOrderListGoodsVos*>*appOrderListGoodsVos;
@property (nonatomic,strong) LLMeOrderListModel *model;/** <#class#> **/
@property (nonatomic, copy)void(^tapAction)(void);

@end

NS_ASSUME_NONNULL_END
