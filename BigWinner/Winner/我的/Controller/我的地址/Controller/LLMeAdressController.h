//
//  LLMeAdressController.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMeAdressController : LMHBaseViewController
@property (nonatomic, copy) void(^getAressBlock)(LLGoodModel *model);
@property (nonatomic,assign) BOOL isChoice;/** class **/
@property (nonatomic,assign) BOOL isOrderChoice;/** class **/
@property (nonatomic,copy) NSString *orderNo;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
