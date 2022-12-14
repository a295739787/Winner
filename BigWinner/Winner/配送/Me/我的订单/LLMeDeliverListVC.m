//
//  LLMeDeliverListVC.m
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import "LLMeDeliverListVC.h"
#import "LLMeOrderListTableCell.h"
#import "LLMeOrderheaderView.h"
#import "LLMeOrderListModel.h"
#import "LLStockOrderDetailController.h"
#import "LLMeAdressView.h"
#import "LLMeOrderDetailController.h"
#import "LLTabbarPeisongViewController.h"
#import "LLOrderDeliverViewController.h"
#import "LLMeAdressView.h"
#import "LLOrderAppltBillController.h"
#import "LLOrderApplyBillStatusConoller.h"
#import "LLOrderApplyBillStatusConoller.h"
#import "LLEvaulateViewController.h"
@interface LLMeDeliverListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong) LLMeOrderListModel *tempMpdel;/** <#class#> **/

@property (nonatomic,strong)LLMeAdressDeleteView *refundView;

@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIView *buttonlineview;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *headerbtn;
@property (nonatomic,strong) NSMutableArray *arrbtn;
@property (nonatomic,strong)LLMeAdressDeleteView *cancleView;
@property (nonatomic,strong)LLMeAdressDeleteView *deleteView;

@end

@implementation LLMeDeliverListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.disableDragBack = YES;
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.payui){
            LLTabbarPeisongViewController *thirdVC=  [[LLTabbarPeisongViewController alloc]init];
            thirdVC.selectedIndex = 2;
            [UIApplication sharedApplication ].delegate.window.rootViewController =  thirdVC;
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
}

