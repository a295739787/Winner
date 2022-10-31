//
//  LLStoreReusableView.h
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLStoreReusableView : UICollectionReusableView
@property (nonatomic, copy)void(^getPaixuBlock)(NSString *sidx,NSString *sort);
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/

@end
@interface LLStoreFooterReusableView : UICollectionReusableView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) NSArray *datas;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
