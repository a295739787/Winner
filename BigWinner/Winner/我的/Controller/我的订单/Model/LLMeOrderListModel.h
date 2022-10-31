//
//  LLMeOrderListModel.h
//  Winner
//
//  Created by YP on 2022/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMeOrderListModel : NSObject<MJKeyValue>

@property (nonatomic,strong)LLMeOrderListModel *listModel;
@property (nonatomic,copy) NSString *judgeTaskPrice;/** <#class#> **/
@property (nonatomic,copy) NSString *completeTime;/** <#class#> **/
@property (nonatomic,copy) NSString *stayTaskTime;/** <#class#> **/
@property (nonatomic, copy) NSString *refuseReason;
@property (nonatomic,copy) NSString *expressName;/** <#class#> **/
@property (nonatomic,copy) NSString *expressId;/** <#class#> **/
@property (nonatomic,copy) NSString *expressVoucher;/** <#class#> **/
@property (nonatomic,assign) NSInteger stockNum;/** class **/
@property (nonatomic,assign) BOOL isAfter ;/** <#class#> **/
@property (nonatomic,strong)NSArray *list;
@property (nonatomic,copy)NSString *actualPrice;
@property (nonatomic,copy)NSString *afterType;
@property (nonatomic,assign) NSInteger isTimeout;/** class **/
@property (nonatomic,copy) NSString *expressNum;/** <#class#> **/
@property (nonatomic, copy) NSString *stayPayTimestamp;

@property (nonatomic,strong)NSArray *appOrderListGoodsVos;
@property (nonatomic, copy) NSString *returnReason;
@property (nonatomic,copy) NSString *timeoutTime;/** <#class#> **/
@property (nonatomic, copy) NSString *stayPayTime;

@property (nonatomic,strong)LLMeOrderListModel *appOrderListGoodsVo;
@property (nonatomic,strong)LLMeOrderListModel *appOrderEvaluateVo;
@property (nonatomic, copy) NSString *returnVoucher;
@property (nonatomic, copy) NSString *deliveryFeePrice;

@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *images;
@property (nonatomic,copy)NSString *star;
@property (nonatomic, copy) NSString *businessReceiverName;
@property (nonatomic, copy) NSString *businessReceiverPhone;
@property (nonatomic, copy) NSString *businessReceiverAddress;

@property (nonatomic,copy)NSString *coverImage;
@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *goodsNum;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *salesPrice;
@property (nonatomic,copy)NSString *scribingPrice;
@property (nonatomic,copy)NSString *specsValName;



@property (nonatomic,copy)NSString *expressType;
@property (nonatomic,copy)NSString *logisticStatus;
@property (nonatomic,copy)NSString *invoiceStatus;
@property (nonatomic,copy)NSString *orderAfterStatus;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *orderStatus;
@property (nonatomic,copy)NSString *orderType;
@property (nonatomic,copy)NSString *refundPrice;
@property (nonatomic,copy)NSString *refundReason;
@property (nonatomic,copy)NSString *taskStatus;
@property (nonatomic,copy)NSString *totalPrice;
@property (nonatomic,copy)NSString *writeCode;
@property (nonatomic,copy) NSString *clerkTelePhone;/** <#class#> **/
@property (nonatomic,copy) NSString *shopTelePhone;/** <#class#> **/

@end

NS_ASSUME_NONNULL_END
