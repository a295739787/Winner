//
//  LLShopCarViewController.m
//  Winner
//
//  Created by mac on 2022/2/1.
//

#import "LLShopCarViewController.h"
#import "LLShopCarCell.h"
#import "LLShopCarHeadView.h"
#import "LLShopCarBoView.h"
#import "LLStoreSureOrderViewController.h"

static NSString *const LLShopCarCellid = @"LLShopCarCell";
@interface LLShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLShopCarHeadView *headView;/** <#class#> **/
@property (nonatomic,strong) LLShopCarBoView *boView;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *selectArray;/** <#class#> **/
@property (nonatomic,assign) BOOL isEdting;/** class **/
@property (nonatomic,assign) NSInteger page;/** class **/

@end

@implementation LLShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.isEdting = NO;
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"购物车";
    self.view.backgroundColor = BG_Color;
    [self setLayout];
    [self getDatas];
}
-(void)header{
    self.page = 1;
    [self getDatas];
}
-(void)footer{
    self.page ++;
    [self getDatas];
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"" forKey:@"keyword"];
    [param setValue:@"" forKey:@"sidx"];
    [param setValue:@"" forKey:@"sort"];
    [param setValue:@"20" forKey:@"pageSize"];
    [param setValue:@(self.page) forKey:@"currentPage"];
    [XJHttpTool post:FORMAT(@"%@",L_apiappcartgetList) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        if(self.page == 1){
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:data[@"list"]]];
        if(self.dataArr .count <= 0){
            
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = YES;
            [self.tableView.mj_footer resetNoMoreData];
        }else{
            self.customNavBar.title = FORMAT(@"购物车(%ld)",self.dataArr.count);
            self.tableView.mj_footer.hidden = NO;;
        }
        [self countPrice];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(void)deleDatas{
    NSMutableArray *goodid = [NSMutableArray array];
    for(LLGoodModel *model in self.selectArray){
        [goodid addObject:model.ID];
    }
    NSString *goodidstr = [goodid componentsJoinedByString:@","];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:goodidstr forKey:@"ids"];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappcartdel,goodidstr) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        [JXUIKit showWithString:responseObj[@"msg"]];
        self.page = 1;
        [self getDatas];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark s下单
-(void)clickOrder{
    if(self.selectArray.count <= 0){
        [JXUIKit showWithString:@"请选择商品"];
        return;
    }
    LLStoreSureOrderViewController *vc = [[LLStoreSureOrderViewController alloc]init];
    vc.datas = self.selectArray.mutableCopy;
    vc.status =RoleStatusShopCar;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setLayout{
    WS(weakself);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SCREEN_top);
        make.height.offset(CGFloatBasedI375(44));

    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.headView.mas_bottom).offset(CGFloatBasedI375(10));
        make.bottom.equalTo(weakself.boView.mas_top).offset(CGFloatBasedI375(0));

    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(50)));

    }];
}

