//
//  LLPaihangbanCell.h
//  Winner
//
//  Created by 廖利君 on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLPaihangbanCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) UILabel *label;/** <#class#> **/

@end
@interface LLPaihangbanHeadView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
NS_ASSUME_NONNULL_END
