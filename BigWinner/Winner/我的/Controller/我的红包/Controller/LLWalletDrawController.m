//
//  LLWalletDrawController.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLWalletDrawController.h"
#import "LLWalletDrawView.h"
#import "LLWalletListTableCell.h"
#import "LLPersonalModel.h"
#import "LLAddBankCardController.h"
#import "Winner-Swift.h"

@interface LLWalletDrawController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) LLPersonalModel *personalModel;/** <#class#> **/
@property (nonatomic,strong)  LLWalletDrawView *headerView;/** <#class#> **/

@end

@implementation LLWalletDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getPersonalUrl];
}

#pragma mark--getPersonalUrl
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.personalModel = [LLPersonalModel mj_objectWithKeyValues:data];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self.tableView reloadData];
}
-(void)postUrl{
    if(self.headerView.textField.text.floatValue <= 0){
        [JXUIKit showErrorWithStatus:@"提现金额不能为0"];
        return;;
    }
    int mon = self.headerView.textField.text.intValue;
    if(mon % 100 != 0){
        [JXUIKit showErrorWithStatus:@"提现金额只能整百"];
        return;;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.headerView.textField.text forKey:@"price"];
    [XJHttpTool post:L_apiappuserbalancewithdrawal method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        if(self.clickTap){
            self.clickTap();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self.tableView reloadData];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"提现";
    [self.view addSubview:self.tableView];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LLWalletAddBankCardTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLWalletAddBankCardTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.personalModel =self.personalModel;
        return cell;
    }else{
        XYOrderQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYQuestionCell" forIndexPath:indexPath];
        cell.questionLabel.text = @"提现遇到问题？";
        return  cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(54);
    }else{
        return CGFloatBasedI375(50);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGFloatBasedI375(147);
    }else{
        return CGFloatBasedI375(0.01);
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        LLWalletDrawFooterView *footerView = [[LLWalletDrawFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
        WS(weakself);
        footerView.clickTap = ^{
            [weakself postUrl];
        };
        return footerView;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGFloatBasedI375(155);
    }else{
        return CGFloatBasedI375(0.01);
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        LLWalletDrawView *headerView = [[LLWalletDrawView alloc]initWithFrame:tableView.tableHeaderView.frame];
        self.headerView = headerView;
        headerView.model = self.personalModel;
        return headerView;
    }else{
        return nil;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    if (indexPath.section == 0) {
        //    if ([self.personalModel.isBank intValue] == 0) {
        LLAddBankCardController *vc = [[LLAddBankCardController alloc]init];
        vc.ID = self.personalModel.bankId;
        
        vc.addBankSuccessBlock = ^(NSMutableDictionary * _Nonnull dict) {
            //        weakself.personalModel.isBank = @"1";
            weakself.personalModel.bankName = dict[@"bankName"];
            weakself.personalModel.bankCardNum = dict[@"bankCardNum"];
            [weakself getPersonalUrl];
            
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [weakself.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
        //    }
    }else{
        
        XYServiceTipsViewController *serviceVC = [[XYServiceTipsViewController alloc]init];
        serviceVC.pushBlock = ^(UIViewController * view) {
            [weakself.navigationController pushViewController:view animated:YES];
        };
        serviceVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        serviceVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:serviceVC animated:YES completion:nil];
    }
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLWalletAddBankCardTableCell class] forCellReuseIdentifier:@"LLWalletAddBankCardTableCell"];
        [_tableView registerClass:[XYOrderQuestionTableViewCell class] forCellReuseIdentifier:@"XYQuestionCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
