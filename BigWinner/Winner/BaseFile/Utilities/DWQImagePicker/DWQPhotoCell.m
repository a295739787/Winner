//
//  DWQPhotoCell.m
//  DWQPublishDemo
//
//  Created by 杜文全 on 16/5/10.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.

#import "DWQPhotoCell.h"
@interface DWQPhotoCell ()<UIGestureRecognizerDelegate>

@end
@implementation DWQPhotoCell

/** 查看大图 */
- (void)setBigImgViewWithImage:(UIImage *)img{
    if (_BigImgView) {
        //如果大图正在显示，还原小图
        _BigImgView.frame = _profilePhoto.frame;
        if([img isKindOfClass:[UIImage class]]){
        _BigImgView.image = img;
        }
    }else{
        _BigImgView = [[UIImageView alloc] initWithImage:img];
        _BigImgView.frame = _profilePhoto.frame;
        [self insertSubview:_BigImgView atIndex:0];
    }
    _BigImgView.contentMode = UIViewContentModeScaleToFill;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.profilePhoto.layer.masksToBounds = YES;
    self.profilePhoto.layer.cornerRadius = CGFloatBasedI375(3);
    self.profilePhoto.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *taps =  [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showupdate:)];
    taps.numberOfTapsRequired = 1;
    taps.delegate = self;
    taps.minimumPressDuration=2.0f;//设置长按 时间
    [self.profilePhoto  addGestureRecognizer:taps];
}
-(void)showupdate:(UILongPressGestureRecognizer *)tap{
    
}
@end
