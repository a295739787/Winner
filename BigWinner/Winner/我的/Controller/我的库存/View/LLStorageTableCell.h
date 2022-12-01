//
//  LLStorageTableCell.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>
#import "LLStorageModel.h"
#import "LLStorageTakeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLStorageAdressTableCell;

typedef void(^LLStorageLetBtnBlock)(NSString *ID);
typedef void(^LLStorageRightBtnBlock)(LLStorageListModel *model);

@interface LLStorageTableCell : UITableViewCell

@property (nonatomic,copy)LLStorageLetBtnBlock storageBtnBlock;
@property (nonatomic,copy)LLStorageRightBtnBlock rightBtnBlock;

@property (assign, nonatomic)BOOL isHidden;

@property (nonatomic,strong)LLStorageListModel *listModel;
@property (nonatomic,strong)LLappUserStockListVoModel *stockListModel;

///显示详情按钮
@property (assign, nonatomic)BOOL showOther;


@end


@interface LLStorageAdressTableCell : UITableViewCell

@property (nonatomic,strong)LLappAddressInfoVoModel *adressModel;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end



NS_ASSUME_NONNULL_END