-(void)clickedit:(UIButton *)sender{
    sender.selected =  !sender.selected;
    if( sender.selected ){
        [self.headView.sureButton setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [self.headView.sureButton setTitle:@"管理" forState:UIControlStateNormal];
    }
    self.boView.isEditing = sender.selected;
}
-(void)clickdele{
    WS(weakself);
    if(self.selectArray.count <= 0){
        [JXUIKit showWithString:@"请选择要删除的商品"];
        return;
    }
  
    [UIAlertController showAlertViewWithTitle:@"确认删除" Message:FORMAT(@"确定将%ld个商品删除？",self.selectArray.count) BtnTitles:@[@"取消",@"删除"] ClickBtn:^(NSInteger index) {
        if(index == 1){
            [weakself deleDatas];
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(400);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = [UIColor clearColor];
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(400))];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:LLShopCarCellid];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView.hidden = YES;
    cell.model = self.dataArr[indexPath.row];
    [self shoppingCartCellClickAction:cell model: self.dataArr[indexPath.row] indexPath:indexPath];
    return cell;
}
- (void)shoppingCartCellClickAction:(LLShopCarCell *)cell
                        model:(LLGoodModel *)model
                          indexPath:(NSIndexPath *)indexPath {
    
    WS(weakself);
    //选中某一行
    cell.ClickRowBlock = ^(BOOL isClick) {
        model.isSelect = isClick;
        if(isClick){
            [self.selectArray addObject:model];
        }else{
            [self.selectArray removeObject:model];
        }
        [self setBottomBtnSelectState];
        [self countPrice];
        [self.tableView reloadData];
    };
    cell.AddBlock = ^(UILabel *countLabel,NSInteger indexs,NSInteger counts) {
        [self addUrl:indexPath.row :countLabel :counts type:@"1" model:model];

    };
    //减
    cell.CutBlock = ^(UILabel *countLabel,NSInteger indexs,NSInteger counts) {
        [self addUrl:indexPath.row :countLabel :counts type:@"2" model:model];
    };
}
#pragma mark  加减请求
-(void)addUrl:(NSInteger)index :(UILabel *)countlabel :(NSInteger)couns type:(NSString *)types model:(LLGoodModel *)sonmodel{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        [params setObject:@(couns) forKey:@"num"];
    [params setValue:sonmodel.ID forKey:@"cartId"];
    [params setValue:types forKey:@"type"];//配送方式（1物流配送、2同城配送）
    [XJHttpTool post:L_apiappcarteditNum method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        sonmodel.goodsNum = FORMAT(@"%ld",couns);
        countlabel.text = [NSString stringWithFormat:@"%ld", couns];
        if ([self.selectArray containsObject:sonmodel]) {
            [self.selectArray removeObject:sonmodel];
            [self.selectArray addObject:sonmodel];
            [self countPrice];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];

    
}
- (void)setBottomBtnSelectState{
    BOOL currentState = YES;
    //下方全选按钮选中状态
    for (int i = 0; i < self.dataArr.count; i++) {
        LLGoodModel *model = self.dataArr[i];
        if (model.isSelect != YES) {
            currentState = NO;
            break;
        }
    }
    //最下方的全选按钮的状态
    self.headView.selectButton.selected =currentState;
}

-(void)countPrice{
    float prices = 0.0;
    NSInteger count = 0;
    for (LLGoodModel *model in self.selectArray) {
        if(model.isSelect){
            CGFloat shop = [[NSString stringWithFormat:@"%@",model.salesPrice] floatValue];
            prices += shop * model.goodsNum.intValue;
            count += model.goodsNum.intValue;
        }
    }
    
    NSString *string;
    if (!self.isEdting) {
        string = [NSString stringWithFormat:@"立即下单"];
    } else {
        string = @"删除";
    }
    if(!self.isEdting){
        self.boView.priceStr = [NSString stringWithFormat:@"%.2f",prices];

    }else{
        self.boView.priceStr =  [NSString stringWithFormat:@"0.00"];
    }
    self.boView.detailsLabel.text = FORMAT(@"共%ld瓶，含配送费",self.selectArray.count);

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLGoodDetailViewController *vc = [[LLGoodDetailViewController alloc]init];
    vc.status = RoleStatusShopCar;
    LLGoodModel *model = self.dataArr[indexPath.row];
    vc.ID = model.goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)clickAll:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self didSelectAllCell:btn.selected];
}
#pragma mark  选择
- (void)didSelectAllCell:(BOOL)selected
{
    for (LLGoodModel *goodsModel in self.dataArr) {
        goodsModel.isSelect = NO;
    }
    [self.selectArray removeAllObjects];
    NSMutableArray *arr = [NSMutableArray array];
    if (selected) {//选中
        NSLog(@"全选");
        for (LLGoodModel *storeModel in self.dataArr) {
                   storeModel.isSelect = YES;
            [self.selectArray addObject:storeModel];
        
        }
    } else {//取消选中
        NSLog(@"取消全选");
        for (LLGoodModel *storeModel in self.dataArr) {
            storeModel.isSelect = NO;
            [self.selectArray removeObject:storeModel];
        }
    }
    [self countPrice];
    [self.tableView reloadData];
    
}
#pragma mark  懒加载
-(LLShopCarHeadView *)headView{
    if(!_headView){
        _headView = [[LLShopCarHeadView alloc]init];
        [_headView.sureButton addTarget:self action:@selector(clickedit:) forControlEvents:UIControlEventTouchUpInside];
        [_headView.selectButton addTarget:self action:@selector(clickAll:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.headView];
    }
    return _headView;
}
-(LLShopCarBoView *)boView{
    if(!_boView){
        _boView = [[LLShopCarBoView alloc]init];
        [_boView.deleButton addTarget:self action:@selector(clickdele) forControlEvents:UIControlEventTouchUpInside];
        [_boView.sureButton addTarget:self action:@selector(clickOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.boView];
    }
    return _boView;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLShopCarCell class] forCellReuseIdentifier:LLShopCarCellid];
        _tableView.scrollEnabled = NO;
        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
        [header setRefreshingTarget:self refreshingAction:@selector(header)];
        _tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
        [footer setRefreshingTarget:self refreshingAction:@selector(footer)];
        _tableView.mj_footer = footer;
    }
    return _tableView;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)selectArray{
    if(!_selectArray){
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
@end
