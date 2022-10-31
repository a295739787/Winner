//
//  LLPinJianViewCell.h
//  Winner
//
//  Created by mac on 2022/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLPinJianViewCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
@interface LLPinJianSectionViewCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
@interface LLPinJianPicViewCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/
@property (nonatomic,copy)void(^pushOrderBlock)(LLGoodModel *model);/** <#class#> **/

@end
@interface LLPinJianViewCountCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) NSIndexPath *IndexPath;/** <#class#> **/


/**
 加
 */
@property (nonatomic, copy) void (^AddBlock)(UILabel *countLabel,NSInteger indexs,NSInteger counts);

/**
 减
 */
@property (nonatomic, copy) void (^CutBlock)(UILabel *countLabel,NSInteger indexs,NSInteger counts);
@end
NS_ASSUME_NONNULL_END
