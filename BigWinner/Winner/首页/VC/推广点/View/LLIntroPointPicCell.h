//
//  LLIntroPointPicCell.h
//  Winner
//
//  Created by 廖利君 on 2022/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLIntroPointPicCell : UITableViewCell
@property (nonatomic,copy) void (^selectBlock)(NSArray *image,NSString *pic,CGFloat heights);/** <#class#> **/
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,strong) UILabel *titlelable ;/** <#class#> **/
@property (nonatomic,copy) NSString *images;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
