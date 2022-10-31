//
//  LLMainReusableView.h
//  Winner
//
//  Created by 廖利君 on 2022/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMainReusableView : UICollectionReusableView
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) NSArray *redUsers;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
