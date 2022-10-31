//
//  LLIntroPointCell.h
//  Winner
//
//  Created by 廖利君 on 2022/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLIntroPointCell : UITableViewCell
@property (nonatomic,weak) id <LLCommonDelegate> delegate;/** <#class#> **/
@property (nonatomic,assign) NSInteger indexs;/** class **/
@property (nonatomic,strong) UILabel *detailsLabel ;/** class **/
@property (nonatomic,strong) UITextField *conTX ;/** <#class#> **/
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,copy) void(^getblock)(NSInteger tags ,NSString *name);/** <#class#> **/
@property (nonatomic,copy) NSString *btnTags;/** <#class#> **/
@property (nonatomic,strong) NSIndexPath *indexPath;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
