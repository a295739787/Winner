//
//  LLoginViewController.m
//  NovaProfile
//
//  Created by lijun L on 2020/1/6.
//  Copyright © 2020 lijun L. All rights reserved.
//

#import "LLoginsViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "Winner-Swift.h"

@interface LLoginsViewController ()<UITextViewDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic,strong) UIImageView *logoImage;/** <#class#> **/
@property (nonatomic,strong) UIImageView *phoneImage;/** <#class#> **/
@property (nonatomic,strong) UITextField *phoneTx;/** <#class#> **/
@property (nonatomic,strong) UIView *linePhoneView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *passImage;/** <#class#> **/
@property (nonatomic,strong) UITextField *passOrcodeTx;/** <#class#> **/
@property (nonatomic,strong) UIView *linePassView;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic,strong) UIImageView *backImage;/** <#class#> **/
@property (nonatomic,strong) UILabel *titlelabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *titlelabel1;/** <#class#> **/
@property (nonatomic,strong) UITextView *boLabel;/** <#class#> **/
@property (nonatomic,strong) UILabel *weLabel;/** <#class#> **/
@property (nonatomic,strong) UIImageView *weImage;/** <#class#> **/
@property (nonatomic,strong) UILabel *liLabel;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView1;/** <#class#> **/
@property (nonatomic,strong) UIButton *codeButton;/** <#class#> **/
@property (nonatomic,copy) NSString *timestamp;/** <#class#> **/
@property (nonatomic,strong) UIButton *appleLoginBtn;/** <#class#> **/


@end

