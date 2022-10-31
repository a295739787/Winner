//
//  LLSurpriseRegBagRecordViewController.m
//  Winner
//
//  Created by mac on 2022/2/7.
//

#import "LLSurpriseRegBagRecordViewController.h"
#import "LLSurpriseRegBagRecordViewCell.h"
#import "LLSurpriseRegBagRecordDetailViewController.h"
static NSString *const LLSurpriseRegBagRecordViewCellid = @"LLSurpriseRegBagRecordViewCell";

@interface LLSurpriseRegBagRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/

@end

@implementation LLSurpriseRegBagRecordViewController
-(void)dealloc{
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"购买记录";
    self.page = 1;
    if(_isRoot == YES){
        self.disableDragBack = YES;
    }
    [self getDatas:YES];
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.isRoot == YES){
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
        
    };
}
-(void)header{
    self.page = 1;
    [self  getDatas:NO];
}
-(void)footer{
    self.page ++;
    [self  getDatas:NO];
}
-(void)getDatas:(BOOL)isshow{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"" forKey:@"keyword"];
    [param setValue:@"" forKey:@"sidx"];
    [param setValue:@"" forKey:@"sort"];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:@(self.page) forKey:@"currentPage"];
    if(isshow){
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
  
    [XJHttpTool post:FORMAT(@"%@",L_apiappredgoodsgetList) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        if(isshow){
            [self setLayout];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];
        if(self.page ==1){
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:data[@"list"]];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            self.tableView.mj_header.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
            self.tableView.mj_header.hidden = NO;
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)setLayout{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(SCREEN_top);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(154);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = [UIColor clearColor];
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(0.001))];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLSurpriseRegBagRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLSurpriseRegBagRecordViewCellid];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView.hidden = YES;
    cell.datas = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLSurpriseRegBagRecordDetailViewController *vc = [[LLSurpriseRegBagRecordDetailViewController alloc]init];
    vc.tagIndex = indexPath.row;
    NSDictionary *dic= self.dataArr[indexPath.row];
    vc.ID = FORMAT(@"%@",dic[@"id"]);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLSurpriseRegBagRecordViewCell class] forCellReuseIdentifier:LLSurpriseRegBagRecordViewCellid];
        [self.view addSubview:self.tableView];
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
