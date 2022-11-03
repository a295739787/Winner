//
//  LLMeAdressEditController.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>
#import "AdressListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,  MeAddressOptions) {
    MeAddressOptionsLogis     = 1,
    MeAddressOptionsDelivery  = 2,
};

@interface LLMeAdressEditController : LMHBaseViewController

@property (assign, nonatomic) NSInteger adressType; //100：添加新地址  200: 编辑地址 300确认订单

@property (nonatomic,strong)AdressListModel *listModel;
@property (nonatomic) MeAddressOptions options;
@property (nonatomic,copy) void(^getAddressBlock)(void);/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
