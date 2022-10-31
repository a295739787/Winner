//
//  LLSystemSettingController.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLSystemSettingController.h"
#import "LLSystemTableCell.h"
#import "LLFeedbackController.h"
#import "LLQuestionController.h"
#import "LLAboutMeController.h"
#import "LLZhuxiaoViewController.h"
@interface LLSystemSettingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation LLSystemSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"系统设置";
    [self.view addSubview:self.tableView];
}

#pragma mark--quteLoginBtnClick
-(void)quteLoginBtnClick:(UIButton *)btn{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@",L_apioauthLogout) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        [AccessTool  removeUserInfo];
        [UserModel resetModel:nil];
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [dele loginMainVc];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLSystemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSystemTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textStr = @[@"意见反馈",@"常见问题",@"关于我们",@"注销账号"][indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFloatBasedI375(64);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *quteLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quteLoginBtn.frame = CGRectMake(0, CGFloatBasedI375(20), SCREEN_WIDTH, CGFloatBasedI375(44));
    quteLoginBtn.backgroundColor = [UIColor whiteColor];
    [quteLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quteLoginBtn setTitleColor:UIColorFromRGB(0x443415 ) forState:UIControlStateNormal];
    quteLoginBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
    [quteLoginBtn addTarget:self action:@selector(quteLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:quteLoginBtn];
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //意见反馈
        LLFeedbackController *feedbackVC = [[LLFeedbackController alloc]init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }else if (indexPath.row == 1){
        //常见问题
        LLQuestionController *questionVC = [[LLQuestionController alloc]init];
        [self.navigationController pushViewController:questionVC animated:YES];
    }else if (indexPath.row == 2){
        //关于我们
        LLAboutMeController *aboutMeVC = [[LLAboutMeController alloc]init];
        [self.navigationController pushViewController:aboutMeVC animated:YES];
    }else{
        LLZhuxiaoViewController *vc = [[LLZhuxiaoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLSystemTableCell class] forCellReuseIdentifier:@"LLSystemTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
