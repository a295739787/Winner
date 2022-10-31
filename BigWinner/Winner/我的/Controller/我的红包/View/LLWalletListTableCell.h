//
//  LLWalletListTableCell.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import "LLWalletListModel.h"
#import "LLPersonalModel.h"
NS_ASSUME_NONNULL_BEGIN

@class LLWalletAddBankCardTableCell;

@interface LLWalletListTableCell : UITableViewCell

@property (nonatomic,strong) LLWalletListModel *listModel ;
@property (assign, nonatomic) NSInteger mode;

@end



@interface LLWalletAddBankCardTableCell : UITableViewCell
@property (nonatomic,strong) LLPersonalModel *personalModel;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
