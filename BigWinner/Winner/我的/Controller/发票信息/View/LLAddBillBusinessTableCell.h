//
//  LLAddBillBusinessTableCell.h
//  Winner
//
//  Created by YP on 2022/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLAddBillSpecialAdressTableCell;

@interface LLAddBillBusinessTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *placeholder;
@property (assign, nonatomic) NSInteger indexRow;
@property (assign, nonatomic) NSInteger type;
@property (nonatomic, copy) NSString *content;

@property (nonatomic,copy)void (^LLAddBillBusinessBlock)(NSInteger index,NSString *content);

@end




@interface LLAddBillSpecialAdressTableCell : UITableViewCell

@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *placeholder;
@property (assign, nonatomic) NSInteger indexRow;
@property (assign, nonatomic) NSInteger type;
@property (nonatomic,strong)NSString *adressStr;
@property (nonatomic, copy) NSString *content;
@property (nonatomic,copy)void (^LLAddBillBusinessBlock)(NSInteger index,NSString *content);

@end




NS_ASSUME_NONNULL_END
