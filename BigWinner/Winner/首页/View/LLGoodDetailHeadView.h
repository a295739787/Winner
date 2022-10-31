//
//  LLGoodDetailHeadView.h
//  ShopApp
//
//  Created by lijun L on 2021/3/23.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LLGoodDetailHeadView : UITableViewHeaderFooterView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *shopModel;/** <#class#> **/
@property (nonatomic,strong) UIButton *shareBtn;/** <#class#> **/
@property (nonatomic,strong) SDCycleScrollView *sycleview;/** <#class#> **/
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property (nonatomic,strong) UILabel *oldpricelable;/** <#class#> **/
@property(nonatomic,strong)UILabel *salelable;
@property(nonatomic,strong)UILabel *addlable;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,copy) NSString *price_market;/** <#class#> **/

@property (nonatomic,copy) NSString *price_virtual;/** <#class#> **/
@end
@interface LLGoodSectionPraiseView : UIView

@property (nonatomic,copy) NSString *totals;/** <#class#> **/
@end
@interface LLGoodSectionDetilasView : UIView

@property (nonatomic,copy) NSString *totals;/** <#class#> **/
@end
NS_ASSUME_NONNULL_END