@implementation LLoginsViewController
-(void)viewWillAppear:(BOOL)animate{
    if(!_isThree){
        NSString *phone =   [[NSUserDefaults standardUserDefaults]objectForKey:@"phones"];
        if(phone.length > 0){
            self.phoneTx.text = phone;
        }
    }
    if (!self.isHiddenNavgationBar) {
        //显示系统导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.isHiddenNavgationBar) {
        //隐藏系统导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = lightGrayFFFF_Color;
    [self setLayout];
}

-(void)sendCode:(UIButton *)sender{

    if(self.phoneTx.text.length <= 0 || self.phoneTx.text.length != 11){
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.phoneTx.text forKey:@"account"];
    if(self.isThree){
    [param setValue:@"3" forKey:@"type"];
    }else{
        [param setValue:@"1" forKey:@"type"];//类型（1登录/注册、2银行卡绑定、3绑定手机号
    }
    self.timestamp = @"";
    self.timestamp = [NSString getNowTimeTimestamp3];
    [param setValue:self.timestamp  forKey:@"timestamp"];

    NSLog(@"   self.timestamp111 == %@",   self.timestamp);

    sender.enabled = NO;
    [XJHttpTool post:L_apiappsmssend method:POST params:param isToken:NO success:^(id  _Nonnull responseObj) {
        sender.enabled = YES;
        self.codeButton.titleLabel.font = [UIFont fontWithFontSize:CGFloatBasedI375(12)];
        [self.codeButton jk_startTime:60 waitTittle:@"s"];
        NSDictionary *data = responseObj[@"data"];
        [MBProgressHUD hideActivityIndicator];
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:responseObj[@"msg"] toView:self.view];

    } failure:^(NSError * _Nonnull error) {
        self.codeButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];

        sender.enabled = YES;
        [MBProgressHUD hideActivityIndicator];
        [MBProgressHUD hideHUDForView:self.view];
    }
     ];
}
-(void)clickUlr{
    if(self.isThree){
        [self postPhoneUrl];
    }else{
        [self postUrl];
    }
}
#pragma mark  请求数据  登录
-(void)postUrl{
//    self.phoneTx.text = @"13265657532";
    if(self.phoneTx.text.length <= 0){
        [MBProgressHUD showError:@"请输入账号" toView:self.view];
        return;
    }
    if(self.passOrcodeTx.text.length <= 0){
        [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    NSString *deviceToken = [CloudPushSDK getApnsDeviceToken];
    NSString *deviceId = [CloudPushSDK getDeviceId];
    [param setValue:deviceId forKey:@"deviceId"];
    [param setValue:deviceToken forKey:@"deviceToken"];
    [param setValue:self.phoneTx.text forKey:@"account"];
    [param setValue:self.passOrcodeTx.text forKey:@"code"];
    [param setValue:@"2" forKey:@"platform"];//登录方式（1 PC系统管理员用户，2 APP手机号验证码，3 APP微信授权）
    [param setValue:self.timestamp  forKey:@"timestamp"];

    [XJHttpTool post:FORMAT(@"%@?n=%@&client_id=admin&client_secret=123456&scope=all&grant_type=password",L_apioauthLogin,self.timestamp ) method:POST params:param isToken:NO success:^(id  _Nonnull responseObj) {
        [[NSUserDefaults standardUserDefaults] setObject:self.phoneTx.text forKey:@"phones"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        [UserModel setUserInfoModelWithTokenDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
        [UserModel saveInfo];
        [self.navigationController popViewControllerAnimated:YES];
//        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [dele loginMainVc];
    } failure:^(NSError * _Nonnull error) {

    }];
}
#pragma mark  绑定手机号请求数据  登录
-(void)postPhoneUrl{
    if(self.phoneTx.text.length <= 0){
        [MBProgressHUD showError:@"请输入账号" toView:self.view];
        return;
    }
    if(self.passOrcodeTx.text.length <= 0){
        [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.phoneTx.text forKey:@"account"];
    [param setValue:self.passOrcodeTx.text forKey:@"code"];
    [param setValue:self.timestamp  forKey:@"timestamp"];
    [param addEntriesFromDictionary:_datas];
    NSLog(@"   self.timestamp2222 == %@",   self.timestamp);
    [XJHttpTool post:FORMAT(@"%@?n=%@&client_id=admin&client_secret=123456&scope=all&grant_type=password",L_apioauthLogin,self.timestamp ) method:POST params:param isToken:NO success:^(id  _Nonnull responseObj) {
        [UserModel setUserInfoModelWithTokenDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
        [UserModel saveInfo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [dele loginMainVc];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)wechatlogin{
    WS(weakself);
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        NSLog(@"error == %@",error);
        if(state == SSDKResponseStateSuccess){
            NSLog(@"微信登录原始数据 == %@",user.rawData);

            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            NSMutableDictionary *valueparam = [NSMutableDictionary dictionary];
            [param setObject:user.uid forKey:@"openId"];
            [param setObject:FORMAT(@"%@",user.rawData[@"unionid"]) forKey:@"unionId"];
            [param setObject:user.nickname forKey:@"nickName"];
            [param setObject:user.icon forKey:@"headIcon"];
            [param setValue:[NSString getNowTimeTimestamp3]  forKey:@"timestamp"];
            [param setValue:@"3" forKey:@"platform"];//登录方式（1 PC系统管理员用户，2 APP手机号验证码，3 APP微信授权）
            
            [valueparam setObject:user.uid forKey:@"openId"];
            [valueparam setObject:FORMAT(@"%@",user.rawData[@"unionid"]) forKey:@"unionId"];
            [valueparam setObject:user.nickname forKey:@"nickName"];
            [valueparam setObject:user.icon forKey:@"headIcon"];
            [valueparam setValue:@"3" forKey:@"platform"];//登录方式（1 PC系统管理员用户，2 APP手机号验证码，3 APP微信授权）
            [XJHttpTool post:FORMAT(@"%@?n=%@&client_id=admin&client_secret=123456&scope=all&grant_type=password",L_apioauthLogin,[NSString getNowTimeTimestamp3]) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneTx.text forKey:@"phones"];
                [[NSUserDefaults standardUserDefaults]  synchronize];
          
                NSDictionary *dic = responseObj[@"data"];
                BOOL  isPhone  = [FORMAT(@"%@",dic[@"isPhone"])boolValue];
                if(isPhone){
                    [UserModel setUserInfoModelWithTokenDict:responseObj[@"data"]];
                    [AccessTool saveUserInfo];
                    [UserModel saveInfo];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [dele loginMainVc];
                    });
                 
                }else{
                    
                    LLoginsViewController *vc = [[LLoginsViewController alloc]init];
                    vc.isThree = YES;
                    vc.datas = valueparam;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];

      
        }
   
    }];
    
}
#pragma mark- 授权苹果ID
- (void)authorizationAppleID{
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider * appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest * authAppleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
//        authAppleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        //如果 KeyChain 里面也有登录信息的话，可以直接使用里面保存的用户名和密码进行登录。
//        ASAuthorizationPasswordRequest * passwordRequest = [[[ASAuthorizationPasswordProvider alloc] init] createRequest];

        NSMutableArray <ASAuthorizationRequest *> * array = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [array addObject:authAppleIDRequest];
        }
//        if (passwordRequest) {
//            [array addObject:passwordRequest];
//        }
        NSArray <ASAuthorizationRequest *> * requests = [array copy];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController * authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
         // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }
}
#pragma mark- ASAuthorizationControllerDelegate
// 授权成功
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        ASAuthorizationAppleIDCredential * credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        
        // 苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString * userID = credential.user;
        //把用户的唯一标识 传给后台 判断该用户是否绑定手机号，如果绑定了直接登录，如果没绑定跳绑定手机号页面
//        // 苹果用户信息 如果授权过，可能无法再次获取该信息
        NSPersonNameComponents * fullName = credential.fullName;
//        NSString * email = credential.email;
//
//        // 服务器验证需要使用的参数
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        NSMutableDictionary *valueparam = [NSMutableDictionary dictionary];

//        // 用于判断当前登录的苹果账号是否是一个真实用户，取值有：unsupported、unknown、likelyReal
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:userID forKey:@"appleOpenId"];
        if(credential.email.length > 0){
            [param setObject:FORMAT(@"%@",credential.email) forKey:@"email"];
        }
        if(fullName.nickname.length >0){
            [param setObject:FORMAT(@"%@",fullName.nickname) forKey:@"nickName"];
            [valueparam setObject:FORMAT(@"%@",fullName.nickname) forKey:@"nickName"];
        }
            [param setValue:[NSString getNowTimeTimestamp3]  forKey:@"timestamp"];
            [param setValue:@"4" forKey:@"platform"];//登录方式（1 PC系统管理员用户，2 APP手机号验证码，3 APP微信授权）
        [valueparam setValue:userID forKey:@"appleOpenId"];
        [valueparam setValue:@"4" forKey:@"platform"];

            [XJHttpTool post:FORMAT(@"%@?n=%@&client_id=admin&client_secret=123456&scope=all&grant_type=password",L_apioauthLogin,[NSString getNowTimeTimestamp3]) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneTx.text forKey:@"phones"];
                [[NSUserDefaults standardUserDefaults]  synchronize];
          
                NSDictionary *dic = responseObj[@"data"];
                BOOL  isPhone  = [FORMAT(@"%@",dic[@"isPhone"])boolValue];
                if(isPhone){
                    [UserModel setUserInfoModelWithTokenDict:responseObj[@"data"]];
                    [AccessTool saveUserInfo];
                    [UserModel saveInfo];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [dele loginMainVc];
                    });
                 
                }else{
                    LLoginsViewController *vc = [[LLoginsViewController alloc]init];
                    vc.isThree = YES;
                    vc.datas = valueparam;
                                [self.navigationController pushViewController:vc animated:YES];
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
        
    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        // 这个获取的是iCloud记录的账号密码，需要输入框支持iOS 12 记录账号密码的新特性，如果不支持，可以忽略
        // 用户登录使用现有的密码凭证
        ASPasswordCredential * passwordCredential = (ASPasswordCredential *)authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString * user = passwordCredential.user;
        
        //把用户的唯一标识 传给后台 判断该用户是否绑定手机号，如果绑定了直接登录，如果没绑定跳绑定手机号页面
        
//        // 密码凭证对象的密码
//        NSString * password = passwordCredential.password;
//        NSLog(@"userID: %@", user);
//        NSLog(@"password: %@", password);
        
    } else {
        
    }
}
// 授权失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    NSLog(@"%@", errorMsg);
}

