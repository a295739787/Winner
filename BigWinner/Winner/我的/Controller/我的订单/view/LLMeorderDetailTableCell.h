//
//  LLMeorderDetailTableCell.h
//  Winner
//
//  Created by YP on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLMeOrderDetailListTableCell;
@class LLMeorderDetailInfotableCell;
@class LlmeOrderDetailOrderInfoTableCell;

@interface LLMeorderDetailTableCell : UITableViewCell

@property (nonatomic,strong)LLappAddressInfoVo *adressModel;

@end

@interface LLMeOrderDetailListTableCell : UITableViewCell

@property (nonatomic,strong)LLappOrderListGoodsVos *goodsModel;
@property (nonatomic,strong) LLMeOrderDetailModel *model;/** <#class#> **/

@end

@interface LLMeorderDetailInfotableCell : UITableViewCell

@property (nonatomic,strong)LLappOrderListGoodsVos *goodsModel;

@end


@interface LlmeOrderDetailOrderInfoTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *rightStr;

@end
@interface LLMeorderDetailPeiSongtableCell : UITableViewCell

@property (nonatomic,strong)LLMeOrderDetailModel *model;

@end
NS_ASSUME_NONNULL_END
