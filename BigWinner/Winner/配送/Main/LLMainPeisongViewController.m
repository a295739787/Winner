//
//  LLMainPeisongViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/3/4.
//

#import "LLMainPeisongViewController.h"
#import "LLMainPeisongCell.h"
#import "LLMainPeisongHeadView.h"
#import "LLIntroPointViewController.h"
#import "LLStockOrderDetailController.h"
#import "EnterPasswordView.h"
#import "NSDate+zh_Format.h"
#import "LLMeDeliverCommissionRecordVC.h"
@interface LLMainPeisongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/
@property (nonatomic,strong) UIView *headView;/** <#class#> **/
@property (nonatomic,strong) UIView *buttonlineview;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *arrbtn;/** <#class#> **/
@property (nonatomic,strong)    LLMainPeisongHeadView *headerbtn ;;/** <#class#> **/
@property (nonatomic, copy) NSString *state;
@property (nonatomic,strong) EnterPasswordView *passView;/** <#class#> **/
@property (nonatomic, copy) NSString *nums;
@property (strong, nonatomic)  CountDown *countDown;
@property(nonatomic,retain) dispatch_source_t timer;

@end
#define btnTags 200
@implementation LLMainPeisongViewController
-(void)viewDidDisappear:(BOOL)animated{
    if(self.countDown){
    [self.countDown destoryTimer];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if([self.state isEqual:@"3"]){
        self.countDown = [[CountDown alloc] init];
        __weak __typeof(self) weakSelf= self;
        [self.countDown countDownWithPER_SECBlock:^{
            [weakSelf updateTimeInVisibleCells];
        }];
    }
    
    if(![self determineWhetherTheAPPOpensTheLocation]){//未授权
        [UIAlertController showAlertViewWithTitle:@"当前定位权限" Message:@"需要您同意定位授权,否则部分功能将受限" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
            if(index == 1){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
            }
        }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.state = @"2";
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"任务大厅";
    [self setLayout];
    [self getDatas];
    [self getcountDatas];
    

    
}
-(void)header{
    [self getcountDatas];
    self.tableView.mj_footer.hidden = NO;
    self.page = 1;
    [self getDatas];
}
-(void)footer{
    self.page ++;
    [self getDatas];
}
#pragma mark 获取任务订单数量
-(void)getcountDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    if(lat.length > 0 && lng.length > 0){
        [param setValue:lat forKey:@"latitude"];
        [param setValue:lng forKey:@"longitude"];
    }
    NSString *url = L_apiapptaskordernum;
    if([UserModel sharedUserInfo].isClerk){//配送员
        url =  L_apiapptaskordernum;
    }
    [XJHttpTool post:url method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [self dealWithCount:data];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    [param setValue:@"1000" forKey:@"pageSize"];
    [param setValue:@"1" forKey:@"currentPage"];
    [param setValue:@"" forKey:@"keyword"];
    if(lat.length > 0 && lng.length > 0){
        [param setValue:lat forKey:@"latitude"];
        [param setValue:lng forKey:@"longitude"];
    }
    [param setValue:@"" forKey:@"sidx"];
    [param setValue:@"" forKey:@"sort"];//排序类型（升序：asc，降序：desc）
    [param setValue:self.state forKey:@"taskStatus"];//接单状态2待接单、3已接单、4已完成）
    NSString *url = L_apiapptaskorderlist;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [XJHttpTool post:url method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        if(self.page == 1){
            [self.dataArr removeAllObjects];
         }
        NSArray *list = data[@"list"];
        NSLog(@"responseObj == %@",responseObj[@"data"]);
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
        NSMutableArray *temp = [NSMutableArray array];
        if([self.state isEqual:@"2"]){
            for(LLGoodModel *model in self.dataArr){
                double kill = [self LantitudeLongitudeDist:[model.appAddressInfoVo.longitude doubleValue] other_Lat:[model.appAddressInfoVo.latitude doubleValue] self_Lon:[lat doubleValue] self_Lat:[lat doubleValue]];//计算我的距离和商家距离多少km
                if(kill >= model.judgeDistance.floatValue){
                    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
                    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSInteger strend = model.stayTaskTimestamp.integerValue;
                    NSString *newdata = [NSString getCurrentTimes];
                    NSInteger startLongLong = [newdata integerValue];
                    if(strend- startLongLong > 0){
                        [temp addObject:model];
                    }
                }
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:temp.mutableCopy];
            LLMainPeisongHeadView *btn = [self.view viewWithTag:btnTags];
            btn.titlelable.text = FORMAT(@"%ld",self.dataArr.count);
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        if(self.dataArr.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"暂无数据"];
        }else{
            [self.tableView removeEmptyView];
        }
        if([self.state isEqual:@"3"] || [self.state isEqual:@"2"]){
            self.countDown = [[CountDown alloc] init];
            __weak __typeof(self) weakSelf= self;
            [self.countDown countDownWithPER_SECBlock:^{
                [weakSelf updateTimeInVisibleCells];
            }];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.tableView.visibleCells; //取出屏幕可见ceLl
    for (LLMainPeisongCell *cell in cells) {
        LLGoodModel *model = self.dataArr[cell.tag];
        if(model.taskStatus == 3){
            NSString *time = [self getNowTimeWithString:model];
            NSString *taskPlanTime = [self getNowtaskPlanTimeTimeWithString:model];
            if ([time isEqualToString:@"over"]) {
                cell.sureButton2.hidden=YES;
            }else{
                cell.sureButton2.hidden=NO;
            }
                NSString *times =model.taskPlanTime;
                if(times.length > 18){
                    times =  [times substringWithRange:NSMakeRange(11, 5)];
                }
                if ([taskPlanTime isEqualToString:@"overtimes"]) {
                    cell.timelable.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"当日%@分前送达 ",times),@"订单已超时"]  colors:@[ BlackTitleFont443415, Main_Color]];
                }else{
                    cell.timelable.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"当日%@分前送达还剩",times),FORMAT(@"%@",taskPlanTime)]  colors:@[ BlackTitleFont443415, Main_Color]];
                }
           
            
        }else if(model.taskStatus == 2 || model.taskStatus == 5){//待接单
            NSString *time = [self getNowTimeWithWaitString:model];
            if ([time isEqualToString:@"overtimes"]) {
                [self.dataArr removeObject:model];
                [self.tableView reloadData];
            }else{
            }
        }
            
    }
      
    
}
-(NSString *)getNowTimeWithWaitString:(LLGoodModel *)models{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//taskPlanTimestamp
    NSInteger strend = [models.stayTaskTimestamp integerValue];//抢单剩余时间戳
    NSTimeInterval time=strend;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSDate  *expireDate = [NSDate dateForString:currentDateStr];
    NSDate  *nowDate = [NSDate date];
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    nowDate = [formater dateFromString:nowDateStr];
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];

    NSInteger days = (NSInteger)(timeInterval/(3600*24));
    NSInteger hours = (NSInteger)((timeInterval-days*24*3600)/3600);
    NSInteger minutes = (NSInteger)(timeInterval-days*24*3600-hours*3600)/60;
    NSInteger seconds = (NSInteger)(timeInterval-days*24*3600-hours*3600-minutes*60);
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;

    if(minutes<10){
        minutesStr = [NSString stringWithFormat:@"0%ld",minutes];
    }else{
        minutesStr = [NSString stringWithFormat:@"%ld",minutes];
    }
    //秒
    if(seconds < 10){
        secondsStr = [NSString stringWithFormat:@"0%ld", seconds];
    }else{
        secondsStr = [NSString stringWithFormat:@"%ld",seconds];
    }

    if (hours<=0 && minutes<=0&&seconds<=0) {
        NSMutableArray *temp = [NSMutableArray array];
        if([self.state isEqual:@"2"]){
            NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
            NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
            for(LLGoodModel *model in self.dataArr){
                double kill = [self LantitudeLongitudeDist:[model.appAddressInfoVo.longitude doubleValue] other_Lat:[model.appAddressInfoVo.latitude doubleValue] self_Lon:[lng doubleValue] self_Lat:[lat doubleValue]];//计算我的距离和商家距离多少km
                if(kill >= model.judgeDistance.floatValue){
                    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
                    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSInteger strend = model.stayTaskTimestamp.integerValue;
                    NSString *newdata = [NSString getCurrentTimes];
                    NSInteger startLongLong = [newdata integerValue];
                    if(strend- startLongLong > 0){
                        [temp addObject:model];
                    }
                }
            }
            LLMainPeisongHeadView *btn = [self.view viewWithTag:btnTags];
            btn.titlelable.text = FORMAT(@"%ld",temp.count);
        }
        return @"overtimes";
    }
    return [NSString stringWithFormat:@"%@:%@",minutesStr,secondsStr];
}
-(NSString *)getNowtaskPlanTimeTimeWithString:(LLGoodModel *)models{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//taskPlanTimestamp
    NSInteger strend = [models.taskPlanTimestamp integerValue];
    NSTimeInterval time=strend;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSDate  *expireDate = [NSDate dateForString:currentDateStr];
    NSDate  *nowDate = [NSDate date];
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    nowDate = [formater dateFromString:nowDateStr];
  
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];

    NSInteger days = (NSInteger)(timeInterval/(3600*24));
    NSInteger hours = (NSInteger)((timeInterval-days*24*3600)/3600);
    NSInteger minutes = (NSInteger)(timeInterval-days*24*3600-hours*3600)/60;
    NSInteger seconds = (NSInteger)(timeInterval-days*24*3600-hours*3600-minutes*60);
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;

    if(minutes<10){
        minutesStr = [NSString stringWithFormat:@"0%ld",minutes];
    }else{
        minutesStr = [NSString stringWithFormat:@"%ld",minutes];
    }
    //秒
    if(seconds < 10){
        secondsStr = [NSString stringWithFormat:@"0%ld", seconds];
    }else{
        secondsStr = [NSString stringWithFormat:@"%ld",seconds];
    }

    if (hours<=0 && minutes<=0&&seconds<=0) {
        return @"overtimes";
    }
    return [NSString stringWithFormat:@"%@:%@",minutesStr,secondsStr];
}
#pragma mark 已转单 倒计时
-(NSString *)getNowTimeWithString:(LLGoodModel *)models{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger strend = models.taskTimestamp.integerValue+300;
    NSString *newdata = [NSString getCurrentTimes];
    NSInteger startLongLong = [newdata integerValue];

    if(strend- startLongLong <= 0){
        return @"over";
    }else{
        
        NSTimeInterval time=strend;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        NSDate  *expireDate = [NSDate dateForString:currentDateStr];
        NSDate  *nowDate = [NSDate date];
        // 当前时间字符串格式
        NSString *nowDateStr = [formater stringFromDate:nowDate];
        // 当前时间date格式
        nowDate = [formater dateFromString:nowDateStr];
        
//        NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
        NSInteger timeInterval =  strend- startLongLong;
        
        NSInteger days = (NSInteger)(timeInterval/(3600*24));
        NSInteger hours = (NSInteger)((timeInterval-days*24*3600)/3600);
        NSInteger minutes = (NSInteger)(timeInterval-days*24*3600-hours*3600)/60;
        NSInteger seconds = (NSInteger)(timeInterval-days*24*3600-hours*3600-minutes*60);
//        NSLog(@"expireDate == %@ taskPlanTimestamp == %@  taskPlanTimestamp+300==%ld",expireDate,models.taskTimestamp,models.taskTimestamp.integerValue+300);
        NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
        
        if(minutes<10)
            minutesStr = [NSString stringWithFormat:@"0%ld",minutes];
        else
            minutesStr = [NSString stringWithFormat:@"%ld",minutes];
        //秒
        if(seconds < 10)
            secondsStr = [NSString stringWithFormat:@"0%ld", seconds];
        else
            secondsStr = [NSString stringWithFormat:@"%ld",seconds];
        if (hours<=0&&minutes<=0&&seconds<=0) {
            return @"over";
        }
//        [JXUIKit showErrorWithStatus:FORMAT(@"strend == %ld  %@:%@",strend- startLongLong,minutesStr,secondsStr)];
        return [NSString stringWithFormat:@"%@:%@",minutesStr,secondsStr];
    }
}
#pragma mark 抢单 转单  提货核销  参数齐全
-(void)qiangOrder:(LLGoodModel *)model :(NSString *)name{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:model.orderNo forKey:@"orderNo"];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
//    [params setValue:lat forKey:@"latitude"];
//    [params setValue:lng forKey:@"longitude"];
    if(lat.length > 0 && lng.length > 0){
        [params setValue:lat forKey:@"latitude"];
        [params setValue:lng forKey:@"longitude"];
    }
    NSString *trun = nil;//转单  抢单
    if([name isEqual: @"提货核销"]){//提货核销 需要加writeCode字段
        trun = L_apiapptaskorderpick;//提货核销
        if(self.nums.length <= 0){
            [MBProgressHUD showError:@"请输入核销码" toView:self.view];
            return;;
        }
        [params setValue:self.nums forKey:@"writeCode"];
    }else if([name isEqual:@"抢单"]){
        trun = L_apiapptaskordertask;//抢单
    }else if([name isEqual:@"转单"]){
        trun = L_apiapptaskorderturn;//转单
        [params setValue:model.orderNo forKey:@"orderNo"];
    }
    if(trun.length <= 0){
        [MBProgressHUD showError:@"url为空" toView:self.view];
        return;;
    }
    [XJHttpTool post:trun method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        self.page = 1;
        [self getDatas];
    } failure:^(NSError * _Nonnull error) {
        if([name isEqual:@"抢单"]){
            [JXUIKit showSuccessWithStatus:@"来晚了，已被抢走了哦"];
            
            self.page = 1;
            [self getDatas];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
  
    
}
#define PI 3.1415926
-(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lon2];
               CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];

                double  distance  = [curLocation distanceFromLocation:otherLocation];
                return  distance;
