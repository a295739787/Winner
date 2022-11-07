//
//  LLQuestionController.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "LLQuestionController.h"
#import "LLSystemTableCell.h"
#import "QuestionModel.h"
#import "LLQuestionDetailController.h"

@interface LLQuestionController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LLQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.customNavBar.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self getlistUrl];
}
#pragma mark--getlistUrl
-(void)getlistUrl{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:L_getQuestionListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSArray *data = responseObj[@"data"];
        
        for (NSDictionary *dict in data) {
            QuestionModel *model = [QuestionModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLSystemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSystemTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QuestionModel *listModel = self.dataArray[indexPath.row];
    cell.textStr = listModel.title;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
    QuestionModel *listModel = self.dataArray[indexPath.row];
    LLQuestionDetailController *detailVC = [[LLQuestionDetailController alloc]init];
    detailVC.listModel = listModel;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNavBar.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.customNavBar.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLSystemTableCell class] forCellReuseIdentifier:@"LLSystemTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
