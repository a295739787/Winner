//
//  LLMeFirstGuideView.h
//  Winner
//
//  Created by YP on 2022/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLMeFirstGuideView : UIView

@property (nonatomic,strong)NSString *type;//1：推广点 2：配送
@property (nonatomic, copy) UIButton *sureButton;
-(void)hidden;
-(void)show;

@end

NS_ASSUME_NONNULL_END
