//
//  LLStorePayViewController.m
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LLStorePayViewController.h"
#import "LLStorePayHeadView.h"
#import "LLStorePaySuccessViewController.h"
#import "LLMeOrderController.h"
#import "LLMeOrderController.h"
#import "LLSurpriseRegBagViewController.h"
#import "LLMainViewController.h"
#import "LLMeOrderDetailController.h"

static NSString *const LLPayViewStyleCellid = @"LLPayViewCell";

@interface LLStorePayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLStorePayHeadView *headView ;/** <#class#> **/
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton ;/** <#class#> **/
@property (nonatomic,assign) NSInteger payMode;/** class **/
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/

@end

@implementation LLStorePayViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PAYSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PAYCANCLE" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark 取消支付
- (void)PAYCANCLE {
    LLMeOrderListController *vc = [[LLMeOrderListController alloc]init];
    vc.payui = YES;
    vc.orderStatus = 1;
    vc.status = _status;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark 支付成功
-(void)paySuccess{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateName" object:nil];
    LLStorePaySuccessViewController *vc = [[LLStorePaySuccessViewController alloc]init];
    vc.payui = YES;
    vc.orderNo = FORMAT(@"%@",_datas[@"orderNo"]);
    vc.status = _status;
    vc.judgePriceType = _judgePriceType;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.payMode = 1;
    self.disableDragBack = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess) name:@"PAYSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PAYCANCLE) name:@"PAYCANCLE" object:nil];
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"收银台";
    [self setLayout];
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.status == RoleStatusRedBag){
            UINavigationController *navC = weakself.navigationController;
                NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                for (UIViewController *vc in navC.viewControllers) {
                    [viewControllers addObject:vc];
                    if ([vc isKindOfClass:[LLSurpriseRegBagViewController class]]) {
                        break;
                    }else  if ([vc isKindOfClass:[LLMainViewController class]]) {
                        break;
                    }else  if ([vc isKindOfClass:[LLMeOrderDetailController class]]) {
                        break;
                    }
                }
                if (viewControllers.count == navC.viewControllers.count) {
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [navC setViewControllers:viewControllers animated:YES];
                }
        }else if(weakself.judgePriceType){
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            LLMeOrderListController *vc = [[LLMeOrderListController alloc]init];
            vc.payui = YES;
            vc.orderStatus = 1;
            vc.status = weakself.status;
            [weakself.navigationController pushViewController:vc animated:YES];
        }
    };
    if((_status == RoleStatusRedBag) ||  (_status == RoleStatusPingjian)||  (_status == RoleStatusStockPeisong)){//惊喜红包没有详情接口
        self.headView.dataDic = _datas;
    }else{
        [self getData];
    }

    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 添加检测app进入后台的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}
-(void)bacls{
    WS(weakself);
    if(weakself.status == RoleStatusRedBag){
        UINavigationController *navC = weakself.navigationController;
            NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
            for (UIViewController *vc in navC.viewControllers) {
                [viewControllers addObject:vc];
                if ([vc isKindOfClass:[LLSurpriseRegBagViewController class]]) {
                    break;
                }else  if ([vc isKindOfClass:[LLMainViewController class]]) {
                    break;
                }else  if ([vc isKindOfClass:[LLMeOrderDetailController class]]) {
                    break;
                }
            }
            if (viewControllers.count == navC.viewControllers.count) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            else {
                [navC setViewControllers:viewControllers animated:YES];
            }
    }else if(weakself.judgePriceType){
        [weakself.navigationController popViewControllerAnimated:YES];
    }else {
        UINavigationController *navC = weakself.navigationController;
            NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
            for (UIViewController *vc in navC.viewControllers) {
                [viewControllers addObject:vc];
                if ([vc isKindOfClass:[LLGoodDetailViewController class]]) {
                    break;
                }else  if ([vc isKindOfClass:[LLMainViewController class]]) {
                    break;
                }else  if ([vc isKindOfClass:[LLMeOrderDetailController class]]) {
                    break;
                }
            }
            if (viewControllers.count == navC.viewControllers.count) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            else {
                [navC setViewControllers:viewControllers animated:YES];
            }

    }
}
- (void)applicationBecomeActive    // 添加检测app进入后台的观察者
{
    if((_status == RoleStatusRedBag) ||  (_status == RoleStatusPingjian)||  (_status == RoleStatusStockPeisong)){//惊喜红包没有详情接口
        self.headView.dataDic = _datas;
    }else{
        [self getData];
    }
}
- (void)applicationEnterBackground{
    [self.headView endTimes];
}
-(void)getData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    [params setObject:_datas[@"orderNo"] forKey:@"orderNo"];
//    [params setValue:lat forKey:@"latitude"];
//    [params setValue:lng forKey:@"longitude"];
    if(lat.length > 0 && lng.length > 0){
        [params setValue:lat forKey:@"latitude"];
        [params setValue:lng forKey:@"longitude"];
    }
    WS(weakself);
    [XJHttpTool post:L_orderDetailUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        weakself.datas = responseObj[@"data"];
        self.headView.timeDic = responseObj[@"data"];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
-(void)setLayout{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SCREEN_top);
        make.bottom.equalTo(weakself.backView.mas_top).offset(0);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.equalTo(DeviceXTabbarHeigh(52));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(6));
        make.height.equalTo(CGFloatBasedI375(38));
    }];
    self.tableView.tableHeaderView = self.headView;
