//
//  LLFeedbackSuccessController.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "LLFeedbackSuccessController.h"
#import "LLSystemTableCell.h"
#import "LLSystemSettingController.h"
@interface LLFeedbackSuccessController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation LLFeedbackSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        UINavigationController *navC = weakself.navigationController;
        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
        for (UIViewController *vc in navC.viewControllers) {
            [viewControllers addObject:vc];
            if ([vc isKindOfClass:[LLSystemSettingController class]]) {
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
    
    self.customNavBar.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLFeedbackSuccessTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLFeedbackSuccessTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WS(weakself);
    cell.LLFeedBackcancleBtnBlock = ^{
        UINavigationController *navC = weakself.navigationController;
        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
        for (UIViewController *vc in navC.viewControllers) {
            [viewControllers addObject:vc];
            if ([vc isKindOfClass:[LLSystemSettingController class]]) {
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
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(252);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED );
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLFeedbackSuccessTableCell class] forCellReuseIdentifier:@"LLFeedbackSuccessTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
