//
//  LLBillInfoAddController.m
//  Winner
//
//  Created by YP on 2022/1/24.
//

#import "LLBillInfoAddController.h"
#import "LLBillInfoView.h"
#import "LLBillInfoTableCell.h"
#import "LLAddBillBusinessTableCell.h"
#import "LLMeAdressController.h"

@interface LLBillInfoAddController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBillAddheaderView *headerView;
@property (nonatomic,strong)LLBillInfoView *bottomView;
@property (nonatomic,strong)LLBillSelectTypeView *selectTypeView;
@property (assign, nonatomic) NSInteger billType;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, copy) NSString *content;

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

@property (assign, nonatomic) NSInteger type;
@property (nonatomic,assign) BOOL taps;/** class **/


//@property (nonatomic,strong)NSString *
//@property (nonatomic,strong)NSString *


@end


@implementation LLBillInfoAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    _billType = 100;
    _type = 1;
    self.customNavBar.title = @"添加发票抬头";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
}
#pragma mark--保存发票抬头
-(void)podSaveInvoice:(UIButton *)sender{
    
    if (_billType == 100) {
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
            [self saveInvoceUrl:1 :sender];
        }
    }else{
        //企业单位
        if (self.type  == 1) {
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
            }else{
                [self saveInvoceUrl:2 :sender];
            }
        }else{
            if ([_invoiceHeader length] <= 0) {
                [MBProgressHUD showError:@"请输入发票抬头"];
                return;
            }else if ([_unitTaxNo length] <= 0){
                [MBProgressHUD showError:@"请输入纳税人识别号"];
                return;
            }else if ([_companyAddress length] <= 0){
                [MBProgressHUD showError:@"请输入注册 地址"];
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
                [self saveInvoceUrl:2 :sender];
            }
        }
    }
}
-(void)saveInvoceUrl:(NSInteger)headerType :(UIButton*)sender{
    
    NSString *invoiceHeader = [_invoiceHeader length] > 0 ? _invoiceHeader : @"";
    NSString *unitTaxNo = [_unitTaxNo length] > 0 ? _unitTaxNo : @"";
    NSString *companyAddress = [_companyAddress length] > 0 ? _companyAddress : @"";
    NSString *bankDeposit = [_bankDeposit length] > 0 ? _bankDeposit : @"";
    NSString *receiveEmail = [_receiveEmail length] > 0 ? _receiveEmail : @"";
    NSString *bankAccount = [_bankAccount length] > 0 ? _bankAccount : @"";
    NSString *companyTelePhone = [_companyTelePhone length] > 0 ? _companyTelePhone : @"";
    NSString *receiveAddress = [_receiveAddress length] > 0 ? _receiveAddress : @"";
    NSString *contactTelePhone = [_contactTelePhone length] > 0 ? _contactTelePhone : @"";
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@(NO) forKey:@"isDefault"];
    [params setObject:@(headerType) forKey:@"headerType"];
    [params setObject:invoiceHeader forKey:@"invoiceHeader"];
    [params setObject:unitTaxNo forKey:@"unitTaxNo"];
    [params setObject:companyAddress forKey:@"companyAddress"];
    [params setObject:bankDeposit forKey:@"bankDeposit"];
    [params setObject:receiveEmail forKey:@"receiveEmail"];
    [params setObject:bankAccount forKey:@"bankAccount"];
    [params setObject:companyTelePhone forKey:@"companyTelePhone"];
    [params setObject:receiveAddress forKey:@"receiveAddress"];
    [params setObject:@(self.type) forKey:@"invoiceType"];
    [params setObject:@"" forKey:@"id"];
    [params setObject:contactTelePhone forKey:@"contactTelePhone"];
    sender.enabled =  NO;
    WS(weakself);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [XJHttpTool post:L_editorInvoceUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSString *code = responseObj[@"code"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        sender.enabled =  YES;
        if ([code intValue] == 200) {
            [JXUIKit showSuccessWithStatus:@"保存成功"];
            if(self.tapAction){
                self.tapAction();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.navigationController popViewControllerAnimated:YES];
            });
          
        }else{
            [MBProgressHUD showSuccess:responseObj[@"msg"]];
        }
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            sender.enabled =  YES;
    }];
    
}


