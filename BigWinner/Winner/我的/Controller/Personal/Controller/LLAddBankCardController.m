//
//  LLAddBankCardController.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLAddBankCardController.h"
#import "LLPersonalTableCell.h"
#import "LLAddBankCardFooterView.h"

@interface LLAddBankCardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSString *bankCardNum;
@property (nonatomic,strong)NSString *bankName;
@property (nonatomic,strong)NSString *certificatesNumber;
@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *realName;
@property (assign, nonatomic)BOOL isAgree;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic,strong) LLPersonalModel *model;/** <#class#> **/
@property (nonatomic, copy) NSString *bankNo;

@property (nonatomic,strong)LLSelectBankNameView *bankNameView;


@end

@implementation LLAddBankCardController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    if(_ID.length > 0){
        self.customNavBar.title = @"编辑银行卡";
        [self getPersonalUrl];
    }
}
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [UserModel setUserInfoModelWithDict:responseObj[@"data"]];
        [AccessTool saveUserInfo];
        self.model = [LLPersonalModel mj_objectWithKeyValues:data];
        self.realName =  self.model.bankRealName.length <=0?@"":self.model.bankRealName;
        self.certificatesNumber =  self.model.bankCertificatesNumber.length <=0?@"":self.model.bankCertificatesNumber;
        self.bankName =  self.model.bankName.length <=0?@"":self.model.bankName;
        self.bankCardNum =  self.model.bankCardNum.length <=0?@"":self.model.bankCardNum;
        self.bankNo =  self.model.bankNo.length <=0?@"":self.model.bankNo;

        self.phone =  self.model.bankPhone.length <=0?@"":self.model.bankPhone;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView reloadData];
}
#pragma mark--createUI
-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.customNavBar.title = @"添加银行卡";
    _isAgree = YES;
