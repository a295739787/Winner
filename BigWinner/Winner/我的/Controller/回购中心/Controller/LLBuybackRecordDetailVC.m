//
//  LLBuybackRecordDetailVC.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLBuybackRecordDetailVC.h"
#import "LLBuyBackView.h"
#import "LLMeBuyBackTableCell.h"
#import "LLBackBuyDetailModel.h"

@interface LLBuybackRecordDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLBackBuyDetailModel *detailModel;

@end

@implementation LLBuybackRecordDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}


#pragma mark--createUI
-(void)createUI{
    
    self.customNavBar.title = @"回购商品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self requestUrl];
}
#pragma mark--requestUrl
-(void)requestUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.ID forKey:@"id"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_BackBuyDetailUrl,self.ID) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
//        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            weakself.detailModel = [LLBackBuyDetailModel yy_modelWithJSON:responseObj[@"data"]];
        }
        
        [weakself.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LLBuybackRecordDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBuybackRecordDetailTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.detailModel) {
            cell.detailModel = self.detailModel;
        }
        return cell;
    }
    LLBuybackRecordInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBuybackRecordInfoTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.detailModel) {
        cell.detailModel = self.detailModel;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(110);
    }
    return CGFloatBasedI375(165);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGFloatBasedI375(52);
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        LLBuybackRecoderFooterView *footerView = [[LLBuybackRecoderFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
        if (_detailModel) {
            footerView.detailModel = _detailModel;
        }
        return footerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFloatBasedI375(54);
    }
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        LLBuybackRecordHeaderView *headerView = [[LLBuybackRecordHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
        return headerView;
    }
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLBuybackRecordDetailTableCell class] forCellReuseIdentifier:@"LLBuybackRecordDetailTableCell"];
        [_tableView registerClass:[LLBuybackRecordInfoTableCell class] forCellReuseIdentifier:@"LLBuybackRecordInfoTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
