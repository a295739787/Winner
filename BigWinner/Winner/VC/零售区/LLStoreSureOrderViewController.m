//
//  LLStoreSureOrderViewController.m
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LLStoreSureOrderViewController.h"
#import "LLStoreSureOrderHeadView.h"
#import "LLStoreSureOrderViewCell.h"
#import "LLShopCarBoView.h"
#import "LLMeAdressEditController.h"
#import "LLMeAdressController.h"
#import "LLStorePayViewController.h"

static NSString *const LLStoreSureOrderViewCellid = @"LLStoreSureOrderViewCell";
static NSString *const LLStoreSureOrderViewAddressCellid = @"LLStoreSureOrderViewAddressCell";
static NSString *const LLStoreSureOrderViewCommonCellid = @"LLStoreSureOrderViewCommonCell";
static NSString *const LLStoreSureOrderViewDeliverCellid = @"LLStoreSureOrderViewDeliverCell";


@interface LLStoreSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLStoreSureOrderHeadView *headView ;/** <#class#> **/
@property (nonatomic,assign) NSInteger tagindex ;/** <#class#> **/
@property (nonatomic,strong) LLShopCarBoView *boView;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *addressModel;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *areaModel;/** <#class#> **/

@end

@implementation LLStoreSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagindex = 1;
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"确认订单";
    [self setLayout];
    [self postDatas];
    [self getAdressListUrl:NO addressType:0];
}

#pragma mark--获取地址列表
-(void)getAdressListUrl:(BOOL)isLoad addressType:(int)type{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"asc" forKey:@"sort"];
    [params setObject:@(type) forKey:@"addrType"];

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
        if(isLoad){
            [self postDatas];
        }
        [self.tableView reloadData];
            
        } failure:^(NSError * _Nonnull error) {
            
    }];
}
-(void)postDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";
    NSString *url = L_apiapporderconfirm;
    NSString *buyType = @"1";
    if(_status == RoleStatusStore){
        buyType = @"1";
        [param setValue:self.valueModel.ID forKey:@"goodsId"];
        [param setValue:self.goodsNum forKey:@"goodsNum"];//数量（零售区立即购买、惊喜红包下单、配送库存采购必传）
        [param setValue:self.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];//规格价格ID（零售区立即购买、惊喜红包、品鉴商品下单、配送库存采购必传）
    }else if(_status == RoleStatusShopCar){
        buyType = @"2";
        NSMutableArray *goodid = [NSMutableArray array];
        for(LLGoodModel *model in _datas){
            [goodid addObject:model.ID];
        }
        NSString *goodidstr = [goodid componentsJoinedByString:@","];
        [param setValue:goodidstr forKey:@"cartIds"];
    }
    if(self.addressModel.ID.length > 0){
        [param setValue:self.addressModel.ID forKey:@"addressId"];
    }
    [param setValue:buyType forKey:@"buyType"];//下单类型（1零售区立即购买，2购物车下单，3惊喜红包、4品鉴商品、5配送库存采购）
    [param setValue:@(self.tagindex) forKey:@"expressType"];//配送方式（1物流配送、2同城配送）
    [XJHttpTool post:url method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        if(self.tagindex != 1){//同城
            if(!self.model.shopInfoVo){
                [UIAlertController showAlertViewWithTitle:@"提示" Message:@"当前收货地址无推广点,不可下单" BtnTitles:@[@"确定"] ClickBtn:^(NSInteger index) {
                    
                }];
            }
        }
        self.boView.model =self.model;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark 提交订单
-(void)subUrl:(UIButton *)sender{
    if(self.tagindex == 1){
        if(self.addressModel.ID.length <= 0){
            [JXUIKit showErrorWithStatus:@"请选择地址"];
            return;;
        }
    }else{
        if(self.model.shopInfoVo.ID.length <= 0){
            [JXUIKit showErrorWithStatus:@"附近无推广点,不可下单"];
            return;;
        }
    }
 
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";
    NSString *url = L_apiappordersubmit;
    NSString *buyType = @"1";
    NSMutableArray *goodAs = [NSMutableArray array];
/*
 {"addressId":"9f844e9a628e44f085db9f1776f909b8","remarks":"","shopId":"e9c9ee4fbf934387a2ed85e34253262b","appOrderSubmitGoodsForm":[{"coverImage":"20220315_890869b32e5b488bbc9db28dcdf2a477.jpg","freight":10.0,"goodsId":"8a500afdbb59488c91444bb5dac4ba56","goodsNum":1,"goodsSpecsPriceId":"1503628812428865537","id":"","name":"大赢家 真心 500ml单瓶装 酱香型白酒","salesPrice":529.0,"scribingPrice":599.0,"specsValName":"4支（500ml*4）;52°"}],"expressType":2,"buyType":1}
 */
    if(_status == RoleStatusStore){
        url = L_apiappordersubmit;
        buyType = @"1";//1零售区立即购买，2购物车下单，3惊喜红包、4品鉴商品、5配送库存采购）
        [self.model.appOrderConfirmGoodsVo enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LLGoodModel *sonmodel = (LLGoodModel *)obj;
            NSMutableDictionary *goodpram = [NSMutableDictionary dictionary];
            [goodpram setValue:sonmodel.ID forKey:@"id"];
            [goodpram setValue:sonmodel.goodsNum forKey:@"goodsNum"];
            [goodpram setValue:sonmodel.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];
            [goodpram setValue:sonmodel.goodsId forKey:@"goodsId"];
            [goodAs addObject:goodpram.mutableCopy];
        }];
        if(goodAs.count <= 0){
            return;;
        }
        [param setValue:goodAs forKey:@"appOrderSubmitGoodsForm"];

    }else if(_status == RoleStatusShopCar){
        buyType = @"2";
        [_datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LLGoodModel *sonmodel = (LLGoodModel *)obj;
            NSMutableDictionary *goodpram = [NSMutableDictionary dictionary];
            [goodpram setValue:sonmodel.ID forKey:@"id"];
            [goodpram setValue:sonmodel.goodsNum forKey:@"goodsNum"];
            [goodpram setValue:sonmodel.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];
            [goodpram setValue:sonmodel.goodsId forKey:@"goodsId"];
            [goodAs addObject:goodpram.mutableCopy];
        }];
        if(goodAs.count <= 0){
            return;;
        }
        [param setValue:goodAs forKey:@"appOrderSubmitGoodsForm"];
    }
    
    if(self.tagindex == 1){
    }else{
        [param setValue:self.model.shopInfoVo.ID forKey:@"shopId"];
    }
    [param setValue:self.addressModel.ID forKey:@"addressId"];
    [param setValue:@(self.tagindex) forKey:@"expressType"];//配送方式（1物流配送、2同城配送）
    [param setValue:buyType forKey:@"buyType"];
    
    NSInteger section = 0;
    if(self.tagindex == 1){
        section = 2;
    }else{
        section = 3;
    }
    LLStoreSureOrderViewCommonCell*cell =  (LLStoreSureOrderViewCommonCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:section]];
    if(cell.conTX.text.length > 0){
       [param setValue:cell.conTX.text.length <=0?@"":cell.conTX.text forKey:@"remarks"];
    }