//    self.headView.dataDic = _datas;
}
-(void)clickactions:(UIButton *)sender{
    CGFloat prices = [_datas[@"payPrice"] floatValue];
    if((_status == RoleStatusRedBag) ||  (_status == RoleStatusPingjian)||  (_status == RoleStatusStockPeisong)){//惊喜红包没有详情接口
        prices = [_datas[@"payPrice"] floatValue];
    }else{
        prices = [_datas[@"totalPrice"] floatValue];
    }
    if(prices <= 0){
        WS(weakself);
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        sender.enabled = NO;
        [param setValue:FORMAT(@"%@",_datas[@"orderNo"]) forKey:@"orderNo"];
        if(_status == RoleStatusStore){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
            [param setValue:@"1" forKey:@"orderType"];
        }else     if(_status == RoleStatusRedBag){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
            [param setValue:@"2" forKey:@"orderType"];
        }else     if(_status == RoleStatusPingjian){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
            [param setValue:@"3" forKey:@"orderType"];
        }else     if(_status == RoleStatusStockPeisong){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
            [param setValue:@"5" forKey:@"orderType"];
        }else{
            [param setValue:@"1" forKey:@"orderType"];
        }
        [param setValue:@(self.payMode) forKey:@"payMode"];
        sender.enabled = NO;
        [XJHttpTool post:FORMAT(@"%@",L_apiapporderpayZero) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
            LLStorePaySuccessViewController *vc = [[LLStorePaySuccessViewController alloc]init];
            vc.payui = YES;
            vc.orderNo = FORMAT(@"%@",weakself.datas[@"orderNo"]);
            vc.status = weakself.status;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError * _Nonnull error) {
            sender.enabled = YES;
        }];
    }else{
        [self subUrl:sender];
    }
}
-(void)subUrl:(UIButton *)sender{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:FORMAT(@"%@",_datas[@"orderNo"]) forKey:@"orderNo"];
  
    if(_status == RoleStatusStore){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
        [param setValue:@"1" forKey:@"orderType"];
    }else     if(_status == RoleStatusRedBag){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
        [param setValue:@"2" forKey:@"orderType"];
    }else     if(_status == RoleStatusPingjian){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
        [param setValue:@"3" forKey:@"orderType"];
    }else     if(_status == RoleStatusStockPeisong){//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
        [param setValue:@"4" forKey:@"orderType"];
    }else{
        [param setValue:@"1" forKey:@"orderType"];
    }
    if(self.judgePriceType){//针对加价
        if(self.feePriceSize == 0){
            [param setValue:@(1) forKey:@"judgePriceType"];
        }else{
            [param setValue:@(2) forKey:@"judgePriceType"];
        }
    }
    [param setValue:@(self.payMode) forKey:@"payMode"];
    sender.enabled = NO;
    [XJHttpTool post:FORMAT(@"%@",L_apiapppay) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        sender.enabled = YES;
        if(self.payMode == 1){
            [self wechatPay:data];
        }else{
            [self alipay:data[@"body"]];
        }
    } failure:^(NSError * _Nonnull error) {
        sender.enabled = YES;
    }];
}
-(void)alipay:(NSString *)paystr{
    if(paystr.length <= 0){
        return;
    }
    NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay:"];
    if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        
        UIAlertController *aletController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"点击去安装支付宝钱包!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *canceAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [aletController addAction:canceAlert];
        
        UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            NSString * URLString = @"http://itunes.apple.com/cn/app/id333206289?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
        }];;
        [aletController addAction:okAlert];
        
        [self presentViewController:aletController animated:YES completion:nil];
        
        return;
    }
    NSString *appScheme = @"alidayingsdkdemo";
    // NOTE: 调用支付结果开始支付
    
    NSLog(@"paystr == %@",paystr);
