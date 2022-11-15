//
//  LLMainPeisongViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/3/4.
//

#import "LLStockPeisongViewController.h"
#import "LLStockPeisongCell.h"
#import "LLMainPeisongHeadView.h"
#import "Winner-Swift.h"
@interface LLStockPeisongViewController ()<UITableViewDelegate,UITableViewDataSource,LLStockPeisongDelegate>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/

@end

@implementation LLStockPeisongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"配送库存";
    [self setLayout];
    [self getDatas];
    
}
-(void)header{
    self.tableView.mj_footer.hidden = NO;
    self.page = 1;
    [self getDatas];
}
-(void)footer{
    self.page ++;
    [self getDatas];
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [XJHttpTool post:L_apiappjudgegoodsdiststockgetList method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];
        NSLog(@"list == %@",list);
        if(self.page == 1){
            [self.dataArr removeAllObjects];
         }
        
        if(self.page ==1){
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:list]];
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

-(void)setLayout{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SCREEN_top);
        make.left.right.bottom.mas_equalTo(CGFloatBasedI375(0));
    }];
}
static NSString *const LLStockPeisongCellid = @"LLStockPeisongCell";
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(190);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header = [[UIView alloc]init];
//    return header;
//}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    return footer;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLStockPeisongCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStockPeisongCellid];
    if(self.dataArr.count){
        cell.model = self.dataArr[indexPath.row];
    }
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}

-(void)joinStockDetailAndShop:(UIButton *)sender dataSource:(LLGoodModel *)model{
    
    if (sender.tag == 101) {
        
        XYStockDetaileViewController *detail = [[XYStockDetaileViewController alloc]init];
        detail.goodModel = model;
        [self.navigationController pushViewController:detail animated:YES];

    }else{
        
        LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
        vc.status = RoleStatusStockPeisong;
        vc.ID = model.ID;
        vc.stocks = model.stayStock;
        vc.distDistGoodsId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLStockPeisongCell class] forCellReuseIdentifier:LLStockPeisongCellid];
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