//    [param setValue:@"无" forKey:@"shopId"];

    WS(weakself);
    [XJHttpTool post:url method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        LLStorePayViewController *vc = [[LLStorePayViewController alloc]init];
        vc.datas =data;
        vc.status = weakself.status;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
// 数组转字符串
- (NSString *)toReadableJSONString:(NSArray *)dataArr {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataArr
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}
-(void)setLayout{
    WS(weakself);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(0));
        make.height.offset(CGFloatBasedI375(50));
        make.right.offset(CGFloatBasedI375(0));

    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(weakself.headView.mas_bottom).offset(CGFloatBasedI375(10));
        make.bottom.equalTo(weakself.boView.mas_top).offset(-CGFloatBasedI375(10));

    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(70)));

    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.tagindex == 1){
        if(section == 0){
            return 1;
        }else if(section == 2){
            return 4;
        }
        return self.model.appOrderConfirmGoodsVo.count;
    }else{
        if(section == 0 || section == 1){
            return 1;
        }else if(section == 3){
            return 5;
        }
        return self.model.appOrderConfirmGoodsVo.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.tagindex == 1){
        return 3;
        
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.tagindex == 1){
        if(indexPath.section == 0){//地指
            return CGFloatBasedI375(84);
        }else if(indexPath.section == 2){
            return CGFloatBasedI375(44);
        }
        return CGFloatBasedI375(110);
    }else{
        if(indexPath.section == 0){
            return CGFloatBasedI375(54);
        }else if(indexPath.section == 1){//地指
            return CGFloatBasedI375(84);
        }else if(indexPath.section == 3){
            return CGFloatBasedI375(44);
        }
        return CGFloatBasedI375(110);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
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
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = [UIColor clearColor];
    
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.tagindex == 1){
        if(indexPath.section == 0){
            LLStoreSureOrderViewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewAddressCellid];
            cell.model =  self.addressModel;
            return cell;
        }else if(indexPath.section == 2){
            LLStoreSureOrderViewCommonCell*cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCommonCellid];
            cell.tagindex = self.tagindex;
            cell.model = self.model;
            cell.status = _status;
            cell.indexs = indexPath.row;
            return cell;
        }
        LLStoreSureOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCellid];
        cell.model = self.model.appOrderConfirmGoodsVo[indexPath.row];
        return cell;
    }else{
        if(indexPath.section == 0){
            LLStoreSureOrderViewDeliverCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewDeliverCellid];
            if(self.model.shopInfoVo){
                 cell.model = self.model.shopInfoVo;
            }
            cell.status = _status;
            return cell;
        }else if(indexPath.section == 1){
            LLStoreSureOrderViewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewAddressCellid];
            cell.model = self.addressModel;
            return cell;
        }else if(indexPath.section == 3){
            LLStoreSureOrderViewCommonCell*cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCommonCellid];
            cell.tagindex = self.tagindex;
            cell.model = self.model;
            cell.status = _status;
            cell.indexs = indexPath.row;
            return cell;
        }
        LLStoreSureOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCellid];
        cell.model = self.model.appOrderConfirmGoodsVo[indexPath.row];

        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    if(self.tagindex == 1){
        if(indexPath.section == 0){
            if(self.addressModel){
                LLMeAdressController *vc = [[LLMeAdressController alloc]init];
                vc.isChoice = YES;
                vc.addressType = LLMeAdressLogis;
                vc.getAressBlock = ^(LLGoodModel * _Nonnull model) {
                    weakself.addressModel = model;
                    [weakself postDatas];
                    if(self.tagindex == 1){
                        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }else{
                        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                WS(weakself);
                LLMeAdressEditController *vc = [[LLMeAdressEditController alloc]init];
                vc.adressType = 300;
                vc.getAddressBlock = ^{
                    [weakself getAdressListUrl:YES addressType:0];
                };
                [self.navigationController pushViewController:vc animated:YES];

            }
        }
    }else{
        if(indexPath.section == 1){
            if(self.addressModel){
                LLMeAdressController *vc = [[LLMeAdressController alloc]init];
                vc.isChoice = YES;
                vc.addressType = LLMeAdressDelivery;
                vc.getAressBlock = ^(LLGoodModel * _Nonnull model) {
                    weakself.addressModel = model;
                    [weakself postDatas];
                    if(self.tagindex == 1){
                        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }else{
                        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                };
                [self.navigationController pushViewController:vc animated:YES];

            }else{
      
                LLMeAdressEditController *vc = [[LLMeAdressEditController alloc]init];
                vc.adressType = 300;
                vc.getAddressBlock = ^{
                    [weakself getAdressListUrl:YES addressType:1];
                };
                [self.navigationController pushViewController:vc animated:YES];

            }
        }
    }
}

#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLStoreSureOrderViewCell class] forCellReuseIdentifier:LLStoreSureOrderViewCellid];
        [ _tableView  registerClass:[LLStoreSureOrderViewAddressCell class] forCellReuseIdentifier:LLStoreSureOrderViewAddressCellid];
        [ _tableView  registerClass:[LLStoreSureOrderViewCommonCell class] forCellReuseIdentifier:LLStoreSureOrderViewCommonCellid];
        [ _tableView  registerClass:[LLStoreSureOrderViewDeliverCell class] forCellReuseIdentifier:LLStoreSureOrderViewDeliverCellid];

        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
-(LLStoreSureOrderHeadView *)headView{
    if(!_headView){
        _headView = [[LLStoreSureOrderHeadView alloc]init];
        [self.view addSubview:_headView];
        WS(weakself);
        _headView.tapClick = ^(NSInteger tagindex) {//1是同城  2是配送
            weakself.tagindex = tagindex;
            [weakself postDatas];
            [weakself.tableView reloadData];
        };
    }
    return _headView;
}
-(LLShopCarBoView *)boView{
    if(!_boView){
        _boView = [[LLShopCarBoView alloc]init];
        [_boView.sureButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_boView.sureButton addTarget:self action:@selector(subUrl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.boView];
    }
    return _boView;
}
@end
