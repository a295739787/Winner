//
//  LLMeTopView.h
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import <UIKit/UIKit.h>
#import "LLPersonalModel.h"

@class LLMeHeaderView;
@class LLMeCommissionNoteView;


typedef void(^LLMePersonalBtnBlock)(void);
typedef void(^LLMeLoginBtnBlock) (void);

NS_ASSUME_NONNULL_BEGIN

@interface LLMeTopView : UIView

@end

typedef NS_OPTIONS(NSUInteger,  LLMeHeaderType) {
    LLMeHeaderTypeNormal     = 0,
    LLMeHeaderTypeShop        = 1 << 0,
    LLMeHeaderTypeClerk       = 1 << 1,
    
};

@interface LLMeHeaderView : UIView
@property (nonatomic, copy) void(^tapBlock)(void);
@property (nonatomic,copy) NSString *content;/** <#class#> **/
@property (nonatomic,copy)LLMePersonalBtnBlock personalBtnBlock;
@property (nonatomic,strong)UILabel *changeLabel;
@property (nonatomic,assign) BOOL isPeisong;/** class **/
-(void)reloadInfo;
@property (nonatomic,strong)LLPersonalModel *personalModel;
@property (nonatomic,strong)LLMeLoginBtnBlock loginBtnBlock;
@property (nonatomic ,assign) LLMeHeaderType type;
@end
@interface LLGoodCarNoticeView : UIView
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,assign) BOOL isSelects;/** <#class#> **/
- (void)showActionSheetView;
- (void)hideActionSheetView;
@property (nonatomic,strong) NSDictionary *dic;/** <#class#> **/

@end


@interface LLMeCommissionNoteView : UIView

@property (nonatomic,copy)void (^LLCommissionNoteBlock)(void);

@property (nonatomic,copy) NSString *content;/** <#class#> **/

@property (nonatomic,strong) LLPersonalModel *personalModel;

-(void)show;
-(void)hidden;

@end

NS_ASSUME_NONNULL_END
