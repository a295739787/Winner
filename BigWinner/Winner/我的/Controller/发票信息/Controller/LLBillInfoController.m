//
//  LLBillInfoController.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLBillInfoController.h"
#import "LLBillInfoTableCell.h"
#import "LLBillInfoDetailController.h"
#import "LLBillInfoView.h"
#import "LLBillInfoAddController.h"
#import "LLBillModel.h"

@interface LLBillInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (nonatomic,strong)LLBillInfoView *bottomView;
@property (nonatomic,strong)NSMutableArray *dataArry;
@property (assign, nonatomic) NSInteger currentPage;


@end

@implementation LLBillInfoController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataArry removeAllObjects];
    self.currentPage = 1;
    
    for (int i = 0; i < 3; i++) {
        NSMutableArray *arrary = [[NSMutableArray alloc]init];
        [self.dataArry addObject:arrary];
    }
    
    [self getListUrl];
}

- (void)viewDidLoad {
    self.currentPage = 1;
    [super viewDidLoad];
    [self createUI];
}

#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"发票信息";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom - CGFloatBasedI375(50));
    }];
}
-(void)header{
    self.currentPage = 1;
    [self getListUrl];
}
-(void)footer{
    self.currentPage ++;
    [self getListUrl];
}

#pragma mark--getListUrl
-(void)getListUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@(_currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"headerType"];
    [params setObject:@"" forKey:@"invoiceType"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"asc" forKey:@"sort"];
    WS(weakself);
    [XJHttpTool post:L_invoceListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
//        NSString *code = responseObj[@"code"];
        
        if (weakself.currentPage == 1) {
            [self.dataArry removeAllObjects];
            for (int i = 0; i < 3; i++) {
                NSMutableArray *arrary = [[NSMutableArray alloc]init];
                [self.dataArry addObject:arrary];
            }
        }
        
        NSArray *data = responseObj[@"data"];
        for (NSDictionary *dict in data) {
            LLBillModel *listModel = [LLBillModel mj_objectWithKeyValues:dict];
            
            NSMutableArray *array1 = self.dataArry[0];
            NSMutableArray *array2 = self.dataArry[1];
            NSMutableArray *array3 = self.dataArry[2];
            
            if ([listModel.headerType intValue] == 1) {
                //个人非企业单位
                [array1 addObject:listModel];
            }else if([listModel.headerType intValue] == 2 && [listModel.invoiceType intValue] == 1){
                //企业单位。增值税电子普通发票
                [array2 addObject:listModel];
            }else{
                //企业单位。增值税专用发票
                [array3 addObject:listModel];
            }
            [self.dataArry replaceObjectAtIndex:0 withObject:array1];
            [self.dataArry replaceObjectAtIndex:1 withObject:array2];
            [self.dataArry replaceObjectAtIndex:2 withObject:array3];
            
        }
        
        if(data.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        if(self.dataArry.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"暂无数据"];
        }else{
            [self.tableView removeEmptyView];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *listArray = self.dataArry[section];
    return listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLBillInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBillInfoTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArry.count > 0) {
        NSMutableArray *listArray = self.dataArry[indexPath.section];
        if (listArray.count > 0) {
            cell.listModel = listArray[indexPath.row];
        }
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArry.count > 0) {
        NSMutableArray *listArray = self.dataArry[indexPath.section];
        if (listArray.count > 0) {
            LLBillModel *listModel = listArray[indexPath.row];
            if ([listModel.headerType intValue] == 1) {
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(65);
        }
        return 0.1;
    }
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSMutableArray *listArray = self.dataArry[section];
    if (listArray.count > 0) {
        return CGFloatBasedI375(54);
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArry.count > 0) {
        NSMutableArray *listArray = self.dataArry[section];
        if (listArray.count > 0) {
            
            UIView *headerView = [[UIView alloc]initWithFrame:tableView.tableHeaderView.frame];
            headerView.backgroundColor = [UIColor clearColor];
            
            UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGFloatBasedI375(10), SCREEN_WIDTH, CGFloatBasedI375(44))];
            bottomView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:bottomView];
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.textColor = UIColorFromRGB(0x443415);
            titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            [bottomView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(CGFloatBasedI375(15));
                make.centerY.mas_equalTo(bottomView);
            }];
            
            
            NSMutableArray *listArray = self.dataArry[section];
            LLBillModel *listModel = listArray[0];
            NSString *typeStr = [listModel.invoiceType intValue] == 1 ? @"增值税电子普通发票" : @"增值税专用发票";
            NSString *headerStr = [listModel.headerType intValue] == 1 ? @"个人/非企业单位" : @"企业单位";
            titleLabel.text = [NSString stringWithFormat:@"%@-%@",typeStr,headerStr];
            
            return headerView;
        }
        return nil;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArry.count > 0) {
        NSArray *listArray = self.dataArry[indexPath.section];
        if(listArray.count){
            LLBillModel *listModel = listArray[indexPath.row];
            if (self.isSelectType == YES) {
                if (self.LLBillInfoSelectBlock) {
                    self.LLBillInfoSelectBlock(listModel);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                LLBillInfoDetailController *detailVC = [[LLBillInfoDetailController alloc]init];
                detailVC.listModel = listModel;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
    }
}

-(LLBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(50) - SCREEN_Bottom) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLBillInfoTableCell class] forCellReuseIdentifier:@"LLBillInfoTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _tableView.mj_footer = footer;
        adjustsScrollViewInsets_NO(_tableView, self);
    }
    return _tableView;
}
-(LLBillInfoView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLBillInfoView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        _bottomView.indexType = 100;
        WS(weakself);
        _bottomView.billInfoBtnBlock = ^(NSInteger btnTag, UIButton * _Nonnull btn) {
            if (btnTag == 100) {
                LLBillInfoAddController *addBillVC = [[LLBillInfoAddController alloc]init];
                addBillVC.tapAction = ^{
                    weakself.currentPage = 1;
                    [weakself getListUrl];
                };
                [weakself.navigationController pushViewController:addBillVC animated:YES];
            }
        };
      
    }
    return _bottomView;
}
-(NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [[NSMutableArray alloc]init];
    }
    return _dataArry;
}

@end
