//
//  LLShopCarHeadView.h
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LLShopCarSectionViewHeaderViewDelegate <NSObject>
/** 全选或者删除按钮点击事件 */
- (void)selectOrEditGoods:(UIButton *)sender;
/** 进入商店 */
- (void)enterShopStore;

@end
@interface LLShopCarHeadView : UIView
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic, weak)  id<LLShopCarSectionViewHeaderViewDelegate>delegate;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) UIButton *selectButton;/** <#class#> **/
@property(nonatomic,strong)UILabel *nameLabel1;

@end

NS_ASSUME_NONNULL_END
