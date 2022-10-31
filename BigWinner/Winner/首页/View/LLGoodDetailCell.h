//
//  LLGoodDetailCell.h
//  Winner
//
//  Created by mac on 2022/2/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLGoodDetailCell : UITableViewCell
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *delable;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *allowimage;/** <#class#> **/
@end
@interface LLGoodPicCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImage;

@property(nonatomic,strong) UIImageView *BigImgView;
/** 查看大图 */
- (void)setBigImgViewWithImage:(UIImage *)img;

@end

NS_ASSUME_NONNULL_END
