//
//  LLBillInfoDetailController.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLBillInfoDetailController.h"
#import "LLBillInfoView.h"
#import "LLBillInfoTableCell.h"
#import "LLMeAdressView.h"
#import "LLMeAdressController.h"

@interface LLBillInfoDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBillInfoView *bottomView;
@property (nonatomic,strong)LLBillSelectTypeView *selectTypeView;
@property (nonatomic,strong)LLMeAdressDeleteView *deleteView;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArry;

@property (nonatomic,strong)NSString *invoiceHeader;
@property (nonatomic,strong)NSString *invoiceType;
@property (nonatomic,strong)NSString *contactTelePhone;
@property (nonatomic,strong)NSString *receiveEmail;
@property (nonatomic,strong)NSString *unitTaxNo;
@property (nonatomic,strong)NSString *receiveAddress;
@property (nonatomic,strong)NSString *bankDeposit;
@property (nonatomic,strong)NSString *bankAccount;
@property (nonatomic,strong)NSString *companyTelePhone;
@property (nonatomic,strong)NSString *companyAddress;

@end

@implementation LLBillInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.customNavBar.title = @"编辑发票抬头";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    
    self.invoiceHeader = self.listModel.invoiceHeader;
    self.unitTaxNo = [self.listModel.unitTaxNo length] <= 0 ? @"没有税号" : self.listModel.unitTaxNo;
    self.receiveEmail = [self.listModel.receiveEmail length] <= 0 ? @"" : self.listModel.receiveEmail;
    self.invoiceType = self.listModel.invoiceType;
    self.contactTelePhone = [self.listModel.contactTelePhone length] <= 0 ? @"" : self.listModel.contactTelePhone;
    self.receiveAddress = [self.listModel.receiveAddress length] <= 0 ? @"123" : self.listModel.receiveAddress;
    self.bankDeposit = [self.listModel.bankDeposit length] <= 0 ? @"" : self.listModel.bankDeposit;
    self.bankAccount = [self.listModel.bankAccount length] <= 0 ? @"" : self.listModel.bankAccount;
    self.companyTelePhone = [self.listModel.companyTelePhone length] <= 0 ? @"123" : self.listModel.companyTelePhone;
    self.companyAddress = [self.listModel.companyAddress length] <= 0 ? @"123" : self.listModel.companyAddress;
    
    if ([self.listModel.invoiceType intValue] == 1) {
        //增值税电子普通发票
        if ([self.listModel.headerType intValue] == 1) {
            //个人/非企业单位
            self.dataArry = [[NSMutableArray alloc]initWithObjects:self.invoiceHeader,self.contactTelePhone,self.receiveEmail, nil];
        }else{
            self.dataArry = [[NSMutableArray alloc]initWithObjects:self.invoiceHeader,self.unitTaxNo,self.contactTelePhone,self.receiveEmail, nil];
        }
        
    }else{
        //增值税专用发票
        self.dataArry = [[NSMutableArray alloc]initWithObjects:self.invoiceHeader,self.unitTaxNo,self.companyAddress,self.bankDeposit,self.bankAccount,self.companyTelePhone,self.receiveAddress, nil];
    }
}


