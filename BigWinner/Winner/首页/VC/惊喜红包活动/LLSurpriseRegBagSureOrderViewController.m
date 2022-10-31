//
//  LLStoreSureOrderViewController.m
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LLSurpriseRegBagSureOrderViewController.h"
#import "LLStoreSureOrderHeadView.h"
#import "LLStoreSureOrderViewCell.h"
#import "LLShopCarBoView.h"
#import "LLStorePayViewController.h"
#import "PLLocationManage.h"

static NSString *const LLStoreSureOrderViewCellid = @"LLStoreSureOrderViewCell";
static NSString *const LLStoreSureOrderViewAddressCellid = @"LLStoreSureOrderViewAddressCell";
static NSString *const LLStoreSureOrderViewCommonCellid = @"LLStoreSureOrderViewCommonCell";
static NSString *const LLStoreSureOrderViewDeliverCellid = @"LLStoreSureOrderViewDeliverCell";


@interface LLSurpriseRegBagSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLStoreSureOrderHeadView *headView ;/** <#class#> **/
@property (nonatomic,assign) NSInteger tagindex ;/** <#class#> **/
@property (nonatomic,strong) LLShopCarBoView *boView;/** <#class#> **/
@property (nonatomic,strong) LLSupriceRedbagView *statusView;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *areaModel;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *addressModel;/** <#class#> **/
@property (nonatomic,strong) CLLocationManager *locationManager ;/** <#class#> **/

@end

@implementation LLSurpriseRegBagSureOrderViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![self determineWhetherTheAPPOpensTheLocation]){//未授权
        [UIAlertController showAlertViewWithTitle:@"当前定位权限" Message:@"加入惊喜红包活动商品需要您同意定位授权,否则将不能加入队列" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
            if(index == 1){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
            }
        }];
    }else{
        NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
        NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
        if(lat.length <= 0 && lng.length <= 0){//没有经纬度 就重新获取经纬度
            [self locations];
        }else{
            [self postAreaDatas];//有经纬度的时候去获取当前城市是否在队列
        }
    }
    
    self.tagindex = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"购买下单";
    [self setLayout];

    [self postDatas];
    
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}
#pragma mark - 获取授权
- (void)requestLocationServicesAuthorization
{
    //CLLocationManager的实例对象一定要保持生命周期的存活
    if (!self.locationManager) {
        self.locationManager  = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}
- (void)applicationBecomeActive    // 添加检测app进入后台的观察者
{
    [self requestLocationServicesAuthorization];
    if(![self determineWhetherTheAPPOpensTheLocation]){//未授权
        [UIAlertController showAlertViewWithTitle:@"当前定位权限" Message:@"加入惊喜红包活动商品需要您同意定位授权,否则将不能加入队列" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
            if(index == 1){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
            }
        }];
    }else{
        NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
        NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
        if(lat.length <= 0 && lng.length <= 0){
            [self locations];
        }else{
            [self postAreaDatas];
        }
    }
}

