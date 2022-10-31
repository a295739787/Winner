//
//  LLAddBankCardFooterView.h
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLSelectBankNameView;

typedef void(^AddBankCardBlock)(NSInteger index,BOOL isSelect,UIButton *sender);

@interface LLAddBankCardFooterView : UIView

@property (nonatomic,copy)AddBankCardBlock addCarBlock;

@end


@interface LLSelectBankNameView : UIView

@property (nonatomic,copy)void(^LLSelectBankBlock)(NSDictionary *dict);

-(void)show;
-(void)hidden;

@end

NS_ASSUME_NONNULL_END
