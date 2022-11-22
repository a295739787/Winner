//
//  LLMeOrderDetailController.m
//  Winner
//
//  Created by YP on 2022/3/12.
//

#import "LLMeOrderDetailController.h"
#import "LLMeOrderDetailHeaderView.h"
#import "LLMeorderDetailTableCell.h"
#import "LLMeOrderDetailModel.h"
#import "LLStorePayViewController.h"
#import "LLMeAdressView.h"
#import "LLOrderAppltBillController.h"
#import "LLEvaulateViewController.h"
#import "LLOrderApplyBillStatusConoller.h"
#import "LLStockOrderDetailTableCell.h"
#import "LLOrderDeliverViewController.h"
#import "LLMeOrderheaderView.h"
#import "LLMeAdressController.h"
#import "Winner-Swift.h"
@interface LLMeOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLMeOrderDetailHeaderView *headerView;
@property (nonatomic,strong)LLMeorderDetailBottomView *bottomView;

@property (nonatomic,strong)LLMeOrderDetailModel *detailModel;
@property (nonatomic,strong)LLappAddressInfoVo *adressModel;
@property (nonatomic,strong) LLAlertShowView *showView;/** <#class#> **/

@property (nonatomic,strong)NSArray *orderInfoArray;

@property (nonatomic,strong)LLMeAdressDeleteView *refundView;
@property (nonatomic,strong)LLMeAdressDeleteView *confirmView;
@property (nonatomic,strong)LLMeAdressDeleteView *cancleView;
@property (nonatomic,strong)LLMeAdressDeleteView *deleteView;
@property (nonatomic,strong) NSMutableArray *appOrderEvaluateVo;/** <#class#> **/

@property (nonatomic,strong) LLMeOrderListModel *shouModel;/** <#class#> **/
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/
@property (nonatomic,strong) LLMeOrderDetailOrderReceiveView *peiSongView;/** <#class#> **/

@end

@implementation LLMeOrderDetailController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    // app启动或者app从后台进入前台都会调用这个方法

    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 添加检测app进入后台的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationBecomeActive    // 添加检测app进入后台的观察者
{
    [self getOrderDetailUrl];
}
- (void)applicationEnterBackground{
    [self.headerView destyTimes];
}
#pragma mark--createUI
-(void)createUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOrderDetailUrl) name:@"updatedeName" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"订单详情";
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top + CGFloatBasedI375(59));
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-CGFloatBasedI375(50) - SCREEN_Bottom);
    }];
    
    [self getOrderDetailUrl];

}
-(void)getData{//获取配送服务
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *ulrl = @"AppExpress5_10AddService";
    if(self.detailModel.feePriceSize == 1){
        ulrl = @"AppExpress10_15AddService";
    }else if(self.detailModel.feePriceSize == 1){
        
    }
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,ulrl) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        NSLog(@"data == %@",responseObj[@"data"]);
        self.datas = data;
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}
#pragma mark--getOrderDetailUrl
-(void)getOrderDetailUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.orderNo forKey:@"orderNo"];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    NSLog(@"lat == %@",lat);
    NSLog(@"lng == %@",lng);
//    [params setValue:lat forKey:@"latitude"];
//    [params setValue:lng forKey:@"longitude"];
    if(lat.length > 0 && lng.length > 0){
        [params setValue:lat forKey:@"latitude"];
        [params setValue:lng forKey:@"longitude"];
    }
    WS(weakself);
    [XJHttpTool post:L_orderDetailUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        self.shouModel =  [LLMeOrderListModel mj_objectWithKeyValues:responseObj[@"data"]];
        if ([code intValue] ==  200) {
            NSLog(@"responseObj == %@",responseObj[@"data"]);
            NSDictionary *dic =responseObj[@"data"];
            LLMeOrderDetailModel *detailModel = [LLMeOrderDetailModel yy_modelWithJSON:responseObj[@"data"]];
            weakself.detailModel = detailModel;
            [self getData];
            if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
                if(self.detailModel.taskStatus == 2){
                    self.detailModel.taskStatus = 3;
                }
            }
            
            [self.appOrderEvaluateVo removeAllObjects];
            for(LLappOrderListGoodsVos *mo in self.detailModel.appOrderListGoodsVos){
                if(mo.appOrderEvaluateVo){
                    [self.appOrderEvaluateVo addObject:[LLMeOrderDetailModel mj_objectWithKeyValues:mo]];
                }
            }
            if(detailModel.orderType.integerValue == 3 ){
                if(weakself.detailModel.taskStatus == 5){
                    weakself.detailModel.taskStatus = 2;
                }
            }
            NSLog(@"self.appOrderEvaluateVo == %@",self.appOrderEvaluateVo);
//            self.detailModel.orderStatus = @"1";
            weakself.headerView.orderStatus = detailModel.orderStatus;
            weakself.bottomView.orderStatus = detailModel.orderStatus;
            weakself.headerView.detailModel = detailModel;
            weakself.bottomView.detailModel = detailModel;
            LLappAddressInfoVo *adressModel = [LLappAddressInfoVo yy_modelWithJSON:responseObj[@"data"][@"appAddressInfoVo"]];
            weakself.adressModel = adressModel;
     
            //库存提货 没有申请退款
            if(detailModel.orderType.integerValue == 2 ){
                if( detailModel.orderStatus.integerValue == 5){
                    self.bottomView.hidden = YES;
                    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(SCREEN_top + CGFloatBasedI375(59));
                        make.right.left.mas_equalTo(0);
                        make.bottom.mas_equalTo(0);
                    }];
                }
            }
            if(detailModel.orderStatus.integerValue == 5){
                self.bottomView.hidden = YES;
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(SCREEN_top + CGFloatBasedI375(59));
                    make.right.left.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                }];
            }
            if(detailModel.orderType.integerValue == 3 ){
                if(detailModel.taskStatus == 2){
                    if(detailModel.feePriceSize == 2){//服务费加价次数（0未加价、1一次、2两次）
                        NSString *firstXiyi =  [[NSUserDefaults standardUserDefaults]objectForKey:@"firstXiyi"];
                        if(firstXiyi.length <=0){
                            [[NSUserDefaults standardUserDefaults]setObject:@"firstXiyi" forKey:@"firstXiyi"];
//                            [JXUIKit showErrorWithStatus:@"用户无人接单"];
                        }
                    }
                }else if(detailModel.taskStatus == 3){//配送员已接单
                    NSString *firstXiyi =  [[NSUserDefaults standardUserDefaults]objectForKey:@"yijiedan"];
                    if(firstXiyi.length <=0){
                        [[NSUserDefaults standardUserDefaults]setObject:@"yijiedan" forKey:@"yijiedan"];
                        if(detailModel.appDeliveryClerkDistanceVo){//配送员已接单
                            [self showPersonViews];
                        }
                    }
                }
                
            }
        }
        
        [weakself.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}
