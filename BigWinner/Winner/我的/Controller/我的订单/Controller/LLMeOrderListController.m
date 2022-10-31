//
//  LLMeOrderListController.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeOrderListController.h"
#import "LLMeOrderListTableCell.h"
#import "LLMeOrderheaderView.h"
#import "LLMeOrderListModel.h"
#import "LLMeOrderDetailController.h"
#import "LLStorePayViewController.h"
#import "LLMeAdressView.h"
#import "LLOrderAppltBillController.h"
#import "LLEvaulateViewController.h"
#import "LLShouHouApplyViewController.h"
#import "LLOrderApplyBillStatusConoller.h"
#import "LLTabbarPeisongViewController.h"
#import "LLStockOrderDetailController.h"
#import "LLOrderDeliverViewController.h"

@interface LLMeOrderListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIView *buttonlineview;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *headerbtn;
@property (nonatomic,strong) NSMutableArray *arrbtn;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong) LLMeOrderListModel *tempMpdel;/** <#class#> **/

@property (nonatomic,strong)LLMeAdressDeleteView *refundView;
@property (nonatomic,strong)LLMeAdressDeleteView *confirmView;
@property (nonatomic,strong)LLMeAdressDeleteView *cancleView;
@property (nonatomic,strong)LLMeAdressDeleteView *deleteView;

@end

@implementation LLMeOrderListController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"我的订单";
    self.currentPage = 1;
    [self createUI];
}

#pragma mark--createUI
-(void)createUI{
    [self creatbutton];
    self.view.backgroundColor = BG_Color;
    [self.view addSubview:self.tableView];
    if(self.payui){
        self.disableDragBack = YES;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(45)+SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom);
    }];
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.payui){
            if(weakself.status == RoleStatusStockPeisong){
                LLTabbarPeisongViewController *thirdVC=  [[LLTabbarPeisongViewController alloc]init];
                thirdVC.selectedIndex = 2;
                [UIApplication sharedApplication ].delegate.window.rootViewController =  thirdVC;
            }else{
                LLTabbarViewController *thirdVC=  [[LLTabbarViewController alloc]init];
                thirdVC.selectedIndex = 3;
                [UIApplication sharedApplication ].delegate.window.rootViewController =  thirdVC;
            }
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
    [self getOrderListUrl:YES];
}
#pragma mark - 创建界面
-(void)creatbutton{
    CGFloat btnWidth = SCREEN_WIDTH/5;
    NSArray *titlearr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    for (int i = 0; i < titlearr.count; i ++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnWidth,SCREEN_top,btnWidth,CGFloatBasedI375(44))];
        [btn setTitle:titlearr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [btn setTitleColor:Main_Color forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"#0A0A0A"] forState:UIControlStateNormal];
        btn.backgroundColor = White_Color;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if(_orderStatus == i){
            btn.selected = YES;
            _headerbtn = btn;
        }
        [self.arrbtn addObject:btn];
    }
    UIView *lineviews = [[UIView alloc]initWithFrame:CGRectMake(_headerbtn.centerX-CGFloatBasedI375(50/2), CGFloatBasedI375(44)+SCREEN_top, CGFloatBasedI375(50), CGFloatBasedI375(2))];
    lineviews.backgroundColor = Main_Color;
    [self.view addSubview:lineviews];
    _buttonlineview = lineviews;
    
    [self.view addSubview:_lineview];
}
-(void)btnClicked:(UIButton *)sender{
    for(UIButton *btn in self.arrbtn){
        btn.selected = NO;
    }
    self.currentPage = 1;
    sender.selected = YES;
    NSArray *da = @[@"",@"1",@"2",@"3",@"4"];
    _orderStatus = [[NSString stringWithFormat:@"%@",da[sender.tag]] integerValue];
    _buttonlineview.x =sender.centerX-CGFloatBasedI375(50/2);
    [self getOrderListUrl:NO];
}
-(void)header{
    self.tableView.mj_footer.hidden = NO;
    self.currentPage = 1;
    [self getOrderListUrl:NO];
}
-(void)footer{
    self.currentPage ++;
    [self getOrderListUrl:NO];
}

