//
//  NSString+Reg.h
//  OrientFund
//
//  Created by fugui on 16/1/29.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Reg)
@property (nonatomic, assign, readonly) BOOL isPhoneNo;
@property (nonatomic, assign, readonly) BOOL isMobiePhoneNo;
@property (nonatomic, assign, readonly) BOOL isFundId;

//@property (nonatomic,assign,readonly) BOOL isFax;

@property (nonatomic, assign, readonly) BOOL isMail;
@property (nonatomic, assign, readonly) BOOL isQQ;
@property (nonatomic, assign, readonly) BOOL isZipCode;

@property (nonatomic, assign, readonly) BOOL isNumberString;
@property (nonatomic, assign, readonly) BOOL isMoneyAmount;

@property (assign, nonatomic, readonly) BOOL validLoginPsw;
@property (assign, nonatomic, readonly) BOOL validPsw;

+ (NSArray *)verifyMoneyAmountInput:(NSString *)amount;
//几分钟前，几小时前，几天前
+ (NSString *) compareCurrentTime:(NSString *)str;
@end
