//
//  HttpRequestToken.m
//  SmartDevice
//
//  Created by singelet on 16/6/12.
//  Copyright © 2016年 ALPHA. All rights reserved.
//

#import "HttpRequestToken.h"
#import "NSData+zh_JSON.h"
#import "Define1.h"

@implementation HttpRequestToken

//解析token 判断是否失效
+ (BOOL)analysisToken:(NSString*)token
{
    
    if (token) {
        return NO;
    }else{
        return NO; ;
    }
    
    NSArray *segments = [token componentsSeparatedByString:@"."];
    NSString *base64String = [segments objectAtIndex: 1];
    
    NSUInteger requiredLength = (int)(4 * ceil((float)[base64String length] / 4.0));
    NSUInteger nbrPaddings = requiredLength - [base64String length];
    
    if (nbrPaddings > 0) {
        NSString *padding = [[NSString string] stringByPaddingToLength:nbrPaddings withString:@"=" startingAtIndex:0];
        base64String = [base64String stringByAppendingString:padding];
    }
    
    base64String = [base64String stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];

    
//    NSDictionary *dddd = [NSData zh_jsonFromData:decodedData];
    
    NSDictionary *dic  = [NSData zh_JSONFromData:[decodedString dataUsingEncoding:NSUTF8StringEncoding]];
    NSTimeInterval time = (NSTimeInterval)[[dic objectForKey:@"exp"] floatValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    
    
    NSTimeInterval time_iat = (NSTimeInterval)[[dic objectForKey:@"iat"] floatValue];
    NSDate *confromTimesp_iat = [NSDate dateWithTimeIntervalSince1970:time_iat];
        NSLog(@"有效期到 =  %@==",confromTimesp);
        NSLog(@"签发时间=  %@",confromTimesp_iat);

//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
////    [formatter setDateStyle:NSDateFormatterMediumStyle];
////    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyy-MM-dd HH：MM：ss"];
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    
//    NSDate *date123= [formatter dateFromString:@"1466483712"];
//
//
//    
//    NSTimeInterval time_iat = (NSTimeInterval)[[dic objectForKey:@"iat"] floatValue];
//    NSDate *confromTimesp_iat = [NSDate dateWithTimeIntervalSince1970:time_iat];
//    NSString *confromTimespStr_iat = [formatter stringFromDate:confromTimesp_iat];
//
//    
//    NSDate* date = [formatter dateFromString:confromTimespStr]; //------------将字符串按formatter转成nsdate
    NSTimeInterval late=[confromTimesp timeIntervalSince1970]*1;
    NSTimeInterval now=[[NSDate date] timeIntervalSince1970]*1;
    NSLog(@"有效期到 = %f=====当前时间==%f====差==%f分钟",late,now,(now-late)/60);
    
    
    if ((now-late) > -5) { //已失效
        return YES;
    }
    return NO;   //未失效
}

+ (void)saveToken:(NSString *)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:kSmartDeviceLoginTokenKey];
    [userDefaults synchronize];
}

+ (NSString*)getToken
{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:kSmartDeviceLoginTokenKey];
    return token;
}


@end
