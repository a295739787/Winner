//
//  UIView+Frame.m
//  Sinfo
//
//  Created by xiaoyu on 16/6/29.
//  Copyright © 2016年 YaoZhong. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(SKOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == SKOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == SKOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

-(void)setCornerRad:(CGFloat)cornerRad
{
    self.layer.cornerRadius = cornerRad;
    self.layer.masksToBounds = YES;
    
}
-(CGFloat)cornerRad
{
    return self.cornerRad;
}
-(void)setCy:(CGFloat)Cy
{
    CGPoint center = self.center;
    center.y = Cy;
    self.center = center;
}
-(CGFloat)Cy
{
    return self.center.y;
}
-(void)setCx:(CGFloat)Cx
{
    CGPoint center = self.center;
    center.x = Cx;
    self.center = center;
}
-(CGFloat)Cx
{
    return self.center.x;
}
-(void)setSh:(CGFloat)Sh
{
    CGRect fram = self.frame;
    fram.size.height = Sh;
    self.frame = fram;
}
-(CGFloat)Sh
{
    return self.frame.size.height;
}
-(void)setSw:(CGFloat)Sw
{
    CGRect fram = self.frame;
    fram.size.width = Sw;
    self.frame = fram;
}
-(CGFloat)Sw
{
    return self.frame.size.width;
}

-(CGFloat)X
{
    return self.frame.origin.x;
}
-(CGFloat)Y
{
    return self.frame.origin.y;
}
-(void)setX:(CGFloat)X
{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}
-(void)setY:(CGFloat)Y
{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}

- (void)setSl_x:(CGFloat)sl_x {
    CGRect frame = self.frame;
    frame.origin.x = sl_x;
    self.frame = frame;
}
- (CGFloat)sl_x {
    return self.frame.origin.x;
}

- (void)setSl_y:(CGFloat)sl_y {
    CGRect frame = self.frame;
    frame.origin.y = sl_y;
    self.frame = frame;
}
- (CGFloat)sl_y {
    return self.frame.origin.y;
}

- (void)setSl_width:(CGFloat)sl_w {
    CGRect frame = self.frame;
    frame.size.width = sl_w;
    self.frame = frame;
}
- (CGFloat)sl_width {
    return self.frame.size.width;
}

- (void)setSl_height:(CGFloat)sl_h {
    CGRect frame = self.frame;
    frame.size.height = sl_h;
    self.frame = frame;
}
- (CGFloat)sl_height {
    return self.frame.size.height;
}

- (void)setSl_size:(CGSize)sl_size {
    CGRect frame = self.frame;
    frame.size = sl_size;
    self.frame = frame;
}
- (CGSize)sl_size {
    return self.frame.size;
}

- (void)setSl_centerX:(CGFloat)sl_centerX {
    CGPoint center = self.center;
    center.x = sl_centerX;
    self.center = center;
}
- (CGFloat)sl_centerX {
    return self.center.x;
}

- (void)setSl_centerY:(CGFloat)sl_centerY {
    CGPoint center = self.center;
    center.y = sl_centerY;
    self.center = center;
}
- (CGFloat)sl_centerY {
    return self.center.y;
}

- (void)setSl_origin:(CGPoint)sl_origin {
    CGRect frame = self.frame;
    frame.origin = sl_origin;
    self.frame = frame;
}
- (CGPoint)sl_origin {
    return self.frame.origin;
}

- (CGFloat)sl_left{
    return self.frame.origin.x;
}
- (void)setSl_left:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)sl_right{
    return CGRectGetMaxX(self.frame);
}

-(void)setSl_right:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)sl_top{
    return self.frame.origin.y;
}

- (void)setSl_top:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)sl_bottom{
    return CGRectGetMaxY(self.frame);
}
- (void)setSl_bottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


@end
