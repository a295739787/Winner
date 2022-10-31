//
//  LLMeBuyBackController.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeBuyBackController.h"
#import "LLMeBuyBackTableCell.h"
#import "LLBuyBackBuyController.h"
#import "LLBuybackRecordController.h"
#import "LLStorageModel.h"

@interface LLMeBuyBackController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLMeBuyBackController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    self.currentPage = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"回购中心";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(header) name:@"LLbuybackSuccessVC" object:nil];
    [self.customNavBar wr_setRightButtonWithTitle:@"回购记录" titleColor:UIColorFromRGB(0x443415)];
    WS(weakself);
    self.customNavBar.onClickRightButton = ^{
        LLBuybackRecordController *recordVC = [[LLBuybackRecordController alloc]init];
        [weakself.navigationController pushViewController:recordVC animated:YES];
    };
    
    [self.view addSubview:self.tableView];
    
    [self getRequestUrl];
}

-(void)header{
    self.currentPage = 1;
    [self getRequestUrl];
}
-(void)footer{
    self.currentPage ++;
    [self getRequestUrl];
}
#pragma mark
#pragma mark--getRequestUrl
-(void)getRequestUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@(self.currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"10" forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"sort" forKey:@"sidx"];
    WS(weakself);
    [XJHttpTool post:L_BackBuybackListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
//        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
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
    LLMeBuyBackTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeBuyBackTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listModel = self.dataArray[indexPath.row];
    WS(weakself);
    cell.buybackBtnBlock = ^(NSString * _Nonnull ID) {
        LLBuyBackBuyController *buyVC = [[LLBuyBackBuyController alloc]init];
        buyVC.ID = ID;
        [weakself.navigationController pushViewController:buyVC animated:YES];
        buyVC.tapAction = ^{
            [weakself getRequestUrl];
        };
    };
    
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
        [_tableView registerClass:[LLMeBuyBackTableCell class] forCellReuseIdentifier:@"LLMeBuyBackTableCell"];
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