-(void)podSaveInvoice{
    
    
    
    if ([self.listModel.headerType intValue] == 1) {
        //个人/非企业单位
        if ([_invoiceHeader length] <= 0) {
            [MBProgressHUD showError:@"请输入发票抬头"];
            return;
        }else if ([_contactTelePhone length] <= 0){
            [MBProgressHUD showError:@"请输入联系手机号码"];
            return;
        }else if ([_receiveEmail length] <= 0){
            [MBProgressHUD showError:@"请输入接收电子发票邮箱"];
            return;
        }else{
            [self saveInvoceUrl:1];
        }
    }else{
        //企业单位
        if ([self.listModel.invoiceType intValue]  == 1) {
            if ([_invoiceHeader length] <= 0) {
                [MBProgressHUD showError:@"请输入发票抬头"];
                return;
            }else if ([_contactTelePhone length] <= 0){
                [MBProgressHUD showError:@"请输入联系手机号码"];
                return;
            }else if ([_receiveEmail length] <= 0){
                [MBProgressHUD showError:@"请输入接收电子发票邮箱"];
                return;
            }else if ([_unitTaxNo length] <= 0){
                [MBProgressHUD showError:@"请输入纳税人识别号"];
                return;
            }else{
                [self saveInvoceUrl:2];
            }
        }else{
            if ([_invoiceHeader length] <= 0) {
                [MBProgressHUD showError:@"请输入发票抬头"];
                return;
            }else if ([_unitTaxNo length] <= 0){
                [MBProgressHUD showError:@"请输入纳税人识别号"];
                return;
            }else if ([_companyAddress length] <= 0){
                [MBProgressHUD showError:@"请输入注册地址"];
                return;
            }else if ([_bankDeposit length] <= 0){
                [MBProgressHUD showError:@"请输入开户银行"];
                return;
            }else if ([_bankAccount length] <= 0){
                [MBProgressHUD showError:@"请输入银行账号"];
                return;
            }else if ([_companyTelePhone length] <= 0){
                [MBProgressHUD showError:@"请输入注册电话"];
                return;
            }else if ([_receiveAddress length] <= 0){
                [MBProgressHUD showError:@"请输入收件地址"];
                return;
            }else{
                [self saveInvoceUrl:2];
            }
        }
    }
}
-(void)saveInvoceUrl:(NSInteger)headerType{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@(NO) forKey:@"isDefault"];
    if (headerType == 1) {
        [params setObject:@(headerType) forKey:@"headerType"];
        [params setObject:_invoiceHeader forKey:@"invoiceHeader"];
        [params setObject:_contactTelePhone forKey:@"contactTelePhone"];
        [params setObject:_receiveEmail forKey:@"receiveEmail"];
        [params  setObject:@"1" forKey:@"invoiceType"];
        [params  setObject:self.listModel.ID forKey:@"id"];
    }else{
        if ([self.listModel.invoiceType intValue] == 1) {
            [params setObject:@(headerType) forKey:@"headerType"];
            [params setObject:_invoiceHeader forKey:@"invoiceHeader"];
            [params setObject:_contactTelePhone forKey:@"contactTelePhone"];
            [params setObject:_receiveEmail forKey:@"receiveEmail"];
            [params  setObject:@"1" forKey:@"invoiceType"];
            [params  setObject:self.listModel.ID forKey:@"id"];
            [params setObject:self.unitTaxNo forKey:@"unitTaxNo"];
        }else{
            [params setObject:@(headerType) forKey:@"headerType"];
            [params setObject:_invoiceHeader forKey:@"invoiceHeader"];
            [params setObject:_unitTaxNo forKey:@"unitTaxNo"];
            [params  setObject:_companyAddress forKey:@"companyAddress"];
            [params  setObject:_bankDeposit forKey:@"bankDeposit"];
//            [params setObject:_receiveEmail forKey:@"eceiveEmail"];
            [params  setObject:_bankAccount forKey:@"bankAccount"];
            [params  setObject:_companyTelePhone forKey:@"companyTelePhone"];
            [params setObject:_companyAddress forKey:@"companyAddress"];
            [params  setObject:@"2" forKey:@"invoiceType"];
            [params  setObject:self.listModel.ID forKey:@"id"];
        }
    }
    
    WS(weakself);
    [XJHttpTool post:L_editorInvoceUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            [JXUIKit showSuccessWithStatus:@"保存成功"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showSuccess:responseObj[@"msg"]];
        }
            
        } failure:^(NSError * _Nonnull error) {
            
    }];
    
}

#pragma mark--删除发票
-(void)delteUtl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_listModel.ID forKey:@"id"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_deleteBillUrl,_listModel.ID) method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            [JXUIKit showSuccessWithStatus:@"删除成功"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showSuccess:responseObj[@"msg"]];
        }
        } failure:^(NSError * _Nonnull error) {
            
    }];
}


