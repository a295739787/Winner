//
//  LLReturnServiceCell.h
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLReturnPicView.h"
#import "LLMeOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LLReturnServiceCell : UITableViewCell
@property (nonatomic,strong) LLMeOrderListModel *model;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *serviceModel;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *refundModel;/** <#class#> **/

@end
@interface LLReturnServiceComCell : UITableViewCell

@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UIImageView *showImage;
@property (nonatomic,strong) UILabel *nameLabel1;
@end
@interface LLReturnApplyComCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;

@end
@interface LLReturnApplyComMonCell : UITableViewCell

@property (nonatomic,copy) NSString *money;/** <#class#> **/
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UILabel *detailsLabel;
@end
@interface LLReturnApplyComTextCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UITextField *detailsLabel;
@end
@interface LLReturnApplyComPicCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UIView *picBtnView;
@property (nonatomic,strong) LLReturnPicView *picView;/** <#class#> **/
@property (nonatomic,copy) void (^selectBlock)(NSArray *image,NSString *pic,CGFloat heights);/** <#class#> **/

@end

@interface LLReturnShowCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@end
@interface LLReturnShowComCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@end
@interface LLogCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@property (nonatomic,assign) NSInteger rows;/** <#class#> **/
@end
@interface LLReturnApplyOnmonyComCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel1;
@property (nonatomic,strong) UITextField *detailsLabel;
@property (nonatomic,strong) UILabel *noticeLabel;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/

@end
NS_ASSUME_NONNULL_END
