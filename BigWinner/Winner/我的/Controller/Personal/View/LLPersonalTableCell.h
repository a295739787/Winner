//
//  LLPersonalTableCell.h
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import <UIKit/UIKit.h>
#import "LLPersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLPersonalBankTableCell;
@class LLCertificationTableCell;
@class LLAddBankCardTableCell;
@class LLMeBankCardTableCell;

typedef void(^LLCentificationBlock)(NSInteger index,NSString *contentStr);
typedef void(^LLAddBankCardBlock)(NSInteger index,NSString *contentStr);
typedef void(^LLAddBankCardSendCodeBtnBlock)(UIButton *sendBtn);

@interface LLPersonalTableCell : UITableViewCell

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *contextStr;
@property (assign, nonatomic) NSInteger index;

@end


@interface LLPersonalBankTableCell : UITableViewCell


@end


@interface LLCertificationTableCell : UITableViewCell

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *placeholderStr;
@property (assign, nonatomic) NSInteger index;

@property (nonatomic,copy)LLCentificationBlock centificationBlock;

@end

@interface LLAddBankCardTableCell : UITableViewCell

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *placeholderStr;
@property (assign, nonatomic) NSInteger index;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSString *bankName;

@property (nonatomic,copy)LLAddBankCardBlock bankCardBlock;
@property (nonatomic,copy)LLAddBankCardSendCodeBtnBlock sendCodeBtnBlock;

@end


@interface LLMeBankCardTableCell : UITableViewCell


@property (nonatomic,strong)LLPersonalModel *personalModel;


@end

NS_ASSUME_NONNULL_END