-(void)postDeal:(NSString *)name model:(LLMeOrderDetailModel *)model{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *url;
    if([name isEqual:@"确认收货"]){
        url = FORMAT(@"%@/%@",L_apiapporderconfirmReceive,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"删除订单"]){
        url = FORMAT(@"%@/%@",L_apiapporderdelete,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"取消订单"]){
        url = FORMAT(@"%@/%@",L_apiappordercancel,model.orderNo);
        [params setValue:model.orderNo forKey:@"orderNo"];
    }else if([name isEqual:@"申请退款"]){
        url = FORMAT(@"%@",L_apiapporderafterapply);
        [params setValue:model.orderNo forKey:@"orderNo"];
        [params setValue:@"1" forKey:@"afterType"];//售后类型(1退款，2退款退货，3库存补发)
        [params setValue:@"1" forKey:@"logisticStatus"];
        [params setValue:@"1" forKey:@"refundReason"];
    }
    [XJHttpTool post:url method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        [self getOrderDetailUrl];
        if(self.tapAction){
            self.tapAction();
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
#pragma mark--获取开票详情
#pragma mark--获取开票详情
-(void)getorderBillDetail{
    //开票状态（1未开票，2开票中，3已开票，4不通过）
    if ([self.detailModel.invoiceStatus intValue] == 1 || [self.detailModel.invoiceStatus intValue] == 0) {
        //未开票
        LLOrderAppltBillController *applyVC = [[LLOrderAppltBillController alloc]init];
        applyVC.orderNo = self.detailModel.orderNo;
        applyVC.invoiceStatus = self.detailModel.invoiceStatus;
//        applyVC.datas = model.appOrderListGoodsVos;
        applyVC.model = (LLMeOrderListModel *)self.detailModel;
        [self.navigationController pushViewController:applyVC animated:YES];
    }else if ([self.detailModel.invoiceStatus intValue] == 2 || [self.detailModel.invoiceStatus intValue] == 3){
        //开票中
        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
        statusVc.orderNo = self.detailModel.orderNo;
        
        [self.navigationController pushViewController:statusVc animated:YES];
    }else if ([self.detailModel.invoiceStatus intValue] == 2){
        //开票中
        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
        statusVc.orderNo = self.detailModel.orderNo;
        statusVc.invoiceStatus = self.detailModel.invoiceStatus;
        [self.navigationController pushViewController:statusVc animated:YES];
    }
}
//-(void)getorderBillDetail{
//
//    if ([_detailModel.invoiceStatus intValue] == 1) {
//        //未开票
//        LLOrderAppltBillController *applyVC = [[LLOrderAppltBillController alloc]init];
//        applyVC.orderNo = _detailModel.orderNo;
//        [self.navigationController pushViewController:applyVC animated:YES];
//    }else if ([_detailModel.invoiceStatus intValue] == 2){
//        //开票中
//        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
//        statusVc.orderNo = _detailModel.orderNo;
//        [self.navigationController pushViewController:statusVc animated:YES];
//    }else if ([_detailModel.invoiceStatus intValue] == 2){
//        //开票中
//        LLOrderApplyBillStatusConoller *statusVc = [[LLOrderApplyBillStatusConoller alloc]init];
//        statusVc.orderNo = _detailModel.orderNo;
//        [self.navigationController pushViewController:statusVc animated:YES];
//    }
//}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_detailModel){
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
            return 4;
        }
    }
    if(self.detailModel.orderType.integerValue == 3){//品鉴区域
        if( self.detailModel.taskStatus == 2){//待接单
            return 3;
        }else if(self.detailModel.taskStatus == 3 || self.detailModel.taskStatus == 4){//待提货 待评价
            return 5;
        }
    }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6) || self.detailModel.orderStatus.integerValue == 4){
            //待提货  待评价
            return 5;
        }
        return 3;
    }
    if ([_detailModel.orderStatus intValue] == 0) {
        return 4;
    }
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_detailModel){
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
            if (section == 0) {
                return 1;
            }else if (section == 1){
                NSLog(@"section == %ld appOrderListGoodsVos == %ld",section,_detailModel.appOrderListGoodsVos.count);
                return _detailModel.appOrderListGoodsVos.count;
            }else if (section == 2){
                return _detailModel.appOrderListGoodsVos.count;
            }
            return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
        }
    }
    if(self.detailModel.orderType.integerValue == 3){//品鉴区域
        if( self.detailModel.taskStatus == 2){//待接单
            if (section == 0) {
                return 1;
            }else if (section == 1){
                return _detailModel.appOrderListGoodsVos.count;
            }else if (section == 2){
                return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
            }
        }else if(self.detailModel.taskStatus == 3 || self.detailModel.taskStatus == 4){//待提货 待评价
            if (section == 0 || section == 1 || section == 2) {
                return 1;
            }else if (section == 3){
                return _detailModel.appOrderListGoodsVos.count;
            }else if (section == 4){
                return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
            }
        }
    }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6)|| self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
          
            if (section == 0 || section == 1 || section == 2) {
                return 1;
            }else if (section == 3){
                return _detailModel.appOrderListGoodsVos.count;
            }else if (section == 4){
                return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
            }
        }//同城提货 其他状态
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return _detailModel.appOrderListGoodsVos.count;
        }
        return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
    }
    if ([_detailModel.orderStatus intValue] == 0) {
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return _detailModel.appOrderListGoodsVos.count;
        }else if (section == 2){
            return _detailModel.appOrderListGoodsVos.count;
        }
        return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
    }
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _detailModel.appOrderListGoodsVos.count;
    }
    return [self getOrderStausInfoArray:_detailModel.orderStatus].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_detailModel){
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
            return  [self dealDoneWith:tableView index:indexPath];
        }
    }
    if(self.detailModel.orderType.integerValue == 3){//品鉴区域
        
        return  [self dealPinjianlWith:tableView index:indexPath];
    }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        return  [self dealTongchengWith:tableView index:indexPath];
    }
    if ([_detailModel.orderStatus intValue] == 0) {
        
        if (indexPath.section == 0) {
            LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_adressModel) {
                cell.adressModel = _adressModel;
            }
            return cell;
        }else if (indexPath.section == 1){
            LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                cell.model = _detailModel;

                cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
            }
            
            return cell;
        }else if (indexPath.section == 2){
            LLMeorderDetailInfotableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailInfotableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
            }
            return cell;
        }
        LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            NSDictionary *dict = _orderInfoArray[indexPath.row];
            cell.leftStr = dict[@"title"];
            cell.rightStr = dict[@"content"];
        }
        return cell;
    }
    if (indexPath.section == 0) {
        LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_adressModel) {
            cell.adressModel = _adressModel;
        }
        return cell;
    }else if (indexPath.section == 1){
        LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            cell.model = _detailModel;
            cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
        }
        return cell;
    }
    LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_detailModel) {
        NSDictionary *dict = _orderInfoArray[indexPath.row];
        cell.leftStr = dict[@"title"];
        cell.rightStr = dict[@"content"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if (section == 1) {
        if(self.detailModel.orderType.integerValue == 3){//品鉴区域
            if(self.detailModel.taskStatus == 2){//待接单
                return CGFloatBasedI375(180);
            }else{//其他状态
                return CGFloatBasedI375(0.01);
            }
        }else if(self.detailModel.orderType.integerValue == 2){//惊喜红包
            return CGFloatBasedI375(25);
        }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
            if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6) || self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
                return CGFloatBasedI375(0.001);
            }
            return CGFloatBasedI375(160);
        }
        return CGFloatBasedI375(160);
    }else if (section == 3) {
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
            return CGFloatBasedI375(95);
        }
        if(self.detailModel.orderType.integerValue == 3 && ( self.detailModel.taskStatus == 3 || self.detailModel.orderStatus.integerValue == 4)){//品鉴区域
            return CGFloatBasedI375(180);
        }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
            if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6)|| self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
                return CGFloatBasedI375(180);
            }
            return CGFloatBasedI375(0.0001);
        }
        return CGFloatBasedI375(0.0001);
    }
    
    if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
        if (self.detailModel.expressType.integerValue == 1 && self.detailModel.orderType.integerValue == 2) {
            if (section == 3) {
                return CGFloatBasedI375(95);
            }
        }else{
            if (section == 2) {
                return CGFloatBasedI375(95);
            }
        }
       
    }
    if(self.detailModel.expressType.integerValue == 1  && (self.detailModel.orderStatus.integerValue == 2 || self.detailModel.orderStatus.integerValue == 4) && self.detailModel.orderType.integerValue != 3){  //配送员，待发货,待评价,3=待收货
        if (section == 2) {
            return CGFloatBasedI375(95);
        }
    }
    if(((self.detailModel.expressType.integerValue == 1 || self.detailModel.expressType.integerValue == 2) && self.detailModel.orderStatus.integerValue == 6)){  //交易关闭 取消订单
        if (section == 2) {
            return CGFloatBasedI375(95);
        }
    }
    if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6)|| self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
        if (section == 4) {
            return CGFloatBasedI375(95);
        }
    }
    if (self.detailModel.taskStatus == 1 && self.detailModel.orderStatus.integerValue == 3 && self.detailModel.orderType.integerValue == 2) {
        if (section == 2) {
            return CGFloatBasedI375(95);
        }
    }
    
    return CGFloatBasedI375(25);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WS(weakself);
    if (section == 0) {
        return nil;
    }else if (section == 1) {
        if(self.detailModel.orderType.integerValue == 3){//品鉴区域
            if( self.detailModel.taskStatus == 2){
                LLMeorderDetailPayInfoView *footerView = [[LLMeorderDetailPayInfoView alloc]initWithFrame:tableView.tableFooterView.frame];
                if (_detailModel) {
                    footerView.detailModel = _detailModel;
                }
                return  footerView;
            }else{
                return  nil;
            }
        }else if(self.detailModel.orderType.integerValue == 2){//惊喜红包
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            
            return  footerView;
        }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
            if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6) || self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
                return  nil;
            }
            LLMeorderDetailPayInfoView *footerView = [[LLMeorderDetailPayInfoView alloc]initWithFrame:tableView.tableFooterView.frame];
            if (_detailModel) {
                footerView.detailModel = _detailModel;
            }
            return  footerView;
        }
        LLMeorderDetailPayInfoView *footerView = [[LLMeorderDetailPayInfoView alloc]initWithFrame:tableView.tableFooterView.frame];
        if (_detailModel) {
            footerView.detailModel = _detailModel;
        }
        return  footerView;
    }else if (section == 3) {
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
        
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.showInfo = YES;
            footerView.questionLabel.text = @"订单遇到问题?";
            footerView.serviceBlock = ^{
               
                [weakself footViewJoinServiceView];
                
            };
            return  footerView;
        }
        if(self.detailModel.orderType.integerValue == 3 && ( self.detailModel.taskStatus == 3 || self.detailModel.orderStatus.integerValue == 4)){//品鉴区域
            LLMeorderDetailPayInfoView *footerView = [[LLMeorderDetailPayInfoView alloc]initWithFrame:tableView.tableFooterView.frame];
            if (_detailModel) {
                footerView.detailModel = _detailModel;
            }
            return  footerView;
        }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
            LLMeorderDetailPayInfoView *footerView = [[LLMeorderDetailPayInfoView alloc]initWithFrame:tableView.tableFooterView.frame];
            if (_detailModel) {
                footerView.detailModel = _detailModel;
            }
            return  footerView;
        }
    }else if (section == 2){
        
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
            
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            return  footerView;
        }else{
            
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.showInfo = YES;
            footerView.questionLabel.text = @"订单遇到问题?";
            footerView.serviceBlock = ^{
               
                [weakself footViewJoinServiceView];
                
            };
            return  footerView;
        }
        
    }
    
    if(self.detailModel.taskStatus == 3 || self.detailModel.taskStatus == 4){
        if (section == 4){
            
            LLmeOrderDetailInfoFooterView *footerView =  [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
            footerView.showInfo = YES;
            footerView.questionLabel.text = @"订单遇到问题?";
            footerView.serviceBlock = ^{
               
                [weakself footViewJoinServiceView];
                
            };
            return  footerView;
        }
    }
    
    return nil;
}

