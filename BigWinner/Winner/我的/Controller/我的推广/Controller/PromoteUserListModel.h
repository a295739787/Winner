//
//  PromoteUserListModel.h
//  Winner
//
//  Created by YP on 2022/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PromoteUserListModel : NSObject

@property (nonatomic,copy)NSString *account;
@property (nonatomic,copy)NSString *bindTime;
@property (nonatomic,copy)NSString *headIcon;
@property (nonatomic,copy)NSString *latelyTime;
@property (nonatomic,copy)NSString *profitPrice;
@property (nonatomic,copy)NSString *realName;
@property (nonatomic,copy)NSString *totalPrice;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic, copy) NSString *nickName;

@end

NS_ASSUME_NONNULL_END
