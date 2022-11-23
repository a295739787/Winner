//
//  LLPersonalModel.h
//  Winner
//
//  Created by YP on 2022/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLPersonalModel : NSObject
@property (nonatomic, copy) NSString *bankNo;

@property (nonatomic,copy)NSString *account;
@property (nonatomic,copy)NSString *balance;
@property (nonatomic,copy)NSString *bankCardNum;
@property (nonatomic,copy)NSString *bankId;
@property (nonatomic,copy)NSString *bankName;
@property (nonatomic,copy)NSString *headIcon;
@property (nonatomic,copy)NSString *invitationCode;
@property (nonatomic,copy)NSString *isBank;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *promotionPrice;
@property (nonatomic,copy)NSString *realName;
@property (nonatomic,copy)NSString *realStatus;
@property (nonatomic,copy)NSString *redBalance;
@property (nonatomic,copy)NSString *stayAfterOrderNum;
@property (nonatomic,copy)NSString *stayDeliveryOrderNum;
@property (nonatomic,copy)NSString *stayPayOrderNum;
@property (nonatomic,copy)NSString *stayReceivingOrderNum;
@property (nonatomic,copy)NSString *stock;
@property (nonatomic,copy)NSString *totalCashRedPrice;
@property (nonatomic,copy)NSString *totalConsumeRedPrice;
@property (nonatomic,copy)NSString *totalPromotionPrice;
@property (nonatomic,copy)NSString *promotionUserNum;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userIdentity;//用户身份（1普通用户，2推广点，3配送员）
@property (nonatomic,assign) BOOL isShop;/** 是否存在推广点 **/
@property (nonatomic,assign) BOOL isClerk;/** 是否存在配送员 **/
@property (nonatomic, copy) NSString *invitationLink;
@property (nonatomic,copy) NSString *bankPhone;/** <#class#> **/
@property (nonatomic,copy) NSString *bankCertificatesNumber;/** <#class#> **/
@property (nonatomic, copy) NSString *bankRealName;
@property (nonatomic,assign) NSInteger messageNum;/** class **/

/* 配送员 */
@property (nonatomic,copy)NSString *clerkAddress;//配送员详细地址
@property (nonatomic,copy)NSString *clerkArea;//配送员所在区
@property (nonatomic,copy)NSString *clerkCertificatesNumber;//配送员证件号码
@property (nonatomic,copy)NSString *clerkCity;//配送员所在市
@property (nonatomic,copy)NSString *clerkGender;//配送员性别(1男、2女)
@property (nonatomic,copy)NSString *clerkId;//配送员ID
@property (nonatomic,copy)NSString *clerkPhoto;//配送员头像
@property (nonatomic,copy)NSString *clerkProvince;//配送员所在省
@property (nonatomic,copy)NSString *clerkRealName;//配送员姓名
@property (nonatomic,copy)NSString *clerkStatus;//状态（1待审核、2已通过、3不通过）
@property (nonatomic,copy)NSString *clerkTelePhone;//配送员电话
@property (nonatomic,copy)NSString *cumulativeDeliveryNum;//累计完成配送数量
@property (nonatomic,copy)NSString *distStayAfterOrderNum;//配送库存售后订单数量
@property (nonatomic,copy)NSString *distStockCompleteOrderNum;//配送库存已完成订单数量
@property (nonatomic,copy)NSString *distStockNum;//配送库存
@property (nonatomic,copy)NSString *distStockStayDeliveryOrderNum;//配送库存待发货订单数量
@property (nonatomic,copy)NSString *distStockStayReceivingOrderNum;//配送库存待收货订单数量
@property (nonatomic,copy)NSString *accumulatedCommissionPrice;//用户手机号

/* 推广员 */
@property (nonatomic,copy)NSString *shopStatus;
@property (nonatomic,copy)NSString *shopProvince;
@property (nonatomic,copy)NSString *shopBusinessLicense;
@property (nonatomic,copy)NSString *shopTelePhone;
@property (nonatomic,copy)NSString *shopLongitude;
@property (nonatomic,copy)NSString *shopCity;
@property (nonatomic,copy)NSString *shopArea;
@property (nonatomic,copy)NSString *shopPhoto;
@property (nonatomic,copy)NSString *shopAddress;
@property (nonatomic,copy)NSString *shopName;
@property (nonatomic,copy)NSString *shopLatitude;
@property (nonatomic,copy)NSString *shopNo;


@end

NS_ASSUME_NONNULL_END
