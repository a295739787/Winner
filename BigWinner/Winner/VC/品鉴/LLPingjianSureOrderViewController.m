//
//  LLStoreSureOrderViewController.m
//  Winner
//
//  Created by mac on 2022/2/2.
//

#import "LLPingjianSureOrderViewController.h"
#import "LLStoreSureOrderHeadView.h"
#import "LLStoreSureOrderViewCell.h"
#import "LLShopCarBoView.h"
#import "LLMeAdressController.h"
#import "LLMeAdressEditController.h"
#import "LLStorePayViewController.h"
#import "LLPinJianViewCell.h"

static NSString *const LLStoreSureOrderViewCellid = @"LLStoreSureOrderViewCell";
static NSString *const LLStoreSureOrderViewAddressCellid = @"LLStoreSureOrderViewAddressCell";
static NSString *const LLStoreSureOrderViewCommonCellid = @"LLStoreSureOrderViewCommonCell";
static NSString *const LLStoreSureOrderViewDeliverCellid = @"LLStoreSureOrderViewDeliverCell";
static NSString *const LLPinJianViewCountCellid = @"LLPinJianViewCountCell";


@interface LLPingjianSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLStoreSureOrderHeadView *headView ;/** <#class#> **/
@property (nonatomic,assign) NSInteger tagindex ;/** <#class#> **/
@property (nonatomic,strong) LLShopCarBoView *boView;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *addressModel;/** <#class#> **/
@property (nonatomic, copy) NSString *counts;

@end

