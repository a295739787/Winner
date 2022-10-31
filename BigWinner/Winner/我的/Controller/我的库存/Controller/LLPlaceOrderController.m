//
//  LLPlaceOrderController.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLPlaceOrderController.h"
#import "LLStorageTableCell.h"
#import "LLSorageView.h"
#import "LLStorageTakeModel.h"
#import "LLMeAdressController.h"
#import "LLMeAdressEditController.h"
@interface LLPlaceOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLStorageBottomView *bottomView;
@property (nonatomic,strong)LLStorageTakeModel *takeModel;
@property (nonatomic,strong)LLappUserStockListVoModel *stockListModel;
@property (nonatomic,strong)NSString *goodsNum;
@property (assign, nonatomic)BOOL distStock;
@property (nonatomic,strong) LLGoodModel *addressModel;/** <#class#> **/

@end

@implementation LLPlaceOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"提货下单";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self getRequestUrl];
    [self getAdressListUrl];
    
}
-(void)getAdressListUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"asc" forKey:@"sort"];
    
    [XJHttpTool post:L_adressListUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        NSMutableArray *temp = [NSMutableArray array];
        if ([code intValue] == 200) {
            NSDictionary *data = responseObj[@"data"];
            NSArray *list = data[@"list"];
            if(list.count > 0){
                for(NSDictionary *dic in list){
                    BOOL isDefault = [dic[@"isDefault"] boolValue];
                    if(isDefault){
                        [temp addObject:dic];
                    }
                }
                if(temp.count <= 0){
                    [temp addObject:[list firstObject]];
                }
             self.addressModel =  [LLGoodModel mj_objectWithKeyValues: [temp firstObject]];
            }else{
                self.addressModel = nil;
            }
          
        }
        
        [self.tableView reloadData];
            
        } failure:^(NSError * _Nonnull error) {
            
    }];
}
#pragma mark--getRequestUrl
-(void)getRequestUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.ID forKey:@"id"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",LL_StorageTakeUrl,self.ID) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
//        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            
            weakself.takeModel = [LLStorageTakeModel yy_modelWithJSON:responseObj[@"data"]];
//            weakself.adressModel = [LLappAddressInfoVoModel yy_modelWithJSON:responseObj[@"data"][@"appAddressInfoVo"]];
            weakself.stockListModel = [LLappUserStockListVoModel yy_modelWithJSON:responseObj[@"data"][@"appUserStockListVo"]];
            weakself.goodsNum = weakself.takeModel.goodsNum;
        }
        [weakself.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

#pragma mark--确认提货
-(void)confirmGoodsUrl{
    if ([self.addressModel.ID length] <= 0) {
        [JXUIKit showErrorWithStatus:@"请选择送货地址"];
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.addressModel.ID forKey:@"addressId"];
    [params setObject:@(self.distStock) forKey:@"distStock"];
    [params setObject:self.goodsNum forKey:@"goodsNum"];
    [params setObject:_stockListModel.ID forKey:@"stockId"];
    
    WS(weakself);
    [XJHttpTool post:L_StorageTakeOrderUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        [MBProgressHUD showSuccess:@"提货成功"];
        
        if ([code intValue] == 200) {
            [weakself.navigationController popToRootViewControllerAnimated:YES];
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
        LLStorageAdressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStorageAdressTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.addressModel;
        return cell;
    }
    LLStorageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStorageTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isHidden = YES;
    cell.stockListModel =  self.stockListModel ;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        if([UserModel sharedUserInfo].isShop){
            return CGFloatBasedI375(110);
        }
        return CGFloatBasedI375(110)/2;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        LLSorageView *footerView = [[LLSorageView alloc]initWithFrame:tableView.tableFooterView.frame];
        footerView.goodsNum = self.stockListModel.goodsNum;
        WS(weakself);
        footerView.LLStorageCountBlock = ^(NSInteger count) {
            weakself.goodsNum = [NSString stringWithFormat:@"%ld",count];
        };
        footerView.LLStorageAddCarBtnBlock = ^(BOOL isCar) {
            weakself.distStock = isCar;
        };
        
        return footerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    if (indexPath.section == 0) {
        if(self.addressModel){
            LLMeAdressController *vc = [[LLMeAdressController alloc]init];
            vc.isChoice = YES;
            vc.getAressBlock = ^(LLGoodModel * _Nonnull model) {
                weakself.addressModel = model;
                    [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
  
            LLMeAdressEditController *vc = [[LLMeAdressEditController alloc]init];
            vc.adressType = 300;
            vc.getAddressBlock = ^{
                [weakself getAdressListUrl];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(50) - SCREEN_Bottom) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLStorageAdressTableCell class] forCellReuseIdentifier:@"LLStorageAdressTableCell"];
        [_tableView registerClass:[LLStorageTableCell class] forCellReuseIdentifier:@"LLStorageTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(LLStorageBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLStorageBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        WS(weakself);
        _bottomView.LLStorageConfirmBtnBlock = ^{
            //确认提货
            [weakself confirmGoodsUrl];
        };
    }
    return _bottomView;
}

@end
