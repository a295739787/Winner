//
//  LLMainPeisongViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/3/4.
//

#import "LLMePersongViewController.h"
#import "LLMainPeisongHeadView.h"
#import "LLMeTopView.h"
#import "LLMeDeliverWorkTableCell.h"
#import "LLMeSectionTableCell.h"
#import "LLMeOrderController.h"
#import "LLMeOrderAftermaketVC.h"
#import "LLMeDeliverOrderController.h"
#import "LLPersonalModel.h"
#import "LLoginsViewController.h"
#import "LLWalletController.h"
#import "LLMeAdressController.h"
#import "LLSystemSettingController.h"
#import "LLMeDeliverCommissionRecordVC.h"
#import "LLStockOrderDetailController.h"
#import "LLMeFirstGuideView.h"
#import "LLMePromoteVC.h"
#import "LLMeDeliverListVC.h"
#import "LLMeTopView.h"
#import "LLMePromoteController.h"
#import "Winner-Swift.h"
@interface LLMePersongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,assign) NSInteger page;/** class **/
@property (nonatomic,strong)LLMeTopView *topView;
@property (nonatomic,strong)LLMeHeaderView *headerView;
@property (nonatomic,strong)LLMeFirstGuideView *guideView;
@property (nonatomic,strong)LLMeCommissionNoteView *commissinNoteView;
@property (nonatomic,assign) NSInteger tagsindex;/** class **/

@property (nonatomic,strong)LLPersonalModel *personalModel;

@end

@implementation LLMePersongViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createUI];
    [self getPersonalUrl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = BG_Color;


    
    [self getData];
    [self getHData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark--createUI
-(void)createUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPersonalUrl) name:@"updateName" object:nil];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

