//
//  LLOrderAppltBillController.m
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import "LLOrderAppltBillController.h"
#import "LLOrderApplyBillInfoTableCell.h"
#import "LLBillInfoController.h"
#import "LLOrderApplyBillStatusConoller.h"

@interface LLOrderAppltBillController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)LLOrderApplyBillModel *billModel;

@property (nonatomic,strong)NSString *invoiceId;
@property (assign, nonatomic)BOOL isDefault;


@end

@implementation LLOrderAppltBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"申请开票";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom - CGFloatBasedI375(49));
    }];
    //    //开票状态（1未开票，2开票中，3已开票，4不通过）
    if(![_invoiceStatus isEqual:@"1"]){
        [self getBillDEtailUrl];
    }

    
}
-(void)getBillDEtailUrl{
    
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

#pragma mark--podBtnClick
-(void)podBtnClick:(UIButton *)btn{
    
    if ([_invoiceId length] <= 0) {
        [MBProgressHUD showError:@"请选择发票抬头"];
        return;;
    }else{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:_invoiceId forKey:@"invoiceId"];
        [params setValue:@(_isDefault) forKey:@"isDefault"];
        [params setValue:self.orderNo forKey:@"orderNo"];
        WS(weakself);
        [XJHttpTool post:L_getOrderBillPodurl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
            
            [JXUIKit showSuccessWithStatus:@"发票已寄出，请留意快递电话"];
            LLOrderApplyBillStatusConoller *statusVC = [[LLOrderApplyBillStatusConoller alloc]init];
            statusVC.orderNo = self.orderNo;
            [weakself.navigationController pushViewController:statusVC animated:YES];
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
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
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LLOrderApplyBillInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderApplyBillInfoTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderNo = self.orderNo;
        cell.billModel = _model;
        return cell;
    }
    LLOrderApplyBillSelectTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderApplyBillSelectTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexRow = indexPath.row;
    cell.leftStr = @[@"发票类型",@"抬头类型",@"发票抬头",@"设置默认抬头"][indexPath.row];
    cell.rightStr = self.dataArray[indexPath.row];
    WS(weakself);
    cell.LLOrderBillSelelctBtnBlock = ^(BOOL isSelect) {
        
        weakself.isDefault = isSelect;
        [weakself.dataArray replaceObjectAtIndex:3 withObject:isSelect == NO ? @"0" :@"1"];
        [weakself.tableView reloadData];
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(80);
    }
    return CGFloatBasedI375(44);
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        LLBillInfoController *billInfoVC = [[ LLBillInfoController alloc]init];
        billInfoVC.isSelectType = YES;
        WS(weakself);
        billInfoVC.LLBillInfoSelectBlock = ^(LLBillModel * _Nonnull listModel) {
            
            NSString *invoiceType = listModel.invoiceType;
            NSString *headerType = listModel.headerType;
            NSString *invoiceHeader = listModel.invoiceHeader;
            weakself.invoiceId = listModel.ID;
            
            [weakself.dataArray replaceObjectAtIndex:0 withObject:invoiceType];
            [weakself.dataArray replaceObjectAtIndex:1 withObject:headerType];
            [weakself.dataArray replaceObjectAtIndex:2 withObject:invoiceHeader];
            
            [weakself.tableView reloadData];
        };
        [self.navigationController pushViewController:billInfoVC animated:YES];
    }

}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLOrderApplyBillInfoTableCell class] forCellReuseIdentifier:@"LLOrderApplyBillInfoTableCell"];
        [_tableView registerClass:[LLOrderApplyBillSelectTableCell class] forCellReuseIdentifier:@"LLOrderApplyBillSelectTableCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"发票类型",@"抬头类型",@"去添加",@"", nil];
    }
    return _dataArray;
}
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(49) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(49) + SCREEN_Bottom)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *podBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        podBtn.backgroundColor = UIColorFromRGB(0xD40006);
        [podBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [podBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        podBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [podBtn addTarget:self action:@selector(podBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        podBtn.layer.cornerRadius = CGFloatBasedI375(18);
        podBtn.clipsToBounds = YES;
        [_bottomView addSubview:podBtn];
        [podBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CGFloatBasedI375(6));
            make.left.mas_equalTo(CGFloatBasedI375(15));
            make.right.mas_equalTo(CGFloatBasedI375(-15));
            make.height.mas_equalTo(CGFloatBasedI375(36));
        }];
        
    }
    return _bottomView;
}

@end
