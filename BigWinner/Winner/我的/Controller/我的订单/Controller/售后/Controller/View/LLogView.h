//
//  LLogView.h
//  ShopApp
//
//  Created by lijun L on 2021/7/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLogView : UIView
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/

- (void)showActionSheetView;
- (void)hideActionSheetView;
@end

NS_ASSUME_NONNULL_END
