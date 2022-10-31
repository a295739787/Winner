//
//  NSString+Reg.m
//  OrientFund
//
//  Created by fugui on 16/1/29.
//
//

#import "NSString+Reg.h"

@implementation NSString (Reg)
-(BOOL)isPhoneNo{
    NSString *phoneRegex = @"\\d{7,11}";
    return [self regMatch:phoneRegex];
}
-(BOOL)isMobiePhoneNo{
    NSString *mobiePhoneRegex = @"^(13|14|15|17|18)\\d{9}$";
    return [self regMatch:mobiePhoneRegex];
}

- (BOOL)isFundId {
    NSString *regex = @"^[\\*a-zA-Z0-9]{1,12}$";
    return [self regMatch:regex];
}

-(BOOL)isMail{
//    NSString *emailRegex = @"^\\w+@[A-Za-z0-9]+\\.[A-Za-z0-9]+$";
    NSString *emailRegex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    return [self regMatch:emailRegex];
}

-(BOOL)isQQ{
    NSString *emailRegex = @"^[1-9]\\d{4,}";
    return [self regMatch:emailRegex];
}

-(BOOL)isZipCode{
    NSString *zipRegex = @"\\d{6}";
    return [self regMatch:zipRegex];
}

- (BOOL)isNumberString{
    NSString *numberRegex = @"\\d";
    return [self regMatch:numberRegex];
}

- (BOOL)isMoneyAmount {
    NSString *moneyAmountRegex = @"^(0|[1-9]\\d{0,13})([.]\\d{1,2}){0,1}$";
    return [self regMatch:moneyAmountRegex] && self.doubleValue > 0;
}

- (BOOL)validLoginPsw {
    NSString *pswRegex = @"^[0-9a-zA-Z!@#$%\\^\\&\\*_\\-]{6,20}$";
    return [self regMatch:pswRegex];
}

- (BOOL)validPsw {
    NSString *pswRegex = @"^(((?=.*\\d)(?=.*[a-zA-Z!@#$%\\^\\&\\*_\\-]))|((?=.*[a-zA-Z])(?=.*[!@#$%\\^\\&\\*_\\-])))[0-9a-zA-Z!@#$%\\^\\&\\*_\\-]{6,20}$";
    return [self regMatch:pswRegex];
}

-(BOOL)regMatch:(NSString* )reg{
    NSPredicate *regPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [regPre evaluateWithObject:self];

}


+ (NSArray *)verifyMoneyAmountInput:(NSString *)amount {
    // 不能连输入两个0
    NSRange range0;
    if (amount.length > 1) {
        range0 = [amount rangeOfString:@"0"];
        if (range0.location != NSNotFound && range0.location == 0) {
            if (![[amount substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."]) {
                return @[@(0), @"整数首位不能为0"];
            }
        }
    }
    // 小数点数目不能多于一个
    NSRange range1 = [amount rangeOfString:@"."];
    if (range1.location != NSNotFound) {
        if ([amount isEqualToString:@"0.00"]) {
            return @[@(0), @"输入金额不能等于0"];
        }
        NSString *subAmount = [amount substringFromIndex:range1.location + range1.length];    // 小数点后面的数字
        NSRange range2 = [subAmount rangeOfString:@"."];
        if (range2.location != NSNotFound) {
            return @[@(0), @"已有小数点"];
        }
        
        // 只保留小数点后两位
        if (subAmount.length > 2) {
            return @[@(0), @"小数点后已有两位小数"];
        }

    }
    
//    NSDecimalNumber *amountDecimal = [NSDecimalNumber decimalNumberWithString:amount];
//    NSDecimalNumber *minDecimal = [NSDecimalNumber decimalNumberWithString:@"0.01"];
//    NSDecimalNumber *maxDecimal = [NSDecimalNumber decimalNumberWithString:@"5000000.00"];
//    if ([amountDecimal compare:minDecimal] == NSOrderedAscending) {
//        return @[@(0), @"存入金额不能小于0.01元"];
//    }
    
    // 如果有上限限制
//    if ([amountDecimal compare:maxDecimal] == NSOrderedDescending) {
//        return @[@(0), @"存入金额不能大于5,000,000.00元"];
//    }
    
    return @[@(1), @""];
}
+ (NSString *) compareCurrentTime:(NSString *)str

{
    
    //把字符串转为NSdate
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    return  result;
    
}

@end
