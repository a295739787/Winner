//
//  LLNewsViewController.m
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import "LLNewsViewController.h"
#import "LLNewsViewCell.h"
#import "LLNewsDetailViewController.h"
#import "LLNewsModel.h"
static NSString *const LLNewsViewCellid = @"LLNewsViewCell";

@interface LLNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger type;



@end

@implementation LLNewsViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"消息中心";
    self.view.backgroundColor = BG_Color;
    [self setLayout];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"updateName" object:nil];
}
-(void)setLayout{
    WS(weakself);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SCREEN_top);
        make.height.offset(CGFloatBasedI375(104));
    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.height.offset(CGFloatBasedI375(24));
        make.width.offset(CGFloatBasedI375(85));
        make.top.equalTo(weakself.backView.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(0));
    }];
    [self creatButton];
    
    self.currentPage = 1;
    self.type = 1;
    [self requesturl:self.type];
}
-(void)refreshData{
    self.currentPage = 1;
    [self requesturl:self.type];
}
-(void)creatButton{
    [self.view layoutIfNeeded];
    for(LLShowView *btn in self.backView.subviews){
        [btn removeFromSuperview];
    }
    NSArray *titles = @[@"系统消息",@"订单消息",@"配送消息"];
    NSArray *images = @[@"xtxx",@"ddxx",@"psxx"];

    for (int i = 0; i < titles.count; i++) {
        CGFloat w = SCREEN_WIDTH/3;
        CGFloat h = CGFloatBasedI375(100);
        CGFloat x = CGFloatBasedI375(0)+(w + CGFloatBasedI375(0))*(i% titles.count);
        CGFloat y =0;
        LLShowView *button = [[LLShowView alloc]init];;
        button.frame = CGRectMake(x, y, w, h);
        button.style = ShowViewNormalState;
        button.tag = i + 100;
        button.titlelable.text = titles[i];
        button.showimage.image = [UIImage imageNamed:images[i]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        [button addGestureRecognizer:tap];
        [self.backView addSubview:button];
        
    }
}
-(void)header{
    self.currentPage = 1;
    [self requesturl:self.type];
}
-(void)footer{
    self.currentPage ++;
    [self requesturl:self.type];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    NSInteger index = [tap view].tag - 100;
    self.type = index+1;
    self.currentPage = 1;
    [self requesturl:index+1];
}

#pragma mark--requestUrl
-(void)requesturl:(NSInteger)type{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(self.currentPage) forKey:@"currentPage"];
    [params setValue:@"" forKey:@"keyword"];
    [params setValue:@(10) forKey:@"pageSize"];
    [params setValue:@"" forKey:@"sidx"];
    [params setValue:@"asc" forKey:@"sort"];
    [params setValue:@(type) forKey:@"type"];
    WS(weakself);
    [XJHttpTool post:L_messageUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            if(weakself.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            NSLog(@"responseObj == %@",responseObj);
            LLNewsModel *model = [LLNewsModel yy_modelWithJSON:responseObj[@"data"]];
            for (LLNewsListModel *listModel in model.list) {
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
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(143);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(400))];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLNewsViewCellid];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView.hidden = YES;
    if (self.dataArray.count > 0) {
        cell.listModel = self.dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > 0) {
        LLNewsListModel *listModel = self.dataArray[indexPath.row];
        LLNewsDetailViewController *vc = [[LLNewsDetailViewController alloc]init];
        vc.ID = listModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark  懒加载
-(LLBaseTableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLNewsViewCell class] forCellReuseIdentifier:LLNewsViewCellid];
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
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_backView];
    }
    return _backView;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"最新通知消息";
        _titlelable.textColor = [UIColor colorWithHexString:@"#999999"];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.view addSubview:self.titlelable];
        _titlelable.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _titlelable.layer.masksToBounds = YES;
        _titlelable.layer.cornerRadius = CGFloatBasedI375(5);
    }
    return _titlelable;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
