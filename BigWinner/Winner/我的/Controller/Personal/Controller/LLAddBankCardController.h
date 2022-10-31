//
//  LLAddBankCardController.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LLAddBankCardSyccessBlock)(NSMutableDictionary *dict);

@interface LLAddBankCardController : LMHBaseViewController
@property (nonatomic,copy) NSString *ID;/** <#class#> **/

@property (nonatomic,copy)LLAddBankCardSyccessBlock addBankSuccessBlock;

@end

NS_ASSUME_NONNULL_END
