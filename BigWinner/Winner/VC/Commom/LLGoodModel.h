//
//  LLGoodModel.h
//  Winner
//
//  Created by 廖利君 on 2022/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLGoodModel : NSObject<MJKeyValue>
@property (nonatomic,strong) LLGoodModel *sku;/** <#class#> **/
@property (nonatomic,copy) NSString *redUsers;/** <#class#> **/
@property (nonatomic,strong) NSArray *carousels;/** <#class#> **/
@property (nonatomic,strong) NSArray *list;/** <#class#> **/
@property (nonatomic,strong) NSArray *goodsEvaluateLists;/** <#class#> **/
@property (nonatomic,strong) NSArray *goodsSpecsLists;/** <#class#> **/
@property (nonatomic,strong) NSArray *goodsSpecsValLists;/** <#class#> **/
@property (nonatomic,strong) NSArray *appOrderConfirmGoodsVo;/** <#class#> **/
@property (nonatomic,copy) NSString *specsValName;/** <#class#> **/
@property (nonatomic,copy) NSString *goodsNum;/** <#class#> **/
@property (nonatomic,copy) NSString *totalPrice;/** <#class#> **/
@property (nonatomic,copy) NSString *redPrice;/** <#class#> **/
@property (nonatomic,copy) NSString *freight;/** <#class#> **/
@property (nonatomic,copy) NSString *goodsId;/** <#class#> **/
@property (nonatomic,copy) NSString *goodsSpecsPriceId;/** <#class#> **/
@property (nonatomic,copy) NSString *recommend;/** <#class#> **/
@property (nonatomic,assign) BOOL isSelect;/** class **/
@property (nonatomic,assign) NSInteger feePriceSize;/** class **/
@property (nonatomic,copy) NSString *returnVoucher;/** <#class#> **/
@property (nonatomic, copy) NSString *stayTaskTimestamp;
@property (nonatomic, copy) NSString *judgeDistance;
@property (nonatomic, copy) NSString *goodsStock;

@property (nonatomic,copy) NSString *judgeImage;/** <#class#> **/
@property (nonatomic,assign) NSInteger purchaseRestrictions;/**     integer($int32)
                                                           单次限购数量 **/
@property (nonatomic,strong) NSArray *appOrderListGoodsVos;/** <#class#> **/
@property (nonatomic,assign) CGFloat refundPrice;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *appAddressInfoVo;/** <#class#> **/
@property (nonatomic,copy) NSString *title;/** <#class#> **/
@property (nonatomic,copy) NSString *shopPhoto;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *userInfo;/** <#class#> **/
@property (nonatomic,copy) NSString *ranking;/** <#class#> **/
@property (nonatomic,copy) NSString *startTime;/** <#class#> **/
@property (nonatomic,copy) NSString *endTime;/** <#class#> **/
@property (nonatomic,copy) NSString *queueName;/** <#class#> **/
@property (nonatomic,copy) NSString *redToTime;/** <#class#> **/
@property (nonatomic,copy) NSString *judgeTaskPrice;/** <#class#> **/
@property (nonatomic,assign) NSInteger taskStatus;/** class **/
@property (nonatomic,copy) NSString *longitude;/** <#class#> **/
@property (nonatomic,copy) NSString *latitude;/** <#class#> **/
@property (nonatomic,copy) NSString *goodsBrokerage;/** <#class#> **/
@property (nonatomic,copy) NSString *deliveryFeePrice;/** <#class#> **/
@property (nonatomic,copy) NSString *isDefault;/** <#class#> **/
@property (nonatomic,assign) NSInteger status;/** 状态（1待审核、2已通过、3不通过） **/
@property (nonatomic, copy) NSString *refuseReason;
@property (nonatomic, copy) NSString *stockPrice;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic,assign) NSInteger orderType;/** class **/
@property (nonatomic,assign) NSInteger platform;/** class **/
@property (nonatomic,copy) NSString *telePhone;/** <#class#> **/
@property (nonatomic,copy) NSString *taskPlanTime;/** <#class#> **/
@property (nonatomic,assign) BOOL isTimeout;/** class **/
@property (nonatomic, copy) NSString *patchNum;
@property (nonatomic,copy) NSString *completeTime;/** <#class#> **/
@property (nonatomic,copy) NSString *timeoutTime;/** <#class#> **/
@property (nonatomic, copy) NSString *stayTaskTime;
@property (nonatomic, copy) NSString *distanceSphere;
@property (nonatomic,copy) NSString *headIcon;/** <#class#> **/

@property (nonatomic,copy) NSString *address;/** <#class#> **/
@property (nonatomic,copy) NSString *city;/** <#class#> **/
@property (nonatomic,copy) NSString *receiveName;/** <#class#> **/
@property (nonatomic,copy) NSString *area;/** <#class#> **/
@property (nonatomic,copy) NSString *province;/** <#class#> **/
@property (nonatomic,copy) NSString *receivePhone;/** <#class#> **/
@property (nonatomic,copy) NSString *expressType;/** <#class#> **/
@property (nonatomic,copy) NSString *orderNo;/** <#class#> **/
@property (nonatomic,copy) NSString *spotNum;/** <#class#> **/
@property (nonatomic,assign) NSInteger redStatus;/** class **/
@property (nonatomic,copy) NSString *expressTime;/** <#class#> **/
@property (nonatomic, copy) NSString *taskPlanTimestamp;
@property (nonatomic, copy) NSString *taskTimestamp;

@property (nonatomic,assign) NSInteger payMode;/** class **/

@property (nonatomic,strong) LLGoodModel *appGoodsListVos;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *AppGoodsEvaluateListVO;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *shopInfoVo;/** <#class#> **/

@property (nonatomic,copy) NSString *locations;/** <#class#> **/
@property (nonatomic,copy) NSString *stayStock;/** <#class#> **/
@property (nonatomic,copy) NSString *remarks;/** <#class#> **/
@property (nonatomic,copy) NSString *taskTime;/** <#class#> **/

@property (nonatomic,copy) NSString *ID;/** <#class#> **/
@property (nonatomic,copy) NSString *link;/** <#class#> **/
@property (nonatomic,copy) NSString *name;/** <#class#> **/
@property (nonatomic,copy) NSString *image;/** <#class#> **/
@property (nonatomic,assign) NSInteger type;/** class **/
@property (nonatomic,copy) NSString *coverImage;/** <#class#> **/
@property (nonatomic,copy) NSString *scribingPrice;/** <#class#> **/
@property (nonatomic,copy) NSString *salesPrice;/** <#class#> **/
@property (nonatomic,copy) NSString *realSalesVolume;/** <#class#> **/
@property (nonatomic,copy) NSString *salesVolume;/** <#class#> **/
@property (nonatomic,copy) NSString *stock;/** <#class#> **/
@property (nonatomic, copy) NSString *cancelTime;

@property (nonatomic,assign) NSInteger cartNum;/** <#class#> **/
@property (nonatomic,copy) NSString *details;/** <#class#> **/
@property (nonatomic,copy) NSString *evaluateNum;/** <#class#> **/
@property (nonatomic,copy) NSString *content;/** <#class#> **/
@property (nonatomic,copy) NSString *createTime;/** <#class#> **/
@property (nonatomic,copy) NSString *images;/** <#class#> **/
@property (nonatomic,copy) NSString *star;/** <#class#> **/
@property (nonatomic,copy) NSString *nickName;/** <#class#> **/
@property (nonatomic,copy) NSString *shopName;/** <#class#> **/
@property (nonatomic, copy) NSString *purchasePrice;
@property (nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
