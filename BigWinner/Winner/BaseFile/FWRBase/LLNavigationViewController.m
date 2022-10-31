
#import "LLNavigationViewController.h"
#import "LLoginsViewController.h"
#import "Winner-Swift.h"
//#import "UIButton+Extension.h"


@interface LLNavigationViewController ()

@end

@implementation LLNavigationViewController

// 只初始化一次
+ (void)initialize{
    
        UINavigationBar *navBar = [UINavigationBar appearance];
        //    [navBar setTintColor:White_Color];
        navBar.barStyle = UIStatusBarStyleDefault ;
//        [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"arial" size:16],NSForegroundColorAttributeName:textblack_Color}];
        [navBar setBarTintColor:White_Color];
    navBar.translucent = NO;
    navBar.backgroundColor=White_Color;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBarHidden = YES;
//    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
//                                                                      NSFontAttributeName : [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)]}];
//
}

-(void)joinOtherLoginView{
    
    [OneKeyLoginTools signOutOneKeyLoginWithCompletion:^{

        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele showLoginVc];

    }];

}
//支持旋转
-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {

        if([viewController isKindOfClass:NSClassFromString(@"")]){
            viewController.hidesBottomBarWhenPushed = NO;
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
        }

        [self setNavigationBarHidden:YES animated:YES];
        viewController.navigationController.navigationBar.hidden = YES;
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

        UIView *btnView=[[UIView alloc]init];
        btnView.frame=CGRectMake(0, 0, CGFloatBasedI375(44), CGFloatBasedI375(44));
        btnView.userInteractionEnabled=YES;
        btnView.backgroundColor=[UIColor clearColor];
        UIButton *backBtn=[[UIButton alloc]init];
//        [backBtn setEnlargeEdge:CGFloatBasedI375(50)];
        backBtn.backgroundColor=[UIColor clearColor];
        backBtn.frame=CGRectMake(0, 0, CGFloatBasedI375(44), CGFloatBasedI375(44));
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"tab_icon_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:backBtn];
        UIBarButtonItem *leftBarButtnItem=[[UIBarButtonItem alloc]initWithCustomView:btnView];
        viewController.navigationItem.leftBarButtonItem=leftBarButtnItem;
        
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), CGFloatBasedI375(13), CGFloatBasedI375(8), CGFloatBasedI375(15))];
        img.image=[UIImage imageNamed:@"b2_icon"];
        [backBtn addSubview:img];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
  
    [super popViewControllerAnimated:animated];
    return nil;
}

- (void)back {

    [MBProgressHUD hideActivityIndicator];
    [self popViewControllerAnimated:YES];
}

@end