#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_billType == 100) {
        return 4;
    }
    return self.type == 1 ? 5 : 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_billType == 100) {
        LLBillInfoContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLBillInfoContentTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexRow = indexPath.row;
        cell.titleStr = @[@"发票类型",@"发票抬头",@"联系电话",@"电子邮箱"][indexPath.row];
        cell.placeholder = @[@"",@"请输入发票抬头",@"请输入联系手机号码",@"请输入接收电子发票邮箱"][indexPath.row];
        WS(weakself);
        cell.editorInvoceBlock = ^(NSInteger index, NSString * _Nonnull contentStr) {
            if (index == 1) {
                weakself.invoiceHeader = contentStr;
            }else if (index == 2){
                weakself.contactTelePhone = contentStr;
            }else{
                weakself.receiveEmail = contentStr;
            }
        };
        return cell;
    }else if (self.billType == 200) {
        
        if (self.type == 1) {
            LLAddBillBusinessTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLAddBillBusinessTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.indexRow = indexPath.row;
            cell.content = self.content;
            cell.type = _type;
            cell.leftStr = @[@"发票类型",@"发票抬头",@"单位税号",@"联系电话",@"电子邮箱"][indexPath.row];
            cell.placeholder = @[@"",@"请输入发票抬头",@"请输入纳税人识别号",@"请输入联系电话",@"请输入电子邮箱"][indexPath.row];

            WS(weakself);
            cell.LLAddBillBusinessBlock = ^(NSInteger index, NSString * _Nonnull content) {
                if (index == 1) {
                    weakself.invoiceHeader = content;
                }else if (index == 2){
                    weakself.unitTaxNo = content;
                }else if(index == 3){
                    weakself.contactTelePhone = content;
                }else{
                    weakself.receiveEmail = content;
                }
            };
            return cell;
        }
        
        LLAddBillSpecialAdressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLAddBillSpecialAdressTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexRow = indexPath.row;
        cell.leftStr = @[@"发票类型",@"发票抬头",@"单位税号",@"注册地址",@"开户银行",@"银行账号",@"注册电话",@"收件地址"][indexPath.row];
        cell.placeholder = @[@"",@"请输入发票抬头",@"请输入纳税人识别号",@"请输入注册地址",@"请输入开户银行",@"请输入银行账号",@"请输入注册电话",@"请选择发票收货地址"][indexPath.row];
        cell.content = self.content;
        cell.type = _type;
        if (_receiveAddress) {
            cell.adressStr = _receiveAddress;
        }
        WS(weakself);
        cell.LLAddBillBusinessBlock = ^(NSInteger index, NSString * _Nonnull content) {
            
            if (index == 1) {
                weakself.invoiceHeader = content;
            }else if (index == 2){
                weakself.unitTaxNo = content;
            }else if(index == 3){
                weakself.companyAddress = content;
            }else if(index == 4){
                weakself.bankDeposit = content;
            }else if(index == 5){
                weakself.bankAccount = content;
            }else if(index == 6){
                weakself.companyTelePhone = content;
            }
        };
        return cell;
       
    }
    return nil;
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
    
    
    if (_billType == 200) {
        
        if (indexPath.row == 0) {
            [self.selectTypeView show];
        }else if (indexPath.row == 7){
            LLMeAdressController *adressVC = [[LLMeAdressController alloc]init];
            adressVC.isChoice = YES;
            WS(weakself);
            adressVC.getAressBlock = ^(LLGoodModel * _Nonnull model) {
                weakself.receiveAddress = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.address];
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:7 inSection:0];
                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:adressVC animated:YES];
        }
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top + CGFloatBasedI375(50), SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(50) - CGFloatBasedI375(50) - SCREEN_Bottom) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLBillInfoContentTableCell class] forCellReuseIdentifier:@"LLBillInfoContentTableCell"];
        [_tableView registerClass:[LLAddBillBusinessTableCell class] forCellReuseIdentifier:@"LLAddBillBusinessTableCell"];
        [_tableView registerClass:[LLAddBillSpecialAdressTableCell class] forCellReuseIdentifier:@"LLAddBillSpecialAdressTableCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(LLBillAddheaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LLBillAddheaderView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, CGFloatBasedI375(50))];
        WS(weakself);
        _headerView.billHeaderBtnBlock = ^(NSInteger index) {
            weakself.billType = index;
            NSLog(@"---------------%ld",index);
            [weakself.tableView reloadData];
        };
    }
    return _headerView;
}
-(LLBillInfoView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLBillInfoView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        _bottomView.indexType = 200;
        WS(weakself);
        _bottomView.billInfoBtnBlock = ^(NSInteger btnTag, UIButton * _Nonnull btn) {
            if (btnTag == 200) {
                //保存
                [weakself  podSaveInvoice:btn];
            }
        };
    
    }
    return _bottomView;
}
-(LLBillSelectTypeView *)selectTypeView{
    if (!_selectTypeView) {
        _selectTypeView = [[LLBillSelectTypeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _selectTypeView.selectTYpeBlock = ^(NSInteger type, NSString * _Nonnull content) {
            weakself.type = type;
            weakself.content = content;
            NSLog(@"===================%ld",type);
            [weakself.tableView reloadData];
        };
    }
    return _selectTypeView;
}

@end
