//
//  UIView+Frame.h
//  Sinfo
//
//  Created by xiaoyu on 16/6/29.
//  Copyright © 2016年 YaoZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SKOscillatoryAnimationToBigger,
    SKOscillatoryAnimationToSmaller,
} SKOscillatoryAnimationType;

@interface UIView (Frame)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;
@property(nonatomic)CGFloat cornerRad;
@property(nonatomic)CGFloat Cy;
@property(nonatomic)CGFloat Cx;

@property(nonatomic,assign)CGFloat X;
@property(nonatomic,assign)CGFloat Y;
@property(nonatomic,assign)CGFloat Sh;
@property(nonatomic,assign)CGFloat Sw;
@property (nonatomic, assign ) CGFloat sl_x;
@property (nonatomic, assign ) CGFloat sl_y;
@property (nonatomic, assign ) CGFloat sl_width;
@property (nonatomic, assign ) CGFloat sl_height;
@property (nonatomic, assign ) CGFloat sl_centerX;
@property (nonatomic, assign ) CGFloat sl_centerY;

@property (nonatomic, assign ) CGSize sl_size;
@property (nonatomic, assign ) CGPoint sl_origin;

@property (nonatomic, assign) CGFloat sl_left;
@property (nonatomic, assign) CGFloat sl_right;
@property (nonatomic, assign) CGFloat sl_top;
@property (nonatomic, assign) CGFloat sl_bottom;
+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(SKOscillatoryAnimationType)type;
@end
