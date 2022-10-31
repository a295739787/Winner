//
//  LLStoreSureOrderHeadView.h
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLStoreSureOrderHeadView : UIView
@property (nonatomic,copy)void(^tapClick)(NSInteger tagindex) ;/** <#class#> **/

@end
@interface LLStoreSureOrderLitterView : UIView
@property (nonatomic,copy) NSString *titles ;/** <#class#> **/
@property (nonatomic,copy) NSString *images ;/** <#class#> **/
@property(nonatomic,strong)UILabel *titlelable;

@end

NS_ASSUME_NONNULL_END
