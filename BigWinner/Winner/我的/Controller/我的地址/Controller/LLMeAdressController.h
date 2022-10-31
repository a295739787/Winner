//
//  LLMeAdressController.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger,  LLMeAdressType) {
    LLMeAdressLogis        = 0,//物流
    LLMeAdressDelivery     = 1,//配送
    LLMeAdressAll          = 2,//全部
};
NS_ASSUME_NONNULL_BEGIN

@interface LLMeAdressController : LMHBaseViewController
@property (nonatomic, copy) void(^getAressBlock)(LLGoodModel *model);
@property (nonatomic,assign) BOOL isChoice;/** class **/
@property (nonatomic,assign) BOOL isOrderChoice;/** class **/
@property (nonatomic,copy) NSString *orderNo;/** <#class#> **/

///判断是否为物流=0,配送地址=1,全部=2
@property (nonatomic ,assign) LLMeAdressType addressType;


@end

NS_ASSUME_NONNULL_END
