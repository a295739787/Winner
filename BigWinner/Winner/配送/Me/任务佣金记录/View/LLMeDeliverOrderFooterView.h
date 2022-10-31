//
//  LLMeDeliverOrderFooterView.h
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderListModel.h"
@class LLMeDeliverOrderHeaderView;

NS_ASSUME_NONNULL_BEGIN

@interface LLMeDeliverOrderFooterView : UIView
@property (nonatomic,strong) LLMeOrderListModel *model;/** <#class#> **/


@end

@interface LLMeDeliverOrderHeaderView : UIView
@property (nonatomic,strong) LLMeOrderListModel *model;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
