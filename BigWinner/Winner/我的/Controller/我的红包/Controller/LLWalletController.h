//
//  LLWalletController.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLWalletController : LMHBaseViewController

@property (nonatomic,strong)NSString *type;//1:余额。2:消费红包
@property (nonatomic,strong)NSString *balance;

@end

NS_ASSUME_NONNULL_END
