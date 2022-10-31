//
//  LLCommonDelegate.h
//  LLTalentGang
//
//  Created by lijun L on 2019/6/24.
//  Copyright © 2019年 lijun L. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LLCommonDelegate <NSObject>
-(void)getData:(NSString *)content indexs:(NSInteger )indextag;
-(void)updateDatas;
-(void)getCellData:(NSString *)content indexs:(NSIndexPath * )indextag;

-(void)updateNiceDatas:(NSString *)name;
-(void)getAddress:(NSDictionary *)dic;
-(void)actionTextfield;
@end

NS_ASSUME_NONNULL_END
