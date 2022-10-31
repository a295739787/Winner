//
//  LLShopCarBoView.h
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLShopCarBoView : UIView
@property (nonatomic,assign) BOOL isEditing;/** <#class#> **/
@property(nonatomic,strong)UIButton *deleButton;
@property(nonatomic,strong)UIButton *sureButton;
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic, copy) NSString *priceStr;
@property(nonatomic,strong)UILabel *delable;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
@interface LLSupriceRedbagView : UIView
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/

@end
NS_ASSUME_NONNULL_END
