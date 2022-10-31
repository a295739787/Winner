//
//  NSObject+Extension.h
//  PieLifeApp
//
//  Created by libj on 2019/8/7.
//  Copyright © 2019 Libj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLGoodModel;
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)

- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs colors:(NSArray <UIColor*>*)colors;

- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs fonts:(NSArray <UIFont*>*)fonts;

- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs fonts:(NSArray <UIFont*>*)fonts colors:(NSArray <UIColor*>*)colors;
- (NSMutableAttributedString *)getAttribuStrWithStrings:(NSArray *)strs fonts:(NSArray <UIFont*>*)fonts lineSpacing:(CGFloat)lineSpacing;

#pragma mark 判断是否打开定位
- (BOOL)determineWhetherTheAPPOpensTheLocation;

- (NSDictionary *)dictWtihKeyValue:(LLGoodModel *)model;
- (NSString *)getOrderStateStrWith:(NSInteger)orderState;
- (UIViewController *)currentViewController;

- (CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