#pragma  mark - 尾视图跳转客服
-(void)footViewJoinServiceView{
    
    WS(weakself);
    XYServiceTipsViewController *serviceVC = [[XYServiceTipsViewController alloc]init];
    serviceVC.pushBlock = ^(UIViewController * view) {
        [weakself.navigationController pushViewController:view animated:YES];
    };
    serviceVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    serviceVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:serviceVC animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    if(self.detailModel.orderType.integerValue == 3 && self.detailModel.taskStatus ==3){
        if (section == 3 || section == 4) {
            return CGFloatBasedI375(44);
        }else if(section == 1){
            if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
                return CGFloatBasedI375(44);
            }
            return 0.1;
        }
        return 0.1;
    }else if(self.detailModel.orderType.integerValue == 3 && self.detailModel.taskStatus == 4){//品鉴 待评价
        if (section == 3 || section == 4) {
            return CGFloatBasedI375(44);
        }else if(section == 1){
            if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
                return CGFloatBasedI375(44);
            }
            return 0.1;
        }
        return 0.1;
    }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6) || self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
            if (section == 3 || section == 4) {
                return CGFloatBasedI375(44);
            }else if(section == 1){
                if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
                    return CGFloatBasedI375(44);
                }
                return 0.1;
            }
            return 0.1;
        }
        return CGFloatBasedI375(44);
    }
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    
    LLMeOrderDetailTitleView *titleView = [[LLMeOrderDetailTitleView alloc]initWithFrame:tableView.tableHeaderView.frame];
    if(self.detailModel.orderType.integerValue == 3 &&  self.detailModel.taskStatus == 3){
        if (section == 3) {
            titleView.titleStr = @"商品信息";
        }else if (section == 4){
            titleView.titleStr = @"订单信息";
        } else if(section == 1){
            if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
                titleView.titleStr = @"商品信息";
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else if(self.detailModel.orderType.integerValue == 3 && self.detailModel.taskStatus == 4){
        if (section == 3) {
            titleView.titleStr = @"商品信息";
        }else if (section == 4){
            titleView.titleStr = @"订单信息";
        } else if(section == 1){
            if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
                titleView.titleStr = @"商品信息";
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else if(self.detailModel.expressType.integerValue == 2 && self.detailModel.orderType.integerValue == 1){//同城提货 待提货
        if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6) || self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
            if (section == 3) {
                titleView.titleStr = @"商品信息";
            }else if (section == 4){
                titleView.titleStr = @"订单信息";
            } else if(section == 1){
                if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
                    titleView.titleStr = @"商品信息";
                }else{
                    return nil;
                }
            }else{
                return nil;
            }
        }
        if (section == 1) {
            titleView.titleStr = @"商品信息";
        }else if (section == 2){
            titleView.titleStr = @"订单信息";
        }
    }
    if (section == 1) {
        titleView.titleStr = @"商品信息";
    }else if (section == 2){
        if(self.detailModel.orderStatus.integerValue == 7 && self.appOrderEvaluateVo.count){//所有已完成订单
            titleView.titleStr = @"商品评价";
        }else{
            titleView.titleStr = @"订单信息";
        }
    }else if (section == 3){
        titleView.titleStr = @"订单信息";
    }
    return titleView;
}

