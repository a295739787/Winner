//
//  LLMeAdressTableCell.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "AdressListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLMeAdressEditTableCell;

typedef void(^LLMeAdressEditBlock)(void);
typedef void(^LLMeAdressTextFieldBlock)(NSInteger index,NSString *fieldStr);
typedef void(^LLMeAdressDefaulBtntBlock)(BOOL isSelect);

@interface LLMeAdressTableCell : UITableViewCell

@property (nonatomic,copy)LLMeAdressEditBlock editBlock;

@property (nonatomic,strong)AdressListModel *listModel ;

@end


@interface LLMeAdressEditTableCell : UITableViewCell


@property (nonatomic,copy)LLMeAdressTextFieldBlock textFieldBlock;
@property (nonatomic,copy)LLMeAdressDefaulBtntBlock defaultBlock;


@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *placeholderStr;
@property (assign, nonatomic) NSInteger index;

@property (nonatomic,strong)NSString *contentStr;

@end

NS_ASSUME_NONNULL_END
