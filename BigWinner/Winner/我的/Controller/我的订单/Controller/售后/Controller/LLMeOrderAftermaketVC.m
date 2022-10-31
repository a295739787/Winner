//
//  LLMeOrderAftermaketVC.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeOrderAftermaketVC.h"
#import "LLMeOrderheaderView.h"
#import "LLMeOrderListTableCell.h"
#import "LLOrderAftermakeDetailVC.h"
#import "LLShouHouApplyViewController.h"
#import "LLOrderDeliverViewController.h"
@interface LLMeOrderAftermaketVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (nonatomic,assign) NSInteger currentPage;/** class **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/

@end

@implementation LLMeOrderAftermaketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"售后";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(SCREEN_top);
    }];
    [self getOrderListUrl:YES];
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

    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:_platform.length <= 0?@"1":_platform forKey:@"platform"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"" forKey:@"sort"];
    WS(weakself);
    if(isload){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }

    [XJHttpTool post:L_apiapporderaftergetList method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *code = responseObj[@"code"];
        NSDictionary *data = responseObj[@"data"];
        NSLog(@"售后data == %@",data[@"list"]);
        if ([code intValue] ==  200) {
            if (self.currentPage == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:[LLMeOrderListModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];

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
        if(self.dataArr.count <= 0){
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
-(void)postDeal:(NSString *)name model:(LLMeOrderListModel *)model{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *url;
    if([name isEqual:@"删除记录"]){
        url = FORMAT(@"%@/%@",L_apiapporderaftergetdel,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }
    [XJHttpTool post:url method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        self.currentPage = 1;
        [self getOrderListUrl:NO];
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LLMeOrderListModel *model = self.dataArr[section];
    return model.appOrderListGoodsVos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMeOrderListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LLMeOrderListModel *model = self.dataArr[indexPath.section];
    cell.faModel = model;
    cell.model = model.appOrderListGoodsVos[indexPath.row];
    cell.typeLabel.hidden = YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(88);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLMeOrderAfterFooterView *footerView = [[LLMeOrderAfterFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.orderModel = self.dataArr[section];
    WS(weakself);
    footerView.ActionBlock = ^(NSString * _Nonnull tagName, LLMeOrderListModel * _Nonnull orderModel) {
        if([tagName isEqual:@"删除记录"]){
            [UIAlertController showAlertViewWithTitle:@"是否删除记录" Message:@"" BtnTitles:@[@"取消",@"确认"] ClickBtn:^(NSInteger index) {
                if(index == 1){
                    [weakself postDeal:tagName model:orderModel];
                }
                
            }];
        }else  if([tagName isEqual:@"取消售后"]){
            [UIAlertController showAlertViewWithTitle:@"提示" Message:@"取消售后将不能再次提交" BtnTitles:@[@"取消",@"确认"] ClickBtn:^(NSInteger index) {
                if(index == 1){
                    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
                        [params setValue:orderModel.orderNo forKey:@"orderNo"];
                    [XJHttpTool post: FORMAT(@"%@/%@",L_apiapporderaftercancel,orderModel.orderNo) method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
                        NSDictionary *data = responseObj[@"data"];
                        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
                        self.currentPage = 1;
                        [self getOrderListUrl:NO];
                    } failure:^(NSError * _Nonnull error) {
                        
                    }];
                }

            }];
          
        }else  if([tagName isEqual:@"重新申请"] || [tagName isEqual:@"查看详情"]){
            LLShouHouApplyViewController *detailVC = [[LLShouHouApplyViewController alloc]init];
            LLMeOrderListModel *model = orderModel;
            //售后状态(1待审核，2待收货 3已通过，4已拒绝)//货物状态（1未收到货，2已收到货）
            if(model.orderAfterStatus.integerValue == 2 && model.logisticStatus.integerValue == 2){
                detailVC.tagIndex = OrderRefundExpressState;
                detailVC.reasonStr = @"退款退货";
            }else{
                if(model.afterType.integerValue == 1){
                    detailVC.tagIndex = OrderRefundOnlyMonState;
                    detailVC.reasonStr = @"退款";
                }else if(model.afterType.integerValue == 2){
                    detailVC.tagIndex = OrderRefundBothMonState;
                    detailVC.reasonStr = @"退款退货";
                }else if(model.afterType.integerValue == 5){
                    detailVC.tagIndex = OrderRefundExpressState;
                    detailVC.reasonStr = @"退款退货";
                }else{
                    detailVC.tagIndex = OrderRefundStockState;
                    detailVC.reasonStr = @"库存补发";
                }
            }
            detailVC.model  = model;
            detailVC.orderNo = model.orderNo;
            WS(weakself);
            detailVC.tapAction = ^{
                weakself.currentPage = 1;
                [weakself getOrderListUrl:NO];
            };
            [weakself.navigationController pushViewController:detailVC animated:YES];
        }
       
    };
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLMeOrderheaderView *headerView = [[LLMeOrderheaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
    headerView.model = self.dataArr[section];
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLShouHouApplyViewController *detailVC = [[LLShouHouApplyViewController alloc]init];
    LLMeOrderListModel *model = self.dataArr[indexPath.section];
    //售后状态(1待审核，2待收货 3已通过，4已拒绝)//货物状态（1未收到货，2已收到货）
    if(model.orderAfterStatus.integerValue == 2 && (model.logisticStatus.integerValue == 2|| model.logisticStatus.integerValue == 1)){
        detailVC.tagIndex = OrderRefundExpressState;
        detailVC.reasonStr = @"退款退货";
    }else{
        if(model.afterType.integerValue == 1){
            detailVC.tagIndex = OrderRefundOnlyMonState;
            detailVC.reasonStr = @"退款";
        }else if(model.afterType.integerValue == 2){
            detailVC.tagIndex = OrderRefundBothMonState;
            detailVC.reasonStr = @"退款退货";
        }else if(model.afterType.integerValue == 5){
            detailVC.tagIndex = OrderRefundExpressState;
            detailVC.reasonStr = @"退款退货";
        }else{
            detailVC.tagIndex = OrderRefundStockState;
            detailVC.reasonStr = @"库存补发";
        }
    }
    detailVC.model  = model;
    detailVC.orderNo = model.orderNo;
    WS(weakself);
    detailVC.tapAction = ^{
        weakself.currentPage = 1;
        [weakself getOrderListUrl:NO];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