//    double er = 6378137; // 6378700.0f;
//    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
//    //equatorial radius = 6378.388
//    //nautical mile = 1.15078
//    double radlat1 = PI*lat1/180.0f;
//    double radlat2 = PI*lat2/180.0f;
//    //now long.
//    double radlong1 = PI*lon1/180.0f;
//    double radlong2 = PI*lon2/180.0f;
//    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
//    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
//    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
//    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
//    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
//    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
//    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
//    //zero ag is up so reverse lat
//    double x1 = er * cos(radlong1) * sin(radlat1);
//    double y1 = er * sin(radlong1) * sin(radlat1);
//    double z1 = er * cos(radlat1);
//    double x2 = er * cos(radlong2) * sin(radlat2);
//    double y2 = er * sin(radlong2) * sin(radlat2);
//    double z2 = er * cos(radlat2);
//    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
//    //side, side, side, law of cosines and arccos
//    double theta = acos((er*er+er*er-d*d)/(2*er*er));
//    double dist  = theta*er;
//    return dist;
}
-(void)setLayout{
    WS(weakself);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SCREEN_top);
        make.height.offset(CGFloatBasedI375(53));
        make.left.right.mas_equalTo(0);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.headView.mas_bottom).offset(CGFloatBasedI375(10));
        make.left.right.bottom.mas_equalTo(CGFloatBasedI375(0));
    }];
    [self creatBtn];
}

