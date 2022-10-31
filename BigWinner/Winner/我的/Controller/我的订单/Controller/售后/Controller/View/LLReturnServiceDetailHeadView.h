//
//  LLReturnServiceDetailHeadView.h
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLReturnServiceDetailHeadView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@property (nonatomic,copy) void(^refreshBlock)(void);/** <#class#> **/
@property (nonatomic,copy) void(^clickpush)(LLGoodModel *model,NSString *titles);/** <#class#> **/
@end
@interface LLReturnServiceDetailTopView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,copy) void(^refreshBlock)(void);/** <#class#> **/

@end
NS_ASSUME_NONNULL_END
