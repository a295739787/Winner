//
//  LLMapChoiceViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/7/13.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLMapChoiceViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LLAddrssTableView.h"
// 自定义大头针 气泡
#import "CustomAnnotationView.h"
#import "CurrentLocationAnnotation.h"

@interface LLMapChoiceViewController ()<MAMapViewDelegate,AMapSearchDelegate,UISearchBarDelegate>
@property (nonatomic, strong ) MAMapView *mapView ;
@property (nonatomic, strong ) AMapSearchAPI *search ;
@property (nonatomic, strong ) AMapLocationManager *locationManager ;
@property (nonatomic) CLLocationCoordinate2D locationCoordinate;
// 自定义大头针

@property (nonatomic,copy) NSString *currentCity;/** <#class#> **/
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
@property (nonatomic, assign) BOOL                  isMapViewRegionChangedFromTableView;// 防止重复点击
@property (nonatomic, assign) BOOL                  isLocated;// 是否正在定位
@property (nonatomic, strong ) UISearchBar * searchBarView ;
@property (nonatomic, strong ) LLAddrssTableView * addressTabelView ;
@property (nonatomic,strong) MAPointAnnotation *annotation;/** <#class#> **/
@property (nonatomic, strong) UIImage              *imageLocated;// 用户自定义大头针
@property (nonatomic, strong) UIImage              *imageNotLocate;
@property( NS_NONATOMIC_IPHONEONLY) CLLocationCoordinate2D coordinateplace;

@property (nonatomic,copy) NSString *textStr;/** <#class#> **/
@end

@implementation LLMapChoiceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.disableDragBack = YES;
    self.customNavBar.title = @"所在位置";
//    [self.customNavBar wr_setRightButtonWithTitle:@"确定" titleColor:Main_Color];
    [self setupMapView];
    

    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.isChat == YES){
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
}

#pragma mark - 定位显示设置
-(void)setupMapView{
    
    [AMapServices sharedServices].enableHTTPS = YES;
 
    
    self.isLocated = NO;
   self.locationManager  = [[AMapLocationManager alloc]init] ;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    WS(weakself);
    [self.addressTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(CGFloatBasedI375(350)+60);
    }];
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_top-CGFloatBasedI375(400))];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.delegate = self;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    [_mapView setZoomLevel:17.5];


    if(!_isShow){
        // 自己的坐标
        self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingweisimage"]];
    self.centerAnnotationView.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.centerAnnotationView.bounds) / 2);
        [self.mapView addSubview:self.centerAnnotationView];
    }else{
//        _mapView.annotations
    }

}

/**
 *  单击地图底图调用此接口
 *
 *  @param mapView    地图View
 *  @param coordinate 点击位置经纬度 根据经纬度获取周边poi
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    self.coordinateplace = coordinate;
//    [self searchPOIInfo:coordinate ];

}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // 防止重复点击
    if (!self.isMapViewRegionChangedFromTableView && self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self actionSearchAroundAt:self.mapView.centerCoordinate];
    }
    self.isMapViewRegionChangedFromTableView = NO;
}
#pragma mark - Handle Action
- (void)actionSearchAroundAt:(CLLocationCoordinate2D)coordinate
{
//    if(self.isLocated ){
//    [self searchReGeocodeWithCoordinate:coordinate];
        [self searchPoiWithCenterCoordinate:coordinate];
//    }
    [self centerAnnotationAnimimate];
}
/* 移动窗口弹一下的动画 */
- (void)centerAnnotationAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y -= 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y += 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
}
/**
 * @brief 逆地址编码查询接口
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];

}
/**
 * @brief 根据中心点坐标来搜周边的POI.
 */
