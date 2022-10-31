//
//  LLSorageView.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLStorageBottomView;

@interface LLSorageView : UIView

@property (nonatomic,strong)NSString *goodsNum;

@property (nonatomic,copy)void (^LLStorageCountBlock)(NSInteger count);
@property (nonatomic,copy)void (^LLStorageAddCarBtnBlock)(BOOL isCar);

@end

@interface LLStorageBottomView : UIView

@property (nonatomic,copy)void (^LLStorageConfirmBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
