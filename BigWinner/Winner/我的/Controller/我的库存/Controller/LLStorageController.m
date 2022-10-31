//
//  LLStorageController.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLStorageController.h"
#import "LLStorageTableCell.h"
#import "LLPlaceOrderController.h"
#import "LLStorageModel.h"

@interface LLStorageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLStorageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    _currentPage = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"我的库存";
    [self.view addSubview:self.tableView];
    
    [self getRequestUrl:YES];
}
-(void)header{
    self.currentPage = 1;
    [self getRequestUrl:NO];
}
-(void)footer{
    self.currentPage ++;
    [self getRequestUrl:NO];
}
#pragma mark--getRequestUrl
-(void)getRequestUrl:(BOOL)isLoad{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"sort" forKey:@"sidx"];
    WS(weakself);
    if(isLoad){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [XJHttpTool post:L_StorageUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSString *code = responseObj[@"code"];
        
        if ([code intValue] == 200) {
            
            if (weakself.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            NSLog(@"responseObj == %@",responseObj[@"data"]);
            LLStorageModel *model = [LLStorageModel yy_modelWithJSON:responseObj[@"data"]];
            
            for (LLStorageListModel *listModel in model.list) {
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLStorageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStorageTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    LLStorageListModel *listModel = self.dataArray[indexPath.row];
    cell.listModel = listModel;
    WS(weakself);
    cell.storageBtnBlock = ^(NSString * _Nonnull ID) {
        if(ID.length <= 0){
            return;;
        }
        LLPlaceOrderController *orderVC = [[LLPlaceOrderController alloc]init];
        orderVC.ID = ID;
        [weakself.navigationController pushViewController:orderVC animated:YES];
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(LLBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLStorageTableCell class] forCellReuseIdentifier:@"LLStorageTableCell"];
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

