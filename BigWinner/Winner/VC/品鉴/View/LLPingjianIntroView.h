//
//  LLPingjianIntroView.h
//  Winner
//
//  Created by mac on 2022/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLPingjianIntroView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

- (void)showActionSheetView;
- (void)hideActionSheetView;
@end

NS_ASSUME_NONNULL_END
