//
//  LLPersonalChangeVC.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LLPersonalChangeSuccessBlock) (NSString *changeText);

@interface LLPersonalChangeVC : LMHBaseViewController

@property (nonatomic,strong)NSString *nameStr;
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *userType;
@property (nonatomic,copy)LLPersonalChangeSuccessBlock changeSuccessBlock;

@end

NS_ASSUME_NONNULL_END
