//
//  LLBillInfoController.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import "LLBillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLBillInfoController : LMHBaseViewController

@property (assign, nonatomic)BOOL isSelectType;
@property (nonatomic,copy)void(^LLBillInfoSelectBlock)(LLBillModel *listModel);

@end

NS_ASSUME_NONNULL_END
