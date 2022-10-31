//
//  LLOrderApplyBillStatusConoller.m
//  Winner
//
//  Created by YP on 2022/3/17.
//

#import "LLOrderApplyBillStatusConoller.h"
#import "LLOrderApplyBillInfoTableCell.h"

@interface LLOrderApplyBillStatusConoller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArry;
@property (nonatomic,strong) LLOrderApplyBillModel *billModel;

@end

@implementation LLOrderApplyBillStatusConoller

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createUI];
    
    [self requestUrl];
}

#pragma mark--requestUrl
-(void)requestUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.orderNo forKey:@"orderNo"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_getOrderBillDeialUrl,self.orderNo) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        LLOrderApplyBillModel *billModel = [LLOrderApplyBillModel yy_modelWithJSON:data];
        weakself.billModel = billModel;
        [weakself.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"申请开票";
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom - CGFloatBasedI375(49));
    }];
}

#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if ([_billModel.invoiceStatus intValue] == 2) {
        if(_billModel.receiveEmail.length <= 0){
            return 2;
        }
        //开票中
        return 3;
    }else if ([_billModel.invoiceStatus intValue] == 3){
        if(_billModel.receiveEmail.length <= 0){
            return 3;
        }
        //已开票
        return 4;
    }
    if(_billModel.receiveEmail.length <= 0){
        return 3;
    }
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        LLOrderApplyBillInfoStatusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderApplyBillInfoStatusTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.billModel) {
            cell.billModel = self.billModel;
        }
        
        return cell;
    }
    LLOrderApplyBillListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderApplyBillListTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_billModel) {
        NSString *invoicePrice = (_billModel.invoicePrice == nil ? @"" : _billModel.invoicePrice);
        NSString *receiveEmail = (_billModel.receiveEmail == nil ? @"" : _billModel.receiveEmail);
        NSString *invoiceApplyTime = (_billModel.invoiceApplyTime == nil ? @"" : _billModel.invoiceApplyTime);
        NSString *invoiceTime = (_billModel.invoiceTime == nil ? @"" : _billModel.invoiceTime);
        invoicePrice = FORMAT(@"￥%@",invoicePrice);
        if ([_billModel.invoiceStatus intValue] == 2) {
            //开票中
     
            if(_billModel.receiveEmail.length <= 0){
                cell.leftStr = @[@"开票金额",@"申请时间"][indexPath.row];
                self.dataArry = @[invoicePrice,invoiceTime];
            }else{
                cell.leftStr = @[@"开票金额",@"接收邮箱",@"申请时间"][indexPath.row];
                self.dataArry = @[invoicePrice,receiveEmail,invoiceTime];
            }
        }else if ([_billModel.invoiceStatus intValue] == 3){
            if(_billModel.receiveEmail.length <= 0){
                cell.leftStr = @[@"开票金额",@"申请时间",@"开票时间"][indexPath.row];
                self.dataArry = @[invoicePrice,invoiceApplyTime,invoiceTime];
            }else{
                cell.leftStr = @[@"开票金额",@"接收邮箱",@"申请时间",@"开票时间"][indexPath.row];
                self.dataArry = @[invoicePrice,receiveEmail,invoiceApplyTime,invoiceTime];
            }
            //已开票
           
        }else{
            if(_billModel.receiveEmail.length <= 0){
                cell.leftStr = @[@"开票金额",@"申请时间",@"审核时间"][indexPath.row];
                self.dataArry = @[invoicePrice,invoiceApplyTime,invoiceTime];
            }else{
                cell.leftStr = @[@"开票金额",@"接收邮箱",@"申请时间",@"审核时间"][indexPath.row];
                self.dataArry = @[invoicePrice,receiveEmail,invoiceApplyTime,invoiceTime];
            }
        }
        cell.rightStr = self.dataArry[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(202);
    }
    return CGFloatBasedI375(35);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLOrderApplyBillListTableCell class] forCellReuseIdentifier:@"LLOrderApplyBillListTableCell"];
        [_tableView registerClass:[LLOrderApplyBillInfoStatusTableCell class] forCellReuseIdentifier:@"LLOrderApplyBillInfoStatusTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