#pragma mark- ASAuthorizationControllerPresentationContextProviding
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return self.view.window;
}
#pragma mark- apple授权状态 更改通知
- (void)handleSignInWithAppleStateChanged:(NSNotification *)notification{
    NSLog(@"%@", notification.userInfo);
}
-(void)setLayout{
WS(weakself);
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(300));
    }];
[self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(weakself.view.mas_centerX);
    make.width.offset(CGFloatBasedI375(65));
    make.height.offset(CGFloatBasedI375(65));
    make.top.offset(CGFloatBasedI375(40)+SCREEN_top);
}];

    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(21));
        make.top.offset(CGFloatBasedI375(40)+SCREEN_top);
    }];
    [self.titlelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(21));

        make.top.equalTo(weakself.titlelabel.mas_bottom).offset(CGFloatBasedI375(0));
    }];
[self.phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.width.offset(CGFloatBasedI375(19));
//    make.height.offset(CGFloatBasedI375(19));
    make.left.offset(CGFloatBasedI375(21));
    make.top.equalTo(weakself.titlelabel1.mas_bottom).offset(CGFloatBasedI375(55));
}];
[self.phoneTx mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(CGFloatBasedI375(-38));
    make.height.mas_equalTo(CGFloatBasedI375(35));
    make.left.equalTo(weakself.phoneImage.mas_right).offset(CGFloatBasedI375(10));
    make.centerY.equalTo(weakself.phoneImage.mas_centerY);
}];
[self.linePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakself.phoneImage.mas_left).offset(CGFloatBasedI375(0));
    make.right.mas_equalTo(CGFloatBasedI375(-43));
    make.height.mas_equalTo(CGFloatBasedI375(1));
    make.top.equalTo(weakself.phoneImage.mas_bottom).offset(CGFloatBasedI375(15));
}];
[self.passImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.offset(CGFloatBasedI375(19));
    make.height.offset(CGFloatBasedI375(19));
    make.left.offset(CGFloatBasedI375(21));
    make.top.equalTo(weakself.linePhoneView.mas_bottom).offset(CGFloatBasedI375(26));
}];