-(void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"AppUserChildCenterProfitRule") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
         NSString *conten = data[@"content"];
        self.commissinNoteView.content = conten;
        
    } failure:^(NSError * _Nonnull error) {
     
    }];
}
-(void)getHData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"AppBanBenKongZhi") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.tagsindex = [FORMAT(@"%@",data[@"content"])integerValue];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}
#pragma mark--getPersonalUrl
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    WS(weakself);
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        NSLog(@"promotionUserNum == %@",data[@"promotionUserNum"]);
        self.personalModel = [LLPersonalModel mj_objectWithKeyValues:data];
        self.headerView.isPeisong = YES;
        self.headerView.personalModel = self.personalModel;
        self.topView.redLabel.hidden = YES;
        if(self.personalModel.messageNum > 0){
            self.topView.redLabel.hidden = NO;
            self.topView.redLabel.text = FORMAT(@"%ld",self.personalModel.messageNum);
        }
        if (weakself.personalModel.isShop) {
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"guide_tgd_status"];
            if (str) {
                weakself.guideView.type = @"2";
                [weakself.guideView show];
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)getPersonChangeUrl{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"3" forKey:@"type"];//编辑类型（1昵称、2头像、3切换身份）
    [params setValue:@"1" forKey:@"value"];//编辑值（昵称值、头像值、切换身份[1普通用户，2推广点，3配送员]）
    [XJHttpTool post:L_UpdateUserInfo method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            dele.status = RoleStatusGeneral;
            LLTabbarViewController *vc = [[LLTabbarViewController alloc]init];
            vc.selectedIndex = 3;
            [UIApplication sharedApplication].delegate.window.rootViewController  = vc;
        });
  
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self.tableView reloadData];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([UserModel sharedUserInfo].isShop) {
        return 2;
    }
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UserModel sharedUserInfo].isShop) {
        if (indexPath.section == 0) {
            LLMeDeliverWorkTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeDeliverWorkTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.personalModel = self.personalModel;
            WS(weakself);
            cell.deliverMoudleBlock = ^(NSInteger modetype) {
                if (modetype == 100) {
                    //累计完成配送
                    
                }else if (modetype == 101){
                    //累计任务佣金
                    LLMeDeliverCommissionRecordVC *commissionRecordVC = [[LLMeDeliverCommissionRecordVC alloc]init];
                    [weakself.navigationController pushViewController:commissionRecordVC animated:YES];
                }else if (modetype == 200){
                    //配送库存
                    weakself.navigationController.tabBarController.selectedIndex = 1;
                    
                }else if (modetype == 201){
                    if(weakself.tagsindex == 1){
                        LLMePromoteVC *promoteVC  = [[LLMePromoteVC alloc]init];
                        [weakself.navigationController pushViewController:promoteVC animated:YES];
                    }else{
                        LLMePromoteController *vc = [[LLMePromoteController alloc]init];
                        [weakself.navigationController pushViewController:vc animated:YES];
                    }
                }else if (modetype == 1000){
                    [weakself.commissinNoteView show];
                }
            };
            return cell;
        }
        LLMeMoudleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeMoudleTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgArray = @[@"jfsc",@"shdd",@"xtsz"];
        cell.titleArray = @[@"我的钱包",@"收货地址",@"系统设置"];
        WS(weakself);
        cell.moudleBtnBlock = ^(NSInteger index) {
            if (index == 100) {
                //我的钱包
                LLWalletController *walletVC = [[LLWalletController alloc]init];
                walletVC.type = @"1";
                walletVC.balance = self.personalModel.balance;
                [weakself.navigationController pushViewController:walletVC animated:YES];
            }else if (index == 101){
                //收货地址
                LLMeAdressController *adressVC = [[LLMeAdressController alloc]init];
                adressVC.addressType = LLMeAdressLogis;
                [weakself.navigationController pushViewController:adressVC animated:YES];
            }else if (index == 102){
                //系统设置
                LLSystemSettingController *systemVC = [[LLSystemSettingController alloc]init];
                [weakself.navigationController pushViewController:systemVC animated:YES];
            }
        };
        
        return cell;
    }else{
    if (indexPath.section == 0) {
        LLMeDeliverWorkTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeDeliverWorkTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.personalModel = self.personalModel;
        WS(weakself);
        cell.deliverMoudleBlock = ^(NSInteger modetype) {
            
            if (modetype == 100) {
                //累计完成配送
                
            }else if (modetype == 101){
                //累计任务佣金
                LLMeDeliverCommissionRecordVC *commissionRecordVC = [[LLMeDeliverCommissionRecordVC alloc]init];
                [weakself.navigationController pushViewController:commissionRecordVC animated:YES];
            }else if (modetype == 200){
                //配送库存
                weakself.navigationController.tabBarController.selectedIndex = 1;
                
            }else if (modetype == 201){
                
                if(weakself.tagsindex == 1){
                    LLMePromoteVC *promoteVC  = [[LLMePromoteVC alloc]init];
                    [weakself.navigationController pushViewController:promoteVC animated:YES];
                }else{
                    LLMePromoteController *vc = [[LLMePromoteController alloc]init];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
      
            }else if (modetype == 1000){
                [weakself.commissinNoteView show];
            }
        };
        return cell;
    }else if (indexPath.section == 1){
        LLMeDeliverOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeDeliverOrderTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.personalModel = self.personalModel;
        WS(weakself);
        cell.deliverOrderBlock = ^(NSInteger index) {
            
            if (index == 200) {
                //全部订单
                LLMeDeliverListVC *orderVC = [[LLMeDeliverListVC alloc]init];
                orderVC.orderStatus = 0;
                orderVC.index = 0;
                [weakself.navigationController pushViewController:orderVC animated:YES];
            }else{
                if (index == 103) {
                    //售后
                    LLMeOrderAftermaketVC *afterVC = [[LLMeOrderAftermaketVC alloc]init];
                    afterVC.platform = @"2";
                    [weakself.navigationController pushViewController:afterVC animated:YES];
                }else{
                    LLMeDeliverListVC *orderVC = [[LLMeDeliverListVC alloc]init];
                    orderVC.index =  (index-100)+1;
                    NSArray *da = @[@"2",@"3",@"7"];
                    orderVC.orderStatus = [da[(index-100)] integerValue];
                    [weakself.navigationController pushViewController:orderVC animated:YES];
                }
            }
        };
        return cell;
    }
    LLMeMoudleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeMoudleTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imgArray = @[@"jfsc",@"shdd",@"xtsz"];
    cell.titleArray = @[@"我的钱包",@"收货地址",@"系统设置"];
    WS(weakself);
    cell.moudleBtnBlock = ^(NSInteger index) {
        
        if (index == 100) {
            //我的钱包
            LLWalletController *walletVC = [[LLWalletController alloc]init];
            walletVC.type = @"1";
            walletVC.balance = self.personalModel.balance;
            [weakself.navigationController pushViewController:walletVC animated:YES];
        }else if (index == 101){
            //收货地址
            LLMeAdressController *adressVC = [[LLMeAdressController alloc]init];
            adressVC.addressType = LLMeAdressLogis;
            [weakself.navigationController pushViewController:adressVC animated:YES];
        }else if (index == 102){
            //系统设置
            LLSystemSettingController *systemVC = [[LLSystemSettingController alloc]init];
            [weakself.navigationController pushViewController:systemVC animated:YES];
        }
    };
    
    return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UserModel sharedUserInfo].isShop) {
        if (indexPath.section == 0) {
            return CGFloatBasedI375(140);
        }
        return CGFloatBasedI375(49) * 3;
    }

    if (indexPath.section == 0) {
        return CGFloatBasedI375(140);
    }else if (indexPath.section == 1){
        return CGFloatBasedI375(122);
    }
    return CGFloatBasedI375(49) * 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if ([UserModel sharedUserInfo].isShop && section == 1) {
//        return 0.1;
//    }
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LLStockOrderDetailController *vc = [[LLStockOrderDetailController alloc]init];
//
//    [self.navigationController pushViewController:vc animated:YES];
}
-(LLBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(75), SCREEN_WIDTH, SCREEN_HEIGHT - CGFloatBasedI375(75) - kTabBarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeMoudleTableCell class] forCellReuseIdentifier:@"LLMeMoudleTableCell"];
        [_tableView registerClass:[LLMeDeliverWorkTableCell class] forCellReuseIdentifier:@"LLMeDeliverWorkTableCell"];
        [_tableView registerClass:[LLMeDeliverOrderTableCell class] forCellReuseIdentifier:@"LLMeDeliverOrderTableCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(getPersonalUrl)];
        _tableView.mj_header = header;
        adjustsScrollViewInsets_NO(_tableView, self);
    }
    return _tableView;
}

