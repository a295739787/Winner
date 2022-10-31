//
//  LLWalletHeaderView.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>

@class LLWalletSelectView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LLWalletButtonBlock)(NSInteger btnTag,NSString *name);
typedef void(^LLwatetModeTypeBlock)(NSInteger modetype);

@interface LLWalletHeaderView : UIView

@property (nonatomic,copy)LLWalletButtonBlock walletBtnBlock;
@property (nonatomic,strong)NSString *balance;
@property (nonatomic,assign) NSInteger type;/** class **/


@end


@interface LLWalletSelectView : UIView

@property (nonatomic,copy)LLwatetModeTypeBlock modeTypeBlock;

@end

NS_ASSUME_NONNULL_END
