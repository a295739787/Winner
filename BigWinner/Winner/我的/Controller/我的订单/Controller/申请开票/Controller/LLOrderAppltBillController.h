//
//  LLOrderAppltBillController.h
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import <UIKit/UIKit.h>
#import "LLOrderApplyBillModel.h"
#import "LLMeOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface LLOrderAppltBillController : LMHBaseViewController

@property (nonatomic,strong)NSString *orderNo;
@property (nonatomic, copy) NSString *invoiceStatus;
@property (nonatomic,strong) LLMeOrderListModel *model;/** <#class#> **/
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
