//
//  LLBillInfoView.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLBillAddheaderView;
@class LLBillSelectTypeView;

typedef void(^LLBillInfoBtnBlock)(NSInteger btnTag,UIButton *btn);
typedef void(^LLBillInfoHeaderBtnBlock)(NSInteger index);
typedef void(^LLBIllSelectTypeBlock)(NSInteger type,NSString *content);

@interface LLBillInfoView : UIView

@property (nonatomic,copy)LLBillInfoBtnBlock billInfoBtnBlock;
@property (assign, nonatomic) NSInteger indexType; //100:添加  200：保存 300:编辑


@end




@interface LLBillAddheaderView : UIView

@property (nonatomic,copy)LLBillInfoHeaderBtnBlock billHeaderBtnBlock;

@end



@interface LLBillSelectTypeView : UIView

-(void)hidden;
-(void)show;


@property (nonatomic,copy)LLBIllSelectTypeBlock selectTYpeBlock;

@end

NS_ASSUME_NONNULL_END
