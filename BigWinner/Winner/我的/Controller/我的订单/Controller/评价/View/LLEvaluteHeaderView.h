//
//  LLEvaluteHeaderView.h
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import <UIKit/UIKit.h>
#import "LLMeOrderDetailModel.h"
#import "LLReturnPicView.h"
#import "LLMeOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN
@class LLEvaluteHeaderView;
@protocol LLEvaluteHeaderViewDelegate <NSObject>

- (void)inputTableViewCell:(LLEvaluteHeaderView *)cell index:(NSIndexPath* )indexs content:(NSDictionary *)datas;;

@end
@interface LLEvaluteHeaderView : UITableViewCell
@property (nonatomic,strong) LLappOrderListGoodsVos *model;/** <#class#> **/
@property (nonatomic,strong) UIView *picBtnView;/** <#class#> **/
@property (nonatomic,strong) LLReturnPicView *picView;/** <#class#> **/
@property (nonatomic, weak, nullable) id <LLEvaluteHeaderViewDelegate> delegate;
@property (assign, nonatomic) NSInteger type;
@property (nonatomic,copy) NSString *titles;/** <#class#> **/
@property (nonatomic,copy) NSString *start;/** <#class#> **/
@property (nonatomic,strong) NSIndexPath *index;/** <#class#> **/
@property (nonatomic,strong) LLMeOrderListModel *famodel;/** <#class#> **/

@property (nonatomic,strong) NSArray *images;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
