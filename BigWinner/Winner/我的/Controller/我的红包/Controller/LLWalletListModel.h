//
//  LLWalletListModel.h
//  Winner
//
//  Created by YP on 2022/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLWalletListModel : NSObject<MJKeyValue>

@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
