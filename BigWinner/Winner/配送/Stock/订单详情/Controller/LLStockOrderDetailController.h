//
//  LLStockOrderDetailController.h
//  Winner
//
//  Created by YP on 2022/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLStockOrderDetailController : LMHBaseViewController
@property (nonatomic,copy) NSString *orderNo;/** <#class#> **/
@property (nonatomic, copy)void(^tapAction)(void);

@end

NS_ASSUME_NONNULL_END
