//
//  AppDelegate.m
//  Winner
//
//  Created by 廖利君 on 2022/1/10.
//

#import "AppDelegate.h"
#import "LLoginsViewController.h"
#import "LLNavigationViewController.h"
#import "LLTabbarPeisongViewController.h"
#import "PLLocationManage.h"
#import "DCNewFeatureViewController.h"
#import "Winner-Swift.h"

@interface AppDelegate ()<WXApiDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager ;/** <#class#> **/
@property (nonatomic,strong) AMapLocationManager *manager ;/** <#class#> **/
//@property (nonatomic, copy) NSString *customView;

@end

@implementation AppDelegate

static NSString *kf_appkey = @"6b318a90-a041-11ec-abdf-f5e66bda2f2e";
static NSString *kf_name = @"测试";
static NSString *kf_userId = @"1234567a8ADC";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    [AccessTool removeUserInfo];
//    if(@available(iOS 14, *)){
//            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//                //do nothing
//            }];
//        }
//    
    [self initMOB];
    [AccessTool loadUserInfo];
    [self getMianvs];
    [self configLocationManager];
    [QMConnect switchServiceRoute:QMServiceLineAliy];
    [QMConnect registerSDKWithAppKey:kf_appkey userName:kf_name userId:kf_userId];
    [self oneKeyLoginAuthSDKInfo];
    [self.window makeKeyAndVisible];
    return YES;
}
/**
 * 功能：禁止横屏
 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)getMianvs{
    [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
        [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    NSString *first =  [[NSUserDefaults standardUserDefaults]objectForKey:@"yindao"];
    if(first.length <=0){

//        [[NSUserDefaults standardUserDefaults]setObject:@"23.127248" forKey:@"lat"];
//        [[NSUserDefaults standardUserDefaults]setObject:@"113.39957" forKey:@"lng"];
//        [[NSUserDefaults standardUserDefaults]setObject:@"广东省" forKey:@"provinces"];
//        [[NSUserDefaults standardUserDefaults]setObject:@"广州市" forKey:@"citys"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
            [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
        [[NSUserDefaults standardUserDefaults]setObject:@"yindao" forKey:@"yindao"];
      DCNewFeatureViewController *dcFVc = [[DCNewFeatureViewController alloc] init];
                    [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
                        if (iphoneXTop==0) {
                          *imageArray = @[@"1242x2209-1.png",@"1242x2209-2.png",@"1242x2209-3.png"];
                        }else{
                            *imageArray = @[@"1242x2689-1.png",@"1242x2689-2.png",@"1242x2689-3.png"];
                        }
                        *showPageCount = YES;
                        *showSkip = NO;
                        *selColor = Main_Color;
                    }];
                    self.window.rootViewController = dcFVc;

    }else{
        [self loginMainVc];
//        [self getPersonalUrl];//判断什么身份
    }
}
-(void)getPersonalUrl{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [UserModel setUserInfoModelWithDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
        if([UserModel sharedUserInfo].isClerk){
            [self loginPeisongVc];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];//clerkStatus
}
-(void)initMOB{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) { //微信
        [platformsRegister setupWeChatWithAppId:K_WX_AppID appSecret:K_WX_AppSecret universalLink:@"https://www.com.gzdayingjia.dyjapp/"];
        [platformsRegister setupQQWithAppId:K_QQ_AppID appkey:K_QQ_AppSecret enableUniversalLink:NO universalLink:@"https://9852ac74d48a464ea0b23ec9a359d084.share2dlink.com/qq_con/101967137"];

    }];
//    [WXApi registerApp:<#(nonnull NSString *)#> universalLink:<#(nonnull NSString *)#>
    [WXApi registerApp:K_WX_AppID universalLink:@"https://www.com.gzdayingjia.dyjapp"];
}
#pragma mark 切换普通模式
-(void)loginMainVc{
    LLTabbarViewController *vc = [[LLTabbarViewController alloc]init];
    self.window.rootViewController  = vc;
}
#pragma mark 切换配送员模式
-(void)loginPeisongVc{
    LLTabbarPeisongViewController *vc = [[LLTabbarPeisongViewController alloc]init];
    vc.selectedIndex = 2;
    self.window.rootViewController  = vc;
}
-(void)loginVc{
    [AccessTool  removeUserInfo];
    [UserModel resetModel:nil];
    
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    LLNavigationViewController *nav = tbc.viewControllers[tbc.selectedIndex];
    
    [OneKeyLoginTools JoinOneKeyLoginPageWithView:nav joinOtherLoginView:@selector(joinOtherLoginView)];
}

///显示登录页面
-(void)showLoginVc{
    
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    LLNavigationViewController *nav = tbc.viewControllers[tbc.selectedIndex];
    LLoginsViewController *vc =[[LLoginsViewController alloc]init];
    vc.isHiddenNavgationBar = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
}

//&&[responseObject[@"msg"] isEqual:@"您的帐号在其他地方已登录,被强制踢出"
-(void)showAlertReforceVc{
    [UIAlertController showAlertViewWithTitle:@"温馨提示" Message:@"您的登录已失效，请重新登录" BtnTitles:@[@"确定"] ClickBtn:^(NSInteger index) {
        [self loginVc];
    }];
}
-(void)showAlertVc{
    [UIAlertController showAlertViewWithTitle:@"温馨提示" Message:@"登录过期,请重新登录" BtnTitles:@[@"确定"] ClickBtn:^(NSInteger index) {
        [self loginVc];
    }];
}
//-(void)loginVc{
//
//    [AccessTool  removeUserInfo];
//    [UserModel resetModel:nil];
//    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
//    LLNavigationViewController *nav = tbc.viewControllers[tbc.selectedIndex];
//    LLoginsViewController *vc =[[LLoginsViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [nav pushViewController:vc animated:YES];
//
//}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [QMConnect setServerToken:deviceToken];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [QMConnect logout];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                //code：拿到授权信息，完成业务逻辑
            }];
    //微信支付回调
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSDictionary *dic  = resultDic;
            NSData *jsonData = [dic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
            NSDictionary *alipay_trade_app_pay_response = dicss[@"alipay_trade_app_pay_response"];
            NSLog(@"错误原因%@",alipay_trade_app_pay_response[@"sub_msg"]);
            NSLog(@"dic %@",dic);

            if ([[dic objectForKey:@"resultStatus"]integerValue]==9000) {
                //支付成功 发送通知
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"PAYSUCCESS" object:nil];
            }else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==6001)
            {
                [MBProgressHUD showError:resultDic[@"memo"]];
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PAYCANCLE" object:nil userInfo:nil]];

            }else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==6002)
            {
                [MBProgressHUD showError:resultDic[@"memo"]];
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PAYCANCLE" object:nil userInfo:nil]];

                //支付取消 发送通知
            }else if ([[resultDic objectForKey:@"resultStatus"]integerValue]==4000)
            {
                [MBProgressHUD showError:alipay_trade_app_pay_response[@"sub_msg"]];
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PAYCANCLE" object:nil userInfo:nil]];

                //支付取消 发送通知
            }
            
            
        }];
    }
    return YES;
}
//程序要实现和微信终端交互代理
-(void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PAYSUCCESS" object:nil userInfo:nil]];
                break;
            default:
                [MBProgressHUD showError:@"支付失败"];
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"PAYCANCLE" object:nil userInfo:nil]];

                break;
        }
    }
}
#pragma mark - 定位
- (void)configLocationManager
{
    [AMapServices sharedServices].apiKey = GDAppID;
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.manager =  [[AMapLocationManager alloc] init];
    
//    if(![self determineWhetherTheAPPOpensTheLocation]){//未授权
//        [UIAlertController showAlertViewWithTitle:@"当前定位权限" Message:@"加入惊喜红包活动商品需要您同意定位授权,否则将不能加入队列" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
//            if(index == 1){
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
//            }
//        }];
//    }
 
    
}
#pragma mark - 一键登录认证
-(void)oneKeyLoginAuthSDKInfo{
    
    [OneKeyLoginTools OneKeyLoginAuthSDKInfo];
    
}

@end
