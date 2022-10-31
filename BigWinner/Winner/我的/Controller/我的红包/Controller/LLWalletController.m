//
//  LLWalletController.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLWalletController.h"
#import "LLWalletHeaderView.h"
#import "LLWalletListTableCell.h"
#import "LLWalletDrawController.h"
#import "LLWalletListModel.h"

@interface LLWalletController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLWalletHeaderView *topView;
@property (nonatomic,strong)LLWalletSelectView *selectView;
@property (nonatomic,strong)UITableView *tableView;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)LLPersonalModel *personalModel;

@property (assign, nonatomic) NSInteger mode;


@end

@implementation LLWalletController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getPersonalUrl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    self.currentPage = 1;
    if(_type.length== 0){
         self.type = @"1";
    }
    self.view.backgroundColor = UIColorFromRGB(0xF0EFED);
    self.customNavBar.title = @"我的钱包";
    [self.view addSubview:self.topView];
    self.topView.type = _type.integerValue;
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.tableView];
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.selectView.mas_bottom).equalTo(0);
        make.left.equalTo(CGFloatBasedI375(10));
        make.right.equalTo(-CGFloatBasedI375(10));
        make.bottom.equalTo(0);
    }];
    self.mode = 1;
    [self getListurl:1];
}
-(void)header{
    self.currentPage = 1;
    [self getListurl:self.mode];
}
-(void)footer{
    self.currentPage ++;
    [self getListurl:self.mode];
}
#pragma mark--获取钱包余额
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    WS(weakself);
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        weakself.personalModel = [LLPersonalModel mj_objectWithKeyValues:data];
        if(weakself.type.integerValue == 2){
            weakself.topView.balance = weakself.personalModel.redBalance;
        }else{
           self.topView.balance = weakself.personalModel.balance;
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark--获取交易记录列表
-(void)getListurl:(NSInteger)mode{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    self.type = [self.type length] <= 0? @"" : self.type;
    [params setObject:self.type forKey:@"type"];
    [params setObject:@(mode) forKey:@"mode"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@(_currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"" forKey:@"sort"];
//    [JXUIKit showErrorWithStatus:params];
    WS(weakself);
    [XJHttpTool post:L_blanceListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        if (self.currentPage == 1) {
            [self.dataArray removeAllObjects];
        }
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];
        [self.dataArray addObjectsFromArray:[LLWalletListModel mj_objectArrayWithKeyValuesArray:list]];
        
//        for (NSDictionary *dict in list) {
//            LLWalletListModel *listModel = [LLWalletListModel mj_objectWithKeyValues:dict];
//            [self.dataArray addObject:listModel];
//        }
        if(list.count < 10 ){
            self.tableView.mj_header.hidden = YES;
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_header.hidden = NO;
            self.tableView.mj_footer.hidden = NO;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
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
//    return 30;;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLWalletListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLWalletListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mode = self.mode;
    if (self.dataArray.count > 0) {
        cell.listModel = self.dataArray[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(70);
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLWalletListTableCell class] forCellReuseIdentifier:@"LLWalletListTableCell"];
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



#pragma mark--lazy
-(LLWalletHeaderView *)topView{
    if (!_topView) {
        _topView = [[LLWalletHeaderView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, CGFloatBasedI375(173))];
        WS(weakself);
        _topView.walletBtnBlock = ^(NSInteger btnTag,NSString *name) {
            if (btnTag == 100) {
                //钱包余额
                weakself.type = @"1";
                weakself.currentPage = 1;
                [weakself getListurl:weakself.mode];
                weakself.topView.balance = weakself.personalModel.balance;
            }else if (btnTag == 200){
                //消费红包
                weakself.type = @"2";
                weakself.currentPage = 1;
                [weakself getListurl:weakself.mode];
                weakself.topView.balance = weakself.personalModel.redBalance;
            }else{
                
                if([name isEqual:@"提现"]){
                    LLWalletDrawController *drawVC = [[LLWalletDrawController alloc]init];
                    drawVC.clickTap = ^{
                        weakself.type = @"1";
                        weakself.currentPage = 1;
                        [weakself getPersonalUrl];
                        [weakself getListurl:weakself.mode];
                    };
                    [weakself.navigationController pushViewController:drawVC animated:YES];
                }else{
                    LLTabbarViewController *thirdVC=  [[LLTabbarViewController alloc]init];
                    thirdVC.selectedIndex = 1;
                    [UIApplication sharedApplication ].delegate.window.rootViewController =  thirdVC;
                }
              
            }
        };
    }
    return _topView;
}
-(LLWalletSelectView *)selectView{
    if (!_selectView) {
        _selectView = [[LLWalletSelectView alloc]initWithFrame:CGRectMake(0, SCREEN_top + CGFloatBasedI375(173), SCREEN_WIDTH, CGFloatBasedI375(50))];
        WS(weakself);
        _selectView.modeTypeBlock = ^(NSInteger modetype) {
            [weakself.dataArray removeAllObjects];
            weakself.mode = modetype;
            weakself.currentPage = 1;
            [weakself getListurl:modetype];
        };
    }
    return _selectView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
