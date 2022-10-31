//
//  LLMeOrderListTableCell.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLMeOrderListTableCell : UITableViewCell

@property (nonatomic,strong)LLMeOrderListModel *model;
@property (assign, nonatomic) NSInteger type;
@property (nonatomic,strong)NSString *orderType;
@property (nonatomic,strong)LLMeOrderListModel *faModel;
@property (nonatomic,strong)LLMeOrderListModel *issmodel;
@property (nonatomic,strong)UILabel *typeLabel;

@end

NS_ASSUME_NONNULL_END
