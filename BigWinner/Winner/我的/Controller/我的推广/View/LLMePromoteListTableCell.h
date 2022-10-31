//
//  LLMePromoteListTableCell.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>
#import "PromoteUserListModel.h"


NS_ASSUME_NONNULL_BEGIN

@class LLMePromoteDetailListTableCell;

@interface LLMePromoteListTableCell : UITableViewCell

@property (nonatomic,strong)PromoteUserListModel *listModel;

@end


@interface LLMePromoteDetailListTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *rightStr;

@property (assign, nonatomic) NSInteger indexRow;



@end

NS_ASSUME_NONNULL_END
