//
//  LLShouHouApplyViewController.h
//  Winner
//
//  Created by 廖利君 on 2022/3/16.
//

#import "LMHBaseViewController.h"
#import "LLMeOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LLShouHouApplyViewController : LMHBaseViewController
@property (nonatomic,assign) OrderRefundState tagIndex;/** <#class#> **/
@property (nonatomic,strong) LLMeOrderListModel *model;/** <#class#> **/
@property (nonatomic, copy)void(^tapAction)(void);
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *reasonStr;
@property (nonatomic,assign) BOOL ShowKucu;/** class **/

@end

NS_ASSUME_NONNULL_END
