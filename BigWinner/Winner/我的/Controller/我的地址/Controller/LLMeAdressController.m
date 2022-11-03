//
//  LLMeAdressController.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLMeAdressController.h"
#import "LLMeAdressTableCell.h"
#import "LLMeAdressView.h"
#import "LLMeAdressEditController.h"
#import "AdressListModel.h"

@interface LLMeAdressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)LLBaseTableView *tableView;
@property (nonatomic,strong)LLMeAdressView *bottomView;

@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *buttonLineView;
@property (nonatomic ,strong) UIButton *logisButton;
@property (nonatomic ,strong) UIButton *deliveryButton;
@property (nonatomic ,assign)  NSInteger selectIndex;

@end

@implementation LLMeAdressController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getAdressListUrl:YES];
}
#pragma mark--createUI
-(void)createUI{
    
    NSString *titleString = @"";
    int topH = 0;
    if (self.addressType == LLMeAdressLogis) {
        titleString = @"物流地址";
        _selectIndex = 1;
    }else if (self.addressType == LLMeAdressDelivery){
        titleString = @"配送地址";
        _selectIndex = 2;
    }else{
        titleString = @"收货地址";
        topH = 46;
        [self creatbutton];
    }
    
    _currentPage = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = titleString;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(topH)+SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom - CGFloatBasedI375(50));
    }];
    
    
    NSData *adressData = [[NSUserDefaults standardUserDefaults] objectForKey:@"adressData"];
    if (!adressData) {
        [self getProvinceUrl];
    }
    
}

#pragma mark - 创建界面
-(void)creatbutton{
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, SCREEN_top, KScreenWidth, CGFloatBasedI375(46));
    topView.backgroundColor = White_Color;
    [self.view addSubview:topView];
    
    _selectIndex = 1;
    
    CGFloat btnX = SCREEN_WIDTH/2-100;
    CGFloat btnWidth = 80;

    _logisButton = [[UIButton alloc] init];
    _logisButton.frame = CGRectMake(btnX, 0, btnWidth, CGFloatBasedI375(44));
    [_logisButton setTitle:@"物流地址" forState:UIControlStateNormal];
    _logisButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
    [_logisButton setTitleColor:Main_Color forState:UIControlStateNormal];
    _logisButton.tag = 101;
    [_logisButton addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:_logisButton];
    
    _deliveryButton = [[UIButton alloc] init];
    _deliveryButton.frame = CGRectMake(CGRectGetMaxX(_logisButton.frame)+40, 0, btnWidth, CGFloatBasedI375(44));
    [_deliveryButton setTitle:@"配送地址" forState:UIControlStateNormal];
    _deliveryButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
    [_deliveryButton setTitleColor:[UIColor colorWithHexString:@"#0A0A0A"] forState:UIControlStateNormal];
    _deliveryButton.tag = 102;
    [_deliveryButton addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:_deliveryButton];
    
    _buttonLineView = [[UIView alloc] init];
    _buttonLineView.frame = CGRectMake(btnX, CGRectGetMaxY(_logisButton.frame), btnWidth, 2);
    _buttonLineView.backgroundColor = Main_Color;
    [topView addSubview:_buttonLineView];

}
-(void)btnClicked:(UIButton *)sender{
    self.currentPage = 1;
    sender.selected = YES;
    if (sender.tag == 101) {
        _selectIndex = 1;
        [_logisButton setTitleColor:Main_Color forState:UIControlStateNormal];
        [_deliveryButton setTitleColor:[UIColor colorWithHexString:@"#0A0A0A"] forState:UIControlStateNormal];
    }else{
        _selectIndex = 2;
        [_deliveryButton setTitleColor:Main_Color forState:UIControlStateNormal];
        [_logisButton setTitleColor:[UIColor colorWithHexString:@"#0A0A0A"] forState:UIControlStateNormal];
    }
    WS(weakself);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.buttonLineView.x = sender.centerX-40;
    }];
    //点击切换
    [self getAdressListUrl:NO];
}


