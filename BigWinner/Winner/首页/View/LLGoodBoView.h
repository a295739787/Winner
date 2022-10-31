//
//  LLGoodBoView.h
//  ShopApp
//
//  Created by lijun L on 2021/3/23.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLGoodBoView : UIView

@property (nonatomic,assign) NSInteger is_virtual;/** <#class#> **/
@property (nonatomic,copy) void(^ActionBlock)(NSInteger tagindex);/**  **/
@property (nonatomic, copy) NSString *bgColor;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/


@property (nonatomic,assign) NSInteger isAttention ;/** <#class#> **/
@end

NS_ASSUME_NONNULL_END
