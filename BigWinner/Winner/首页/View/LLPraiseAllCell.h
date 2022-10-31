//
//  LLPraiseAllCell.h
//  JuMei
//
//  Created by lijun L on 2019/12/17.
//  Copyright © 2019 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLPraiseAllCell : UITableViewCell
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@end
@interface LLPraisePicCell : UICollectionViewCell

@property (nonatomic,copy) NSString *imagestr;/** <#class#> **/
@property(nonatomic,strong)UIImageView *showimage;
@property(nonatomic,strong) UIImageView *BigImgView;
- (void)setBigImgViewWithImage:(UIImage *)img;
@end
NS_ASSUME_NONNULL_END
