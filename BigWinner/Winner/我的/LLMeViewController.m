//
//  LLMeViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/1/16.
//

#import "LLMeViewController.h"
#import "LLMeTopView.h"
#import "LLMeSectionTableCell.h"
#import "LLPersonalController.h"
#import "LLMePromoteVC.h"
#import "LLStorageController.h"
#import "LLMeOrderController.h"
#import "LLMeOrderAftermaketVC.h"
#import "LLMeAdressController.h"
#import "LLMeBuyBackController.h"
#import "LLBillInfoController.h"
#import "LLSystemSettingController.h"
#import "LLWalletController.h"
#import "LLPersonalModel.h"
#import "LLoginsViewController.h"
#import "LLMeFirstGuideView.h"
#import "LLSurpriseRegBagRecordViewController.h"
#import "LLMePromoteController.h"
#import "Winner-Swift.h"
@interface LLMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLMeTopView *topView;
@property (nonatomic,strong)LLMeHeaderView *headerView;

@property (nonatomic,strong)LLMeCommissionNoteView *commissinNoteView;
@property (nonatomic,strong)LLMeFirstGuideView *guideView;
@property (nonatomic,assign) NSInteger tagsindex;/** class **/

@property (nonatomic,strong)LLPersonalModel *personalModel;
@property (nonatomic,strong) LLGoodCarNoticeView *noticeView;/** <#class#> **/

@property (nonatomic, copy) NSString *conten;


@end

@implementation LLMeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([UserModel sharedUserInfo].token.length > 0){
        [self getPersonalUrl];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getData];
    [self getHData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark--createUI
-(void)createUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPersonalUrl) name:@"updateName" object:nil];
    
    self.view.backgroundColor = UIColorFromRGB(0xF0EFED);
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SCREEN_top);
        make.left.right.bottom.equalTo(0);
    }];
    self.tableView.tableHeaderView = self.headerView;
}
-(void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"AppUserCenterProfitRule") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.conten = data[@"content"];
        self.commissinNoteView.content = self.conten;
        
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}
-(void)getHData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"AppBanBenKongZhi") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.tagsindex = [FORMAT(@"%@",data[@"content"])integerValue];
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}

