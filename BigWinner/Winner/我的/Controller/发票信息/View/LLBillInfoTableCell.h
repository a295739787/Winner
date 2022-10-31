//
//  LLBillInfoTableCell.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import "LLBillModel.h"

NS_ASSUME_NONNULL_BEGIN

@class LLBillInfoContentTableCell;
@class LLBIllBudinessSpecialTableCell;
@class LLBillDetailTableViewCell;


typedef void(^LLInvoceEditorContentBlock)(NSInteger index,NSString *contentStr);


@interface LLBillInfoTableCell : UITableViewCell

@property (nonatomic,strong)LLBillModel *listModel;


@end


@interface LLBillInfoContentTableCell : UITableViewCell

@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *placeholder;
@property (assign, nonatomic) NSInteger indexRow;
@property (nonatomic,strong)NSString *contentStr;

@property (nonatomic,copy)LLInvoceEditorContentBlock editorInvoceBlock;

@end


@interface LLBIllBudinessSpecialTableCell : UITableViewCell

@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *placeholder;
@property (assign, nonatomic) NSInteger indexRow;
@property (nonatomic,strong)NSString *typeStr;

@property (nonatomic,copy)LLInvoceEditorContentBlock editorInvoceBlock;

@end


@interface LLBillDetailTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *placeholder;
@property (assign, nonatomic) NSInteger indexRow;
@property (nonatomic,strong)NSString *typeStr;

@property (nonatomic,copy)LLInvoceEditorContentBlock editorInvoceBlock;

@end

NS_ASSUME_NONNULL_END
