//
//  LLMePromoteVC.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLMePromoteVC.h"
#import "LLMePromoteView.h"
#import "LLMePromoteListTableCell.h"
#import "LLMePromoteDetailVC.h"
#import "PromoteTeamModel.h"
#import "PromoteUserListModel.h"
#import "LLMeTopView.h"

@interface LLMePromoteVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLMePromoteView *headerView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)LLMeCommissionNoteView *commissinNoteView;

@property (assign, nonatomic) NSInteger currentPage;


@end

@implementation LLMePromoteVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _currentPage = 1;
    [self getTeamCountUrl];
    [self getTeamUserListUrl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"我的推广";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top + CGFloatBasedI375(180));
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom);
    }];
}
-(void)header{
    self.currentPage = 1;
    [self getTeamUserListUrl];
}
-(void)footer{
    self.currentPage ++;
    [self getTeamUserListUrl];
}

#pragma mark--推广用户统计
-(void)getTeamCountUrl{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    WS(weakself);
    [XJHttpTool post:L_promoteTeamUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSDictionary *data = responseObj[@"data"];
        PromoteTeamModel *teamModel = [PromoteTeamModel mj_objectWithKeyValues:data];
        weakself.headerView.teamModel = teamModel;
            
        } failure:^(NSError * _Nonnull error) {
            
    }];
}
-(void)getTeamUserListUrl{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"asc" forKey:@"sort"];
    WS(weakself);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [XJHttpTool post:L_promoteUserListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (self.currentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];
        
        for (NSDictionary *dict in list) {
            PromoteUserListModel *listModel = [PromoteUserListModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:listModel];
        }
        
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
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
-(void)clickTap:(UIButton *)sender{
    
    self.commissinNoteView.content = self.content;
    [self.commissinNoteView show];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMePromoteListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMePromoteListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        cell.listModel = self.dataArray[indexPath.row];
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > 0) {
//        PromoteUserListModel *listModel = self.dataArray[indexPath.row];
//        LLMePromoteDetailVC *detailVC = [[LLMePromoteDetailVC alloc]init];
//        detailVC.userId = listModel.userId;
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top + CGFloatBasedI375(180), SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top  - CGFloatBasedI375(180)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMePromoteListTableCell class] forCellReuseIdentifier:@"LLMePromoteListTableCell"];
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
-(LLMePromoteView *)headerView{
    if (!_headerView) {
        _headerView = [[LLMePromoteView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, CGFloatBasedI375(190))];
        WS(weakself);
        [_headerView.sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        _headerView.promoteBlock = ^{
            LLMePromoteDetailVC *detailVC = [[LLMePromoteDetailVC alloc]init];
            NSLog(@"user_id == %@",[UserModel sharedUserInfo].userId);
//            [UserModel sharedUserInfo].userId;
            detailVC.userId = @"";
            [weakself.navigationController pushViewController:detailVC animated:YES];
        };
    }
    return _headerView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(LLMeCommissionNoteView *)commissinNoteView{
    if (!_commissinNoteView) {
        _commissinNoteView = [[LLMeCommissionNoteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _commissinNoteView.LLCommissionNoteBlock = ^{
  
        };
    }
    return _commissinNoteView;
}

@end
