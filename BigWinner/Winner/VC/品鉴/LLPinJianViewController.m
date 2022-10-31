//
//  LLPinJianViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/1/16.
//

#import "LLPinJianViewController.h"
#import "LLPinJianViewCell.h"
#import "LLPingjianIntroView.h"
#import "LLPingjianSureOrderViewController.h"
#import "SuspensionAssistiveTouch.h"
#import "LLIntroPointViewController.h"
static NSString *const LLPinJianViewCellid = @"LLPinJianViewCell";
static NSString *const LLPinJianSectionViewCellID = @"LLPinJianSectionViewCell";
static NSString *const LLPinJianPicViewCellid = @"LLPinJianPicViewCell";


@interface LLPinJianViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** class **/
@property (nonatomic,strong) UIImageView *showImage ;/** <#class#> **/
@property (nonatomic,strong) UIScrollView *scollview ;/** <#class#> **/
@property (nonatomic,strong) LLPingjianIntroView *introView ;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *valueModel;/** <#class#> **/
@property (nonatomic,strong) SuspensionAssistiveTouch *assistiveTouch;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *listArr;/** <#class#> **/

@end

@implementation LLPinJianViewController
-(void)viewWillAppear:(BOOL)animated{
    if([UserModel sharedUserInfo]){
        if([UserModel sharedUserInfo].isShop || [UserModel sharedUserInfo].isClerk){
            _assistiveTouch.hidden = YES;
        }
        if([UserModel sharedUserInfo].userIdentity != 1){
            _assistiveTouch.hidden = YES;
        }
        if(![UserModel sharedUserInfo].isClerk && [UserModel sharedUserInfo].clerkStatus == 3){
            _assistiveTouch.hidden = NO;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BG_Color;
    // Do any additional setup after loading the view.
    [self setLayout];
    [self getDatas:YES];
}

-(void)header{
//    self.page = 1;
    [self getDatas:NO];
    [self getPersonalUrl];
}
-(void)footer{
//    self.page ++;
    [self getDatas:NO];
}
#pragma mark--getPersonalUrl
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    WS(weakself);
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [UserModel setUserInfoModelWithDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
        [UserModel saveInfo];

    } failure:^(NSError * _Nonnull error) {
    }];
    [self.tableView reloadData];
}
-(void)getDatas:(BOOL)isload{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"" forKey:@"keyword"];
    [param setValue:@"Sort" forKey:@"sidx"];
    [param setValue:@"asc" forKey:@"sort"];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:@"1" forKey:@"currentPage"];

    if(isload){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }

    [XJHttpTool post:FORMAT(@"%@",L_apiappjudgegoodsgetJudgeGoodsList) method:GET params:param isToken:NO success:^(id  _Nonnull responseObj) {
        [self.dataArr removeAllObjects];
        [self.listArr removeAllObjects];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        NSArray *list = data[@"list"];

        if(list.count > 3){
            NSArray *remaining = [list subarrayWithRange:NSMakeRange(3, list.count-3)];
            [self.listArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:remaining]];
        }
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
        NSLog(@"self.dataArr == %ld",self.dataArr.count);
        NSLog(@"self.listArr == %ld",self.listArr.count);
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_header.hidden = NO;
            self.tableView.mj_footer.hidden = NO;
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

    [self.view addSubview:self.tableView];
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"pj_bg"].CGImage;
    layer.anchorPoint = CGPointZero;
    layer.bounds = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    CGRect rect = layer.frame;
    rect.origin.y = 0;
    layer.frame = rect;
    [self.tableView.layer addSublayer:layer];
    layer.zPosition = -5;
    
    
    _assistiveTouch = [[SuspensionAssistiveTouch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-CGFloatBasedI375(70), SCREEN_HEIGHT-DeviceXTabbarHeigh(130), CGFloatBasedI375(63),CGFloatBasedI375(63))];
    NSLog(@" == %@",_assistiveTouch.showimage);
    _assistiveTouch.showimage.userInteractionEnabled = YES;
    _assistiveTouch.showimage.image  = [UIImage imageNamed:@"sqpsy"];
    [self.view addSubview:_assistiveTouch];
    [self.view insertSubview:_assistiveTouch aboveSubview:self.tableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestzujiForUrl)];
    [ _assistiveTouch.showimage addGestureRecognizer:tap];
    
  
    if([UserModel sharedUserInfo]){
        if([UserModel sharedUserInfo].isShop || [UserModel sharedUserInfo].isClerk){
            _assistiveTouch.hidden = YES;
        }
        if([UserModel sharedUserInfo].userIdentity != 1){
            _assistiveTouch.hidden = YES;
        }
        if([UserModel sharedUserInfo].isClerk && [UserModel sharedUserInfo].clerkStatus == 3){
            _assistiveTouch.hidden = NO;
        }
    }


}
-(void)requestzujiForUrl{
    
    if([UserModel sharedUserInfo].token.length <= 0){
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele loginVc];
        return ;
    }
    if([UserModel sharedUserInfo].shopStatus == 0){//状态（1待审核、2已通过、3不通过）
        //状态（1待审核、2已通过、3不通过
        if([UserModel sharedUserInfo].clerkStatus == 0){
            LLIntroPointViewController *vc = [[LLIntroPointViewController alloc]init];
            vc.status = RoleStatusPeisong;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([UserModel sharedUserInfo].clerkStatus == 1){
            [JXUIKit showErrorWithStatus:@"配送申请审核中"];
        }else if ([UserModel sharedUserInfo].clerkStatus == 3){
            LLIntroPointViewController *vc = [[LLIntroPointViewController alloc]init];
            vc.status = RoleStatusPeisong;
            vc.refuseStutas = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else    if([UserModel sharedUserInfo].shopStatus == 1){//状态（1待审核、2已通过、3不通过）
        [JXUIKit showErrorWithStatus:@"申请推广员审核中，不能申请配送员"];
    }else if([UserModel sharedUserInfo].shopStatus == 3){
        LLIntroPointViewController *vc = [[LLIntroPointViewController alloc]init];
        vc.status = RoleStatusPeisong;
        vc.refuseStutas = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
 
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataArr.count<=0 ){
        return 0;;
    }
    if(section != 2){
        return 1;;
    }
    return self.listArr.count;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return CGFloatBasedI375(140);
    }else     if(indexPath.section == 1){
        return CGFloatBasedI375(210);
    }
    return CGFloatBasedI375(130);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section != 0){
        return CGFloatBasedI375(0.001);
    }
    return CGFloatBasedI375(232);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section != 0){
        return nil;
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(232))];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(0.001))];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LLPinJianSectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLPinJianSectionViewCellID];
        if(self.dataArr.count > 0){
        cell.model = self.dataArr[0];
        }
        return cell;
    }else     if(indexPath.section == 1){
        LLPinJianPicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLPinJianPicViewCellid];
        if(self.dataArr.count > 0){
            cell.datas = self.dataArr.mutableCopy;
        }
        WS(weakself);
        cell.pushOrderBlock = ^(LLGoodModel * _Nonnull model) {
            [weakself showModel:model];
        };
        return cell;
    }
    
    
    LLPinJianViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLPinJianViewCellid];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView.hidden = YES;
    if(self.listArr.count > 0){
        cell.model = self.listArr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(self.dataArr.count > 0){
        [self showModel:self.dataArr[indexPath.row]];
        }
    }else if(indexPath.section == 1){
        
    }else{
        [self showModel:self.listArr[indexPath.row]];
        
    }
}
-(void)showModel:(LLGoodModel *)model{
    if(self.introView){
        self.introView = nil;
    }
    [self introView];
    self.introView.model = model;
    self.valueModel = model;
    [self.view addSubview:self.introView];
    [self.view insertSubview:self.introView aboveSubview:self.tableView];

    }
