//
//  LLAllPraiseViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/5/24.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLGoodPraiseViewController.h"
#import "LLGoodPraiseCell.h"

static NSString *const LLGoodPraiseCellid = @"LLGoodPraiseCell";

@interface LLGoodPraiseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) UIView *topView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *tabArr;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *seleArr;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** <#class#> **/
@property (nonatomic,copy) NSString *typeid;/** <#class#> **/

@property (nonatomic,assign) BOOL isLoad;/** <#class#> **/
@end

@implementation LLGoodPraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeid = @"0";
    self.page =1;
    self.isLoad = NO;
    // Do any additional setup after LLGoodPraiseViewController the view.

    self.view.backgroundColor = BG_Color;
    [self setlaouts];
    [self loadUrl];
}

-(void)header{
    self.isLoad = YES;
    self.page = 1;
    [self loadUrl];
}
-(void)footer{
    self.isLoad = YES;
    self.page ++;
    [self loadUrl];
}
-(void)loadUrl{
    if(!_isLoad){
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    }
    NSMutableDictionary *pram = [NSMutableDictionary dictionary];
    [pram setValue:self.goodsId forKey:@"goodsId"];
    [pram setValue:@(self.page) forKey:@"page"];
    [pram setObject:@"" forKey:@"keyword"];
    [pram setObject:@"10" forKey:@"pageSize"];
    [pram setObject:@"1" forKey:@"platform"];
    [pram setObject:@"" forKey:@"sidx"];
    [pram setObject:@"" forKey:@"sort"];
    [XJHttpTool post:L_apiappgoodsevaluategetList method:GET params:pram isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *dic = responseObj[@"data"];
        NSArray *data = dic[@"list"];
        if(self.page == 1){
            [self.dataArr removeAllObjects];
        }
        if(data.count < 10){
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data]];
        self.customNavBar.title = FORMAT(@"商品评论(%ld)",self.dataArr.count);
        if(self.dataArr.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"暂无数据"];
        }else{
            [self.tableView removeEmptyView];
        }

        [self.tableView reloadData];
        [self refrehTab];
    } failure:^(NSError * _Nonnull error) {
        [self refrehTab];

    }
     ];
}

-(void)refrehTab{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD hideActivityIndicator];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}
-(void)setlaouts{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(SCREEN_top);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    LLGoodModel *model = self.dataArr[indexPath.section];
//    NSArray *datas = [model.comment_content.images componentsSeparatedByString:@","];
//    if(datas.count > 0){
//        CGFloat counts = 0;
//        if(datas.count %3 == 0){
//            counts = datas.count /3;
//        }else{
//            counts = (datas.count /3)+1;
//        }
//        return CGFloatBasedI375(130)+(counts*CGFloatBasedI375(150));
//    }else{
//        return CGFloatBasedI375((374+100)/2);
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.dataArr.count) {
        return [self.tableView fd_heightForCellWithIdentifier:LLGoodPraiseCellid configuration:^(LLGoodPraiseCell *cell) {
            [self configureOriCell:cell atIndexPath:indexPath];
        }];;
    }
    else{
        return 150.f;
    }
}
- (void)configureOriCell:(LLGoodPraiseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (indexPath.row < self.dataArr.count) {
        cell.model = self.dataArr[indexPath.section];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    view.backgroundColor =BG_Color;
    return view;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLGoodPraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:LLGoodPraiseCellid];
    cell.model = self.dataArr[indexPath.section];

    return cell;
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLGoodPraiseCell class] forCellReuseIdentifier:LLGoodPraiseCellid];
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _tableView.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _tableView.mj_footer = footer;

        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)tabArr{
    if(!_tabArr){
        _tabArr = [NSMutableArray array];
    }
    return _tabArr;
}
- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = White_Color;
        [self.view addSubview:_topView];
    }
    return _topView;
}
-(NSMutableArray *)seleArr{
    if(!_seleArr){
        _seleArr = [NSMutableArray array];
    }
    return _seleArr;
}
@end
