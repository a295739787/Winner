//
//  LLMeAdressEditController.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeAdressEditController.h"
#import "LLMeAdressView.h"
#import "LLMeAdressTableCell.h"
#import "LLMeAdressView.h"
#import "AdressListView.h"
#import "LLMapChoiceViewController.h"
#import "PLLocationManage.h"
#import "Winner-Swift.h"

@interface LLMeAdressEditController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLMeAdressView *bottomView;
@property (nonatomic,strong)LLMeAdressDeleteView *deleteView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)AdressListView *adressView;
@property (nonatomic,strong) NSMutableArray *adressList;/** <#class#> **/

@property (nonatomic,strong)NSString *address;//详细地址
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *area;//区
@property (nonatomic,strong)NSString *city;//市
@property (nonatomic,strong)NSString *idd;//收货地址id
@property (assign, nonatomic)BOOL isDefault;//是否是默认值
@property (nonatomic,strong)NSString *latitude;//纬度
@property (nonatomic,strong)NSString *longitude;//经度
@property (nonatomic,strong)NSString *receiveName;//收货人姓名
@property (nonatomic,strong)NSString *receivePhone;//收货人手机号
@property (nonatomic, copy) NSString *locations;
@property (nonatomic,strong) CLLocationManager *locationManager;/** <#class#> **/


@end

@implementation LLMeAdressEditController
-(void)viewWillAppear:(BOOL)animated{
//    if([self determineWhetherTheAPPOpensTheLocation]){//未授权
//        NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
//        NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
//        if(lat.length <= 0 && lng.length <= 0){
//            [self locations];
//        }
//    }else{
//
//    }
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self createUI];
    [self getProvinceUrl];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *addressStyle;
    if (self.options == MeAddressOptionsLogis) {
        addressStyle = @"物流";
    }else{
        addressStyle = @"配送";
    }
    self.customNavBar.title = self.adressType == 100 ? [NSString stringWithFormat:@"添加%@地址",addressStyle]:[NSString stringWithFormat:@"编辑%@地址",addressStyle];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    self.bottomView.adressType = self.adressType == 100 ? 200:300;
    
    if (self.listModel) {
        _receiveName = self.listModel.receiveName;
        _receivePhone = self.listModel.receivePhone;
        _province = self.listModel.province;
        _city = self.listModel.city;
        _area = self.listModel.area;
        _idd = self.listModel.ID;
        _locations =self.listModel.locations;
        NSString *areaStr = [NSString stringWithFormat:@"%@%@%@%@",self.listModel.province,self.listModel.city,self.listModel.area,self.locations];
        _address = self.listModel.address;
        _isDefault = self.listModel.isDefault;
        self.dataArray = [[NSMutableArray alloc]initWithObjects:_receiveName,_receivePhone,areaStr,_address,@(_isDefault), nil];
    }else{
        self.dataArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@(NO), nil];
    }
    [self.tableView reloadData];
}
- (void)applicationBecomeActive    // 添加检测app进入后台的观察者
{
    [self requestLocationServicesAuthorization];
    if(![self determineWhetherTheAPPOpensTheLocation]){//未授权
        [UIAlertController showAlertViewWithTitle:@"当前定位权限" Message:@"添加地址需要开启定位权限" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
            if(index == 1){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
            }
        }];
    }else{
        NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
        NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
        if(lat.length <= 0 && lng.length <= 0){
            [self locationsActopn];
        }else{
            [self.tableView reloadData];
        }
    }
}

-(void)locationsActopn{
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
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.building] forKey:@"building"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];
}];
}
-(void)getProvinceUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:L_provinceUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            NSArray *data = responseObj[@"data"];
            [self.adressList removeAllObjects];
            [self.adressList addObjectsFromArray:data];
