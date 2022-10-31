//
//  PromoteDetailModel.h
//  Winner
//
//  Created by YP on 2022/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PromoteDetailModel : NSObject<MJKeyValue>

@property (nonatomic,copy)NSString *account;
@property (nonatomic,copy)NSString *activatedPrice;
@property (nonatomic,copy)NSString *buyPrice;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *headIcon;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *profitPrice;
@property (nonatomic,copy)NSString *realName;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *toBeActivatedPrice;
@property (nonatomic,copy)NSString *completeTime;
@property (nonatomic,copy)NSString *userId;

@end

NS_ASSUME_NONNULL_END