//根据商品的订单状态判断订单信息的现实数量
-(NSArray *)getOrderStausInfoArray:(NSString *)orderStatus{
    
    _orderInfoArray = [[NSArray alloc]init];
    
    if (_detailModel) {
        
        NSString *orderNo = [_detailModel.orderNo length] > 0 ? _detailModel.orderNo : @"3";
        NSString *createTime = [_detailModel.createTime length] > 0 ? _detailModel.createTime : @"3";
        NSString *payTime = [_detailModel.payTime length] > 0 ? _detailModel.payTime : @"无";
        NSString *deliveryTime = [_detailModel.deliveryTime  length] > 0? _detailModel.deliveryTime : @"3";
        NSString *completeTime = [_detailModel.completeTime length] > 0 ? _detailModel.completeTime : @"3";
        NSString *payMode = [_detailModel.payMode intValue] == 1 ? @"微信" :@"支付宝";
        NSString *remarks = _detailModel.remarks.length > 0 ? _detailModel.remarks : @"暂无备注";
        NSString *taskTime = [_detailModel.taskTime length] > 0 ? _detailModel.taskTime : @"";
        if(_detailModel.orderType.integerValue == 2){//惊喜红包
            if(orderStatus.integerValue == 2){//待发货
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},nil];
            }else if(orderStatus.integerValue == 3 || orderStatus.integerValue == 4){//待收货
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                 @{@"title":@"发货时间",@"content":deliveryTime}   ,nil];
            }else{
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                 @{@"title":@"发货时间",@"content":deliveryTime}   ,nil];
            }
            //已完成
          
        }else if(_detailModel.orderType.integerValue == 3){//品鉴区域
            if (_detailModel.taskStatus == 2) {
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if( _detailModel.taskStatus == 1){//待付款
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if( _detailModel.taskStatus == 3){//待提货
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"接单时间",@"content":taskTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if(orderStatus.integerValue == 4){//待评价
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"接单时间",@"content":_detailModel.taskTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }
        }else if(_detailModel.orderType.integerValue == 1 && _detailModel.expressType.integerValue == 2){//同城
            if (_detailModel.taskStatus == 2) {
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if( _detailModel.taskStatus == 1 || _detailModel.orderStatus.integerValue == 1){//待付款
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if( _detailModel.taskStatus == 3 && orderStatus.integerValue != 6){//待提货
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"接单时间",@"content":taskTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if(orderStatus.integerValue == 4){//待评价
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"接单时间",@"content":_detailModel.taskTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }else if(orderStatus.integerValue == 6){//已取消
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                 
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }else{
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"接单时间",@"content":_detailModel.taskTime},
                                   @{@"title":@"完成时间",@"content":_detailModel.completeTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"订单备注",@"content":remarks}, nil];
            }
        }else{
        
        if ([orderStatus intValue] == 0) {
            //已完成
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"发货时间",@"content":deliveryTime},
                                                              @{@"title":@"完成时间",@"content":completeTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }else if ([orderStatus intValue] == 1 || [orderStatus intValue] == 6){
            //待付款
            _orderInfoArray = [[NSArray alloc]initWithObjects:
                                                              @{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }else if ([orderStatus intValue] == 2){
            //待发货
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                               @{@"title":@"支付时间",@"content":payTime.length <=0?@"":payTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }else if ([orderStatus intValue] == 3){
            //待收货
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"发货时间",@"content":deliveryTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }else if ([orderStatus intValue] == 4){
            //待评价
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"发货时间",@"content":deliveryTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }else if ([orderStatus intValue] == 5){
            //待评价
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"发货时间",@"content":deliveryTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }else if ([orderStatus intValue] == 7){
            //已完成
            if(completeTime.length > 0){
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"发货时间",@"content":deliveryTime},
                                   @{@"title":@"完成时间",@"content":completeTime.length <=0?@"无":completeTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"备注",@"content":remarks}, nil];
            }else{
                _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                                  @{@"title":@"下单时间",@"content":createTime},
                                                                  @{@"title":@"支付时间",@"content":payTime},
                                                                  @{@"title":@"发货时间",@"content":deliveryTime},
                                                                  @{@"title":@"支付方式",@"content":payMode},
                                                                  @{@"title":@"备注",@"content":remarks}, nil];
            }
            
          
        }else{
            _orderInfoArray = [[NSArray alloc]initWithObjects:@{@"title":@"订单编号",@"content":orderNo},
                                                              @{@"title":@"下单时间",@"content":createTime},
                                                              @{@"title":@"支付时间",@"content":payTime},
                                                              @{@"title":@"发货时间",@"content":deliveryTime},
                                                              @{@"title":@"支付方式",@"content":payMode},
                                                              @{@"title":@"备注",@"content":remarks}, nil];
        }
    }
    }
    return _orderInfoArray;
}

#pragma mark 所有已完成订单  显示评价 各种状态的cell处理
-(UITableViewCell *)dealDoneWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_adressModel) {
            cell.adressModel = _adressModel;
        }
        return cell;
    }else if(indexPath.section == 1){//商品信息
        LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            cell.model = _detailModel;
            cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
        }
        
        return cell;
    }else if(indexPath.section == 2){//评价
        LLMeorderDetailInfotableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailInfotableCellpingjia" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
        }
        return cell;
    }
    LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_detailModel) {
        NSDictionary *dict = _orderInfoArray[indexPath.row];
        cell.leftStr = dict[@"title"];
        cell.rightStr = dict[@"content"];
    }
    return cell;
    


}
#pragma mark 同城cell 各种状态的cell处理
-(UITableViewCell *)dealTongchengWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    if((self.detailModel.taskStatus == 3 && self.detailModel.orderStatus.integerValue != 6) || self.detailModel.orderStatus.integerValue == 4){  //待提货  待评价
    if(indexPath.section == 0){
        LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_adressModel) {
            cell.adressModel = _adressModel;
        }
        return cell;
    }else if(indexPath.section == 1){//配送员信息
        LLMeorderDetailPeiSongtableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailPeiSongtableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
//                cell.model = _detailModel;
            cell.model = _detailModel;
        }
        
        return cell;
    }else if(indexPath.section == 2){//地图
        LLStockoOrderMapTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockoOrderMapTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            cell.model = _detailModel;
        }
        return cell;
    }else if(indexPath.section == 3){//
        LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            cell.model = _detailModel;
            cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
        }
        
        return cell;
    }
    LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_detailModel) {
        NSDictionary *dict = _orderInfoArray[indexPath.row];
        cell.leftStr = dict[@"title"];
        cell.rightStr = dict[@"content"];
    }
    return cell;
    }
    if(indexPath.section == 0){
        LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_adressModel) {
            cell.adressModel = _adressModel;
        }
        return cell;
    }else if(indexPath.section == 1){
        LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            cell.model = _detailModel;
            cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
        }
        
        return cell;
    }else{
        LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            NSDictionary *dict = _orderInfoArray[indexPath.row];
            cell.leftStr = dict[@"title"];
            cell.rightStr = dict[@"content"];
        }
        return cell;
    }

}
#pragma mark 品鉴cell 各种状态的cell处理
-(UITableViewCell *)dealPinjianlWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    WS(weakself);
    if(self.detailModel.taskStatus == 2){
        if(indexPath.section == 0){
            LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_adressModel) {
                cell.adressModel = _adressModel;
            }
            return cell;
        }else if(indexPath.section == 1){
            LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                cell.model = _detailModel;
                cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
            }
            
            return cell;
        }else{
            LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                NSDictionary *dict = _orderInfoArray[indexPath.row];
                cell.leftStr = dict[@"title"];
                cell.rightStr = dict[@"content"];
            }
            return cell;
        }
    }else   if( self.detailModel.taskStatus == 1){
        if(indexPath.section == 0){
            LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_adressModel) {
                cell.adressModel = _adressModel;
            }
            return cell;
        }else if(indexPath.section == 1){
            LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                cell.model = _detailModel;
                cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
            }
            
            return cell;
        }else{
            LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                NSDictionary *dict = _orderInfoArray[indexPath.row];
                cell.leftStr = dict[@"title"];
                cell.rightStr = dict[@"content"];
            }
            return cell;
        }
    }else if( self.detailModel.taskStatus == 3|| self.detailModel.taskStatus == 4){//待提货 待评价
        if(indexPath.section == 0){
            LLMeorderDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_adressModel) {
                cell.adressModel = _adressModel;
            }
            return cell;
        }else if(indexPath.section == 1){//配送员信息
            LLMeorderDetailPeiSongtableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeorderDetailPeiSongtableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
//                cell.model = _detailModel;
                cell.model = _detailModel;
            }
            
            return cell;
        }else if(indexPath.section == 2){//地图
            LLStockoOrderMapTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLStockoOrderMapTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                cell.model = _detailModel;
            }
            return cell;
        }else if(indexPath.section == 3){//
            LLMeOrderDetailListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderDetailListTableCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_detailModel) {
                cell.model = _detailModel;
                cell.goodsModel = _detailModel.appOrderListGoodsVos[indexPath.row];
            }
            
            return cell;
        }
        LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel) {
            NSDictionary *dict = _orderInfoArray[indexPath.row];
            cell.leftStr = dict[@"title"];
            cell.rightStr = dict[@"content"];
        }
        return cell;
    }else{
        LlmeOrderDetailOrderInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LlmeOrderDetailOrderInfoTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_detailModel && _orderInfoArray.count) {
            NSDictionary *dict = _orderInfoArray[indexPath.row];
            cell.leftStr = dict[@"title"];
            cell.rightStr = dict[@"content"];
        }
        return cell;
    }
   
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top + CGFloatBasedI375(59), SCREEN_WIDTH, (SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(59) - CGFloatBasedI375(50) - SCREEN_Bottom)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeorderDetailInfotableCell class] forCellReuseIdentifier:@"LLMeorderDetailInfotableCell"];
        [_tableView registerClass:[LLMeorderDetailTableCell class] forCellReuseIdentifier:@"LLMeorderDetailTableCell"];
        [_tableView registerClass:[LLMeOrderDetailListTableCell class] forCellReuseIdentifier:@"LLMeOrderDetailListTableCell"];
        [_tableView registerClass:[LlmeOrderDetailOrderInfoTableCell class] forCellReuseIdentifier:@"LlmeOrderDetailOrderInfoTableCell"];
        [_tableView registerClass:[LLMeorderDetailPeiSongtableCell class] forCellReuseIdentifier:@"LLMeorderDetailPeiSongtableCell"];
        [_tableView registerClass:[LLMeorderDetailInfotableCell class] forCellReuseIdentifier:@"LLMeorderDetailInfotableCellpingjia"];

        [_tableView registerClass:[LLStockoOrderMapTableCell class] forCellReuseIdentifier:@"LLStockoOrderMapTableCell"];
        
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = CGFloatBasedI375(10);
        _tableView.rowHeight=UITableViewAutomaticDimension;
    }
    return _tableView;
}
-(LLMeOrderDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LLMeOrderDetailHeaderView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, CGFloatBasedI375(59))];
        WS(weakself);
        _headerView.tapAddAction = ^(LLMeOrderDetailModel * _Nonnull detailModel) {
          //品鉴 待接单
            if(detailModel.orderType.integerValue == 3 && detailModel.taskStatus == 2 && detailModel.orderStatus.integerValue == 2){
                [weakself  showPays];
            }
        };
    }
    return _headerView;
}
-(LLMeorderDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLMeorderDetailBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        WS(weakself);
        _bottomView.ActionBlock = ^(NSString * _Nonnull tagName) {
            if ([tagName isEqual:@"去付款"]) {
                LLStorePayViewController *vc = [[LLStorePayViewController alloc]init];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:weakself.detailModel.orderNo forKey:@"orderNo"];
                [param setValue:weakself.detailModel.actualPrice forKey:@"payPrice"];
                [param setValue:weakself.detailModel.stayPayTimestamp forKey:@"stayPayTimestamp"];
                vc.datas = param.mutableCopy;
                if(weakself.detailModel.orderType.integerValue == 1){
                    vc.status = RoleStatusStore;
                }else if(weakself.detailModel.orderType.integerValue == 2){
                    vc.status = RoleStatusRedBag;
                }else if(weakself.detailModel.orderType.integerValue == 3){
                    vc.status = RoleStatusPingjian;
                }
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if ([tagName isEqual:@"取消订单"]){
                [weakself.cancleView show];
            }else if ([tagName isEqual:@"申请退款"]){
                if(weakself.detailModel.stockNum > 0 ){
                    LLShouHouApplyViewController *vc = [[LLShouHouApplyViewController alloc]init];
                    vc.model = weakself.shouModel;
                    vc.tagIndex = 0;
                    if(weakself.detailModel.orderType.integerValue == 2 || weakself.detailModel.stockNum> 0){
                        vc.ShowKucu = YES;
                    }
                    vc.tapAction = ^{
                        [weakself getOrderDetailUrl];
                    };
                    [weakself.navigationController pushViewController:vc animated:YES];
                }else{
                    [weakself.refundView show];
                }
             
               
            }else if ([tagName isEqual:@"确认收货"]){
                NSString *name = @"是否确认收货";
                NSString *names = @"确认收货后将不能退货退款";
                if(weakself.statues == RoleStatusStockPeisong){
                    name = @"请注意快递是否存在破损问题";
                    names = @"";
                }
                [UIAlertController showAlertViewWithTitle:name Message:names BtnTitles:@[@"取消",@"确认"] ClickBtn:^(NSInteger index) {
                    if(index == 1){
                        [weakself postDeal:tagName model:weakself.detailModel];
                    }
                    
                }];
            }else if ([tagName isEqual:@"查看物流"]){
                LLOrderDeliverViewController *vc = [[LLOrderDeliverViewController alloc]init];
                vc.orderNo = weakself.detailModel.orderNo;
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if ([tagName isEqual:@"申请售后"]){
                LLShouHouApplyViewController *vc = [[LLShouHouApplyViewController alloc]init];
                vc.model = weakself.shouModel;
                vc.tagIndex = 0;
                if(weakself.detailModel.orderType.integerValue == 2 || weakself.detailModel.stockNum> 0){
                    vc.ShowKucu = YES;
                }
                vc.tapAction = ^{
                    [weakself getOrderDetailUrl];
                };
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if ([tagName isEqual:@"去评价"]){
                LLEvaulateViewController *evaluateVC = [[LLEvaulateViewController alloc]init];
                evaluateVC.model =  weakself.shouModel;
                evaluateVC.tapAction = ^{
                    [weakself getOrderDetailUrl];
                };
                [weakself.navigationController pushViewController:evaluateVC animated:YES];
            }else if ([tagName isEqual:@"申请开票"] || [tagName isEqual:@"开票中"]|| [tagName isEqual:@"已开票"]|| [tagName isEqual:@"开票不通过"]){
                [weakself getorderBillDetail];
            }else if ([tagName isEqual:@"删除订单"]){
                [weakself.deleteView show];
            }else if ([tagName isEqual:@"修改地址"]){
                LLMeAdressController *vc = [[LLMeAdressController alloc]init];
                vc.isOrderChoice = YES;
                vc.orderNo = weakself.detailModel.orderNo;
                vc.getAressBlock = ^(LLGoodModel * _Nonnull model) {
                    [weakself getOrderDetailUrl];
                };
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if ([tagName isEqual:@"联系配送员"]){
                    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",weakself.detailModel.appDeliveryClerkDistanceVo.telePhone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }else if ([tagName isEqual:@"联系推广员"]){
                    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",weakself.detailModel.shopDistanceVo.telePhone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
            }
        };
    }
    return _bottomView;
}

-(LLMeAdressDeleteView *)refundView{
    if (!_refundView) {
        _refundView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _refundView.titleStr = @"申请退款";
        _refundView.textStr = @"确认要对该笔订单订单申请退款吗？申请\n后退款将在1-3个工作日原路返回";
        _refundView.rightStr = @"确定";
        WS(weakself);
        _refundView.deleteBtnBlock = ^{
            [weakself postDeal:@"申请退款" model:weakself.detailModel];
        };
    }
    return _refundView;
}

-(LLMeAdressDeleteView *)confirmView{
    if (!_confirmView) {
        _confirmView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _refundView.titleStr = @"确认收货";
        _confirmView.textStr = @"是否确认收货";
        _confirmView.rightStr = @"确定";
        WS(weakself);
        _confirmView.deleteBtnBlock = ^{
            [weakself postDeal:@"确认收货" model:weakself.detailModel];
        };
    }
    return _confirmView;
}
-(LLMeAdressDeleteView *)cancleView{
    if (!_cancleView) {
        _cancleView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _cancleView.titleStr = @"取消订单";
        _cancleView.textStr = @"是否取消订单";
        _cancleView.rightStr = @"确定";
        WS(weakself);
        _cancleView.deleteBtnBlock = ^{
            [weakself postDeal:@"取消订单" model:weakself.detailModel];
        };
    }
    return _cancleView;
}
-(LLMeAdressDeleteView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _deleteView.titleStr = @"删除订单";
        _deleteView.textStr = @"是否删除订单";
        _deleteView.rightStr = @"确定";
        WS(weakself);
        _deleteView.deleteBtnBlock = ^{
            [weakself postDeal:@"删除订单" model:weakself.detailModel];
        };
    }
    return _deleteView;
}
-(void)showPays{
    if(self.detailModel.feePriceSize != 2){//服务费加价次数（0未加价、1一次、2两次）
        if(_showView){
            _showView = nil;
        }
        NSLog(@" self.datas == %@", self.datas);
        self.showView.datas = self.datas;
        self.showView.model = self.detailModel;
        [self showView];
        [self.showView showActionSheetView];
        
    }else{
        [self cancles];
    }

}
-(void)pickerEnsureBtnTarget{
    [self.showView hideActionSheetView];
    LLStorePayViewController *vc = [[LLStorePayViewController alloc]init];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.detailModel.orderNo forKey:@"orderNo"];
    [param setValue:self.datas[@"content"] forKey:@"payPrice"];
   NSInteger times =  [_detailModel.stayTaskTimestamp integerValue]+600;
//    NSString *newdata = [NSString getCurrentTimes];
//    long long startLongLong = [newdata longLongValue];
    [param setValue:FORMAT(@"%ld",times) forKey:@"stayPayTimestamp"];

    
    vc.status = RoleStatusPingjian;
    vc.datas = param.mutableCopy;
    vc.judgePriceType = YES;
    vc.feePriceSize = self.detailModel.feePriceSize;
    [self.navigationController pushViewController:vc animated:YES];
}
-(LLAlertShowView *)showView{
    if(!_showView){
        _showView = [[LLAlertShowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_showView.sureBtn addTarget:self action:@selector(pickerEnsureBtnTarget) forControlEvents:UIControlEventTouchUpInside];
        [_showView.sureBtn1 addTarget:self action:@selector(cancles) forControlEvents:UIControlEventTouchUpInside];

    }
    return _showView;
}
-(void)cancles{
    [self.showView hideActionSheetView];
    [self postDeal:@"取消订单" model:self.detailModel];
}
-(void)showPersonViews{
    if(self.peiSongView){
        self.peiSongView = nil;
    }
    [self peiSongView];
    self.peiSongView.model = self.detailModel;
    [self.peiSongView show];
}
-(LLMeOrderDetailOrderReceiveView *)peiSongView{
    if(!_peiSongView){
        _peiSongView = [[LLMeOrderDetailOrderReceiveView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [_showView.sureBtn addTarget:self action:@selector(pickerEnsureBtnTarget) forControlEvents:UIControlEventTouchUpInside];

    }
    return _peiSongView;
}
-(NSMutableArray *)appOrderEvaluateVo{
    if(!_appOrderEvaluateVo){
        _appOrderEvaluateVo = [NSMutableArray array];
    }
    return _appOrderEvaluateVo;
}
@end
