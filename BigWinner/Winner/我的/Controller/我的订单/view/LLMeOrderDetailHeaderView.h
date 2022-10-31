//
//  LLMeOrderDetailHeaderView.h
//  Winner
//
//  Created by YP on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLMeOrderDetailTitleView;
@class LLMeorderDetailPayInfoView;
@class LLmeOrderDetailInfoFooterView;
@class LLMeorderDetailBottomView;
@class LlmeOrderGoodsInfoheaderView;
@class LLMeOrderEvaluateFooterView;
@class LLMeOrderEvaluateStarView;
@class LLMeOrderApplyRefundView;
@class LLMeOrderDetailOrderReceiveView;

@interface LLMeOrderDetailHeaderView : UIView
@property (nonatomic,strong)LLMeOrderDetailModel *detailModel;

@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic, copy)void(^tapAddAction)(LLMeOrderDetailModel *detailModel);
-(void)destyTimes;
@end

@interface LLMeOrderDetailTitleView : UIView

@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)LLMeOrderDetailModel *detailModel;

@end


@interface LLMeorderDetailPayInfoView : UIView

@property (nonatomic,strong)LLMeOrderDetailModel *detailModel;

@end


@interface LLmeOrderDetailInfoFooterView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong)LLMeOrderDetailModel *detailModel;

@end


@interface LLMeorderDetailBottomView : UIView
@property (nonatomic,strong)LLMeOrderDetailModel *detailModel;

@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic, copy) void(^ActionBlock)(NSString *tagName);
@property (nonatomic,strong)UIButton *payBtn;
@property (nonatomic,strong) UILabel *paytext;/** <#class#> **/

@end


@interface LlmeOrderGoodsInfoheaderView : UIView


@end




@interface LLMeOrderEvaluateFooterView : UIView

@property (nonatomic,strong) NSArray *datas;/** <#class#> **/


@end



@interface LLMeOrderEvaluateStarView : UIView

@property (nonatomic,strong)NSString *star;

@end


@interface LLMeOrderDetailOrderReceiveView : UIView


@property (nonatomic,strong) LLMeOrderDetailModel *model;/** <#class#> **/

-(void)show;
-(void)hidden;

@end





NS_ASSUME_NONNULL_END
