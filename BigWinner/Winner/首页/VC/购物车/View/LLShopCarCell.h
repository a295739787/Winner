//
//  LLShopCarCell.h
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLShopCarCell : UITableViewCell
@property (nonatomic,assign) NSIndexPath *IndexPath;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

/**
 选中
 */
@property (nonatomic, copy) void (^ClickRowBlock)(BOOL isClick);

/**
 加
 */
@property (nonatomic, copy) void (^AddBlock)(UILabel *countLabel,NSInteger indexs,NSInteger counts);

/**
 减
 */
@property (nonatomic, copy) void (^CutBlock)(UILabel *countLabel,NSInteger indexs,NSInteger counts);
@end

NS_ASSUME_NONNULL_END
