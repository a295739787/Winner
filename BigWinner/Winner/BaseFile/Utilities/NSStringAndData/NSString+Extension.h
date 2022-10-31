//
//  NSString+Extension.h
//  SmartDevice
//
//  Created by mengzhiqiang on 17/3/13.
//  Copyright © 2017年 TeeLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (NSString *)getFirstLetter;
#pragma mark  手机号中间4位隐藏
+(NSString *)setPhoneMidHid:(NSString *)phone;
- (BOOL)isChinese;
/**
 *   根据手机适配不同链接图片
 *
 *  @return 图片链接
 */
+ (NSString *)getImageUrlWithCover:(NSDictionary*)cover;
/**字符串是否为空*/
+ (BOOL)isBlankString:(NSString *)str;
+(NSString *)getNowTimeTimestamp3;//获取时间戳
+(NSString*)getCurrentTimes;
#pragma mark  获取当前时间戳
+(NSInteger)getNowTimestamp;
+(NSString*)getCurrentTimesYYDD;
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime;
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
//获取app信息
+(NSString *)getAppInfo;

+ (NSArray *)loadingImages;
@end
@interface NSArray (PinYin)

/*
 *将一个字符串数组按照拼音首字母规则进行重组排序, 返回重组后的数组.
 *格式和规则为:
 
  [
      @{
           @"firstLetter": @"A",
           @"content": @[@"啊", @"阿狸"]
       }
      ,
      @{
           @"firstLetter": @"B",
           @"content": @[@"部落", @"帮派"]
       }
      ,
      ...
  ]
 
 *只会出现有对应元素的字母字典, 例如: 如果没有对应 @"C"的字符串出现, 则数组内也不会出现 @"C"的字典.
 *数组内字典的顺序按照26个字母的顺序排序
 *@"#"对应的字典永远出现在数组最后一位
 */
- (NSArray *)arrayWithPinYinFirstLetterFormat;
- (BOOL)isPhoneXxxx;
/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;

@end
