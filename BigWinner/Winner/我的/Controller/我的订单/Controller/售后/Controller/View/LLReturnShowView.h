//
//  LLReturnShowView.h
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLReturnShowView : UIView
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/
@property (nonatomic,copy) NSString *titles;/** <#class#> **/

@property (nonatomic,assign) NSInteger indexs;/** <#class#> **/
@property (nonatomic,copy) void(^getDatasBlock)(NSString *datas,NSInteger tagindex,NSInteger indexs);/** <#class#> **/
- (void)showActionSheetView;
- (void)hideActionSheetView;
@property (nonatomic,copy) void(^getDatasBlocks)(LLGoodModel *model,NSInteger tagindex,NSInteger indexs);/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