//            NSData *adressData = [NSKeyedArchiver archivedDataWithRootObject:data];
//            [[NSUserDefaults standardUserDefaults] setObject:adressData forKey:@"adressData"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
-(NSMutableArray *)adressList{
    if(!_adressList){
        _adressList = [NSMutableArray array];
    }
    return _adressList;
}
#pragma mark--saveAdressUrl
-(void)saveAdressUrl{
//    _area = @"广州省广州省天河";
//    _address = @"车别";
//    _province = @"车别";
//    _area = @"车别";
//    _city = @"车别";
    
    if ([_receiveName length] <= 0) {
        [JXUIKit showErrorWithStatus:@"请输入收货人"];
    }else if ([_receivePhone length] <= 0){
        [JXUIKit showErrorWithStatus:@"请输入手机号"];
    }else if ([_area length] <= 0){
        [JXUIKit showErrorWithStatus:@"请输入地区"];
//    }else if ([_locations length] <= 0){
//        [JXUIKit showErrorWithStatus:@"请选择位置"];
    }else if ([_address length] <= 0){
            [JXUIKit showErrorWithStatus:@"请输入地址"];
    }else{
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:_address forKey:@"address"];
        [params setObject:_province forKey:@"province"];
        [params setObject:_area forKey:@"area"];
        [params setObject:_city forKey:@"city"];
        if (_idd) {
            [params setObject:_idd forKey:@"id"];
        }else{
            [params setObject:@"" forKey:@"id"];
        }
        NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
        NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
//        [params setValue:lat forKey:@"latitude"];
//        [params setValue:lng forKey:@"longitude"];
        if(lat.length > 0 && lng.length > 0){
            [params setValue:lat forKey:@"latitude"];
            [params setValue:lng forKey:@"longitude"];
        }
        if (self.options == MeAddressOptionsLogis) {
            [params setObject:@"" forKey:@"locations"];
        }else{
            [params setObject:_locations forKey:@"locations"];
        }
        [params setObject:@(_isDefault) forKey:@"isDefault"];
        [params setObject:_receiveName forKey:@"receiveName"];
        [params setObject:_receivePhone forKey:@"receivePhone"];
        [params setObject:@(_options) forKey:@"addrType"];

        WS(weakself);
        [XJHttpTool post:L_addAdressUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
            
            NSString *code = responseObj[@"code"];
            if (weakself.adressType == 200) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }else if (weakself.adressType  == 300) {//确认订单
                if(self.getAddressBlock){
                    self.getAddressBlock();
                }
                [weakself.navigationController popViewControllerAnimated:YES];
            }else{
                if(self.getAddressBlock){
                    self.getAddressBlock();
                }
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            
            [MBProgressHUD showSuccess:responseObj[@"msg"]];
                    
         } failure:^(NSError * _Nonnull error) {
                    
        }];
    }
}
#pragma mark--设置默认地址
-(void)setAddressIsDeafaultUrl{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_idd forKey:@"id"];
    [params setObject:@(_isDefault) forKey:@"isDefault"];
    [params setObject:@(_options) forKey:@"addrType"];

    WS(weakself);
    [XJHttpTool post:L_adressIsDefaultUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        if(self.getAddressBlock){
            self.getAddressBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        });
       } failure:^(NSError * _Nonnull error) {
            
    }];
}
#pragma mark--删除收货地址
-(void)deleteAdressUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:_idd forKey:@"id"];
    [params setObject:@(_options) forKey:@"addrType"];

    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_deleteAdressUrl,_idd) method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSString *code = responseObj[@"code"];
        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        if(self.getAddressBlock){
            self.getAddressBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        });

       } failure:^(NSError * _Nonnull error) {
            
    }];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMeAdressEditTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeAdressEditTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftStr = @[@"收货人",@"手机号码",@"收货地区",@"详细地址",@"设为默认地址"][indexPath.row];
    cell.placeholderStr = @[@"收货人姓名",@"收货人手机号码",@"请选择地区",@"街道、楼牌号",@""][indexPath.row];
    cell.index = indexPath.row;
    cell.contentStr = self.dataArray[indexPath.row];
    
    WS(weakself);
    cell.textFieldBlock = ^(NSInteger index, NSString * _Nonnull fieldStr) {
        if (index == 0) {
            weakself.receiveName = fieldStr;
        }else if (index == 1){
            weakself.receivePhone = fieldStr;
        }else if (index == 3){
            weakself.address = fieldStr;
        }
        [weakself.dataArray replaceObjectAtIndex:index withObject:fieldStr];
    };
    cell.defaultBlock = ^(BOOL isSelect) {
        weakself.isDefault = isSelect;
        if (weakself.idd) {
            [weakself setAddressIsDeafaultUrl];
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    if (indexPath.row == 2) {
        if(lat.length <= 0 && lng.length <= 0){
            [self applicationBecomeActive];
        }else{
            WS(weakself);
            if (self.options == MeAddressOptionsLogis) {
                
                XYAddressPickerView *pickerView = [[XYAddressPickerView alloc] initWithProvince:self.province city:self.city area:self.area];
                pickerView.addressClickBlock = ^(NSString * province, NSString * city, NSString * area) {
                    weakself.province = province;
                    weakself.city = city;
                    weakself.area = area;
                    NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",province,city,area];
                    [weakself.dataArray replaceObjectAtIndex:2 withObject:areaStr];
                    NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:2 inSection:0]; //刷新第0段第2行
                    [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathTT,nil] withRowAnimation:UITableViewRowAnimationNone];
                };
                [pickerView showView];
                
            }else{
                LLMapChoiceViewController *vc = [[LLMapChoiceViewController alloc]init];
                vc.choicePoi = ^(AMapPOI * _Nonnull poi) {
                    weakself.province = poi.province;
                    weakself.city =poi.city;
                    weakself.area = poi.district;
                    weakself.locations = poi.name;
                    NSString *areaStr = [NSString stringWithFormat:@"%@%@%@%@",poi.province,poi.city,poi.district,poi.name];
                    [weakself.dataArray replaceObjectAtIndex:2 withObject:areaStr];
//                    [weakself.dataArray replaceObjectAtIndex:3 withObject:poi.name];
                    
                    NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:2 inSection:0]; //刷新第0段第2行
                    [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathTT,nil] withRowAnimation:UITableViewRowAnimationNone];
//                    [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }
//    else if( indexPath.row == 3){
//        if(lat.length <= 0 && lng.length <= 0){
//            [self applicationBecomeActive];
//        }else{
//            WS(weakself);
//            LLMapChoiceViewController *vc = [[LLMapChoiceViewController alloc]init];
//            vc.choicePoi = ^(AMapPOI * _Nonnull poi) {
//                weakself.province = poi.province;
//                weakself.city =poi.city;
//                weakself.area = poi.district;
//                weakself.locations = poi.name;
//                NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",poi.province,poi.city,poi.district];
//                [weakself.dataArray replaceObjectAtIndex:2 withObject:areaStr];
//                [weakself.dataArray replaceObjectAtIndex:3 withObject:poi.name];
//                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//                NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:2 inSection:0]; //刷新第0段第2行
//                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathTT,nil] withRowAnimation:UITableViewRowAnimationNone];
//            };
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - SCREEN_Bottom - CGFloatBasedI375(50)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeAdressEditTableCell class] forCellReuseIdentifier:@"LLMeAdressEditTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(LLMeAdressView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLMeAdressView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        WS(weakself);
        _bottomView.adressBtnBlock = ^(NSInteger index) {
            if (index == 100) {
                LLMeAdressEditController *editVC = [[LLMeAdressEditController alloc]init];
                editVC.adressType = 100;
                [weakself.navigationController pushViewController:editVC animated:YES];
            }else if (index == 200){
                //保存地址
                [weakself saveAdressUrl];
            }else if (index == 300){
                //删除地址
                [weakself.deleteView show];
            }else if (index == 400){
                [weakself saveAdressUrl];
            }
        };
    }
    return _bottomView;
}
-(LLMeAdressDeleteView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _deleteView.textStr = @"确定删除该收货地址？";
        _deleteView.titleStr = @"确认删除";
        _deleteView.rightStr = @"删除";
        WS(weakself);
        _deleteView.deleteBtnBlock = ^{
            //删除
            [weakself deleteAdressUrl];
        };
    }
    return _deleteView;
}

-(AdressListView *)adressView{
    if (!_adressView) {
        _adressView = [[AdressListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _adressView.adressBlock = ^(NSMutableDictionary *dict) {
            
            weakself.province = dict[@"provinceName"];
//            weakself.provinceId = dict[@"provinceId"];
            weakself.city = dict[@"cityName"];
//            weakself.cityId = dict[@"cityId"];
            weakself.area = dict[@"districtName"];
//            weakself.districtId = dict[@"districtId"];
            
            NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",weakself.province,weakself.city,weakself.area];
            [weakself.dataArray replaceObjectAtIndex:2 withObject:areaStr];
            
            NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:2 inSection:0]; //刷新第0段第2行
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathTT,nil] withRowAnimation:UITableViewRowAnimationNone];
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];

        };
    }
    return _adressView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
