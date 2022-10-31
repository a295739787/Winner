//
//  LLMoudleButton.h
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import <UIKit/UIKit.h>


@class LLMeStockButton;
@class LLMeOrderHeaderButton;
@class LLMeOrderButton;
@class LLMeListButton;


NS_ASSUME_NONNULL_BEGIN

@interface LLMoudleButton : UIButton

@property (nonatomic,strong)NSString *countStr;
@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)UILabel *countLabel;

@end


@interface LLMeStockButton : UIButton

@property (nonatomic,strong)NSString *countStr;
@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *imgStr;

@end


@interface LLMeOrderHeaderButton : UIButton

@property (nonatomic,strong)NSString *titleStr;

@end


@interface LLMeOrderButton : UIButton

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *imgStr;
@property (nonatomic,strong)NSString *countStr;

@end

@interface LLMeListButton : UIButton

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *imgStr;

@end

NS_ASSUME_NONNULL_END
