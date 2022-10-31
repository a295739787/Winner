//
//  LLCertificationController.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LLCertificationBlock)(NSString *realname);

@interface LLCertificationController : LMHBaseViewController

@property (nonatomic,copy)LLCertificationBlock certificationBlock;

@end

NS_ASSUME_NONNULL_END
