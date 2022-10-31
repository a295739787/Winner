//
//  LLOrderApplyBillModel.h
//  Winner
//
//  Created by YP on 2022/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLOrderApplyBillModel : NSObject

@property (nonatomic,copy)NSString *invoiceApplyTime;
@property (nonatomic,copy)NSString *invoicePrice;
@property (nonatomic,copy)NSString *invoiceStatus;
@property (nonatomic,copy)NSString *invoiceTime;
@property (nonatomic,copy)NSString *receiveEmail;

@end

NS_ASSUME_NONNULL_END
