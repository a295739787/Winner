//
//  SuspensionAssistiveTouch.h
//  SuspensionAssistiveTouch
//
//  Created by Rainy on 2017/9/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Header.h"
//@interface SuspensionAssistiveTouch : UIWindow<UIGestureRecognizerDelegate>
@interface SuspensionAssistiveTouch : UIView<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIImageView *showimage;/** <#class#> **/
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,strong)   UIButton *touchButton; ;/** <#class#> **/
@property (nonatomic,copy) NSString *skuid;/** <#class#> **/
//@property (nonatomic,copy) NSString *isVatual;/** <#class#> **/
@property (nonatomic,assign) BOOL isVatual;/** <#class#> **/

@property (nonatomic,assign) BOOL isMain;/** <#class#> **/
@end