#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.listModel.invoiceType intValue] == 1) {
        if ([self.listModel.headerType intValue] == 1) {
            return 3;
        }
        return 4;
    }
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.listModel.invoiceType intValue] == 1) {
        
        if ([self.listModel.headerType intValue] == 1) {
            LLBillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBillDetailTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.indexRow = indexPath.row;
            cell.titleStr = @[@"发票抬头",@"联系电话",@"电子邮箱"][indexPath.row];
            cell.placeholder = @[@"请输入发票抬头",@"请输入联系手机号码",@"请输入接收电子发票邮箱"][indexPath.row];
            cell.typeStr = self.dataArry[indexPath.row];
            WS(weakself);
            cell.editorInvoceBlock = ^(NSInteger index, NSString * _Nonnull contentStr) {
                if (index == 0) {
                    weakself.invoiceHeader = contentStr;
                }else if (index == 1){
                    weakself.contactTelePhone = contentStr;
                }else{
                    weakself.receiveEmail = contentStr;
                }
            };
            return cell;
        }
        LLBillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBillDetailTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexRow = indexPath.row;
        cell.titleStr = @[@"发票抬头",@"单位税号",@"联系电话",@"电子邮箱"][indexPath.row];
        cell.placeholder = @[@"",@"请输入单位税号",@"请输入联系手机号码",@"请输入接收电子发票邮箱"][indexPath.row];
        cell.typeStr = self.dataArry[indexPath.row];
        WS(weakself);
        cell.editorInvoceBlock = ^(NSInteger index, NSString * _Nonnull contentStr) {
            if (index == 0) {
                weakself.invoiceHeader = contentStr;
            }else if (index == 1){
                weakself.unitTaxNo = contentStr;
            }else if (index == 2){
                weakself.contactTelePhone = contentStr;
            }else{
                weakself.receiveEmail = contentStr;
            }
        };
        return cell;
    }
    LLBillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBillDetailTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexRow = indexPath.row;
    cell.titleStr = @[@"发票抬头",@"单位税号",@"注册地址",@"开户银行",@"银行账号",@"注册电话",@"收件地址"][indexPath.row];
    cell.placeholder = @[@"请输入发票抬头",@"请输入纳税人识别号",@"请输入注册地址",@"请输入开户银行",@"请输入银行账号",@"请输入注册电话",@""][indexPath.row];
    cell.typeStr = self.dataArry[indexPath.row];
    WS(weakself);
    cell.editorInvoceBlock = ^(NSInteger index, NSString * _Nonnull contentStr) {
        if (index == 0) {
            weakself.invoiceHeader = contentStr;
        }else if (index == 1){
            weakself.unitTaxNo = contentStr;
        }else if(index == 2){
            weakself.companyAddress = contentStr;
        }else if(index == 3){
            weakself.bankDeposit = contentStr;
        }else if(index == 4){
            weakself.bankAccount = contentStr;
        }else if(index == 5){
            weakself.companyTelePhone = contentStr;
        }else{
            weakself.receiveAddress = contentStr;
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:tableView.tableHeaderView.frame];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = UIColorFromRGB(0x443415);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"";
    titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.centerY.mas_equalTo(headerView);
    }];
    
    if (self.listModel) {
        
        NSString *typeStr = [self.listModel.invoiceType intValue] == 1 ? @"增值税电子普通发票" : @"增值税专用发票";
        NSString *headerStr = [self.listModel.headerType intValue] == 1 ? @"个人/非企业单位" : @"企业单位";
        titleLabel.text = [NSString stringWithFormat:@"%@-%@",typeStr,headerStr];
    }
    
    
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        LLMeAdressController *adressVC = [[LLMeAdressController alloc]init];
        adressVC.isChoice = YES;
        WS(weakself);
        adressVC.getAressBlock = ^(LLGoodModel * _Nonnull model) {
            weakself.receiveAddress = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.address];
            [weakself.dataArry replaceObjectAtIndex:6 withObject:weakself.receiveAddress];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:6 inSection:0];
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:adressVC animated:YES];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(50) - SCREEN_Bottom) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLBillInfoContentTableCell class] forCellReuseIdentifier:@"LLBillInfoContentTableCell"];
        [_tableView registerClass:[LLBillDetailTableViewCell class] forCellReuseIdentifier:@"LLBillDetailTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(LLBillSelectTypeView *)selectTypeView{
    if (!_selectTypeView) {
        _selectTypeView = [[LLBillSelectTypeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _selectTypeView;
}


-(LLBillInfoView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLBillInfoView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        _bottomView.indexType = 300;
        WS(weakself);
        _bottomView.billInfoBtnBlock = ^(NSInteger btnTag, UIButton * _Nonnull btn) {
            if (btnTag == 300) {
                //删除
                [weakself.deleteView show];
                
            }else if (btnTag == 400){
                //保存
                [weakself podSaveInvoice];
            }
        };
      
    }
    return _bottomView;
}

-(LLMeAdressDeleteView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _deleteView.textStr = @"确定删除发票抬头？";
        _deleteView.titleStr = @"确认删除";
        _deleteView.rightStr = @"删除";
        WS(weakself);
        _deleteView.deleteBtnBlock = ^{
            //删除
            [weakself delteUtl];
        };
    }
    return _deleteView;
}
-(NSMutableArray *)dataArry{
    if (!_dataArry){
        _dataArry = [[NSMutableArray alloc]init];
    }
    return _dataArry;
}


@end