-(void)header{
    if([UserModel sharedUserInfo].token.length > 0){
  
        [self getPersonalUrl];
        [self getHData];
    }else{
    [AccessTool  removeUserInfo];
    [UserModel resetModel:nil];
        self.personalModel  = nil;
        self.headerView.personalModel = self.personalModel;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark - 一键登录点击其他号码登录
-(void)joinOtherLoginView{

    [OneKeyLoginTools signOutOneKeyLoginWithCompletion:^{

        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele showLoginVc];
    }];
 
}

#pragma mark--getPersonalUrl
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    WS(weakself);
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        NSLog(@"clerkStatus == %@ isClerk == %@",data[@"clerkStatus"],data[@"isClerk"]);
        [UserModel setUserInfoModelWithDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
        [UserModel saveInfo];
        self.personalModel = [LLPersonalModel mj_objectWithKeyValues:data];
        self.headerView.personalModel = self.personalModel;
        self.topView.redLabel.hidden = YES;
        if(self.personalModel.messageNum > 0){
            self.topView.redLabel.hidden = NO;
            self.topView.redLabel.text = FORMAT(@"%ld",self.personalModel.messageNum);
        }
   
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView reloadData];
}
-(void)getPersonUrl{
    [self.guideView hidden];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakself);
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"3" forKey:@"type"];//编辑类型（1昵称、2头像、3切换身份）
    if( weakself.personalModel.isClerk){
        [params setValue:@"3" forKey:@"value"];//编辑值（昵称值、头像值、切换身份[1普通用户，2推广点，3配送员]）
    }else if( weakself.personalModel.isShop){
        [params setValue:@"2" forKey:@"value"];//编辑值（昵称值、头像值、切换身份[1普通用户，2推广点，3配送员]）
    }
    [XJHttpTool post:L_UpdateUserInfo method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(weakself.personalModel.isClerk){
                    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    dele.status = RoleStatusPeisong;
                    [dele loginPeisongVc];
                }else if(weakself.personalModel.isShop){
                    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    dele.status = RoleStatusTuiguang;
                    [dele loginPeisongVc];
                }
            });
           
        
        });
      

    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self.tableView reloadData];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        LLMeSectionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeSectionTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.personalModel = self.personalModel;
        WS(weakself);
        cell.sectionBtnBlock = ^(NSInteger index) {
            if([UserModel sharedUserInfo].token.length <= 0){
                AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [dele loginVc];
                return ;
            }
            if (index == 100) {
                //累计现金红包
                LLWalletController *walletVC = [[LLWalletController alloc]init];
                walletVC.balance = weakself.personalModel.totalConsumeRedPrice;
                [weakself.navigationController pushViewController:walletVC animated:YES];
            }else if (index == 101){
                //累计消费红包
                LLWalletController *walletVC = [[LLWalletController alloc]init];
                walletVC.type = @"2";
                walletVC.balance = weakself.personalModel.totalConsumeRedPrice;
                [weakself.navigationController pushViewController:walletVC animated:YES];
            }else if (index == 102){
                //累计推广佣金
//                LLMePromoteVC *promoteVC  = [[LLMePromoteVC alloc]init];
//                promoteVC.content = weakself.conten;
//                [weakself.navigationController pushViewController:promoteVC animated:YES];
                LLWalletController *walletVC = [[LLWalletController alloc]init];
                walletVC.balance = weakself.personalModel.totalConsumeRedPrice;
                [weakself.navigationController pushViewController:walletVC animated:YES];
            }else if (index == 200){
                //我的库存
                LLStorageController *storageVC = [[LLStorageController alloc]init];
                [weakself.navigationController pushViewController:storageVC animated:YES];
            }else if (index == 201){
                if(weakself.tagsindex == 1){
                    //分享好友
                    LLMePromoteVC *promoteVC  = [[LLMePromoteVC alloc]init];
                    promoteVC.content = weakself.conten;
                    [weakself.navigationController pushViewController:promoteVC animated:YES];
                }else{
                    LLMePromoteController *vc = [[LLMePromoteController alloc]init];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
   
            }else if (index == 0){
                [weakself.commissinNoteView show];
            }
        };
        return cell;
    }else if (indexPath.section == 1){
        LLMeOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.personalModel = self.personalModel;
        WS(weakself);
        cell.orderBlock = ^(NSInteger index) {
            if([UserModel sharedUserInfo].token.length <= 0){
                AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [dele loginVc];
                return ;
            }
            if (index == 200) {
                //全部订单
                LLMeOrderListController *orderVC = [[LLMeOrderListController alloc]init];
                orderVC.orderStatus = 0;
                [weakself.navigationController pushViewController:orderVC animated:YES];
            }else{
                if (index == 104) {
                    //售后
                    LLMeOrderAftermaketVC *afterVC = [[LLMeOrderAftermaketVC alloc]init];
                    [weakself.navigationController pushViewController:afterVC animated:YES];
                }else{
                    LLMeOrderListController *orderVC = [[LLMeOrderListController alloc]init];
                    orderVC.orderStatus = (index-100)+1;
                    [weakself.navigationController pushViewController:orderVC animated:YES];
                }
            }
        };
         
        return cell;
    }
    LLMeMoudleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeMoudleTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imgArray = @[@"jfsc",@"gmjl",@"hgzx",@"shdd",@"fpgl",@"xtsz"];
    cell.titleArray = @[@"我的钱包",@"惊喜活动专区购买记录",@"回购中心",@"收货地址",@"发票信息",@"系统设置"];
    WS(weakself);
    cell.moudleBtnBlock = ^(NSInteger index) {
        if([UserModel sharedUserInfo].token.length <= 0){
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [dele loginVc];
            return ;
        }
        if (index == 100) {
            //我的钱包
            LLWalletController *walletVC = [[LLWalletController alloc]init];
            walletVC.type = @"1";
            walletVC.balance = self.personalModel.balance;
            [weakself.navigationController pushViewController:walletVC animated:YES];
        }else if (index == 101){
            //惊喜活动购买记录
            LLSurpriseRegBagRecordViewController *vc = [[LLSurpriseRegBagRecordViewController alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }else if (index == 102){
            //回购中心
            LLMeBuyBackController *buybackVC = [[LLMeBuyBackController alloc]init];
            [weakself.navigationController pushViewController:buybackVC animated:YES];
        }else if (index == 103){
            //我的地址
            LLMeAdressController *adressVC = [[LLMeAdressController alloc]init];
            adressVC.addressType = LLMeAdressAll;
            [weakself.navigationController pushViewController:adressVC animated:YES];
        }else if (index == 104){
            //发票信息
            LLBillInfoController *billInfoVC = [[LLBillInfoController alloc]init];
            [weakself.navigationController pushViewController:billInfoVC animated:YES];
        }else if (index == 105){
            //系统设置
            LLSystemSettingController *systemVC = [[LLSystemSettingController alloc]init];
            [weakself.navigationController pushViewController:systemVC animated:YES];
        }
    };
     
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(140);
    }else if (indexPath.section == 1){
        return CGFloatBasedI375(122);;
    }else if (indexPath.section == 2){
        return CGFloatBasedI375(49) * 6;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundView = nil;
        _tableView.backgroundView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[LLMeSectionTableCell class] forCellReuseIdentifier:@"LLMeSectionTableCell"];
        [_tableView registerClass:[LLMeOrderTableCell class] forCellReuseIdentifier:@"LLMeOrderTableCell"];
        [_tableView registerClass:[LLMeMoudleTableCell class] forCellReuseIdentifier:@"LLMeMoudleTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
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
        
        WS(weakself);
        _headerView.tapBlock = ^{
                NSString *guide_psy_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"guide_psy_status"];
                if (guide_psy_status.length <= 0) {
                    if( weakself.personalModel.isClerk){
                        weakself.guideView.type = @"1";
                    }else if( weakself.personalModel.isShop){
                        weakself.guideView.type = @"2";
                    }
                    [weakself.guideView show];
                }else{
                    [weakself getPersonUrl];
                }

   
        };
        _headerView.personalBtnBlock = ^{
            if([UserModel sharedUserInfo].token.length <= 0){
                AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [dele loginVc];
                return ;
            }
            //个人资料
            LLPersonalController *personalVC = [[LLPersonalController alloc]init];
            personalVC.personalModel = weakself.personalModel;
            [weakself.navigationController pushViewController:personalVC animated:YES];
        };

        _headerView.loginBtnBlock = ^{
            
            [OneKeyLoginTools JoinOneKeyLoginPageWithView:weakself joinOtherLoginView:@selector(joinOtherLoginView)];
        };
    }
    return _headerView;
}

-(LLMeCommissionNoteView *)commissinNoteView{
    if (!_commissinNoteView) {
        _commissinNoteView = [[LLMeCommissionNoteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _commissinNoteView.LLCommissionNoteBlock = ^{
//            LLWalletController *walletVC = [[LLWalletController alloc]init];
//            [weakself.navigationController pushViewController:walletVC animated:YES];
            
            LLMePromoteVC *promoteVC  = [[LLMePromoteVC alloc]init];
            promoteVC.content = weakself.conten;
            [weakself.navigationController pushViewController:promoteVC animated:YES];
        };
    }
    return _commissinNoteView;
}
-(LLMeFirstGuideView *)guideView{
    if (!_guideView) {
        _guideView = [[LLMeFirstGuideView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_guideView.sureButton addTarget:self action:@selector(getPersonUrl) forControlEvents:UIControlEventTouchUpInside];
    }
    return _guideView;
}


@end