[self.passOrcodeTx mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(CGFloatBasedI375(-38));
    make.left.equalTo(weakself.passImage.mas_right).offset(CGFloatBasedI375(10));
    make.centerY.equalTo(weakself.passImage.mas_centerY);
}];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(CGFloatBasedI375(-38));
        make.width.offset(CGFloatBasedI375(90));
        make.height.offset(CGFloatBasedI375(30));
        make.centerY.equalTo(weakself.passImage.mas_centerY);
    }];
[self.linePassView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakself.phoneImage.mas_left).offset(CGFloatBasedI375(0));
    make.right.mas_equalTo(CGFloatBasedI375(-43));
    make.height.mas_equalTo(CGFloatBasedI375(1));
    make.top.equalTo(weakself.passImage.mas_bottom).offset(CGFloatBasedI375(15));
}];
[self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(weakself.phoneImage.mas_left).offset(CGFloatBasedI375(0));
    make.right.mas_equalTo(CGFloatBasedI375(-38));
    make.height.mas_equalTo(CGFloatBasedI375(45));
    make.top.equalTo(weakself.linePassView.mas_bottom).offset(CGFloatBasedI375(30));
}];
    [self.boLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(20));
        make.right.offset(-CGFloatBasedI375(20));
        make.bottom.offset(-DeviceXTabbarHeigh(30));
    }];
