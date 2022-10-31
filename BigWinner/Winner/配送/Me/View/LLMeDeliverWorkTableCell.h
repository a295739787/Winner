//
//  LLMeDeliverWorkTableCell.h
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import <UIKit/UIKit.h>
#import "LLPersonalModel.h"


@class LLMeDeliverOrderTableCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LLDeliverMoudleTypeBlock)(NSInteger modetype);

typedef void(^LLMeDelverOrderBtnBlock)(NSInteger index);

@interface LLMeDeliverWorkTableCell : UITableViewCell

@property (nonatomic,strong)LLPersonalModel *personalModel;
@property (nonatomic,copy)LLDeliverMoudleTypeBlock deliverMoudleBlock;

@end


@interface LLMeDeliverOrderTableCell : UITableViewCell

@property (nonatomic,copy)LLMeDelverOrderBtnBlock deliverOrderBlock;

@property (nonatomic,strong)LLPersonalModel *personalModel;

@end

NS_ASSUME_NONNULL_END
