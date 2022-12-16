//
//  LLSystemTableCell.h
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LLFeedbackSuccessTableCell;

@interface LLSystemTableCell : UITableViewCell

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *infoStr;


@end



@interface LLFeedbackSuccessTableCell: UITableViewCell

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,copy)void (^LLFeedBackcancleBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
