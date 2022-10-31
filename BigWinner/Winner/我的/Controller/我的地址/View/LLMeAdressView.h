//
//  LLMeAdressView.h
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLMeAdressDeleteView;

typedef void(^LLMeAdreddBtnBlock)(NSInteger index);
typedef void(^LLMeAdressDeleteBtnBlock)(void);

@interface LLMeAdressView : UIView

@property (nonatomic,copy)LLMeAdreddBtnBlock adressBtnBlock;
@property (assign, nonatomic) NSInteger adressType;//100:添加新地址 //200:保存 300：编辑地址


@end


@interface LLMeAdressDeleteView : UIView

@property (nonatomic,copy)LLMeAdressDeleteBtnBlock deleteBtnBlock;

@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *rightStr;

-(void)hidden;
-(void)show;

@end

NS_ASSUME_NONNULL_END