@implementation LLPingjianSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagindex = 2;
    self.counts = @"1";
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"确认订单";
    [self setLayout];
    [self getAdressListUrl];


}
-(void)postDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";
    NSString *url = L_apiapporderconfirm;
    NSString *buyType = @"4";
    [param setValue:self.valueModel.goodsId forKey:@"goodsId"];
    [param setValue:self.valueModel.ID forKey:@"id"];
    if(_status == RoleStatusPingjian){
        [param setValue:buyType forKey:@"buyType"];//下单类型（1零售区立即购买，2购物车下单，3惊喜红包、4品鉴商品、5配送库存采购）
    }else if(_status == RoleStatusStockPeisong){
        [param setValue:@"5" forKey:@"buyType"];
        [param setValue:_distDistGoodsId forKey:@"distDistGoodsId"];
        [param setValue:_distDistGoodsId forKey:@"id"];
    }

    [param setValue:self.valueModel.ID forKey:@"judgeGoodsId"];//规格价格ID（零售区立即购买、惊喜红包、品鉴商品下单、配送库存采购必传）
    [param setValue:self.valueModel.ID forKey:@"redGoodsId"];

    [param setValue:_goodsSpecsPriceId.length <= 0?self.valueModel.goodsSpecsPriceId:_goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];
  
    [param setValue:_goodsNum forKey:@"goodsNum"];
    [param setValue:self.addressModel.ID forKey:@"addressId"];
    [param setValue:@(2) forKey:@"expressType"];//配送方式（1物流配送、2同城配送）
    if(_status == RoleStatusPingjian){
        [param setValue:@"1" forKey:@"goodsNum"];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [XJHttpTool post:url method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
//        NSLog(<#NSString * _Nonnull format, ...#>)
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        self.boView.model = self.model;
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
#pragma mark--获取地址列表
-(void)getAdressListUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@(10) forKey:@"pageSize"];
    [params setObject:@"" forKey:@"sidx"];
    [params setObject:@"asc" forKey:@"sort"];
    
    if(_status == RoleStatusStockPeisong){
        [params setObject:@(1) forKey:@"addrType"];
    }else{
        [params setObject:@(2) forKey:@"addrType"];
    }
    
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
        
        [self postDatas];
            
        } failure:^(NSError * _Nonnull error) {
            
    }];
}
#pragma mark 提交订单
-(void)subUrl:(UIButton *)sender{
    
    if(self.addressModel.ID.length <= 0){
        [JXUIKit showErrorWithStatus:@"请选择地址"];
        return;;
    }
 
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";
    NSString *url = L_apiappordersubmit;
    NSString *buyType = @"1";
    NSMutableArray *goodAs = [NSMutableArray array];
        buyType = @"4";//1零售区立即购买，2购物车下单，3惊喜红包、4品鉴商品、5配送库存采购）
        [self.model.appOrderConfirmGoodsVo enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LLGoodModel *sonmodel = (LLGoodModel *)obj;
            NSMutableDictionary *goodpram = [NSMutableDictionary dictionary];
            [goodpram setValue:sonmodel.ID forKey:@"id"];
//            [goodpram setValue:sonmodel.goodsNum forKey:@"goodsNum"];
            if(_status == RoleStatusPingjian){
                [goodpram setValue:self.counts forKey:@"goodsNum"];
            }else{
                [goodpram setValue:sonmodel.goodsNum forKey:@"goodsNum"];
            }
         
            [goodpram setValue:sonmodel.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];
            [goodpram setValue:sonmodel.goodsId forKey:@"goodsId"];
         
            [goodAs addObject:goodpram.mutableCopy];
        }];
        if(goodAs.count <= 0){
            return;;
        }
        [param setValue:goodAs forKey:@"appOrderSubmitGoodsForm"];

    [param setValue:self.addressModel.ID forKey:@"addressId"];

    if(_status == RoleStatusStockPeisong){
        buyType = @"5";
    }
    [param setValue:buyType forKey:@"buyType"];
    
    NSInteger section = 0;
    if(_status == RoleStatusPingjian){
        
        section = 2;
    }else{
        
    }
    LLStoreSureOrderViewCommonCell*cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:section]];
    if(cell.conTX.text.length > 0){
        [param setValue:cell.conTX.text.length <=0?@"":cell.conTX.text forKey:@"remarks"];
    }
    if(_status == RoleStatusStockPeisong){
        [param setValue:@(1) forKey:@"expressType"];//库存配送 只有快递
    }else{
        [param setValue:@(2) forKey:@"expressType"];//配送方式（1物流配送、2同城配送）
    }
    NSLog(@"param == %@",param);
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
-(void)setLayout{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(0));
        make.bottom.equalTo(weakself.boView.mas_top).offset(-CGFloatBasedI375(10));

    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(50)));

    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_status == RoleStatusPingjian){
        if(section == 0){
            return 1;
        }else if(section == 3){
            return 4;
        }
        return 1;
    }
    if(section == 0){
        return 1;
    }else if(section == 2){
        return 4;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(_status == RoleStatusPingjian){
        return 4;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_status == RoleStatusPingjian){
        if(indexPath.section == 0){//地指
            return CGFloatBasedI375(84);
        }else if(indexPath.section == 3){
            return CGFloatBasedI375(44);
        }else if(indexPath.section == 2){
            return CGFloatBasedI375(44);
        }
        return CGFloatBasedI375(110);
    }
    if(indexPath.section == 0){//地指
        return CGFloatBasedI375(84);
    }else if(indexPath.section == 2){
        return CGFloatBasedI375(44);
    }
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(_status == RoleStatusPingjian){
        if(section != 3){
            return CGFloatBasedI375(0.001);
        }
        return CGFloatBasedI375(140);
    }
    if(section != 2){
        return CGFloatBasedI375(0.001);
    }
    if(_status == RoleStatusStockPeisong){
        return CGFloatBasedI375(0.001);
    }
    return CGFloatBasedI375(140);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_status == RoleStatusPingjian && section == 3){
        return 0.001;
    }
    return CGFloatBasedI375(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(_status == RoleStatusPingjian && section == 3){
        return nil;
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = BG_Color;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSInteger rows = 2;
    if(_status == RoleStatusPingjian){
        rows = 3;
        if(section != rows){
            return nil;
        }
    }else{
        if(section != rows){
            return nil;
        }
    }
    if(_status == RoleStatusStockPeisong){
        return nil;
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(140))];
    header.backgroundColor = BG_Color;
    UILabel *nameLabel1 = [[UILabel alloc]init];
    nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
    nameLabel1.textColor =[UIColor colorWithHexString:@"#999999"];
    nameLabel1.textAlignment = NSTextAlignmentLeft;
    nameLabel1.userInteractionEnabled = YES;
    nameLabel1.numberOfLines = 0;
    nameLabel1.attributedText = [self getAttribuStrWithStrings:@[@"配送须知：\n1.正常下单",@"5KM",@"范围内支付",@"配送费0元",@"，配送员接单后预计",@"30-40 分钟",@"内送达；\n2.",@"5KM-10KM",@"范围内",@"加配送费10元",@"，配送员接单后预计",@"40-60分钟",@"内送达；\n3.",@"10KM-15KM",@"范围内",@"加配送费20元",@"，配送员接单后预计",@"60-90分钟",@"内送达；\n4.",@"超出15KM",@"或订单无人接单将自动取消订单",@"原路返还支付金额"] colors:@[lightGray9999_Color, Main_Color,lightGray9999_Color, Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color,lightGray9999_Color,Main_Color]];
    
//    nameLabel1.text = @"配送须知： 1.正常下单5KM范围内支付配送费0元，配送员接单后预计30-40 分钟内送达； 2.5KM-10KM范围内加配送 1.正常下单5KM范围内支付配送费0元，配送员接单后预计30-40 分钟内送达； 2.5KM-10KM范围内加配送 1.正常下单5KM范围内支付配送费0元，配送员接单后预计30-40 分钟内送达； 2.5KM-10KM范围内加配送";
    [header addSubview:nameLabel1];
    [nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(10));
    }];
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    if(_status == RoleStatusPingjian){
      if(indexPath.section == 0){
            LLStoreSureOrderViewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewAddressCellid];
            cell.model =  self.addressModel;
            return cell;
        }else if(indexPath.section == 3){
            LLStoreSureOrderViewCommonCell*cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCommonCellid];
            cell.status = _status;
            cell.counts = self.counts.integerValue;
            cell.model = self.model;
            cell.indexs = indexPath.row;
            return cell;
        }else    if(indexPath.section == 2){
            LLPinJianViewCountCell*cell = [tableView dequeueReusableCellWithIdentifier:LLPinJianViewCountCellid];
            cell.model =  self.model;
            cell.AddBlock = ^(UILabel * _Nonnull countLabel, NSInteger indexs, NSInteger counts) {
                weakself.counts = FORMAT(@"%ld",counts);
                
                NSInteger goodsStocks = weakself.model.stock.integerValue;
                if (counts > goodsStocks) {
                    CGFloat goods = goodsStocks*weakself.model.goodsPrice.floatValue;
                    CGFloat stocks = counts*weakself.model.goodsPrice.floatValue;
                    CGFloat addSum = stocks-goods;
                    weakself.boView.priceStr = FORMAT(@"%.2f",addSum);
                }else{
                    
                    weakself.boView.priceStr = [NSString stringWithFormat:@"0.00"];
                    
                    [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
                }
                                
                weakself.boView.detailsLabel.text = FORMAT(@"共%@瓶，含配送费",weakself.counts );
                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
            };
            
            cell.CutBlock = ^(UILabel * _Nonnull countLabel, NSInteger indexs, NSInteger counts) {
                weakself.counts =FORMAT(@"%ld",counts);
                
                NSInteger goodsStocks = weakself.model.stock.integerValue;
                if (counts > goodsStocks) {
                    
                    CGFloat goods = goodsStocks*weakself.model.goodsPrice.floatValue;
                    CGFloat stocks = counts*weakself.model.goodsPrice.floatValue;
                    CGFloat addSum = stocks-goods;
                    weakself.boView.priceStr = FORMAT(@"%.2f",addSum);
                }else{
                    
                    weakself.boView.priceStr = [NSString stringWithFormat:@"0.00"];
                    
                    [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
                }
                
                weakself.boView.detailsLabel.text = FORMAT(@"共%@瓶，含配送费",weakself.counts );
                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
                
            };
            return cell;
        }
        LLStoreSureOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCellid];
        cell.model = self.model.appOrderConfirmGoodsVo[indexPath.row];
        cell.typeLabel.hidden = NO;
        return cell;
    }
    if(indexPath.section == 0){
        LLStoreSureOrderViewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewAddressCellid];
        cell.model =  self.addressModel;
        return cell;
    }else if(indexPath.section == 2){
        LLStoreSureOrderViewCommonCell*cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCommonCellid];
        cell.counts = self.counts.integerValue;
        cell.status = _status;
        cell.model = self.model;
        cell.indexs = indexPath.row;
        return cell;
    }
    LLStoreSureOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLStoreSureOrderViewCellid];
    cell.model = self.model.appOrderConfirmGoodsVo[indexPath.row];
    cell.typeLabel.hidden = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);

    if(indexPath.section == 0){
    if(self.addressModel){
        LLMeAdressController *vc = [[LLMeAdressController alloc]init];
        vc.isChoice = YES;
        if (_status == RoleStatusStockPeisong) {
            vc.addressType = LLMeAdressLogis;
        }else{
            vc.addressType = LLMeAdressDelivery;
        }
        vc.getAressBlock = ^(LLGoodModel * _Nonnull model) {
            weakself.addressModel = model;
//            if(self.tagindex == 1){
                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//            }else{
//                [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
//            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        WS(weakself);
        LLMeAdressEditController *vc = [[LLMeAdressEditController alloc]init];
        if (_status == RoleStatusStockPeisong) {
            vc.options = MeAddressOptionsLogis;
        }else{
            vc.options = MeAddressOptionsDelivery;
        }
        vc.adressType = 300;
        vc.getAddressBlock = ^{
            [weakself getAdressListUrl];
        };
        [self.navigationController pushViewController:vc animated:YES];
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
        [ _tableView  registerClass:[LLPinJianViewCountCell class] forCellReuseIdentifier:LLPinJianViewCountCellid];

        
        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

-(LLShopCarBoView *)boView{
    if(!_boView){
        _boView = [[LLShopCarBoView alloc]init];
        [_boView.sureButton setTitle:@"提交订单" forState:UIControlStateNormal];
        if(_status == RoleStatusStockPeisong){
            [_boView.sureButton setTitle:@"确认采购" forState:UIControlStateNormal];
        }
     
        [_boView.sureButton addTarget:self action:@selector(subUrl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.boView];
    }
    return _boView;
}
@end