#pragma mark--getOrderListUrl
-(void)getOrderListUrl:(BOOL)isload{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if(self.orderStatus == 0){
        [params setObject:@"" forKey:@"orderStatus"];
    }else{
        [params setObject:@(self.orderStatus) forKey:@"orderStatus"];
    }
   
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:@"1" forKey:@"platform"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"" forKey:@"sort"];
    WS(weakself);
    if(isload){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }


    [XJHttpTool post:L_orderListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *code = responseObj[@"code"];
        NSDictionary *data = responseObj[@"data"];
        if ([code intValue] ==  200) {
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArr removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:[LLMeOrderListModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
            [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];

        }
        NSArray *list = data[@"list"];
        NSLog(@" list === %@",list);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        if(self.dataArray.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"暂无数据"];
        }else{
            [self.tableView removeEmptyView];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [weakself.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma mark 处理各种状态 去付款 查看物流
-(void)dealWithFooter:(LLMeOrderFooterView *)footerview section:(NSInteger)section model:(LLMeOrderListModel *)model{
    WS(weakself);
    footerview.ActionBlock = ^(NSString * _Nonnull tagName, LLMeOrderListModel * _Nonnull orderModel) {
        weakself.tempMpdel = model;
        if([tagName isEqual:@"去付款"]){
            LLStorePayViewController *vc = [[LLStorePayViewController alloc]init];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:model.orderNo forKey:@"orderNo"];
            [param setValue:model.actualPrice forKey:@"payPrice"];
            [param setValue:model.stayPayTimestamp forKey:@"stayPayTimestamp"];
            vc.datas = param.mutableCopy;//订单类型（1零售商品、2惊喜红包商品、3品鉴商品、4配送库存提货）
            if(orderModel.orderType.integerValue == 1){
                vc.status = RoleStatusStore;
            }else if(orderModel.orderType.integerValue == 2){
                vc.status = RoleStatusRedBag;
            }else if(orderModel.orderType.integerValue == 3){
                vc.status = RoleStatusPingjian;
            }
            [weakself.navigationController pushViewController:vc animated:YES];
        }else  if([tagName isEqual:@"取消订单"]){
            [weakself.cancleView show];
        }else  if([tagName isEqual:@"申请退款"]){
            if(model.stockNum > 0 ){
                LLShouHouApplyViewController *vc = [[LLShouHouApplyViewController alloc]init];
                vc.model = model;
                vc.tagIndex = 0;
              
                vc.tapAction = ^{
                    weakself.currentPage = 1;
                    [weakself getOrderListUrl:NO];
                };
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                [weakself.refundView show];
            }
         
   
        }else if ([tagName isEqual:@"确认收货"]){
            [UIAlertController showAlertViewWithTitle:@"是否确认收货" Message:@"确认收货后将不能退货退款" BtnTitles:@[@"取消",@"确认"] ClickBtn:^(NSInteger index) {
                if(index == 1){
                    [weakself postDeal:tagName model:model];
                }
                
            }];
        }else if ([tagName isEqual:@"查看物流"]){
            LLOrderDeliverViewController *vc = [[LLOrderDeliverViewController alloc]init];
            vc.orderNo = model.orderNo;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([tagName isEqual:@"申请售后"]){
            LLShouHouApplyViewController *vc = [[LLShouHouApplyViewController alloc]init];
            vc.model = model;
            vc.tagIndex = 0;
            if(model.orderType.integerValue == 2 || model.stockNum > 0 ){
                vc.ShowKucu = YES;
            }
            vc.tapAction = ^{
                weakself.currentPage = 1;
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:vc animated:YES];
        }else if ([tagName isEqual:@"去评价"]){
            LLEvaulateViewController *evaluateVC = [[LLEvaulateViewController alloc]init];
            evaluateVC.model = model;
            evaluateVC.tapAction = ^{
                weakself.currentPage = 1;
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:evaluateVC animated:YES];
            
        }else if ([tagName isEqual:@"申请开票"] || [tagName isEqual:@"开票中"]|| [tagName isEqual:@"已开票"]|| [tagName isEqual:@"开票不通过"]){
            [weakself getorderBillDetail:orderModel];
        }else if ([tagName isEqual:@"删除订单"]){
            [weakself.deleteView show];
        }else if ([tagName isEqual:@"查看详情"]){
            LLMeOrderDetailController *detailVC = [[LLMeOrderDetailController alloc]init];
            detailVC.orderNo = model.orderNo;
            WS(weakself);
            detailVC.tapAction = ^{
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:detailVC animated:YES];
        }else if ([tagName isEqual:@"联系配送员"]){
            if(model.shopTelePhone.length > 0){
                    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.shopTelePhone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }else{
                    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.clerkTelePhone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }
        }else if ([tagName isEqual:@"联系推广点"]){
            if(model.shopTelePhone.length > 0){
                    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.shopTelePhone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }else{
                    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.clerkTelePhone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }
            NSLog(@"model.shopTelePhone == %@  model.clerkTelePhone==%@",model.shopTelePhone,model.clerkTelePhone);
       
        }
    };
}


-(void)postDeal:(NSString *)name model:(LLMeOrderListModel *)model{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *url;
    if([name isEqual:@"确认收货"]){
        url = FORMAT(@"%@/%@",L_apiapporderconfirmReceive,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"删除订单"]){
        url = FORMAT(@"%@/%@",L_apiapporderdelete,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"取消订单"]){
        url = FORMAT(@"%@/%@",L_apiappordercancel,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"申请退款"]){
        url = FORMAT(@"%@",L_apiapporderafterapply);
        [params setValue:model.orderNo forKey:@"orderNo"];
        [params setValue:@"1" forKey:@"afterType"];//售后类型(1退款，2退款退货，3库存补发)
        [params setValue:@"1" forKey:@"logisticStatus"];
        [params setValue:@"1" forKey:@"refundReason"];
    }
    [XJHttpTool post:url method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        self.currentPage = 1;
        [self getOrderListUrl:NO];
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
#pragma mark--获取开票详情
-(void)getorderBillDetail:(LLMeOrderListModel *)model{
    //开票状态（1未开票，2开票中，3已开票，4不通过）
    if ([model.invoiceStatus intValue] == 1 || [model.invoiceStatus intValue] == 0) {
        //未开票
        LLOrderAppltBillController *applyVC = [[LLOrderAppltBillController alloc]init];
        applyVC.orderNo = model.orderNo;
        applyVC.invoiceStatus = model.invoiceStatus;
//        applyVC.datas = model.appOrderListGoodsVos;
        applyVC.model = model;
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if ([model.invoiceStatus intValue] == 2 || [model.invoiceStatus intValue] == 3){
        //开票中
        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
        statusVc.orderNo = model.orderNo;
        
        [self.navigationController pushViewController:statusVc animated:YES];
    }else if ([model.invoiceStatus intValue] == 2){
        //开票中
        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
        statusVc.orderNo = model.orderNo;
        statusVc.invoiceStatus = model.invoiceStatus;
        [self.navigationController pushViewController:statusVc animated:YES];
    }
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LLMeOrderListModel *orderModel = self.dataArray[section];
    return orderModel.appOrderListGoodsVos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMeOrderListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.dataArray.count){
        LLMeOrderListModel *orderModel = self.dataArray[indexPath.section];
        cell.faModel = orderModel;
//        NSDictionary *dict = orderModel.appOrderListGoodsVos[indexPath.row];
//        LLMeOrderListModel *appOrderListGoodsVo = [LLMeOrderListModel mj_objectWithKeyValues:dict];
        cell.model =  orderModel.appOrderListGoodsVos[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    LLMeOrderListModel *orderModel = self.dataArray[section];
    if(orderModel.orderType.integerValue == 2){//库存提货  惊喜红包下单的
        if(orderModel.orderStatus.integerValue == 2 || orderModel.orderStatus.integerValue == 5){//待发货  售后中
           return CGFloatBasedI375(10);
        }
        return CGFloatBasedI375(64);
    }
    return CGFloatBasedI375(88);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLMeOrderListModel *orderModel = self.dataArray[section];
//    if(orderModel.orderType.integerValue == 2){//库存提货  惊喜红包下单的
//        if(orderModel.orderStatus.integerValue == 2){//待发货
//            return nil;
//        }
//    }
    LLMeOrderFooterView *footerView = [[LLMeOrderFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.orderModel = orderModel;
    [self dealWithFooter:footerView section:section model:orderModel ];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(54);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLMeOrderheaderView *headerView = [[LLMeOrderheaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
    LLMeOrderListModel *orderModel = self.dataArray[section];
    headerView.orderModel = orderModel;
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > 0) {
        LLMeOrderListModel *orderModel = self.dataArray[indexPath.section];
//        if ([orderModel.orderType intValue] == 3 && [orderModel.taskStatus intValue] == 5) {//已转单
//            LLStockOrderDetailController *detailVC = [[LLStockOrderDetailController alloc]init];
//            detailVC.orderNo = orderModel.orderNo;
//            [self.navigationController pushViewController:detailVC animated:YES];
//        }else{
            LLMeOrderDetailController *detailVC = [[LLMeOrderDetailController alloc]init];
            detailVC.orderNo = orderModel.orderNo;
            WS(weakself);
            detailVC.tapAction = ^{
                [weakself getOrderListUrl:NO];
            };
            [self.navigationController pushViewController:detailVC animated:YES];
//        }
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(40)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeOrderListTableCell class] forCellReuseIdentifier:@"LLMeOrderListTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _tableView.mj_footer = footer;
        adjustsScrollViewInsets_NO(_tableView, self);
    }
    return _tableView;
}
-(LLMeAdressDeleteView *)refundView{
    if (!_refundView) {
        _refundView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _refundView.titleStr = @"申请退款";
        _refundView.textStr = @"确认要对该笔订单订单申请退款吗？申请\n后退款将在1-3个工作日原路返回";
        _refundView.rightStr = @"确定";
        WS(weakself);
        _refundView.deleteBtnBlock = ^{
            [weakself postDeal:@"申请退款" model:weakself.tempMpdel];
        };
    }
    return _refundView;
}
-(LLMeAdressDeleteView *)confirmView{
    if (!_confirmView) {
        _confirmView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _refundView.titleStr = @"确认收货";
        _confirmView.textStr = @"是否确认收货";
        _confirmView.rightStr = @"确定";
        WS(weakself);
        _confirmView.deleteBtnBlock = ^{
            [weakself postDeal:@"确认收货" model:weakself.tempMpdel];
        };
    }
    return _confirmView;
}
-(LLMeAdressDeleteView *)cancleView{
    if (!_cancleView) {
        _cancleView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _cancleView.titleStr = @"取消订单";
        _cancleView.textStr = @"是否取消订单";
        _cancleView.rightStr = @"确定";
        WS(weakself);
        _cancleView.deleteBtnBlock = ^{
            [weakself postDeal:@"取消订单" model:weakself.tempMpdel];
        };
    }
    return _cancleView;
}
-(LLMeAdressDeleteView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _deleteView.titleStr = @"删除订单";
        _deleteView.textStr = @"是否删除订单";
        _deleteView.rightStr = @"确定";
        WS(weakself);
        _deleteView.deleteBtnBlock = ^{
            [weakself postDeal:@"删除订单" model:weakself.tempMpdel];
        };
    }
    return _deleteView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)arrbtn{
    if(!_arrbtn){
        _arrbtn = [NSMutableArray array];
    }
    return _arrbtn;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
