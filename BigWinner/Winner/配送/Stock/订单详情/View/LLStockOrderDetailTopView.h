//
//  LLStockOrderDetailTopView.h
//  Winner
//
//  Created by YP on 2022/3/22.
//

#import <UIKit/UIKit.h>
#import "NSDate+zh_Format.h"
NS_ASSUME_NONNULL_BEGIN

@class LLStockOrderDetailFooterView;
@class LLStockOrderBottomView;

@interface LLStockOrderDetailTopView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end


@interface LLStockOrderDetailFooterView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end


@interface LLStockOrderBottomView : UIView
@property (nonatomic, copy)void(^tapAction)(LLGoodModel *model,NSString *name);
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
