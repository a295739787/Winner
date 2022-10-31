//
//  HSTabbarViewController.m
//  HuaSheng
//
//  Created by  on 2018/5/3.
//  Copyright © 2018年 ebenny. All rights reserved.
//

#import "LLTabbarViewController.h"
#import "LLMainViewController.h"
#import "LLStoreViewController.h"
#import "LLMeViewController.h"
#import "LLPinJianViewController.h"
#import "LLNavigationViewController.h"
//#import "LLCircleViewController.h"
//#import "EMConversationsViewController.h"
//#import "LLCircleMainViewController.h"

@interface LLTabbarViewController ()<UITabBarDelegate,UITabBarControllerDelegate,UIGestureRecognizerDelegate>
/// 图片宽
@property (nonatomic, assign) CGFloat imageWidth;
/// 图片高
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, strong) NSArray *imageNameArrays;

@property (nonatomic,assign) NSInteger originY;/** <#class#> **/
@end

@implementation LLTabbarViewController{
//    // 这个socket用来做发送使用 当然也可以接收
//    GCDAsyncSocket *sendTcpSocket;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

} 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originY = SCREEN_HEIGHT-DeviceXTabbarHeigh(49)-kTabBarHeight;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = White_Color;
    self.navigationController.navigationBarHidden = YES;
    self.delegate = self;
    //添加所有的子控制器
    [self addAllChildVcs];

}


//添加所有的子控制器
-(void)addAllChildVcs{
    LLMainViewController *dating = [[LLMainViewController alloc] init];
    [self addOneChildVc:dating andTitle:@"首页" andImageName:@"home_gray" andSelectedImageName:@"home_red"];
    LLStoreViewController *classify = [[LLStoreViewController alloc] init];
    [self addOneChildVc:classify andTitle:@"零售区" andImageName:@"retail_gray" andSelectedImageName:@"retail_red"];
    LLPinJianViewController *circles = [[LLPinJianViewController alloc] init];
    [self addOneChildVc:circles andTitle:@"品鉴" andImageName:@"judge_gray" andSelectedImageName:@"judge_red"];

    LLMeViewController *shopcar = [[LLMeViewController alloc] init];
    [self addOneChildVc:shopcar andTitle:@"我的" andImageName:@"user_gray" andSelectedImageName:@"user_red"];


}

-(void)addOneChildVc:(UIViewController *)childVc andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName{
    NSLog(@"title == %@",title);
    //设置标题:相当于同时设置了tabBarItem.title和navigationItem.title
    childVc.title = title;
    UIImage *moreImage = [UIImage imageNamed:imageName];

    //设置图标
    childVc.tabBarItem.image = [moreImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中后的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc] init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#808080"];
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    NSMutableDictionary *textAttrssele = [[NSMutableDictionary alloc] init];
    textAttrssele[NSForegroundColorAttributeName] =Main_Color;
    textAttrssele[NSFontAttributeName] = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
    [childVc.tabBarItem setTitleTextAttributes:textAttrssele forState:UIControlStateSelected];
//    self.tabBar.tintColor = Main_Color;
    self.tabBar.translucent = NO;
    childVc.title = title;

    // 添加为tabbar控制器的子控制器
    LLNavigationViewController *nav = [[LLNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
#pragma mark - UITabBarControllerDelegate
//根据BOOL值来判断是否处于可继续点击状态
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];

    
    if (index == 3) {
        if([UserModel sharedUserInfo].token<= 0){
//            AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            [dele loginVc];
//             return NO;
        }else{
//            self.tabBar.backgroundColor = [UIColor blackColor];
        }
    }
//    return YES;
//    if (index == 2 || index == 1) {
//        if([UserModel sharedUserInfo].token<= 0){
//            AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
////            [dele loginVc];
//             return NO;
//        }
//    }
    return YES;

}
#pragma mark - 点赞动画
- (void)praiseAnimation {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    //  初始frame，即设置了动画的起点
    imageView.frame = CGRectMake(SCREEN_WIDTH*0.5-self.imageWidth*0.5, self.originY, self.imageWidth, self.imageHeight);
    //  初始化imageView透明度为0
    imageView.alpha = 0;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    //  用0.2秒的时间将imageView的透明度变成1.0，同时将其放大1.3倍，再缩放至1.1倍，这里参数根据需求设置
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
        imageView.alpha = 1.0;
        imageView.frame = CGRectMake(SCREEN_WIDTH*0.5-self.imageWidth*0.5, self.originY, self.imageWidth, self.imageHeight);
        CGAffineTransform transfrom = CGAffineTransformMakeScale(1.3, 1.3);
        imageView.transform = CGAffineTransformScale(transfrom, 1, 1);
    } completion:^(BOOL finished) {
        
    }];
//    [UIView animateWithDuration:0.2 animations:^{
//
//    }];
    [self.view addSubview:imageView];
    UIImageView *showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGFloatBasedI375(50), CGFloatBasedI375(50))];
    showView.image = [UIImage imageNamed:@"phoneimage"];
    [imageView addSubview:showView];

    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(NW(showView)+5, 0, 100, 50)];
    titlelabel.text = @"小米最新款千兆光猫接…";
    titlelabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(10)];
    [imageView addSubview:titlelabel];
    
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.imageWidth, imageView.height)];
    [imageView addSubview:btn];
    [btn addTarget:self action:@selector(clickview) forControlEvents:UIControlEventTouchUpInside];
    //  随机产生一个动画结束点的X值
    CGFloat finishX = self.view.frame.size.width - round(random() % (int)self.view.frame.size.width);
    //  动画结束点的Y值
    CGFloat finishY = 0;
    //  imageView在运动过程中的缩放比例
    CGFloat scale = round(random() % 2) + 0.7;
    // 生成一个作为速度参数的随机数
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    //  动画执行时间
    NSTimeInterval duration = 8 * speed;
//    NSLog(@"时间--%f",duration);
    //  如果得到的时间是无穷大，就重新附一个值（这里要特别注意，请看下面的特别提醒）
    if (duration == INFINITY) duration = 2.412346;
    // 随机生成一个图片数组的index
    int imageIndex = round(random() % self.imageNameArrays.count);
    
    //  开始动画
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    //  设置动画时间
    [UIView setAnimationDuration:duration];
    //  拼接图片名字
    imageView.image = [UIImage imageNamed:self.imageNameArrays[imageIndex]];
    
    //  设置imageView的结束frame
    imageView.frame = CGRectMake( finishX, finishY, self.imageWidth * scale, self.imageHeight * scale);
    //  设置渐渐消失的效果，这里的时间最好和动画时间一致
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
    //  结束动画，调用onAnimationComplete:finished:context:函数
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    //  设置动画代理
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
-(void)clickview{
    NSLog(@"点击了view、");
}
/// 动画完后销毁iamgeView
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    UIImageView *imageView = (__bridge UIImageView *)(context);
    [imageView removeFromSuperview];
    imageView = nil;
}
@end
