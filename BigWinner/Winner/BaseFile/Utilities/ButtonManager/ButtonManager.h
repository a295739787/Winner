//
//  VoiceManager.h
//  SmartDevice
//
//  Created by admin on 16/6/3.
//  Copyright © 2016年 ALPHA. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求回调
typedef void (^RequestBlock)(NSDictionary *response);

typedef void (^ClickBlock)(NSInteger index);

@interface ButtonManager : NSObject
@property (copy, nonatomic) ClickBlock clickBlock;
@property (copy, nonatomic) RequestBlock requestBlock;
//@property (copy, nonatomic) FailedBlock failedBlock;

+ (ButtonManager *)sharedManager;

+ (void)hidden:(BOOL)hidden;
/**
 *  显示按钮
 *  @param clickBlock        返回点击index
 *  @param requestBlock      请求错误
 */


+ (void)clickVoiceButtonAtIndex:(ClickBlock)clickBlock
                        Request:(RequestBlock)requestBlock;


/**
 *  销毁
 */
+ (void)dissMiss;

@end
