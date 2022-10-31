//
//  LLMePromoteView.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>
#import "PromoteTeamModel.h"
#import "PromoteDetailModel.h"
#import "LLMePromoteDetailVC.h"
NS_ASSUME_NONNULL_BEGIN

@class LLPromoteHeaderView;
@class LLPromoteFooterView;

typedef void(^LLMePromoteBlock)(void);

@interface LLMePromoteView : UIView

@property (nonatomic,copy)LLMePromoteBlock promoteBlock;
@property (nonatomic,strong)PromoteTeamModel *teamModel;
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/

@end


@interface LLPromoteHeaderView : UIView

@property (nonatomic,strong)PromoteDetailModel *listModel;

@end

@interface LLPromoteFooterView : UIView

@property (nonatomic,strong)PromoteDetailModel *listModel;

@end

NS_ASSUME_NONNULL_END
