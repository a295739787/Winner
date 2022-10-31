//
//  LLGoodYoujuViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/3/25.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLMainViewController.h"
#import "LLMainReusableView.h"
#import "LLMainCell.h"
#import "LLNewsViewController.h"
#import "LLShopCarViewController.h"
#import "QMChatRoomViewController.h"
#import "PLLocationManage.h"
#import "LLXieyiview.h"
#define  heights CGFloatBasedI375(260)
#define  widths (SCREEN_WIDTH-CGFloatBasedI375(20))/2
static NSString *const LLMainCellid = @"LLMainCell";
static NSString *const LLMainReusableViewid = @"LLMainReusableView";
static NSString *const footerCollectionIdentifier = @"footerCollection";
@interface LLMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout * collectionLayout;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *redUsers;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/
@property (nonatomic,strong) UILabel *redLabel;/** <#class#> **/
@property (nonatomic,strong) CLLocationManager *locationManager ;/** <#class#> **/

@property (nonatomic,strong) LLXieyiview *xieyiview;/** <#class#> **/

@end

@implementation LLMainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([UserModel sharedUserInfo].token > 0){
        [UserModel saveInfo];
        if([[UserModel sharedUserInfo] messageNum] > 0){
            self.redLabel.hidden = NO;
            self.redLabel.text = FORMAT(@"%ld",[UserModel sharedUserInfo].messageNum);
        }
    }
    
    if(![self determineWhetherTheAPPOpensTheLocation]){//未授权
        [UIAlertController showAlertViewWithTitle:@"当前定位权限" Message:@"加入惊喜红包活动商品需要您同意定位授权,否则将不能加入队列" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
            if(index == 1){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
            }
        }];
    }else{
        [self locations];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    NSString *firstXiyi =  [[NSUserDefaults standardUserDefaults]objectForKey:@"firstXiyi"];
    if(firstXiyi.length <=0){
        [self show];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDatas) name:@"updateName" object:nil];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    self.customNavBar.imageStr = @"logo_home";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"notice_home"]];
    
    WS(weakself);
    self.customNavBar.onClickRightButton = ^{
        LLNewsViewController *vc = [[LLNewsViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    [self setLayout];

    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self getDatas];
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
        }
    }
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
-(void)show{
    
    if(_xieyiview){
        _xieyiview = nil;
    }
    [self xieyiview];
    [self.xieyiview showActionSheetView];
    
}
-(LLXieyiview *)xieyiview{
    if(!_xieyiview){
        _xieyiview = [[LLXieyiview alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _xieyiview;
}
-(UILabel *)redLabel{
    if (!_redLabel) {
        _redLabel = [[UILabel alloc]init];
        _redLabel.textColor = UIColorFromRGB(0xFFFFFF);
        _redLabel.textAlignment = NSTextAlignmentCenter;
        _redLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(10)];
        _redLabel.layer.masksToBounds = YES;
        _redLabel.text = @"8";
        _redLabel.adjustsFontSizeToFitWidth = YES;
        _redLabel.layer.cornerRadius = CGFloatBasedI375(12)/2;
        _redLabel.backgroundColor = Red_Color;
        [self.customNavBar addSubview:_redLabel];
        self.redLabel.hidden = YES;
    }
    return _redLabel;
}
-(void)header{
    self.page = 1;
    [self getDatas];
}
-(void)footer{
    self.page ++;
    [self getDatas];
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:@( self.page ) forKey:@"currentPage"];
    [XJHttpTool post:L_apiappgoodshome method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [self.redUsers removeAllObjects];
        [self.redUsers addObjectsFromArray:data[@"redUsers"]];
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        if(self.page == 1){
            [self.dataArr removeAllObjects];
         }
        NSArray *list = data[@"appGoodsListVos"][@"list"];
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"appGoodsListVos"][@"list"]]];
        if(list.count < 10 ){
            self.collectionView.mj_footer.hidden = YES;
            [self.collectionView.mj_footer resetNoMoreData];
        }else{
            self.collectionView.mj_footer.hidden = NO;
        }
     
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
-(void)setLayout{
    WS(weakself);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(0));
        make.bottom.offset(CGFloatBasedI375(-0));
        make.right.offset(CGFloatBasedI375(0));

    }];
    CGFloat orY = CGFloatBasedI375(32);
    if([NSString isPhoneXxxx]){
        orY += CGFloatBasedI375(28);
    }
    [self.redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orY);
        make.right.equalTo(-2);
        make.height.mas_equalTo(CGFloatBasedI375(11));
        make.width.mas_equalTo(CGFloatBasedI375(15));
    }];
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
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.building] forKey:@"building"];

    [[NSUserDefaults standardUserDefaults]synchronize];
  
}];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLMainCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLMainCellid forIndexPath:indexPath];
    cell.model= self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatBasedI375(10);
    
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatBasedI375(10);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatBasedI375(10), CGFloatBasedI375(10),CGFloatBasedI375(10), CGFloatBasedI375(10));
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind == UICollectionElementKindSectionHeader) { //头部视图
        LLMainReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:LLMainReusableViewid forIndexPath:indexPath];
        if(self.redUsers.count > 0){
            headerView.redUsers = self.redUsers.mutableCopy;
        }
        if(self.model){
            headerView.model = self.model;
        }
        return headerView;
    } else { //脚部视图
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
      return footerView;
    }

}
//根据文字大小计算不同item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((SCREEN_WIDTH-CGFloatBasedI375(30))/2, CGFloatBasedI375(252));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
    vc.status = RoleStatusRedBag;
    LLGoodModel *model =  self.dataArr[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//          layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//          layout.minimumLineSpacing = 0;
//          layout.minimumInteritemSpacing = 0;
          _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
          _collectionView.tag = 11;
          _collectionView.dataSource = self;
          _collectionView.delegate = self;
//          _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#DEDCD5"];
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(475));
        layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, CGFloatBasedI375(50));
        [_collectionView registerClass:[LLMainCell class] forCellWithReuseIdentifier:LLMainCellid];
        [_collectionView registerClass:[LLMainReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LLMainReusableViewid];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier];
        [self.view addSubview:_collectionView];
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _collectionView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _collectionView.mj_footer = footer;
        adjustsScrollViewInsets_NO(_collectionView, self);
    }
    return _collectionView;
}
-(NSMutableArray *)redUsers{
    if(!_redUsers){
        _redUsers = [NSMutableArray array];
    }
    return _redUsers;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