-(void)tapAction:(UITapGestureRecognizer *)sender{
    if([UserModel sharedUserInfo].token.length <= 0){
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele loginVc];
        return;
    }
    LLPingjianSureOrderViewController *vc = [[LLPingjianSureOrderViewController alloc]init];
    vc.valueModel = self.valueModel;
    vc.status = RoleStatusPingjian;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLPinJianViewCell class] forCellReuseIdentifier:LLPinJianViewCellid];
        [ _tableView  registerClass:[LLPinJianSectionViewCell class] forCellReuseIdentifier:LLPinJianSectionViewCellID];
        [ _tableView  registerClass:[LLPinJianPicViewCell class] forCellReuseIdentifier:LLPinJianPicViewCellid];
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _tableView.mj_footer = footer;
//        [self.view addSubview:self.tableView];
        
        adjustsScrollViewInsets_NO(self.tableView, self);
//        [_tableView setContentInset:UIEdgeInsetsMake(CGFloatBasedI375(232), 0, 0, 0)];  //
    }
    return _tableView;
}

-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        _showImage.image = [UIImage imageNamed:@"jxhb_bg"];
        _showImage.userInteractionEnabled = YES;
        [self.view addSubview:self.showImage];
    }
    return _showImage;
}

-(LLPingjianIntroView *)introView{
    if(!_introView){
        _introView = [[LLPingjianIntroView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _introView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_introView addGestureRecognizer:tap];
      
    }
    return _introView;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)listArr{
    if(!_listArr){
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}
@end
