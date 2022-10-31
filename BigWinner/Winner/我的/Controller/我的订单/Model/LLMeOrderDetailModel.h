//
//  LLMeOrderDetailModel.h
//  Winner
//
//  Created by YP on 2022/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LLappAddressInfoVo;
@class LLappOrderListGoodsVos;
@class LLappOrderEvaluateVo;
//@class LLappDeliveryClerkDistanceVo;
@class LLshopDistanceVo;


@interface LLMeOrderDetailModel : NSObject<NSCoding,NSCopying,MJKeyValue>

@property (nonatomic,copy) NSString *stockTotalPrice;/** <#class#> **/
@property (nonatomic,copy) NSString *photo;/** <#class#> **/
@property (nonatomic,copy) NSString *realName;/** <#class#> **/
@property (nonatomic,copy) NSString *telePhone;/** <#class#> **/
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *writeCode;
@property (nonatomic,copy) NSString *taskTime;/** <#class#> **/
@property (nonatomic,assign) NSInteger feePriceSize;/** 加价的次数 **/
@property (nonatomic,copy) NSString *orderAfterStatus;/** <#class#> **/
@property (nonatomic,copy) NSString *afterType;/** <#class#> **/
@property (nonatomic,strong) LLMeOrderDetailModel *shopDistanceVo;/** <#class#> **/
@property (nonatomic, copy) NSString *shopPhoto;
@property (nonatomic, copy) NSString *name;
@property (nonatomic,strong) LLMeOrderDetailModel *appDeliveryClerkDistanceVo;/** <#class#> **/
@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic,copy) NSString *headIcon;/** <#class#> **/

@property (nonatomic,copy)NSString *actualPrice;
@property (nonatomic,copy)NSString *stayPayTime;
@property (nonatomic,copy)NSString *staySurplusTime;
@property (nonatomic,copy)NSString *stayTaskTime;
@property (nonatomic,copy)NSString *stock;
@property (nonatomic,copy)NSString *taskPlanTime;
@property (nonatomic,copy)NSString *timeoutTime;
@property (nonatomic,copy)NSString *totalPrice;
@property (nonatomic,copy)NSString *cancelTime;
@property (nonatomic,copy)NSString *completeTime;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *deliveryFeePrice;
@property (nonatomic,copy)NSString *deliveryTime;
@property (nonatomic,copy)NSString *expressTime;
@property (nonatomic,copy)NSString *expressType;
@property (nonatomic,copy)NSString *freight;
@property (nonatomic,copy)NSString *goodsBrokerage;
@property (nonatomic,copy)NSString *invoiceStatus;
@property (nonatomic,copy)NSString *isTimeout;
@property (nonatomic,copy)NSString *judgeTaskPrice;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *orderStatus;
@property (nonatomic,copy)NSString *orderType;
@property (nonatomic,copy)NSString *payMode;
@property (nonatomic,copy)NSString *payTime;
@property (nonatomic,copy)NSString *platform;
@property (nonatomic,copy)NSString *receivingTime;
@property (nonatomic,copy)NSString *redPrice;
@property (nonatomic,copy)NSString *refundTime;
@property (nonatomic,copy)NSString *remarks;
@property (nonatomic,assign) NSInteger taskStatus;/** class **/
@property (nonatomic, copy) NSString *stayTaskTimestamp;
@property (nonatomic,assign) NSInteger stockNum;/** class **/
@property (nonatomic,assign) BOOL isAfter ;/** <#class#> **/
//@property (nonatomic,strong) LLMeOrderDetailModel *appDeliveryClerkDistanceVo;/** <#class#> **/
@property (nonatomic,strong) LLMeOrderDetailModel *appAddressInfoVo;/** <#class#> **/
@property (nonatomic, copy) NSString *stayPayTimestamp;

@property (nonatomic,strong)NSArray<LLappOrderListGoodsVos*> *appOrderListGoodsVos;


@end




@interface LLappAddressInfoVo : NSObject

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *distanceSphere;
@property (nonatomic,copy)NSString *adressId;
@property (nonatomic,copy)NSString *isDefault;
@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *locations;
@property (nonatomic,copy)NSString *longitude;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *receiveName;
@property (nonatomic,copy)NSString *receivePhone;


@end



@interface LLappOrderListGoodsVos : NSObject

@property (nonatomic,copy)NSString *coverImage;
@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *goodsNum;
@property (nonatomic,copy)NSString *idd;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *salesPrice;
@property (nonatomic,copy)NSString *scribingPrice;
@property (nonatomic,copy)NSString *specsValName;
@property (nonatomic,copy)NSDictionary *appOrderEvaluateVo;


@end


@interface LLappOrderEvaluateVo : NSObject

@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *images;
@property (nonatomic,copy)NSString *star;

@end



//
//@interface LLappDeliveryClerkDistanceVo : NSObject
//
//
//@property (nonatomic,copy)NSString *address;
//@property (nonatomic,copy)NSString *area;
//@property (nonatomic,copy)NSString *city;
//@property (nonatomic,copy)NSString *gender;
//@property (nonatomic,copy)NSString *deliverId;
//@property (nonatomic,copy)NSString *photo;
//@property (nonatomic,copy)NSString *idd;
//@property (nonatomic,copy)NSString *province;
//@property (nonatomic,copy)NSString *realName;
//@property (nonatomic,copy)NSString *telePhone;
//@property (nonatomic,copy)NSString *userId;
//
//
//@end




@interface LLshopDistanceVo : NSObject

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *businessLicense;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *distanceSphere;
@property (nonatomic,copy)NSString *distanceWgs;
@property (nonatomic,copy)NSString *idd;
@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *longitude;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *refuseReason;
@property (nonatomic,copy)NSString *shopPhoto;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *telePhone;
@property (nonatomic,copy)NSString *userId;


@end

NS_ASSUME_NONNULL_END
