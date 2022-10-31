//
//  LLBillModel.h
//  Winner
//
//  Created by YP on 2022/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLBillModel : NSObject

@property (nonatomic,copy)NSString *bankAccount;
@property (nonatomic,copy)NSString *bankDeposit;
@property (nonatomic,copy)NSString *companyAddress;
@property (nonatomic,copy)NSString *companyTelePhone;
@property (nonatomic,copy)NSString *contactTelePhone;
@property (nonatomic,copy)NSString *headerType;
@property (nonatomic,copy)NSString *invoiceHeader;
@property (nonatomic,copy)NSString *invoiceType;
@property (nonatomic,copy)NSString *isDefault;
@property (nonatomic,copy)NSString *receiveAddress;
@property (nonatomic,copy)NSString *receiveEmail;
@property (nonatomic,copy)NSString *unitTaxNo;
@property (nonatomic,copy)NSString *ID;


@end

NS_ASSUME_NONNULL_END
