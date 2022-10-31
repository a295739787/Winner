//
//  LLStoreSureOrderViewCell.h
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLStoreSureOrderViewCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) UILabel *typeLabel;/** <#class#> **/

@end
@interface LLStoreSureOrderViewAddressCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
@interface LLStoreSureOrderViewCommonCell : UITableViewCell
@property(nonatomic,strong)UITextField *conTX;
@property (nonatomic,weak) id <LLCommonDelegate> delegate;/** <#class#> **/
@property (nonatomic,assign) NSInteger indexs ;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *titlelable;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UIImageView *numsImageview;
@property (nonatomic,strong) UILabel *priceLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIButton *selectButton;/** <#class#> **/
@property(nonatomic,strong)UILabel *countlabel;
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,assign) NSInteger tagindex ;/** <#class#> **/
@property (nonatomic,assign) NSInteger counts;/** class **/

@property (nonatomic,strong) UIView *backNoView;
@property (nonatomic,strong) UIImageView *addImage;
@property (nonatomic,strong) UILabel *addnameLabel1;
@property (nonatomic,strong) UIImageView *allowImageview;
@end
@interface LLStoreSureOrderViewDeliverCell : UITableViewCell
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
NS_ASSUME_NONNULL_END
