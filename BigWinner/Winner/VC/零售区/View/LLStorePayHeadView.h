//
//  LLStorePayHeadView.h
//  Winner
//
//  Created by mac on 2022/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLStorePayHeadView : UIView
@property (nonatomic,strong) NSDictionary *dataDic;/** <#class#> **/
@property (nonatomic,strong) NSDictionary *timeDic;/** <#class#> **/
-(void)endTimes;
@property (nonatomic, copy)void(^tapAction)(void);

@end
@interface LLPayViewStyleCell : UITableViewCell
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UIImageView *showimage;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UILabel *deLabel;

@property(nonatomic,strong)UIButton *sureButton;
//@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,assign) BOOL isSelects;/** <#class#> **/
@end

@interface LLStorePaySuccessHeadView : UIView

@end
NS_ASSUME_NONNULL_END
