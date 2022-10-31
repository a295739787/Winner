//
//  LLSearchCell.h
//  Winner
//
//  Created by 廖利君 on 2022/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLSearchCell : UICollectionViewCell
@property (nonatomic, copy) NSString *keyword;
- (CGSize)sizeForCell;
@property (strong, nonatomic) UILabel *nameLabel1;
@end

NS_ASSUME_NONNULL_END
