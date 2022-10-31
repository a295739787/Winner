//
//  LLMainPeisongCell.h
//  Winner
//
//  Created by 廖利君 on 2022/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMainPeisongCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic, copy)void(^tapAction)(LLGoodModel *model,NSString *name);
@property (nonatomic,assign) NSInteger state;/** class **/
@property (nonatomic,strong) UIButton *sureButton2;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *issmodel;/** <#class#> **/
@property(nonatomic,strong)UILabel *timelable;
@property (nonatomic,assign) BOOL isOver;/** class **/

@end

NS_ASSUME_NONNULL_END