-(void)header{
    self.currentPage = 1;
    [self getAdressListUrl:NO];
}
-(void)footer{
    self.currentPage ++;
    [self getAdressListUrl:NO];
}
#pragma mark--获取地址列表
-(void)getAdressListUrl:(BOOL)isload{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_currentPage) forKey:@"currentPage"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"" forKey:@"sort"];
    [params setObject:@(_selectIndex) forKey:@"addrType"];

    WS(weakself);
    if(isload){
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [XJHttpTool post:L_adressListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *code = responseObj[@"code"];
        NSDictionary *data = responseObj[@"data"];
        
        NSArray *list = data[@"list"];
        NSMutableArray *dataList = [[NSMutableArray alloc] init];
        for (int i = 0; i<list.count; i++) {
            NSDictionary *listDic = [list objectAtIndex:i];
            int addressType = [[listDic objectForKey:@"addrType"] intValue];
            if (addressType == weakself.selectIndex) {
                [dataList addObject:listDic];
            }
        }
        
        if(self.currentPage == 1){
           [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:[AdressListModel mj_objectArrayWithKeyValuesArray:dataList]];
//        [JXUIKit showErrorWithStatus:FORMAT(@"请求数据 == %ld",self.dataArray.count)];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(list.count < 10 ){
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.tableView.mj_header.hidden = NO;
            self.tableView.mj_footer.hidden = NO;
        }
        if(self.dataArray.count <= 0){
            [self.tableView showEmptyViewWithType:0 imagename:@"" noticename:@"暂无数据"];
        }else{
            [self.tableView removeEmptyView];
        }

        [self.tableView reloadData];
            
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
    }];
}


-(void)getProvinceUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:L_provinceUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            NSArray *data = responseObj[@"data"];
            NSData *adressData = [NSKeyedArchiver archivedDataWithRootObject:data];
            [[NSUserDefaults standardUserDefaults] setObject:adressData forKey:@"adressData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
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
    LLMeAdressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeAdressTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addressType = self.selectIndex;
    if (self.dataArray.count > 0) {
        cell.listModel = self.dataArray[indexPath.row];
    }
    WS(weakself);
    cell.editBlock = ^{
        LLMeAdressEditController *editVC = [[LLMeAdressEditController alloc]init];
        editVC.adressType = 200;
        editVC.options = self.selectIndex;
        editVC.listModel = self.dataArray[indexPath.row];
        editVC.getAddressBlock = ^{
            weakself.currentPage = 1;
            [weakself getAdressListUrl:NO];
        };
        [weakself.navigationController pushViewController:editVC animated:YES];
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
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AdressListModel *listModel = self.dataArray[indexPath.row];
    if(self.isOrderChoice){
        NSString *add = FORMAT(@"%@ %@\n%@%@%@%@",listModel.receiveName,listModel.receivePhone,listModel.province, listModel.city, listModel.area, listModel.address);
        [UIAlertController showAlertViewWithTitle:@"收货人信息" Message:add BtnTitles:@[@"取消",@"确认修改"] ClickBtn:^(NSInteger index) {
            if(index == 1){
                [self choiceAdd:listModel.ID];
            }
            
        }];
    }
    if(self.isChoice){//订单那边过来选择
        LLGoodModel *model = [[LLGoodModel alloc]init];

        model.receiveName = listModel.receiveName;
        model.receivePhone= listModel.receivePhone;
        model.province= listModel.province;
        model.address= listModel.address;
        model.locations= listModel.locations;
        
        model.ID= listModel.ID;
        model.city= listModel.city;
        model.area= listModel.area;
        model.isDefault = FORMAT(@"%ld",listModel.isDefault);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            self.getAressBlock(model);
        });

    }
}
-(void)choiceAdd:(NSString *)ID{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:_orderNo forKey:@"orderNo"];
    [params setValue:ID forKey:@"addressId"];
    [XJHttpTool post:L_apiapporderupdateAddress method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [JXUIKit showSuccessWithStatus:@"修改成功"];
        LLGoodModel *model = [[LLGoodModel alloc]init];
        self.getAressBlock(model);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(LLBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - SCREEN_Bottom - CGFloatBasedI375(50)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeAdressTableCell class] forCellReuseIdentifier:@"LLMeAdressTableCell"];
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
-(LLMeAdressView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLMeAdressView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        _bottomView.adressType = 100;
        WS(weakself);
        _bottomView.adressBtnBlock = ^(NSInteger index) {
            if (index == 100) {
                LLMeAdressEditController *editVC = [[LLMeAdressEditController alloc]init];
                editVC.adressType = 100;
                editVC.options = weakself.selectIndex;
                editVC.getAddressBlock = ^{
                    weakself.currentPage = 1;
                    [weakself getAdressListUrl:NO];
                };
                [weakself.navigationController pushViewController:editVC animated:YES];
            }
        };
    }
    return _bottomView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
