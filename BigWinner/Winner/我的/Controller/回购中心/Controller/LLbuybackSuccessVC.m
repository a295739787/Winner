//
//  LLbuybackSuccessVC.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLbuybackSuccessVC.h"
#import "LLBuyBackView.h"
#import "LLMeBuyBackTableCell.h"
#import "LLMeBuyBackController.h"
@interface LLbuybackSuccessVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation LLbuybackSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.disableDragBack = YES;
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LLbuybackSuccessVC" object:nil];
        UINavigationController *navC = weakself.navigationController;
            NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
            for (UIViewController *vc in navC.viewControllers) {
                [viewControllers addObject:vc];
                if ([vc isKindOfClass:[LLMeBuyBackController class]]) {
                    break;
                }
            }
            if (viewControllers.count == navC.viewControllers.count) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            else {
                [navC setViewControllers:viewControllers animated:YES];
            }
    };
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"回购成功";
    [self.view addSubview:self.tableView];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLBuybackSuccessTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBuybackSuccessTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftStr = @[@"回购商品",@"回购数量",@"回购总价"][indexPath.row];
    if (self.successModel) {
        NSString *goodsName = self.successModel.goodsName;
        NSString *goodsNum = [NSString stringWithFormat:@"%@件",self.successModel.goodsNum];
        NSString *totalPrice = [NSString stringWithFormat:@"¥%@",self.successModel.totalPrice];
        cell.rightStr = @[goodsName,goodsNum,totalPrice][indexPath.row];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(212);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLBuybackSuccessHeaderView *headerView = [[LLBuybackSuccessHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
    
    return headerView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLBuybackSuccessTableCell class] forCellReuseIdentifier:@"LLBuybackSuccessTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
