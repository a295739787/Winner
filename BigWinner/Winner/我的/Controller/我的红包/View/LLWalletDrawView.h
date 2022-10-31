//
//  LLWalletDrawView.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import "LLPersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLWalletDrawFooterView;

@interface LLWalletDrawView : UIView
@property (nonatomic,strong) LLPersonalModel *model;/** <#class#> **/
@property (nonatomic,strong)UITextField *textField;


@end

@interface LLWalletDrawFooterView : UIView
@property (nonatomic,strong) LLPersonalModel *model;/** <#class#> **/
@property (nonatomic, copy) void(^clickTap)(void);

@end

NS_ASSUME_NONNULL_END
