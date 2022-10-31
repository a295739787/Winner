//
//  LLStorePayViewController.m
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LLStorePaySuccessViewController.h"
#import "LLStorePayHeadView.h"
#import "LLStoreSureOrderViewCell.h"
#import "LLMeOrderController.h"
#import "LLSurpriseRegBagViewController.h"
#import "LLMainViewController.h"
#import "LLMeOrderDetailController.h"
#import "LLMeDeliverListVC.h"
#import "LLTabbarPeisongViewController.h"
#import "LLSurpriseRegBagRecordViewController.h"
static NSString *const LLStoreSureOrderViewCellid = @"LLStoreSureOrderViewCell";

@interface LLStorePaySuccessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LLStorePaySuccessHeadView *headView ;/** <#class#> **/
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
@end

@implementation LLStorePaySuccessViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.disableDragBack = YES;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"下单成功";
    if(_judgePriceType){
       [[NSNotificationCenter defaultCenter]postNotificationName:@"updatedeName" object:nil];
    }
    if(_status == RoleStatusRedBag){
        [JXUIKit showSuccessWithStatus:@"商品已加入您的酒库，请使用【提货】或【品鉴】"];
        
    }
    [self setLayout];
//    [self getURl];
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
 
        if(weakself.judgePriceType ){
            UINavigationController *navC = weakself.navigationController;
                NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                for (UIViewController *vc in navC.viewControllers) {
                    [viewControllers addObject:vc];
                    if ([vc isKindOfClass:[LLMeOrderDetailController class]]) {
                        break;
                    }
                }
                if (viewControllers.count == navC.viewControllers.count) {
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [navC setViewControllers:viewControllers animated:YES];
                }
        }else{
            if(weakself.status == RoleStatusRedBag){
                LLSurpriseRegBagRecordViewController *vc = [[LLSurpriseRegBagRecordViewController alloc]init];
                vc.isRoot = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                [weakself.navigationController popToRootViewControllerAnimated:YES];
            }
        }
       
    };
}
-(void)getURl{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_orderNo forKey:@"orderNo"];
    NSString *orderType = @"1";
    if(_status == RoleStatusRedBag){
        orderType = @"2";
    }else if (_status == RoleStatusPingjian){
        orderType = @"3";
    }else if (_status == RoleStatusStockPeisong){
        orderType = @"4";
    }
    [param setValue:orderType forKey:@"orderType"];//订单类型（1零售商品、2惊喜红包商品、3品鉴商品）
    [XJHttpTool post:FORMAT(@"%@/%@/%@",L_apiapporderpaysuccess,orderType,_orderNo) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)setLayout{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SCREEN_top);
        make.bottom.equalTo(weakself.backView.mas_top).offset(0);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.equalTo(DeviceXTabbarHeigh(52));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(6));
        make.height.equalTo(CGFloatBasedI375(38));
    }];
    self.tableView.tableHeaderView = self.headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.model.expressType.integerValue == 2 && self.model.shopName.length > 0){
        return 5;;
    }
    return 0;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(400);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = BG_Color;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(400))];
    header.backgroundColor = [UIColor clearColor];
    
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLStoreSureOrderViewCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCellid];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLStoreSureOrderViewCommonCell class] forCellReuseIdentifier:LLStoreSureOrderViewCellid];
        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
-(LLStorePaySuccessHeadView *)headView{
    if(!_headView){
        _headView = [[LLStorePaySuccessHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(209))];
        [self.view addSubview:self.headView];
    }
    return _headView;
}
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        [self.view addSubview:self.backView];
    }
    return _backView;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [[UIButton alloc]init];
        [_sureButton setTitle:@"查看订单" forState:UIControlStateNormal];
        if(_judgePriceType){
            [_sureButton setTitle:@"返回" forState:UIControlStateNormal];
        }
        [_sureButton setTitleColor:lightGrayFFFF_Color forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = CGFloatBasedI375(19);
        _sureButton.backgroundColor = Main_Color;
        [self.backView addSubview:self.sureButton];
        [_sureButton addTarget:self action:@selector(subUrl) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sureButton;
}

-(void)subUrl{
    
    if(_judgePriceType){
        UINavigationController *navC = self.navigationController;
                        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                        for (UIViewController *vc in navC.viewControllers) {
                            [viewControllers addObject:vc];
                            if ([vc isKindOfClass:[LLMeOrderDetailController class]]) {
                                break;
                            }
                        }
                        if (viewControllers.count == navC.viewControllers.count) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        else {
                            [navC setViewControllers:viewControllers animated:YES];
                        }
    }else{
        if(_status == RoleStatusStockPeisong){

            LLMeDeliverListVC *orderVC = [[LLMeDeliverListVC alloc]init];
            orderVC.orderStatus = 0;
            orderVC.index = 0;
            orderVC.payui = YES;
            [self.navigationController pushViewController:orderVC animated:YES];
        }else{
            if(_status == RoleStatusRedBag){
                LLSurpriseRegBagRecordViewController *vc = [[LLSurpriseRegBagRecordViewController alloc]init];
                vc.isRoot = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
            LLMeOrderListController *vc = [[LLMeOrderListController alloc]init];
            vc.payui = YES;
            vc.orderStatus = 2;
            vc.status =self.status;
            [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }

}
@end
