//
//  LLMeDeliverCommissionRecordVC.m
//  Winner
//
//  Created by YP on 2022/3/6.
//

#import "LLMeDeliverCommissionRecordVC.h"
#import "LLMeOrderListTableCell.h"
#import "LLMeDeliverOrderFooterView.h"
#import "LLStockOrderDetailController.h"
@interface LLMeDeliverCommissionRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (nonatomic,assign) NSInteger page;/** class **/

@end

@implementation LLMeDeliverCommissionRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self createUI];
    [self getDatas];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = UIColorFromRGB(0xF0EFED);
    self.customNavBar.title = @"任务佣金记录";
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom);
    }];
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:@"1" forKey:@"currentPage"];
    [param setValue:@"" forKey:@"keyword"];
    if(lat.length > 0 && lng.length > 0){
        [param setValue:lat forKey:@"latitude"];
        [param setValue:lng forKey:@"longitude"];
    }
    [param setValue:@"" forKey:@"sidx"];
    [param setValue:@"" forKey:@"sort"];//排序类型（升序：asc，降序：desc）
    [param setValue:@"4" forKey:@"taskStatus"];//接单状态（2待接单、3已接单、4已完成）
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
        [self.dataArr addObjectsFromArray:[LLMeOrderListModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
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
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LLGoodModel *model  = self.dataArr[section];
    return  model.appOrderListGoodsVos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMeOrderListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = 100;
    cell.faModel = self.dataArr[indexPath.section];
    LLGoodModel *model  = self.dataArr[indexPath.section];
    cell.issmodel = model.appOrderListGoodsVos[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLMeDeliverOrderFooterView *footerView = [[LLMeDeliverOrderFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.model = self.dataArr[section];
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(54);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLMeDeliverOrderHeaderView *headerView = [[LLMeDeliverOrderHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
    headerView.model = self.dataArr[section];
    return headerView;
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
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeOrderListTableCell class] forCellReuseIdentifier:@"LLMeOrderListTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
