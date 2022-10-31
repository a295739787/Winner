//
//  LLMeSectionTableCell.h
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import <UIKit/UIKit.h>
#import "LLPersonalModel.h"


@class LLMeOrderTableCell;
@class LLMeMoudleTableCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LLMeMoudleBtnBlock)(NSInteger index);
typedef void(^LLsectionBtnBlock)(NSInteger index);
typedef void(^LLMeOrderBtnBlock)(NSInteger index);

@interface LLMeSectionTableCell : UITableViewCell

@property (nonatomic,copy)LLsectionBtnBlock sectionBtnBlock;

@property (nonatomic,strong) LLPersonalModel *personalModel;

@end


@interface LLMeOrderTableCell : UITableViewCell

@property (nonatomic,copy)LLMeOrderBtnBlock orderBlock;

@property (nonatomic,strong) LLPersonalModel *personalModel;

@end


@interface LLMeMoudleTableCell : UITableViewCell

@property (nonatomic,copy)LLMeMoudleBtnBlock moudleBtnBlock;

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *imgArray;

@end

NS_ASSUME_NONNULL_END