-(LLMeTopView *)topView{
    if (!_topView) {
        _topView = [[LLMeTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(263))];
        
    }
    return _topView;
}
-(LLMeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LLMeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(100))];
        _headerView.changeLabel.text = @"普通用户";
        _headerView.isPeisong = YES;
        if ([UserModel sharedUserInfo].isShop) {
            _headerView.type = LLMeHeaderTypeShop;
        }else{
            _headerView.type = LLMeHeaderTypeClerk;
        }
        WS(weakself);
        _headerView.tapBlock = ^{
            [weakself getPersonChangeUrl];
        };
        _headerView.personalBtnBlock = ^{
            //个人资料
        
            if ([UserModel sharedUserInfo].isShop) {
                XYShopDetailViewController *shopVC = [[XYShopDetailViewController alloc] init];
                shopVC.personalModel = weakself.personalModel;
                [weakself.navigationController pushViewController:shopVC animated:YES];
            }
            
        };
        _headerView.loginBtnBlock = ^{
            
            [OneKeyLoginTools JoinOneKeyLoginPageWithView:weakself joinOtherLoginView:@selector(joinOtherLoginView)];
        };
    }
    return _headerView;
}

#pragma mark - 一键登录点击其他号码登录
-(void)joinOtherLoginView{

    [OneKeyLoginTools signOutOneKeyLoginWithCompletion:^{

        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele showLoginVc];
    }];
 
}
-(LLMeFirstGuideView *)guideView{
    if (!_guideView) {
        _guideView = [[LLMeFirstGuideView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _guideView;
}

-(LLMeCommissionNoteView *)commissinNoteView{
    if (!_commissinNoteView) {
        _commissinNoteView = [[LLMeCommissionNoteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _commissinNoteView.LLCommissionNoteBlock = ^{
            LLMeDeliverCommissionRecordVC *commissionRecordVC = [[LLMeDeliverCommissionRecordVC alloc]init];
            [weakself.navigationController pushViewController:commissionRecordVC animated:YES];
        };
    }
    return _commissinNoteView;
}

@end
