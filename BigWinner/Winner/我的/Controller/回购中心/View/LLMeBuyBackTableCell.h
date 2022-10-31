//
//  LLMeBuyBackTableCell.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "LLStorageModel.h"
#import "LLBackBuyModel.h"
#import "LLBackBuyDetailModel.h"
#import "LLBackBuyPodModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLBuybackSuccessTableCell;
@class LLBuybackRecordTableCell;
@class LLBuybackRecordDetailTableCell;
@class LLBuybackRecordInfoTableCell;

typedef void(^LLMeBuybackBtnBlock)(NSString *ID);

@interface LLMeBuyBackTableCell : UITableViewCell

@property (nonatomic,copy)LLMeBuybackBtnBlock buybackBtnBlock;
@property (assign, nonatomic)BOOL isbuyHidden;
@property (nonatomic,strong)LLStorageListModel *listModel;
@property (nonatomic,strong)LLBackBuyPodModel *backBuyModel;

@end


@interface LLBuybackSuccessTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *rightStr;

@end



@interface LLBuybackRecordTableCell : UITableViewCell


@property (nonatomic,strong)LLBackBuyListModel *listModel;


@end



@interface LLBuybackRecordDetailTableCell : UITableViewCell


@property (nonatomic,strong)LLBackBuyDetailModel *detailModel;

@end


@interface LLBuybackRecordInfoTableCell : UITableViewCell

@property (nonatomic,strong)LLBackBuyDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
