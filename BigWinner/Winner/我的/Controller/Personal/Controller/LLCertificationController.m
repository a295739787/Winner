//
//  LLCertificationController.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLCertificationController.h"
#import "LLPersonalTableCell.h"

@interface LLCertificationController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *certificatesNumber;
@property (nonatomic,strong)NSString *realName;

@end

@implementation LLCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"实名认证";
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark--confirmBtnClick
-(void)confirmBtnClick:(UIButton *)btn{
    
    //立即提交
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.realName forKey:@"realName"];
    [params setObject:self.certificatesNumber forKey:@"certificatesNumber"];
    WS(weakself);
    [XJHttpTool post:L_RealAuth method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            
            if (weakself.certificationBlock) {
                weakself.certificationBlock(weakself.realName);
            }
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLCertificationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLCertificationTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textStr = @[@"真实姓名",@"身份证号"][indexPath.row];
    cell.placeholderStr = @[@"请输入真实姓名",@"请输入身份证号码"][indexPath.row];
    cell.index = indexPath.row;
    WS(weakself);
    cell.centificationBlock = ^(NSInteger index, NSString * _Nonnull contentStr) {
        if (index == 0) {
            //真实姓名
            weakself.realName = contentStr;
        }else if (index == 1){
            //身份证号码
            weakself.certificatesNumber = contentStr;
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(64);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"立即提交" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor whiteColor];
    [confirmBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:tableView.tableHeaderView.frame];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请正确填写身份证上对应姓名与身份证号";
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLCertificationTableCell class] forCellReuseIdentifier:@"LLCertificationTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
