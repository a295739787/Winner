//
//  LLPromiteListController.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLPromiteListController.h"
#import "LLMePromoteView.h"
#import "LLMePromoteListTableCell.h"
#import "PromoteDetailModel.h"

@interface LLPromiteListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (assign, nonatomic)NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLPromiteListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = BG_Color;
    [self.view addSubview:self.tableView];
    [self  getDetailLiatUrl:NO];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom);
    }];
}

-(void)header{
    self.currentPage = 1;
    [self getDetailLiatUrl:NO];
}
-(void)footer{
    self.currentPage ++;
    [self getDetailLiatUrl:NO];
}
-(void)setStatus:(NSInteger)status{
    _status = status;
    self.currentPage = 1;
    [self getDetailLiatUrl:NO];
    
}
#pragma mark--推广用户明细
-(void)getDetailLiatUrl:(BOOL)isLoad{
//    if(self.userId.length <= 0){
//        return;;
//    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (self.status == 0) {
        [params setObject:@"" forKey:@"status"];
    }else if(self.status == 1){
        [params setObject:@"2" forKey:@"status"];
    }
    else{
        [params setObject:@"1" forKey:@"status"];
    }
    
    [params setObject:@"" forKey:@"userId"];
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"asc" forKey:@"sort"];
    if(isLoad){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    WS(weakself);
    [XJHttpTool post:L_promoteDeatailUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (self.currentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];
        for (NSDictionary *dict in list) {
            PromoteDetailModel *listModel = [PromoteDetailModel mj_objectWithKeyValues:dict];
            [weakself.dataArray addObject:listModel];
        }
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PromoteDetailModel *listModel = self.dataArray[section];
    if ([listModel.status intValue] == 1) {
        //待结算
        return 3;
    }
    //已结算部分，已结算完成
    return 5;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMePromoteDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMePromoteDetailListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        PromoteDetailModel *listModel = self.dataArray[indexPath.section];
        
        NSString *orderNo = [listModel.orderNo length] > 0 ? listModel.orderNo : @"";
        NSString *createTime = [listModel.createTime length] > 0 ? listModel.createTime : @"";
        NSString *completeTime = [listModel.completeTime length] > 0 ? listModel.completeTime : @"";
        
        CGFloat buyPrice = [listModel.buyPrice floatValue];
        NSString *buyPriceStr = [NSString stringWithFormat:@"¥%.2f",buyPrice];
        
        CGFloat toBeActivatedPrice = [listModel.toBeActivatedPrice floatValue];
        NSString *toBeActivatedPriceStr = [NSString stringWithFormat:@"¥%.2f",toBeActivatedPrice];
        
        if ([listModel.status intValue] == 1) {
            //待结算
            cell.leftStr = @[@"订单编号",@"下单时间",@"下单金额"][indexPath.row];
            cell.rightStr = @[orderNo,createTime,buyPriceStr][indexPath.row];
        }else{
            cell.leftStr = @[@"订单编号",@"下单时间",@"完成时间",@"下单金额",@"待激活金额"][indexPath.row];
            cell.rightStr = @[orderNo,createTime,completeTime,buyPriceStr,toBeActivatedPriceStr][indexPath.row];
        }
        cell.indexRow = indexPath.row;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(30);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(35);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLPromoteFooterView *footerView = [[LLPromoteFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    PromoteDetailModel *listModel = self.dataArray[section];
    if (listModel) {
        footerView.listModel = listModel;
    }
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(90);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLPromoteHeaderView *headerView = [[LLPromoteHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
    PromoteDetailModel *listModel = self.dataArray[section];
    if (listModel) {
        headerView.listModel = listModel;
    }
    return headerView;
}

-(LLBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - SCREEN_Bottom) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMePromoteDetailListTableCell class] forCellReuseIdentifier:@"LLMePromoteDetailListTableCell"];
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

@end
