//
//  LLMeOrderheaderView.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderListModel.h"
#import "LLMeOrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@class LLMeOrderFooterView;
@class LLMeOrderAfterFooterView;


@interface LLMeOrderheaderView : UIView
@property (nonatomic,strong)LLMeOrderListModel *model;
@property (nonatomic,strong)LLMeOrderListModel *orderModel;
@property (nonatomic, copy) void(^ActionBlock)(NSString *tagName,LLMeOrderListModel *orderModel);

@end


@interface LLMeOrderFooterView : UIView
@property (nonatomic, copy) void(^ActionBlock)(NSString *tagName,LLMeOrderListModel *orderModel);
@property (nonatomic,strong)LLMeOrderListModel *orderModel;


@end

@interface LLMeOrderAfterFooterView : UIView
@property (nonatomic, copy) void(^ActionBlock)(NSString *tagName,LLMeOrderListModel *orderModel);
@property (nonatomic,strong)LLMeOrderListModel *orderModel;

@end

@interface LLAlertShowView : UIView
@property (nonatomic,strong) LLMeOrderDetailModel *model;/** <#class#> **/
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) UIButton *sureBtn1;

- (void)showActionSheetView;
- (void)hideActionSheetView;
@end
NS_ASSUME_NONNULL_END
