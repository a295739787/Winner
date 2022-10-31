//
//  LLBuybackRecordController.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLBuybackRecordController.h"
#import "LLBuyBackView.h"
#import "LLMeBuyBackTableCell.h"
#import "LLBuybackRecordDetailVC.h"
#import "LLBackBuyModel.h"

@interface LLBuybackRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLBuybackRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"回购记录";
    [self.view addSubview:self.tableView];
    
    [self requestUrl];
}

-(void)header{
    self.currentPage = 1;
    [self requestUrl];
}
-(void)footer{
    self.currentPage ++;
    [self requestUrl];
}

#pragma mark--requestUrl
-(void)requestUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
//    [params setObject:@"" forKey:@"sidx"];
    WS(weakself);
    [XJHttpTool post:L_BackBuyListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
//        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if (weakself.currentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        
        LLBackBuyModel *model = [LLBackBuyModel yy_modelWithJSON:responseObj[@"data"]];
        
        for (LLBackBuyListModel *listModel in model.list) {
            [self.dataArray addObject:listModel];
        }
        
        if(model.list.count < 10 ){
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
    }];
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLBuybackRecordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBuybackRecordTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listModel = self.dataArray[indexPath.section];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(54);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLBuybackRecordHeaderView *headerView = [[LLBuybackRecordHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
    LLBackBuyListModel *listModel = self.dataArray[section];
    headerView.textLabel.text = listModel.createTime;
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > 0) {
        LLBackBuyListModel *listModel = self.dataArray[indexPath.section];
        LLBuybackRecordDetailVC *detailVC = [[LLBuybackRecordDetailVC alloc]init];
        detailVC.ID = listModel.ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(LLBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLBuybackRecordTableCell class] forCellReuseIdentifier:@"LLBuybackRecordTableCell"];
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
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