-(void)locations{
[[PLLocationManage shareInstance] requestLocationWithCompletionBlock:^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull regeocode, NSError * _Nonnull error) {
    NSLog(@"%@",regeocode);
    
    if (location == nil) {
        return ;
    }
    NSString *lat =[NSString stringWithFormat:@"%.5f",location.coordinate.latitude];
    NSString *lng =[NSString stringWithFormat:@"%.5f",location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults]setObject:lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setObject:lng forKey:@"lng"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",regeocode.city,regeocode.district] forKey:@"areaname"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",regeocode.province,regeocode.city] forKey:@"provincecity"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.city] forKey:@"city"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.province] forKey:@"province"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.district] forKey:@"district"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.street] forKey:@"street"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self postAreaDatas];
    
}];
}
-(void)postAreaDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *url = L_apiapporderqueuecity;
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    NSString *province = [[NSUserDefaults standardUserDefaults]objectForKey:@"province"];
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    [param setValue:lat forKey:@"latitude"];
    [param setValue:lng forKey:@"longitude"];
    [param setValue:province forKey:@"province"];
    [param setValue:city forKey:@"city"];
    [XJHttpTool post:url method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
     self.areaModel =[LLGoodModel mj_objectWithKeyValues:data];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

-(void)postDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *url = L_apiapporderconfirm;
    [param setValue:self.valueModel.goodsId forKey:@"goodsId"];
    [param setValue:self.valueModel.ID forKey:@"redGoodsId"];
    [param setValue:self.goodsNum forKey:@"goodsNum"];//数量（零售区立即购买、惊喜红包下单、配送库存采购必传）
    [param setValue:self.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];//规格价格ID（零售区立即购买、惊喜红包、品鉴商品下单、配送库存采购必传）
    [param setValue:@"3" forKey:@"buyType"];//下单类型（1零售区立即购买，2购物车下单，3惊喜红包、4品鉴商品、5配送库存采购）
    [param setValue:@(2) forKey:@"expressType"];//配送方式（1物流配送、2同城配送）
    [XJHttpTool post:url method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        self.boView.model = self.model;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark 提交订单
-(void)subUrl:(UIButton *)sender{
    if(self.areaModel.ID.length <= 0){
        [JXUIKit showErrorWithStatus:@"您所在的地区还未开放"];
        return;;
    }

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSMutableArray *goodAs = [NSMutableArray array];
    [self.model.appOrderConfirmGoodsVo enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLGoodModel *sonmodel = (LLGoodModel *)obj;
        NSMutableDictionary *goodpram = [NSMutableDictionary dictionary];
        [goodpram setValue:sonmodel.ID forKey:@"id"];
        [goodpram setValue:sonmodel.goodsNum forKey:@"goodsNum"];
        [goodpram setValue:sonmodel.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];
        [goodpram setValue:sonmodel.ID forKey:@"goodsId"];
        [goodAs addObject:goodpram.mutableCopy];
    }];
    
    [param setValue:goodAs forKey:@"appOrderSubmitGoodsForm"];
    [param setValue:self.areaModel.ID forKey:@"queueId"];
    [param setValue:@"3" forKey:@"buyType"];

    WS(weakself);
    [XJHttpTool post:L_apiappordersubmit method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        LLStorePayViewController *vc = [[LLStorePayViewController alloc]init];
        vc.datas =data;
        vc.status = weakself.status;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)setLayout{
    WS(weakself);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(0));        make.bottom.equalTo(weakself.boView.mas_top).offset(-CGFloatBasedI375(10));

    }];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(weakself.boView.mas_top).offset(0);
        make.height.offset(CGFloatBasedI375(30));
    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(50)));
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 2){
        return 2;
    }
    return self.model.appOrderConfirmGoodsVo.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){//地指
        return CGFloatBasedI375(54);
    }else if(indexPath.section == 2){
        return CGFloatBasedI375(44);
    }
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section != 2){
        return CGFloatBasedI375(10);
    }
    return CGFloatBasedI375(40);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = [UIColor clearColor];
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section != 2){
        return nil;
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(40))];
    header.backgroundColor = BG_Color;
    UILabel *nameLabel1 = [[UILabel alloc]init];
    nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
    nameLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
    nameLabel1.textAlignment = NSTextAlignmentLeft;
    nameLabel1.userInteractionEnabled = YES;
    nameLabel1.text = @"惊喜活动商品支付后，商品会加入您的库存。";
    [header addSubview:nameLabel1];
    [nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(10));
    }];
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LLStoreSureOrderViewDeliverCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewDeliverCellid];
        cell.model = self.areaModel;
        cell.status = RoleStatusRedBag;
        return cell;
    }else if(indexPath.section == 2){
        LLStoreSureOrderViewCommonCell*cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCommonCellid];
        cell.model = self.model;
        cell.status = RoleStatusRedBag;
        cell.indexs = indexPath.row;
        return cell;
    }
    LLStoreSureOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCellid];
    cell.model = self.model.appOrderConfirmGoodsVo[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        [ _tableView  registerClass:[LLStoreSureOrderViewCell class] forCellReuseIdentifier:LLStoreSureOrderViewCellid];
        [ _tableView  registerClass:[LLStoreSureOrderViewAddressCell class] forCellReuseIdentifier:LLStoreSureOrderViewAddressCellid];
        [ _tableView  registerClass:[LLStoreSureOrderViewCommonCell class] forCellReuseIdentifier:LLStoreSureOrderViewCommonCellid];
        [ _tableView  registerClass:[LLStoreSureOrderViewDeliverCell class] forCellReuseIdentifier:LLStoreSureOrderViewDeliverCellid];

        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
-(LLStoreSureOrderHeadView *)headView{
    if(!_headView){
        _headView = [[LLStoreSureOrderHeadView alloc]init];
        [self.view addSubview:_headView];
        WS(weakself);
        _headView.tapClick = ^(NSInteger tagindex) {//1是同城  2是配送
            weakself.tagindex = tagindex;
            [weakself.tableView reloadData];
        };
    }
    return _headView;
}
-(LLShopCarBoView *)boView{
    if(!_boView){
        _boView = [[LLShopCarBoView alloc]init];
        [_boView.sureButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_boView.sureButton addTarget:self action:@selector(subUrl:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.boView];
    }
    return _boView;
}
-(LLSupriceRedbagView *)statusView{
    if(!_statusView){
        _statusView = [[LLSupriceRedbagView alloc]init];
        [self.view addSubview:self.statusView];
    }
    return _statusView;
}
@end
