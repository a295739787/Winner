//
//  ImgCollectionViewCell.h
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DeletePhotoBlock)(NSInteger index);

@interface ImgCollectionViewCell : UICollectionViewCell


@property (assign, nonatomic) NSInteger index; //0无图片的状态  1有图片
@property (nonatomic,strong)UIImage *img;
@property (assign, nonatomic) NSInteger indexRow;//图片顺序

@property (nonatomic,copy)DeletePhotoBlock deleteBlock;

@end

NS_ASSUME_NONNULL_END
