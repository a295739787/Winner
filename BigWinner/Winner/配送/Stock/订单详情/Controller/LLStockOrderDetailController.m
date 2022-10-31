//
//  LLStockOrderDetailController.m
//  Winner
//
//  Created by YP on 2022/3/22.
//

#import "LLStockOrderDetailController.h"
#import "LLStockOrderDetailTopView.h"
#import "LLStockOrderDetailTableCell.h"
#import "LLStockOrderDetailTopView.h"
#import "LLMeOrderDetailHeaderView.h"
#import "LLMeorderDetailTableCell.h"
#import "EnterPasswordView.h"
#import "LLMeDeliverCommissionRecordVC.h"
@interface LLStockOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLStockOrderDetailTopView *topView;
@property (nonatomic,strong)LLStockOrderBottomView *bottomView;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@property (nonatomic,assign) NSInteger taskStatus;/** class **/
@property (nonatomic,strong) EnterPasswordView *passView;/** <#class#> **/
@property (nonatomic, copy) NSString *nums;
@property (nonatomic,strong) CountDown *countDown;/** <#class#> **/


@property (assign, nonatomic) RoleStatus status; // 1无地图。2有地图


@end

@implementation LLStockOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData:YES];
}
#pragma mark--getOrderDetailUrl
-(void)getData:(BOOL)isLoad{
    if(_orderNo.length <= 0){
        return;
    }
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_orderNo forKey:@"orderNo"];
    if(lat.length > 0 && lng.length > 0){
        [params setValue:lat forKey:@"latitude"];
        [params setValue:lng forKey:@"longitude"];
    }
  
    WS(weakself);
    if(isLoad){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }

    [XJHttpTool post:L_orderDetailUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        if(isLoad){
            [self createUI];
        }
        NSLog(@"responseObj == %@",responseObj[@"data"]);
        self.model = [LLGoodModel mj_objectWithKeyValues:responseObj[@"data"]];
        if(self.model.taskStatus == 2){// 待接单
            self.status = RoleStatusWaitOrder;
            self.countDown = [[CountDown alloc] init];
            __weak __typeof(self) weakSelf= self;
            [self.countDown countDownWithPER_SECBlock:^{
                [self getNowTimeWithWaitString:self.model];
            }];
        
        }else if(self.model.taskStatus == 3){ // 已接单
            self.status = RoleStatusHadOrder;
        }else if(self.model.taskStatus == 5){ //已转单
            self.status = RoleStatusTransOrder;
            [self.countDown countDownWithPER_SECBlock:^{
                [self getNowTimeWithWaitString:self.model];
            }];
        }else{// 已完成
            self.status = RoleStatusDoneOrder;
        }
        self.topView.model = self.model;
        self.bottomView.model = self.model;
        [weakself.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)getNowTimeWithWaitString:(LLGoodModel *)models{
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
    NSLog(@"minutesStr == %@  secondsStr == %@",minutesStr,secondsStr);
    if (hours<=0 && minutes<=0&&seconds<=0) {
        [self.countDown destoryTimer];
        if(self.tapAction){
           self.tapAction();
        }

        [self.navigationController popViewControllerAnimated:YES];
        return;;
    }
}
#pragma mark 抢单 转单  提货核销  参数齐全
-(void)qiangOrder:(LLGoodModel *)model :(NSString *)name{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:model.orderNo forKey:@"orderNo"];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    [params setValue:lat forKey:@"latitude"];
    [params setValue:lng forKey:@"longitude"];
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
        [self getData:NO];
    } failure:^(NSError * _Nonnull error) {
        if([name isEqual:@"抢单"]){
            [JXUIKit showSuccessWithStatus:@"来晚了，已被抢走了哦"];
            if(self.tapAction){
                self.tapAction();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
  
    
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"订单详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top + CGFloatBasedI375(59));
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.bottomView.mas_top).offset(0);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(DeviceXTabbarHeigh(50));
        make.bottom.mas_equalTo(0);
    }];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.status == RoleStatusWaitOrder || self.status == RoleStatusDoneOrder || self.status== RoleStatusTransOrder) {
        return 4;
    }
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.status == RoleStatusWaitOrder  || self.status == RoleStatusDoneOrder){
        if(section == 3){
            return 3;
        }
    }else if(self.status == RoleStatusDoneOrder){
        if(section == 3){
            return 2;
        }
    }else if(self.status == RoleStatusHadOrder){
        if(section == 5){
            return 3;
        }
    }else if(self.status == RoleStatusTransOrder){
        if(section == 3){
            return 4;
        }
    }
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.status == RoleStatusWaitOrder || self.status == RoleStatusDoneOrder || self.status == RoleStatusTransOrder) {
        if (indexPath.section == 0) {
            LLStockOrderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockOrderDetailTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }else if (indexPath.section == 1){
            LlStockReceiveAdresstablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlStockReceiveAdresstablecell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }else if (indexPath.section == 2){
            LLStockGoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockGoodsListTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }
        LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.status == RoleStatusHadOrder){
            if(indexPath.row == 0){
                cell.leftStr = @"订单编号";
                cell.rightStr = self.model.orderNo;
            }else if(indexPath.row == 1){
                cell.leftStr = @"客户备注";
                cell.rightStr = self.model.remarks.length <= 0?@"无":self.model.remarks;
            }
        }else if(self.status == RoleStatusTransOrder){
            if(indexPath.row == 0){
                cell.leftStr = @"订单编号";
                cell.rightStr = self.model.orderNo;
            }else if(indexPath.row == 1){
                cell.leftStr = @"抢单时间";
                cell.rightStr = self.model.taskTime;
            }else if(indexPath.row == 2){
                cell.leftStr = @"转单时间";
                cell.rightStr = self.model.cancelTime.length <= 0?@"无":self.model.cancelTime;
            }else if(indexPath.row == 3){
                cell.leftStr = @"客户备注";
                cell.rightStr = self.model.remarks.length <= 0?@"无":self.model.remarks;
            }
        }else if(self.status == RoleStatusWaitOrder){
            if(indexPath.row == 0){
                cell.leftStr = @"配送编号";
                cell.rightStr = self.model.orderNo;
            }else if(indexPath.row == 1){
                cell.leftStr = @"下单时间";
                cell.rightStr = self.model.createTime;
            }else if(indexPath.row == 2){
                cell.leftStr = @"客户备注";
                cell.rightStr = self.model.remarks.length <= 0?@"无":self.model.remarks;
            }
        }else{
            if(indexPath.row == 0){
                cell.leftStr = @"配送编号";
                cell.rightStr = self.model.orderNo;
            }else if(indexPath.row == 1){
                cell.leftStr = @"下单时间";
                cell.rightStr = self.model.createTime;
            }else if(indexPath.row == 2){
                cell.leftStr = @"抢单时间";
                cell.rightStr = self.model.taskTime;
            }else if(indexPath.row == 3){
                cell.leftStr = @"客户备注";
                cell.rightStr = self.model.remarks.length <= 0?@"无":self.model.remarks;
            }
        }
        return cell;
    }
    
    //存在地图的情况
    if (indexPath.section == 0) {
        LLStockOrderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockOrderDetailTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 1){
        //展示地图的cell
        LLStockoOrderMapTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockoOrderMapTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.perimodel = self.model;
        return cell;
    }else if (indexPath.section == 2){
        LLStockoOrderTimeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockoOrderTimeTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 3){
        LlStockReceiveAdresstablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlStockReceiveAdresstablecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 4){
        LLStockGoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockGoodsListTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }
    LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 0){
        cell.leftStr = @"订单编号";
        cell.rightStr = self.model.orderNo;
    }else if(indexPath.row == 1){
        cell.leftStr = @"抢单时间";
        cell.rightStr = self.model.taskTime;
    }else if(indexPath.row == 2){
        cell.leftStr = @"客户备注";
        cell.rightStr = self.model.remarks.length <= 0?@"无":self.model.remarks;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.status == RoleStatusWaitOrder || self.status == RoleStatusDoneOrder || self.status == RoleStatusTransOrder) {
        if (section == 2) {
            return CGFloatBasedI375(117);
        }else if(section == 3){
            return CGFloatBasedI375(25);
        }
    }
    if (section == 4) {
        return CGFloatBasedI375(117);
    }else if(section == 5){
        return CGFloatBasedI375(25);
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.status == RoleStatusWaitOrder || self.status == RoleStatusTransOrder || self.status == RoleStatusDoneOrder) {
        if (section == 2) {
            LLStockOrderDetailFooterView *footerView = [[LLStockOrderDetailFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.model = self.model;
            return footerView;
        }else if (section == 3){
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.model = self.model;
            return  footerView;
        }
    }else{
        if (section == 4) {
            LLStockOrderDetailFooterView *footerView = [[LLStockOrderDetailFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.model = self.model;
            return footerView;
        }else if (section == 5){
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.model = self.model;
            return  footerView;
        }
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.status == RoleStatusWaitOrder || self.status == RoleStatusTransOrder || self.status == RoleStatusDoneOrder) {
        if (section == 2 || section == 3) {
            return CGFloatBasedI375(44);
        }
    }
    if (section == 4 || section == 5) {
        return CGFloatBasedI375(44);
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.status == RoleStatusWaitOrder || self.status == RoleStatusDoneOrder || self.status == RoleStatusTransOrder) {
        if (section == 2 || section == 3) {
            LLMeOrderDetailTitleView *titleView = [[LLMeOrderDetailTitleView alloc]initWithFrame:tableView.tableHeaderView.frame];
            titleView.titleStr = section == 2 ? @"商品信息" : @"订单信息";
            return titleView;
        }
    }
    if (section == 4 || section == 5) {
        LLMeOrderDetailTitleView *titleView = [[LLMeOrderDetailTitleView alloc]initWithFrame:tableView.tableHeaderView.frame];
        titleView.titleStr = section == 4 ? @"商品信息" : @"订单信息";
        return titleView;
    }
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top + CGFloatBasedI375(59), SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLStockOrderDetailTableCell class] forCellReuseIdentifier:@"LLStockOrderDetailTableCell"];
        [_tableView registerClass:[LlStockReceiveAdresstablecell class] forCellReuseIdentifier:@"LlStockReceiveAdresstablecell"];
        [_tableView registerClass:[LLStockGoodsListTableCell class] forCellReuseIdentifier:@"LLStockGoodsListTableCell"];
        [_tableView registerClass:[LlmeOrderDetailOrderInfoTableCell class] forCellReuseIdentifier:@"LlmeOrderDetailOrderInfoTableCell"];
        [_tableView registerClass:[LLStockoOrderTimeTableCell class] forCellReuseIdentifier:@"LLStockoOrderTimeTableCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[LLStockoOrderMapTableCell class] forCellReuseIdentifier:@"LLStockoOrderMapTableCell"];

        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(LLStockOrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [[LLStockOrderDetailTopView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, CGFloatBasedI375(59))];
    }
    return _topView;
}
-(LLStockOrderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLStockOrderBottomView alloc]init];
        WS(weakself);
        _bottomView.tapAction = ^(LLGoodModel * _Nonnull model, NSString * _Nonnull name) {
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
            }else if([name isEqual:@"查看佣金"]){
                LLMeDeliverCommissionRecordVC *vc = [[LLMeDeliverCommissionRecordVC alloc]init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                [weakself qiangOrder:model :name];
            }

        };
    }
    return _bottomView;
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
