//
//  LLOrderApplyBillInfoTableCell.h
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import <UIKit/UIKit.h>
#import "LLOrderApplyBillModel.h"
#import "LLOrderApplyBillModel.h"
#import "LLMeOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN


@class LLOrderApplyBillSelectTableCell;
@class LLOrderApplyBillInfoStatusTableCell;
@class LLOrderApplyBillListTableCell;

@interface LLOrderApplyBillInfoTableCell : UITableViewCell

@property (nonatomic,strong)LLMeOrderListModel *billModel;
@property (nonatomic,strong)NSString *orderNo;

@end


@interface LLOrderApplyBillSelectTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *rightStr;
@property (assign, nonatomic) NSInteger indexRow;

@property (nonatomic,copy)void(^LLOrderBillSelelctBtnBlock)(BOOL isSelect);


@end



@interface LLOrderApplyBillInfoStatusTableCell : UITableViewCell

@property (nonatomic,strong)LLOrderApplyBillModel *billModel;


@end



@interface LLOrderApplyBillListTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *rightStr;

@end

NS_ASSUME_NONNULL_END

