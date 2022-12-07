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
#import "Winner-Swift.h"

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
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        
        if (weakself.popViewOption == popView) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    
    self.tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, self.customNavBar.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.height-49-[self safeAreaBottom]) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LLStorageTableCell class] forCellReuseIdentifier:@"LLStorageTableCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
    [header setRefreshingTarget:self refreshingAction:@selector(header)];
    self.tableView.mj_header = header;
    MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
    [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
    self.tableView.mj_footer = footer;
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self.view addSubview:self.tableView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 49+[self safeAreaBottom]);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];

    UIButton *bottomBindButton = [[UIButton alloc] init];
    bottomBindButton.frame = CGRectMake(15, 6, bottomView.frame.size.width-30, 37);
    [bottomBindButton setTitle:@"去绑卡" forState:(UIControlStateNormal)];
    [bottomBindButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    bottomBindButton.titleLabel.font = [UIFont systemFontOfSize:16];
    bottomBindButton.backgroundColor = [UIColor HexString:@"#D40006"];
    [bottomView addSubview:bottomBindButton];
    bottomBindButton.layer.masksToBounds = YES;
    bottomBindButton.layer.cornerRadius = 37/2;
    [bottomBindButton addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
#pragma mark-- 去绑定点击方法
-(void)buttonClick:(UIButton *)sender{
    
    XYBandLiquorCardViewController *vc = [[XYBandLiquorCardViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLStorageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStorageTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showOther = YES;
    LLStorageListModel *listModel = self.dataArray[indexPath.row];
    cell.listModel = listModel;
    WS(weakself);
    cell.storageBtnBlock = ^(NSString * _Nonnull ID) {
        if(ID.length <= 0){
            return;
        }
        LLPlaceOrderController *orderVC = [[LLPlaceOrderController alloc]init];
        orderVC.ID = ID;
        [weakself.navigationController pushViewController:orderVC animated:YES];
    };
     cell.rightBtnBlock = ^(LLStorageListModel * _Nonnull model) {
        
        XYLiquorCardDetailViewController *vc = [[XYLiquorCardDetailViewController alloc]init];
         vc.goodId = model.goodsId;
         vc.userId = [UserModel sharedUserInfo].userId;
         vc.status = @"1";
         vc.userType = @"1";
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [weakself presentViewController:vc animated:YES completion:nil];
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
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(CGFloat)safeAreaBottom{
 
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            
            return mainWindow.safeAreaInsets.bottom;
        }
        return 0.0;
    }
    return 0.0;
}

@end