-(void)dealWithCount:(NSDictionary *)data{
    LLMainPeisongHeadView *btn = [self.view viewWithTag:btnTags];
    btn.titlelable.text = FORMAT(@"%@",data[@"stayOrderNum"]);
    LLMainPeisongHeadView *btn1 = [self.view viewWithTag:btnTags+1];
    btn1.titlelable.text = FORMAT(@"%@",data[@"thenOrderNum"]);
    LLMainPeisongHeadView *btn2 = [self.view viewWithTag:btnTags+2];
    btn2.titlelable.text = FORMAT(@"%@",data[@"completeOrderNum"]);
}
-(void)creatBtn{
    CGFloat btnWidth = SCREEN_WIDTH/3;
    NSArray *titlearr = @[@"抢单",@"已接单",@"已完成"];
    NSArray *namearr = @[@"0",@"0",@"0"];
    for (int i = 0; i < titlearr.count; i ++) {
        
        LLMainPeisongHeadView *btn = [[LLMainPeisongHeadView alloc]initWithFrame:CGRectMake(i*btnWidth,0,btnWidth,CGFloatBasedI375(53))];
        btn.titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        btn.titlelable.text = namearr[i];
        btn.namelable.text = titlearr[i];
        btn.tag = i+btnTags;
        [self.headView addSubview:btn];
        if(0 == i){
            btn.titlelable.textColor =Main_Color;
            btn.namelable.textColor =Main_Color;
            _headerbtn = btn;
        }
        [self.arrbtn addObject:btn];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [btn addGestureRecognizer:tap];
       
    }
    UIView *lineviews = [[UIView alloc]initWithFrame:CGRectMake(_headerbtn.centerX-CGFloatBasedI375(25/2),  CGFloatBasedI375(53), CGFloatBasedI375(25), CGFloatBasedI375(2))];
    lineviews.backgroundColor = Main_Color;
    [self.view addSubview:lineviews];
    _buttonlineview = lineviews;
    
    [self.headView addSubview:lineviews];
}
-(void)tapAction:(UITapGestureRecognizer * )sender{
    for( LLMainPeisongHeadView *btns in self.arrbtn){
        btns.titlelable.textColor = [UIColor colorWithHexString:@"#666666"];
        btns.namelable.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    self.page = 1;
    NSArray *da = @[@"2",@"3",@"4"];
    LLMainPeisongHeadView *btn =(LLMainPeisongHeadView *)sender.view;
    btn.titlelable.textColor =Main_Color;
    btn.namelable.textColor =Main_Color;
    _state = [NSString stringWithFormat:@"%@",da[sender.view.tag-btnTags]];
    _buttonlineview.x = btn.centerX-CGFloatBasedI375(25/2);
        [self getDatas];
}
static NSString *const LLMainPeisongCellid = @"LLMainPeisongCell";
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(280);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMainPeisongCell *cell = [tableView dequeueReusableCellWithIdentifier:LLMainPeisongCellid];
    cell.state = self.state.integerValue;
    if(self.dataArr.count){
        cell.model = self.dataArr[indexPath.section];
    }
    cell.tag = indexPath.section;
    WS(weakself);
    cell.tapAction = ^(LLGoodModel * _Nonnull model, NSString * _Nonnull name) {
        if([name isEqual:@"联系客户"]){
                NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.appAddressInfoVo.receivePhone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
        
        }else if([name isEqual:@"转单"]){
            [UIAlertController showAlertViewWithTitle:@"确认转单" Message:@"确定将此单释放？" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
                if(index == 1){
                    [weakself qiangOrder:model :name];
                }
            }];
            
        }else if([name isEqual:@"提货核销"]){
            if(weakself.passView){
                weakself.passView = nil;
            }
            [weakself passView];
            weakself.passView.model  = model;
            [weakself.passView show];
        } else if([name isEqual:@"查看佣金"]){
            LLMeDeliverCommissionRecordVC *vc = [[LLMeDeliverCommissionRecordVC alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }else{
            [weakself qiangOrder:model :name];
        }
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLGoodModel *model  = self.dataArr[indexPath.section];
    LLStockOrderDetailController *vc = [[LLStockOrderDetailController alloc]init];
    vc.orderNo = model.orderNo;
    WS(weakself);
    vc.tapAction = ^{
        weakself.page = 1;
        [weakself getDatas];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT)style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLMainPeisongCell class] forCellReuseIdentifier:LLMainPeisongCellid];
        [self.view addSubview:self.tableView];
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _tableView.mj_footer = footer;
    }
    return _tableView;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = White_Color;
        [self.view addSubview:_headView];
    }
    return _headView;;
}
-(NSMutableArray *)arrbtn{
    if(!_arrbtn){
        _arrbtn = [NSMutableArray array];
    }
    return _arrbtn;
}
-(EnterPasswordView *)passView{
    if (!_passView) {
        WS(weakself);
        _passView = [[EnterPasswordView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _passView.EnterPasswordBlock = ^(NSString * _Nonnull number, LLGoodModel * _Nonnull model) {
            weakself.nums = number;
            [weakself qiangOrder:model :@"提货核销"];
        };
    }
    return _passView;
}

@end
