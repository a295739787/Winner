//
//  LLPaihangbanViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/3/14.
//

#import "LLPaihangbanViewController.h"
#import "LLPaihangbanCell.h"
@interface LLPaihangbanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showImage;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/

@end

@implementation LLPaihangbanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"";
    [self setLayout];
    [self getProvinceUrl];
    [self getData];
}
-(void)header{
    self.page = 1;
    [self  getProvinceUrl];
}
-(void)footer{
    self.page ++;
    [self  getProvinceUrl];
}
-(void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"DaYingJiaListBackImage") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        NSString *img;
        if([data[@"content"] containsString:@"http"]){
            img = data[@"content"];
        }else{
            img = FORMAT(@"%@%@",API_IMAGEHOST,data[@"content"]);
        }
        [self.showImage  sd_setImageWithUrlString:FORMAT(@"%@",img) placeholderImage:[UIImage imageNamed:morenpic]];

    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}
-(void)getProvinceUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"" forKey:@"keyword"];
    [params setValue:@"100" forKey:@"pageSize"];
    [params setValue:@(self.page) forKey:@"currentPage"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [XJHttpTool post:L_apiappgoodsgetRankingList method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSArray *data = responseObj[@"data"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(self.page ==1){
           [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data]];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(data.count < 10 ){
            self.tableView.mj_header.hidden = YES;
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_header.hidden = NO;
            self.tableView.mj_footer.hidden = NO;
        }
        if(self.dataArr.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"暂无数据"];
        }else{
            [self.tableView removeEmptyView];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
-(void)setLayout{
    WS(weakself);
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.bottom.mas_equalTo(CGFloatBasedI375(0));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.bottom.mas_equalTo(CGFloatBasedI375(0));
    }];
//    self.tableView.tableHeaderView = self.showImage;
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    self.customNavBar.titleLabelColor = White_Color;
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"white_back"]];
    [self.customNavBar wr_setRightButtonWithTitle:@"活动规则" titleColor:lightGrayFFFF_Color];
    
    self.customNavBar.onClickRightButton = ^{
        LLWebViewController *vc = [[LLWebViewController alloc]init];
        vc.isHiddenNavgationBar = YES;
        vc.htmlStr = @"DaYingJiaListActivityRule";
        vc.name = @"排行榜";
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    

}
static NSString *const LLPaihangbanCellid = @"LLPaihangbanCell";
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count?self.dataArr.count:0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(50);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLPaihangbanHeadView *header = [[LLPaihangbanHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(44))];
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLPaihangbanCell *cell = [tableView dequeueReusableCellWithIdentifier:LLPaihangbanCellid];
    if(self.dataArr.count){
        cell.model = self.dataArr[indexPath.row];
    }
    cell.label.text = FORMAT(@"%ld",indexPath.row+1);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark  导航栏渐变
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat topImageH = CGFloatBasedI375(264)+SCREEN_top;
    
    if (offsetY >= -(topImageH+offsetY)) {
        CGFloat alpha = MIN(1, (topImageH + offsetY)/topImageH);
        
        [self.customNavBar wr_setBackgroundAlpha:alpha];
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"b2_icon"]];
        [self.customNavBar wr_setRightButtonWithTitle:@"活动规则" titleColor:[UIColor blackColor]];
    }else{
        
        [self.customNavBar wr_setBackgroundAlpha:0];
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"white_back"]];
        [self.customNavBar wr_setRightButtonWithTitle:@"活动规则" titleColor:lightGrayFFFF_Color];
    }
    
    
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT)style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLPaihangbanCell class] forCellReuseIdentifier:LLPaihangbanCellid];
        [self.view addSubview:self.tableView];
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = YES;
//        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
//        [header setRefreshingTarget:self refreshingAction:@selector(header)];
//        _tableView.mj_header = header;
//        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
//        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
//        _tableView.mj_footer = footer;
        if (IS_X_) {
            [_tableView setContentInset:UIEdgeInsetsMake(CGFloatBasedI375(310), 0, 0, 0)];
        }else{
            [_tableView setContentInset:UIEdgeInsetsMake(CGFloatBasedI375(255), 0, 0, 0)];
        }
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
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(264)+SCREEN_top)];
        _showImage.userInteractionEnabled = YES;
//        _showImage.image =[UIImage imageNamed:allowimageGray];
        [self.view addSubview:self.showImage];
    }
    return _showImage;
}
@end
