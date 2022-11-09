//
//  LLStockPeisongCell.h
//  Winner
//
//  Created by 廖利君 on 2022/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LLStockPeisongDelegate <NSObject>

-(void)joinStockDetailAndShop:(UIButton *)sender dataSource:(LLGoodModel *)model;

@end

@interface LLStockPeisongCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic ,weak)  id<LLStockPeisongDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