//    [self.weLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakself.view.mas_centerX);
//        make.width.mas_equalTo(CGFloatBasedI375(38));
//        make.bottom.equalTo(weakself.boLabel.mas_top).offset(-CGFloatBasedI375(30));
//    }];
 
    if([WXApi isWXAppInstalled]){
        if (@available(iOS 13.0, *)) {
            [self.weImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(CGFloatBasedI375(80));
                make.width.height.mas_equalTo(CGFloatBasedI375(50));
                make.bottom.equalTo(weakself.boLabel.mas_top).offset(-CGFloatBasedI375(25));
            }];
            [self.liLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakself.view.mas_centerX);
                make.width.mas_equalTo(CGFloatBasedI375(160));
                make.bottom.equalTo(weakself.weImage.mas_top).offset(-CGFloatBasedI375(10));
            }];
            [self.appleLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(CGFloatBasedI375(-80));
                make.width.mas_equalTo(CGFloatBasedI375(50));
                make.height.mas_equalTo(CGFloatBasedI375(50));
                make.centerY.equalTo(weakself.weImage.mas_centerY);;
            }];
        } else {
            [self.weImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakself.view.mas_centerX);
                make.width.height.mas_equalTo(CGFloatBasedI375(50));
                make.bottom.equalTo(weakself.boLabel.mas_top).offset(-CGFloatBasedI375(25));
            }];
            [self.liLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakself.view.mas_centerX);
                make.width.mas_equalTo(CGFloatBasedI375(160));
                make.bottom.equalTo(weakself.weImage.mas_top).offset(-CGFloatBasedI375(10));
            }];
        }
       
    }else{
        if (@available(iOS 13.0, *)) {
            [self.appleLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakself.view.mas_centerX);
                make.width.height.mas_equalTo(CGFloatBasedI375(50));
                make.bottom.equalTo(weakself.boLabel.mas_top).offset(-CGFloatBasedI375(25));
            }];
            [self.liLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakself.view.mas_centerX);
                make.width.mas_equalTo(CGFloatBasedI375(160));
                make.bottom.equalTo(weakself.appleLoginBtn.mas_top).offset(-CGFloatBasedI375(10));
            }];
        }
    }
    
    if(self.isThree){
        self.weLabel.hidden = YES;
        self.weImage.hidden = YES;
        self.liLabel.hidden = YES;
        _titlelabel.text = @"绑定手机号";
        [_sureButton setTitle:@"绑定手机号" forState:UIControlStateNormal];;
    }
}
-(UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.textColor = [UIColor blackColor];
        _titlelabel.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(24)];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.text = @"手机号码登录";
        [self.view addSubview:self.titlelabel];
    }
    return _titlelabel;
}
-(UILabel *)titlelabel1{
    if (!_titlelabel1) {
        _titlelabel1 = [[UILabel alloc]init];
        _titlelabel1.textColor = [UIColor blackColor];
        _titlelabel1.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titlelabel1.textAlignment = NSTextAlignmentLeft;
        _titlelabel1.text = @"您好，欢迎您成为大赢家";
        [self.view addSubview:self.titlelabel1];
    }
    return _titlelabel1;
}
-(UILabel *)weLabel{
    if (!_weLabel) {
        _weLabel = [[UILabel alloc]init];
        _weLabel.textColor = [UIColor colorWithHexString:@"#443415"];
        _weLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _weLabel.textAlignment = NSTextAlignmentCenter;
        _weLabel.text = @"微信";
        [self.view addSubview:self.weLabel];
        _weLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wechatlogin)];
        [_weLabel addGestureRecognizer:tap];
    
    }
    return _weLabel;
}
-(UILabel *)liLabel{
    if (!_liLabel) {
        _liLabel = [[UILabel alloc]init];
        _liLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        _liLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _liLabel.textAlignment = NSTextAlignmentCenter;
        _liLabel.text = @"——  其他方式登录  ——";
        [self.view addSubview:self.liLabel];
    }
    return _liLabel;
}
-(UITextView *)boLabel{
    if (!_boLabel) {
        _boLabel = [[UITextView alloc]init];
        _boLabel.textColor = [UIColor blackColor];
//        _boLabel.numberOfLines = 2;
        _boLabel.delegate = self;
        _boLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _boLabel.textAlignment = NSTextAlignmentCenter;
        _boLabel.text = @"若您的账号未注册，将为您自动注册。注册或登录及代表您同意我们的 服务协议 和 隐私保护指引";
//        _boLabel.attributedText = [self getAttribuStrWithStrings:@[@"若您的账号未注册，将为您自动注册。注册或登录及代表您同意我们的 ",@"服务协议",@"和",@"隐私保护指引"] colors:@[[UIColor colorWithHexString:@"#999999"],[UIColor colorWithHexString:@"#5082B0"],[UIColor colorWithHexString:@"#999999"],[UIColor colorWithHexString:@"#5082B0"]]];
        _boLabel.editable=NO;
        _boLabel.scrollEnabled=NO;
         
         NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
         paragraphStyle.lineSpacing= 1;
         NSDictionary*attributes = @{NSFontAttributeName: [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)],
                                     NSParagraphStyleAttributeName:paragraphStyle};
         NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_boLabel.text attributes:attributes];
         [attributedString addAttribute:NSLinkAttributeName value:@"yonghuxieyi://" range:NSMakeRange(32,4)];
         [attributedString addAttribute:NSLinkAttributeName value:@"yisizhengce://" range:NSMakeRange(39,6)];
         [attributedString addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithHexString:@"#999999"] range:NSMakeRange(0,_boLabel.text.length)];
        _boLabel.attributedText= attributedString;
         //设置被点击字体颜色
        _boLabel.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#5082B0"]};
        [self.view addSubview:self.boLabel];
    }
    return _boLabel;
}
#pragma mark 富文本点击事件
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if ([[URL scheme] isEqualToString:@"yonghuxieyi"]) {
        NSLog(@"富文本点击 用户协议");
        LLWebViewController *vc = [[LLWebViewController alloc]init];
        vc.htmlStr = @"AppServiceAgreement";
        vc.isHiddenNavgationBar = YES;
//        vc.name = @"排行榜";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([[URL scheme] isEqualToString:@"yisizhengce"]) {
        NSLog(@"富文本点击 隐私政策");
        LLWebViewController *vc = [[LLWebViewController alloc]init];
        vc.htmlStr = @"AppPrivacyAgreement";
        vc.isHiddenNavgationBar = YES;
//        vc.name = @"排行榜";
        [self.navigationController pushViewController:vc animated:YES];
    }
    return YES;
}
-(UIImageView *)logoImage{
    if(!_logoImage){
        _logoImage = [[UIImageView alloc]init];
        _logoImage.image = [UIImage imageNamed:@"logoingas"];
        [self.view addSubview:self.logoImage];
        _logoImage.layer.masksToBounds = YES;
        _logoImage.layer.cornerRadius = CGFloatBasedI375(8);
    }
    return _logoImage;
}
-(UIImageView *)backImage{
    if(!_backImage){
        _backImage = [[UIImageView alloc]init];
        _backImage.image = [UIImage imageNamed:@"login_bg"];
        [self.view addSubview:self.backImage];
    }
    return _backImage;
}
-(UIImageView *)phoneImage{
    if(!_phoneImage){
        _phoneImage = [[UIImageView alloc]init];
        _phoneImage.image = [UIImage imageNamed:@"sjh_gray"];
        [self.view addSubview:self.phoneImage];
    }
    return _phoneImage;
}
-(UIImageView *)weImage{
    if(!_weImage){
        _weImage = [[UIImageView alloc]init];
        _weImage.image = [UIImage imageNamed:@"wechat"];
        [self.view addSubview:self.weImage];
        _weImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wechatlogin)];
        [_weImage addGestureRecognizer:tap];
    }
    return _weImage;
}
- (UIView *)linePassView{
    if(!_linePassView){
        _linePassView = [[UIView alloc]init];
        _linePassView.backgroundColor = [[UIColor colorWithHexString:@"#CCCCCC"]colorWithAlphaComponent:0.3];
        [self.view addSubview:_linePassView];
    }
    return _linePassView;
}
- (UIView *)linePhoneView{
    if(!_linePhoneView){
        _linePhoneView = [[UIView alloc]init];
        _linePhoneView.backgroundColor = [[UIColor colorWithHexString:@"#CCCCCC"] colorWithAlphaComponent:0.3];
        [self.view addSubview:_linePhoneView];
    }
    return _linePhoneView;
}
- (UIView *)lineView1{
    if(!_lineView1){
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [[UIColor colorWithHexString:@"#CCCCCC"] colorWithAlphaComponent:0.3];
        [self.view addSubview:_lineView1];
    }
    return _lineView1;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [[UIColor colorWithHexString:@"#CCCCCC"] colorWithAlphaComponent:0.3];
        [self.view addSubview:_lineView];
    }
    return _lineView;
}
-(UITextField *)passOrcodeTx{
    if(!_passOrcodeTx){
        _passOrcodeTx = [[UITextField alloc]init];
        _passOrcodeTx.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        _passOrcodeTx.textColor = Black0000_Color;
        _passOrcodeTx.placeholder = @"请输入验证码";
        _passOrcodeTx.keyboardType = UIKeyboardTypePhonePad;
        [self.view addSubview:_passOrcodeTx];
    }
    return _passOrcodeTx;
}
-(UITextField *)phoneTx{
    if(!_phoneTx){
        _phoneTx = [[UITextField alloc]init];
        _phoneTx.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        _phoneTx.textColor = Black0000_Color;
        _phoneTx.placeholder = @"请输入您的手机号";
        if(!_isThree){
//            self.phoneTx.text = @"13265657532";
        }

        _phoneTx.keyboardType = UIKeyboardTypePhonePad;
        [self.view addSubview:_phoneTx];
    }
    return _phoneTx;
}

