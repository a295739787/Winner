//
//  EnterPasswordView.h
//  Winner
//
//  Created by YP on 2022/3/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnterPasswordView : UIView


@property (nonatomic,copy)void (^EnterPasswordBlock)(NSString *number,LLGoodModel *model);

@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

-(void)show;
-(void)hidden;

@end

NS_ASSUME_NONNULL_END
