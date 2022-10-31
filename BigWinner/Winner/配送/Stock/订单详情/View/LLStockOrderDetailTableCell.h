//
//  LLStockOrderDetailTableCell.h
//  Winner
//
//  Created by YP on 2022/3/22.
//

#import <UIKit/UIKit.h>
// 自定义大头针 气泡
#import "CustomMapAnnotationViews.h"
#import "CurrentLocationAnnotation.h"
#import "LLMeOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@class LlStockReceiveAdresstablecell;
@class LLStockGoodsListTableCell;
@class LLStockoOrderTimeTableCell;

@interface LLStockOrderDetailTableCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end


@interface LlStockReceiveAdresstablecell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@end


@interface LLStockGoodsListTableCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end


@interface LLStockoOrderTimeTableCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
@interface LLStockoOrderMapTableCell : UITableViewCell
@property (nonatomic,strong) LLMeOrderDetailModel *model;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *perimodel;/** <#class#> **/

@end
NS_ASSUME_NONNULL_END