//    paystr = @"alipay_sdk=alipay-sdk-java-4.9.79.ALL&app_id=2021003120652825&biz_content=%7B%22body%22%3A%22%E6%B5%8B%E8%AF%95%E6%94%AF%E4%BB%98%22%2C%22out_trade_no%22%3A%22NO20220412095812339%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22App%E6%B5%8B%E8%AF%95%E6%94%AF%E4%BB%98%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fapi.wenshiwx.com%2Fapi%2Fapp%2Fpay%2Fnotify%2Falipay&sign=TwmYlsDrz%2BnMIThJAYFEmELvU6qOp%2FOP27Qcmy8Rg158n3zFdLbimMtxk4ihvUOuSVCTh9oHcErexlMC6vYFn28fF1iFXZIl%2F7iethhyZBpor1kpYFlkX%2BR9dx4yVD%2FVoU%2Fm5zxFMmYpmusBYJWrm%2FYbdAj8b6nO3Xvmai038zoMZI%2B9DaQOmrzbfVe8%2FS9Da3%2FSM%2F%2Bpi8WG28HsOCYYMHRI%2B64MoV5DVPV7W6xrQClw7veOWRHtiQQSa89N6MqGgNPaJcmKsSs1zcfS17aMpkfczhsSf6t7NmyjyXl3DI3I038GGSIPbLkHyU2iMGvLxZuGb7Esn5tGlYJ8%2BWdDDw%3D%3D&sign_type=RSA2&timestamp=2022-04-12+17%3A58%3A12&version=1.0";
    [[AlipaySDK defaultService] payOrder:FORMAT(@"%@",paystr) fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
        if(resultStatus == 4000){
            [MBProgressHUD showError:@"支付失败"];
            return;
        }
    }];
}
//微信支付
-(void)wechatPay:(NSDictionary *)datas{
//    if([ShareSDK isClientInstalled:SSDKPlatformSubTypeWechatSession]){
        PayReq *request = [[PayReq alloc] init];
        /** 商家向财付通申请的商家id */
        request.partnerId = [NSString stringWithFormat:@"%@",datas[@"mchId"]];
        /** 预支付订单 */
        request.prepayId= [NSString stringWithFormat:@"%@",datas[@"prepayId"]];
        /** 商家根据财付通文档填写的数据和签名 */
        request.package = [NSString stringWithFormat:@"%@",datas[@"packages"]];
        /** 随机串，防重发 */
        request.nonceStr=[NSString stringWithFormat:@"%@",datas[@"nonceStr"]];
        /** 时间戳，防重发 */
        request.timeStamp = [datas[@"timestamp"] intValue];
        /** 商家根据微信开放平台文档对数据做的签名 */
        request.sign = [NSString stringWithFormat:@"%@",datas[@"sign"]];
        [WXApi sendReq:request completion:^(BOOL success) {
            
        }];
        
//    }else{
//        [MBProgressHUD showError:@"您未安装微信"];
//    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(400);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = BG_Color;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(400))];
    header.backgroundColor = [UIColor clearColor];
    
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLPayViewStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:LLPayViewStyleCellid];
    cell.titlelable.text = @[@"微信支付",@"支付宝支付"][indexPath.row];
    cell.showimage.image = [UIImage imageNamed: @[@"icon_wxzf",@"icon_zfbzf"][indexPath.row]];
    if(self.payMode == indexPath.row+1){
        cell.isSelects = YES;
    }else{
        cell.isSelects = NO;
    }
        
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.payMode = indexPath.row+1;
    [self.tableView reloadData];
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLPayViewStyleCell class] forCellReuseIdentifier:LLPayViewStyleCellid];
        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
-(LLStorePayHeadView *)headView{
    if(!_headView){
        _headView = [[LLStorePayHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(253))];
        [self.view addSubview:self.headView];
        WS(weakself);
        _headView.tapAction = ^{
            [weakself bacls];
        };
    }
    return _headView;
}
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        [self.view addSubview:self.backView];
    }
    return _backView;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [[UIButton alloc]init];
        [_sureButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = CGFloatBasedI375(19);
        _sureButton.backgroundColor = Main_Color;
        [self.backView addSubview:self.sureButton];
        [_sureButton addTarget:self action:@selector(clickactions:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
@end