#pragma mark--createUI
-(void)createUI{
    [self creatbutton];
    self.view.backgroundColor = BG_Color;
    [self.view addSubview:self.tableView];
    self.customNavBar.title = @"????????????";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(45)+SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom);
    }];
    
    [self getOrderListUrl:NO];

}
#pragma mark - ????????????
-(void)creatbutton{
    CGFloat btnWidth = SCREEN_WIDTH/4;
    NSArray *titlearr = @[@"??????",@"?????????",@"?????????",@"?????????"];
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
        if(_index == i){
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
    NSLog(@"arrbtn == %@",self.arrbtn);
    for(UIButton *btn in self.arrbtn){
        btn.selected = NO;
    }
    self.currentPage = 1;
    sender.selected = YES;
    NSArray *da = @[@"",@"2",@"3",@"7"];
    _orderStatus = [[NSString stringWithFormat:@"%@",da[sender.tag]] integerValue];
    _buttonlineview.x =sender.centerX-CGFloatBasedI375(50/2);
    [self getOrderListUrl:NO];
}
-(NSMutableArray *)arrbtn{
    if(!_arrbtn){
        _arrbtn = [NSMutableArray array];
    }
    return _arrbtn;
}
-(void)header{
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
    [params setObject:@"2" forKey:@"platform"];
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
        NSLog(@"responseObj == %@",data);
        if ([code intValue] ==  200) {
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArr removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:[LLMeOrderListModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
            [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];

        }
        NSArray *list = data[@"list"];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        if(self.dataArray.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"????????????"];
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
#pragma mark ?????????????????? ????????? ????????????
-(void)dealWithFooter:(LLMeOrderFooterView *)footerview section:(NSInteger)section model:(LLMeOrderListModel *)model{
    WS(weakself);
    footerview.ActionBlock = ^(NSString * _Nonnull tagName, LLMeOrderListModel * _Nonnull orderModel) {
        weakself.tempMpdel = model;
       if([tagName isEqual:@"????????????"]){
            [weakself.cancleView show];
        }else  if([tagName isEqual:@"????????????"]){
            [weakself.refundView show];
        }else if ([tagName isEqual:@"????????????"]){
            [UIAlertController showAlertViewWithTitle:@"???????????????????????????????????????" Message:@"" BtnTitles:@[@"??????",@"??????"] ClickBtn:^(NSInteger index) {
                if(index == 1){
                    [weakself postDeal:tagName model:model];
                }
                
            }];
        }else if ([tagName isEqual:@"????????????"]){
            LLOrderDeliverViewController *vc = [[LLOrderDeliverViewController alloc]init];
            vc.orderNo = model.orderNo;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([tagName isEqual:@"????????????"] || [tagName isEqual:@"?????????"]||[tagName isEqual:@"???????????????"]||[tagName isEqual:@"????????????"]||[tagName isEqual:@"???????????????"]){
            LLShouHouApplyViewController *vc = [[LLShouHouApplyViewController alloc]init];
            vc.model = model;
            vc.tagIndex = 0;
            if(model.orderType.integerValue == 2){
                vc.ShowKucu = YES;
            }
            vc.tapAction = ^{
                weakself.currentPage = 1;
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:vc animated:YES];
        }else if ([tagName isEqual:@"?????????"]){
            LLEvaulateViewController *evaluateVC = [[LLEvaulateViewController alloc]init];
            evaluateVC.model = model;
            evaluateVC.tapAction = ^{
                weakself.currentPage = 1;
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:evaluateVC animated:YES];
            
        }else if ([tagName isEqual:@"????????????"] || [tagName isEqual:@"?????????"]|| [tagName isEqual:@"?????????"]|| [tagName isEqual:@"???????????????"]){
            [weakself getorderBillDetail:orderModel];
        }else if ([tagName isEqual:@"????????????"]){
            [weakself.deleteView show];
        }else if ([tagName isEqual:@"????????????"]){
            LLMeOrderDetailController *detailVC = [[LLMeOrderDetailController alloc]init];
            detailVC.orderNo = model.orderNo;
            WS(weakself);
            detailVC.tapAction = ^{
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:detailVC animated:YES];
        }
    };
}

#pragma mark--??????????????????
-(void)getorderBillDetail:(LLMeOrderListModel *)model{
    //???????????????1????????????2????????????3????????????4????????????
    if ([model.invoiceStatus intValue] == 1 || [model.invoiceStatus intValue] == 0) {
        //?????????
        LLOrderAppltBillController *applyVC = [[LLOrderAppltBillController alloc]init];
        applyVC.orderNo = model.orderNo;
        applyVC.invoiceStatus = model.invoiceStatus;
//        applyVC.datas = model.appOrderListGoodsVos;
        applyVC.model = model;
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if ([model.invoiceStatus intValue] == 2 || [model.invoiceStatus intValue] == 3){
        //?????????
        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
        statusVc.orderNo = model.orderNo;
        
        [self.navigationController pushViewController:statusVc animated:YES];
    }else if ([model.invoiceStatus intValue] == 2){
        //?????????
        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
        statusVc.orderNo = model.orderNo;
        statusVc.invoiceStatus = model.invoiceStatus;
        [self.navigationController pushViewController:statusVc animated:YES];
    }
}
-(void)postDeal:(NSString *)name model:(LLMeOrderListModel *)model{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *url;
    if([name isEqual:@"????????????"]){
        url = FORMAT(@"%@/%@",L_apiapporderconfirmReceive,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"????????????"]){
        url = FORMAT(@"%@/%@",L_apiapporderdelete,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"????????????"]){
        url = FORMAT(@"%@/%@",L_apiappordercancel,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"????????????"]){
        url = FORMAT(@"%@",L_apiapporderafterapply);
        [params setValue:model.orderNo forKey:@"orderNo"];
        [params setValue:@"1" forKey:@"afterType"];//????????????(1?????????2???????????????3????????????)
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

    if(self.dataArray.count){
        LLMeOrderListModel *orderModel = self.dataArray[indexPath.section];
        cell.faModel = orderModel;
        cell.model =  orderModel.appOrderListGoodsVos[indexPath.row];
        cell.typeLabel.hidden = YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(88);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLMeOrderFooterView *footerView = [[LLMeOrderFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    LLMeOrderListModel *orderModel = self.dataArray[section];
    footerView.orderModel = orderModel;
    [self dealWithFooter:footerView section:section model:orderModel];
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
        LLMeOrderDetailController *detailVC = [[LLMeOrderDetailController alloc]init];
        detailVC.statues = RoleStatusStockPeisong;
        detailVC.orderNo = orderModel.orderNo;
        WS(weakself);
        detailVC.tapAction = ^{
            [weakself getOrderListUrl:NO];
        };
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(LLBaseTableView *)tableView{
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
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(LLMeAdressDeleteView *)refundView{
    if (!_refundView) {
        _refundView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _refundView.titleStr = @"????????????";
        _refundView.textStr = @"??????????????????????????????????????????????????????\n???????????????1-3????????????????????????";
        _refundView.rightStr = @"??????";
        WS(weakself);
        _refundView.deleteBtnBlock = ^{
            [weakself postDeal:@"????????????" model:weakself.tempMpdel];
        };
    }
    return _refundView;
}

-(LLMeAdressDeleteView *)cancleView{
    if (!_cancleView) {
        _cancleView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _cancleView.titleStr = @"????????????";
        _cancleView.textStr = @"??????????????????";
        _cancleView.rightStr = @"??????";
        WS(weakself);
        _cancleView.deleteBtnBlock = ^{
            [weakself postDeal:@"????????????" model:weakself.tempMpdel];
        };
    }
    return _cancleView;
}
-(LLMeAdressDeleteView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _deleteView.titleStr = @"????????????";
        _deleteView.textStr = @"??????????????????";
        _deleteView.rightStr = @"??????";
        WS(weakself);
        _deleteView.deleteBtnBlock = ^{
            [weakself postDeal:@"????????????" model:weakself.tempMpdel];
        };
    }
    return _deleteView;
}
@end
