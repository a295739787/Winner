//
//  UIButton+Extension.m
//  text
//
//  Created by 利君 on 15/9/10.
//  Copyright (c) 2017年 LiJun All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
#import "CustomButton.h"
@implementation UIButton (Extension)

/** 创建按钮，设置按钮文字，文字颜色默认灰色，文字大小默认12 */
+ (instancetype)buttonWithTitle:(NSString *)title atTarget:(id)target atAction:(SEL)action {
    return [self buttonWithTitle:title atTitleSize:0 atTitleColor:nil atTarget:target atAction:action];
}

/** 创建按钮，设置按钮文字与大小，文字颜色默认灰色 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleSize:(CGFloat)size atTarget:(id)target atAction:(SEL)action {
    return [self buttonWithTitle:title atTitleSize:size atTitleColor:nil atTarget:target atAction:action];
}

/** 创建按钮，设置按钮文字与文字颜色，文字大小默认12 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleColor:(UIColor *)color atTarget:(id)target atAction:(SEL)action {
    return [self buttonWithTitle:title atTitleSize:0 atTitleColor:color atTarget:target atAction:action];
}

/** 创建按钮，设置按钮文字、文字颜色与文字大小 */
+ (instancetype)buttonWithTitle:(NSString *)title atTitleSize:(CGFloat)size atTitleColor:(UIColor *)color atTarget:(id)target atAction:(SEL)action {
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"arial" size:(size ? : 12 )]];
    [button setTitleColor:(color ? : [UIColor grayColor]) forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return button;
}

/** 创建带有图片与文字的按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title atNormalImageName:(NSString *)normalImageName atSelectedImageName:(NSString *)selectedImageName atTarget:(id)target atAction:(SEL)action {
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Black_Color forState:UIControlStateNormal];
    [button setImage:(normalImageName ? [UIImage imageNamed:normalImageName] : nil) forState:UIControlStateNormal];
    [button setImage:(selectedImageName ? [UIImage imageNamed:selectedImageName] : nil) forState:UIControlStateSelected];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button.titleLabel setFont:[UIFont fontWithName:@"arial" size:14]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/** 创建带有图片与文字的按钮 左文字右图片 */
+ (instancetype)buttonWithTitle:(NSString *)title atRightNormalImageName:(NSString *)ImageName atRightSelectedImageName:(NSString *)selectedImageName atTarget:(id)target atAction:(SEL)action {
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Black_Color forState:UIControlStateNormal];
    [button setImage:(ImageName ? [UIImage imageNamed:ImageName] : nil) forState:UIControlStateNormal];
    [button setImage:(selectedImageName ? [UIImage imageNamed:selectedImageName] : nil) forState:UIControlStateSelected];
    CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -[UIImage imageNamed:ImageName].size.width, 0, [UIImage imageNamed:ImageName].size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -labelWidth-15)];
    [button.titleLabel setFont:[UIFont fontWithName:@"arial" size:14]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/** 创建带有图片与文字的按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title atBackgroundNormalImageName:(NSString *)BackgroundImageName atBackgroundSelectedImageName:(NSString *)BackgroundselectedImageName atTarget:(id)target atAction:(SEL)action {
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    /** 设置标题 */
    [button setTitle:title forState:UIControlStateNormal];
    /** 设置字体颜色 */
    [button setTitleColor:Black_Color forState:UIControlStateNormal];
    /** 普通背景图 */
    [button setBackgroundImage:(BackgroundImageName ? [UIImage imageNamed:BackgroundImageName] : nil) forState:UIControlStateNormal];
    /** 选中背景图 */
    [button setBackgroundImage:(BackgroundselectedImageName ? [UIImage imageNamed:BackgroundselectedImageName] : nil) forState:UIControlStateSelected];
    /** 添加点击事件 */
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    /** 设置字体 */
    [button.titleLabel setFont:[UIFont fontWithName:@"arial" size:14]];
    return button;
}




- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 10, -labelWidth*1.5);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/1.5, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}



- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)timer {
    
    return objc_getAssociatedObject(self, _cmd);
}


-(void)jk_startTime:(NSInteger )timeout  waitTittle:(NSString *)waitTittle{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(self.timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            [self invalidate];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.selected = YES;
//                self.userInteractionEnabled = YES;
//            });
            
        }else{
            //            int minutes = timeout / 60;
            int seconds;
            if (timeOut == 60) {
                seconds = 60;
            }else {
                seconds = timeOut % 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [self setTitle:[NSString stringWithFormat:@"重新获取(%@%@)",strTime,waitTittle] forState:UIControlStateNormal];
                [self setNeedsLayout];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
            
        }
    });
    dispatch_resume(self.timer);
}

- (void)invalidate {
    if(self.timer){
    dispatch_source_cancel(self.timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示 根据自己需求设置
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
//        self.selected = YES;
        self.userInteractionEnabled = YES;
    });
    }
}
#pragma mark - ************* 通过运行时动态添加关联 ******************
//定义关联的Key
static const char * titleRectKey = "yl_titleRectKey";
- (CGRect)titleRect {
    
    return [objc_getAssociatedObject(self, titleRectKey) CGRectValue];
}

- (void)setTitleRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, titleRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

//定义关联的Key
static const char * imageRectKey = "yl_imageRectKey";
- (CGRect)imageRect {
    
    NSValue * rectValue = objc_getAssociatedObject(self, imageRectKey);
    
    return [rectValue CGRectValue];
}

- (void)setImageRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, imageRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - ************* 通过运行时动态替换方法 ******************
+ (void)load {
    
    MethodSwizzle(self,@selector(titleRectForContentRect:),@selector(override_titleRectForContentRect:));
    MethodSwizzle(self,@selector(imageRectForContentRect:),@selector(override_imageRectForContentRect:));
}

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    
    //运行时函数class_addMethod 如果发现方法已经存在，会失败返回，也可以用来做检查用:
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        //如果添加成功(在父类中重写的方法)，再把目标类中的方法替换为旧有的实现:
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        //addMethod会让目标类的方法指向新的实现，使用replaceMethod再将新的方法指向原先的实现，这样就完成了交换操作。
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

- (CGRect)override_titleRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [self override_titleRectForContentRect:contentRect];
    
}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [self override_imageRectForContentRect:contentRect];
}


// 设置背景颜色for state
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}
// 设置颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 为控件添加渐变色
 
 @param starColor 起点颜色
 @param endColor 结点颜色
 */
- (void)setGradientStarColor:(NSString *)starColor endColor:(NSString *)endColor{

    UIColor *stars = [UIColor colorWithHexString:starColor];
    UIColor *ends = [UIColor colorWithHexString:endColor];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, self.width, self.height);
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = @[(__bridge id)stars.CGColor, (__bridge id)ends.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    self.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:72/255.0 blue:68/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,11);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 15;
    [self.layer addSublayer:gl];
    [self.layer insertSublayer:gl atIndex:0];

}

@end
