//
//  LLFeedbackInoutTableCell.h
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import <UIKit/UIKit.h>
#import "LLTextView.h"
NS_ASSUME_NONNULL_BEGIN
@class LLFeedbackInoutTableCell;
@protocol LLFeedbackInoutTableCellDelegate <NSObject>

- (void)inputTableViewCell:(LLFeedbackInoutTableCell *)cell index:(NSIndexPath* )indexs content:(NSDictionary *)datas;;

@end

typedef void(^LLFeedbackInputBlock)(NSString *contentStr,NSInteger indexSection);
typedef void(^OpenCameraOrAlbumBlock)(NSInteger indexSection);
typedef void (^LLUpdateImgAtrayBlock)(NSInteger deleteIndex,NSInteger indexSection);

@interface LLFeedbackInoutTableCell : UITableViewCell
@property (nonatomic, weak, nullable) id <LLFeedbackInoutTableCellDelegate> delegate;

@property (nonatomic,copy)LLFeedbackInputBlock inputBlock;
@property (nonatomic,copy)OpenCameraOrAlbumBlock openBlock;
@property (nonatomic,copy)LLUpdateImgAtrayBlock updateImgArrayBlock;

@property (nonatomic,strong)LLTextView *textView;

@property (nonatomic,strong)NSMutableArray *selectPhotos;

@property (assign, nonatomic) NSInteger indexSection;
@property (nonatomic,strong)NSString *titleStr;

@property (assign, nonatomic) NSInteger type;
@property (nonatomic,copy) NSString *titles;/** <#class#> **/
@property (nonatomic,copy) NSString *start;/** <#class#> **/
@property (nonatomic,strong) NSIndexPath *index;/** <#class#> **/

@property (nonatomic,copy) NSString *images;/** <#class#> **/


@end

NS_ASSUME_NONNULL_END