- (void)searchPoiWithCenterCoordinate:(CLLocationCoordinate2D )coord
{
    AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
    request.radius   = 500;             /// 搜索范围
    request.sortrule = 0;               ///排序规则
    [self.search AMapPOIAroundSearch:request];
}
#pragma mark - userLocation
/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    self.coordinateplace = userLocation.coordinate;
    if(!updatingLocation)
        return ;
    if (userLocation.location.horizontalAccuracy < 0){
        return ;
    }
    if (!self.isLocated)
    {
        self.isLocated = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
//        [self actionSearchAroundAt:userLocation.location.coordinate];
    }
}


/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    // 自定义坐标
    if ([annotation isKindOfClass:[CurrentLocationAnnotation class]])
    {
        static NSString *reuseIndetifier = @"CustomAnnotationView";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"dingweisimage"];
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
        
    }
    return nil;
}

/**
 *  根据经纬度搜索周边POI
 *
 *  @param coordinate 经纬度
 *
 */
-(void)searchPOIInfo:(CLLocationCoordinate2D)coordinate{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //    request.keywords            = @"电影院";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.radius              = 500;
    [self.search AMapPOIAroundSearch:request];
}
/* 逆地理编码查询回调函数 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    self.currentCity = response.regeocode.addressComponent.city;
    if (self.currentCity.length == 0) {
        self.currentCity = response.regeocode.addressComponent.province;
    }
}

/* 输入提示查询回调函数 */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    
    if (response.tips.count>0) {
        //将搜索出的结果保存到数组
        self.addressTabelView.array = response.tips ;
    }else{
    }
}
- (void)AMapPOIKeywordsSearch:(AMapPOIKeywordsSearchRequest *)request{
    
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    if (response.pois.count == 0)
    {
        self.addressTabelView.array =@[];
        return;
    }
    NSLog(@"reGeocode:%@", response.pois);
    for (AMapPOI* poi in response.pois) {
        NSLog(@"reGeocode:%@", poi.name);
    }
    
    self.addressTabelView.array = response.pois ;
    _addressTabelView.hidden = NO;
    WS(weakself);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.addressTabelView.top = SCREEN_top ;
    }];
    [self.view addSubview:_addressTabelView];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    //地理编码器
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:self.coordinateplace radius:1000.0f identifier:@"GeocodeRegion"];

    [geocoder geocodeAddressString:searchBar.text inRegion:region completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place = placemarks[0];
        CLLocationCoordinate2D coordinateplace = place.location.coordinate;

        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(coordinateplace.latitude, coordinateplace.longitude)];
        for (CLPlacemark *placemark in placemarks){
            //坐标（经纬度)
         NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);

            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            if(self.textStr.length > 0){
                [self choicetetxt:self.textStr];
            }else{
               [self searchPOIInfo:coordinate ];
            }
        }
            
    }];
  
}
-(void)choicetetxt:(NSString *)text{
    AMapPOIKeywordsSearchRequest*request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.sortrule = 0;               ///排序规则
//    request.city =   self.currentCity;//查询城市默认为当前定位的城市
    request.keywords = text;
    request.cityLimit = YES;
    [self.search AMapPOIKeywordsSearch:request];
}
-(LLAddrssTableView*)addressTabelView{
    if (!_addressTabelView) {
        _addressTabelView = [[LLAddrssTableView alloc]init];
        _addressTabelView.searchBarView.delegate = self;
        [self.view addSubview:self.addressTabelView];
        WS(weakself);
        _addressTabelView.textblock = ^(NSString * _Nonnull text) {
            weakself.isMapViewRegionChangedFromTableView = YES;
            weakself.textStr = text;
            [weakself choicetetxt:text];
        };
        _addressTabelView.choicePoi = ^(AMapPOI * _Nonnull poi) {
            if(weakself.isChat){
                weakself.sendCompletion(CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude), poi.name,poi.address);
                /** 退出界面 */
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself dismissViewControllerAnimated:YES completion:nil];
                });
            }else{
                if(weakself.choicePoi){
                    weakself.choicePoi(poi);
                }
                /** 退出界面 */
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                });
            }
         
        };
    }
    return _addressTabelView;
}

@end
