//
//  LLOrderDeliverCell.h
//  ShopApp
//
//  Created by lijun L on 2021/5/21.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLOrderDeliverCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/
@property (nonatomic,assign) NSInteger indexs;/** class **/


@end
@interface LLGoodcarDetCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@end
@interface LLGoodcarDeView : UIView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end
@interface LLOrderDeliverTopCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/
@property (nonatomic,assign) NSInteger indexs;/** class **/


@end
NS_ASSUME_NONNULL_END