//    SCREEN_top
}
#pragma mark--添加银行卡
-(void)addBankVCardUrl:(UIButton *)sender{
    
    if(_isAgree == NO){
        [MBProgressHUD showError:@"请查看并同意《服务协议》"];
        return;
    }else if ([_realName length] <= 0) {
        [MBProgressHUD showError:@"请输入真是姓名"];
        return;
    }else if ([_certificatesNumber length] <= 0){
        [MBProgressHUD showError:@"请输入身份证号"];
        return;
    }else if ([_bankName length] <= 0){
        [MBProgressHUD showError:@"请输入本人的银行卡名称"];
        return;
    }else if ([_bankCardNum length] <= 0){
        [MBProgressHUD showError:@"请输入本人的银行卡卡号"];
        return;
    }else if ([_phone length] <= 0){
        [MBProgressHUD showError:@"请输入预留手机号"];
        return;
    }else if ([_code length] <= 0){
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }else{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_realName forKey:@"realName"];
        [params setObject:_certificatesNumber forKey:@"certificatesNumber"];
        [params setObject:_bankName forKey:@"bankName"];
        [params setObject:_bankNo forKey:@"bankNo"];
        [params setObject:_bankCardNum forKey:@"bankCardNum"];
        
        [params setObject:_phone forKey:@"phone"];
        [params setObject:_code forKey:@"code"];
        [params setValue: self.timestamp  forKey:@"timestamp"];
        if(_ID.length > 0){
            [params setValue:_ID  forKey:@"id"];
        }
        WS(weakself);
        sender.enabled = NO;
        [XJHttpTool post:L_addBankUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
            sender.enabled = YES;
            NSString *code = responseObj[@"code"];
            [MBProgressHUD showSuccess:responseObj[@"msg"]];
            
            if ([code intValue] == 200) {
                if (weakself.addBankSuccessBlock) {
                    weakself.addBankSuccessBlock(params);
                }
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            
            } failure:^(NSError * _Nonnull error) {
                sender.enabled = YES;
        }];
    }
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLAddBankCardTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLAddBankCardTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.textStr = @[@"持卡人姓名",@"身份证号",@"银行卡名称",@"银行卡卡号",@"预留手机号",@"验证码"][indexPath.row];
    cell.placeholderStr = @[@"请输入真实姓名",@"请输入身份证号码",@"请输入本人的银行卡名称",@"请输入本人的银行卡卡号",@"请输入预留手机号",@"请输入验证码"][indexPath.row];
    if(_ID.length > 0 && self.model){
        cell.textField.text = @[self.realName,self.certificatesNumber, @"" ,self.bankCardNum,self.phone,@""][indexPath.row];
    }
    
    if (indexPath.row == 2) {
        cell.bankName = _bankName;
    }
    
    WS(weakself);
    cell.bankCardBlock = ^(NSInteger index, NSString * _Nonnull contentStr) {
        if (index == 0) {
            //持卡人姓名
            weakself.realName = contentStr;
        }else if (index == 1){
            //身份证号
            weakself.certificatesNumber = contentStr;
        }else if (index == 2){
            //银行卡名称
//            weakself.bankName = contentStr;
        }else if (index == 3){
            //银行卡卡号
            weakself.bankCardNum = contentStr;
        }else if (index == 4){
            //预留手机号
            weakself.phone = contentStr;
        }else if (index == 5){
            //验证码
            weakself.code = contentStr;
        }
    };
    cell.sendCodeBtnBlock = ^(UIButton * _Nonnull sendBtn) {
        if ([weakself.phone length] >0 && [weakself.phone length] == 11) {
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:weakself.phone forKey:@"account"];
            [param setValue:@"2" forKey:@"type"];
             self.timestamp = [NSString getNowTimeTimestamp3];
            [param setValue: self.timestamp  forKey:@"timestamp"];
            sendBtn.enabled = NO;
            [XJHttpTool post:L_apiappsmssend method:POST params:param isToken:NO success:^(id  _Nonnull responseObj) {
                sendBtn.enabled = YES;
                [sendBtn jk_startTime:60 waitTittle:@"s"];
//                NSDictionary *data = responseObj[@"data"];
                [MBProgressHUD hideActivityIndicator];
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:responseObj[@"msg"] toView:self.view];

            } failure:^(NSError * _Nonnull error) {
                sendBtn.enabled = YES;
                [MBProgressHUD hideActivityIndicator];
                [MBProgressHUD hideHUDForView:self.view];
            }];
        }else{
            [MBProgressHUD showError:@"请输入正确的手机号"];
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(102);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLAddBankCardFooterView *footerView = [[LLAddBankCardFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    WS(weakself);
    footerView.addCarBlock = ^(NSInteger index, BOOL isSelect,UIButton *sender) {
        
        if (index == 100) {
            weakself.isAgree = isSelect;
            
        }else if (index == 200){
            //立即提交
            [weakself addBankVCardUrl:sender];
        }else{
            LLWebViewController *vc = [[LLWebViewController alloc]init];
            vc.isHiddenNavgationBar = YES;
            vc.htmlStr = @"AppUserBankService";
            vc.name = @"服务协议";
            [weakself.navigationController pushViewController:vc animated:YES];
        }
    };
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:tableView.tableHeaderView.frame];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请绑定持卡人本人的银行卡";
    titleLabel.textColor = UIColorFromRGB(0x666666);
    titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(CGFloatBasedI375(14));
    }];
    
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self.view endEditing:NO];
        [self.bankNameView show];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLAddBankCardTableCell class] forCellReuseIdentifier:@"LLAddBankCardTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(LLSelectBankNameView *)bankNameView{
    if (!_bankNameView) {
        _bankNameView = [[LLSelectBankNameView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _bankNameView.LLSelectBankBlock = ^(NSDictionary * _Nonnull dict) {
            
            //银行卡名称
           weakself.bankName = dict[@"name"];
            //行号
          weakself.bankNo = dict[@"number"];
            
            
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    return _bankNameView;
}

@end