-(UIImageView *)passImage{
    if(!_passImage){
        _passImage = [[UIImageView alloc]init];
        _passImage.image = [UIImage imageNamed:@"yzm_gray"];
        [self.view addSubview:self.passImage];
    }
    return _passImage;
    }
    -(UIButton *)sureButton{
        if(!_sureButton){
            _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _sureButton.layer.cornerRadius = CGFloatBasedI375(23);
            _sureButton.layer.masksToBounds = YES;
            [_sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
            _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
            [_sureButton setTitle:@"登录" forState:UIControlStateNormal];;
            [_sureButton addTarget:self action:@selector(clickUlr) forControlEvents:UIControlEventTouchUpInside];
                _sureButton.backgroundColor = Main_Color;
            [self.view addSubview:self.sureButton];
        }
        return _sureButton;
    }
-(UIButton *)codeButton{
    if(!_codeButton){
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.layer.cornerRadius = CGFloatBasedI375(15);
        _codeButton.layer.masksToBounds = YES;
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
        [_codeButton setTitleColor:[UIColor colorWithHexString:@"#212121"] forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_codeButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.codeButton];
    }
    return _codeButton;
}
-(UIButton *)appleLoginBtn{
    if(!_appleLoginBtn){
        _appleLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_appleLoginBtn setImage:[UIImage imageNamed:@"pingguo"] forState:UIControlStateNormal];
        [_appleLoginBtn addTarget:self action:@selector(authorizationAppleID) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.appleLoginBtn];
    }
    return _appleLoginBtn;
}
@end
