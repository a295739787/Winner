//
//  LLBuyBackView.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "LLBackBuyDetailModel.h"
#import "LLBackBuyPodModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLBuybackBottomView;
@class LLBuybackConfirmView;
@class LLBuybackSuccessHeaderView;
@class LLBuybackRecordHeaderView;
@class LLBuybackRecoderFooterView;

typedef void(^LLBuybackBtnBlock)(void);
typedef void(^LLBuybackConfirmBtnBlock)(void);

@interface LLBuyBackView : UIView

@property (nonatomic,strong)LLBackBuyPodModel *backBuyModel;
@property (nonatomic,copy)void (^LLBackBuyCountBtnBlock)(NSInteger count);

@end



@interface LLBuybackBottomView : UIView

@property (nonatomic,copy)LLBuybackBtnBlock buybackBlock;
@property (nonatomic,strong)NSString *buyBackPrice;

@end



@interface LLBuybackConfirmView : UIView

@property (nonatomic,copy)LLBuybackConfirmBtnBlock confirmBtnBlock;

@property (nonatomic,strong)NSString *totlePrice;
@property (nonatomic,strong)NSString *totalCount;

-(void)hidden;
-(void)show;

@end


@interface LLBuybackSuccessHeaderView : UIView


@end



@interface LLBuybackRecordHeaderView : UIView


@property (nonatomic,strong)UILabel *textLabel;

@end




@interface LLBuybackRecoderFooterView : UIView

@property (nonatomic,strong)LLBackBuyDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
