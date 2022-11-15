//
//  LLReturnServiceViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/4/1.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLShouHouApplyViewController.h"
#import "LLReturnServiceCell.h"
#import "LLReturnShowView.h"
#import "LLMeOrderDetailHeaderView.h"
#import "Winner-Swift.h"

static NSString *const LLReturnServiceCellid = @"LLReturnServiceCell";
static NSString *const LLReturnServiceComCellid = @"LLReturnServiceComCellid";
static NSString *const LLReturnApplyComCellid = @"LLReturnApplyComCell";
static NSString *const LLReturnApplyComMonCellid = @"LLReturnApplyComMonCell";
static NSString *const LLReturnApplyComTextCellid = @"LLReturnApplyComTextCell";
static NSString *const LLReturnApplyComPicCellid = @"LLReturnApplyComPicCell";
static NSString *const LLReturnApplyOnmonyComCellid = @"LLReturnApplyOnmonyComCell";
@interface LLShouHouApplyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLReturnShowView *showView;/** <#class#> **/
@property (nonatomic,copy) NSString *tokens;/** <#class#> **/
@property (nonatomic,copy) NSString *imageStr;/** <#class#> **/
@property (nonatomic,strong) NSArray *imageArr;/** <#class#> **/
@property (nonatomic,copy) UITextField *descriptionStr;/** <#class#> **/
@property (nonatomic,copy) UITextField *refund_express_amount;/** <#class#> **/
@property (nonatomic,copy) NSString *refund_type;/** <#class#> **/
@property (nonatomic,copy) NSString *refund_Name;/** <#class#> **/
@property (nonatomic,copy) NSString *reason;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,copy) NSString *is_receiptName;/** <#class#> **/
@property (nonatomic,copy) NSString *is_receipt;/** 0未收到 1收到 **/
@property (nonatomic,assign) NSInteger indexResontag;/** 弹框选择 **/
@property (nonatomic,strong) UIView *boView;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic,assign) NSInteger logisticStatus;/** class **/
@property (nonatomic, copy) NSString *logisticStatusStr;
@property (nonatomic, copy) NSString *refundReason;
@property (nonatomic,strong) LLGoodModel *vaModel;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *expressModel;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *imageeList;/** <#class#> **/
@property (nonatomic, copy) NSString *refuseReason;
@property (nonatomic,strong)LLMeorderDetailBottomView *bottomView;
@property (nonatomic,strong) NSArray *imageArrsss;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataExArr;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataReasonArr;/** <#class#> **/
@property (nonatomic,strong) LLMeOrderListModel *detailModel;/** <#class#> **/
@property (nonatomic, copy) NSString *returnReason;
@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic,assign) BOOL isUpload;/** class **/

@property (nonatomic,assign) NSInteger indextag;/** 弹框选择 **/
@end

@implementation LLShouHouApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"申请售后";
    if(_tagIndex == OrderRefundStockState){
        self.customNavBar.title = @"申请售后";
    }
    self.indextag = -1;
    self.indexResontag = -1;
    [self setLayout];
    [self getExpessData];
    [self getsonReaData];
    [self getOrderDetailUrl];
  
    if(self.orderNo){
        self.reason   =self.reasonStr;
        [self getDetailData];
    }
    

}
-(void)getDetailData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *orders = _orderNo.length<=0?_model.orderNo:_orderNo;
    [params setValue:orders forKey:@"orderNo"];
    WS(weakself);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [XJHttpTool post:FORMAT(@"%@/%@",L_apiapporderaftergetById,orders) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSDictionary *data = responseObj[@"data"];
        NSLog(@"data == %@",responseObj[@"data"]);
        self.detailModel = [LLMeOrderListModel mj_objectWithKeyValues:responseObj[@"data"]];
        [self setLayout];
        if((self.detailModel.expressNum.length > 0 && self.detailModel.expressName.length > 0)|| (self.detailModel.orderAfterStatus.integerValue == 2 && self.detailModel.afterType.integerValue == 2)){
            self.tagIndex = OrderRefundExpressState;
            LLGoodModel *models = [[LLGoodModel alloc]init];
            models.title =  self.detailModel.expressName;
            models.ID =  self.detailModel.expressId;
            self.expressModel = models;
           
            NSString *expressVoucher =self.detailModel.expressVoucher;
            if(self.detailModel.expressVoucher.length > 0){
                self.imageArr =[expressVoucher componentsSeparatedByString:@","];
            }
            NSString *returnVoucher =self.detailModel.returnVoucher;
            if(self.detailModel.returnVoucher.length > 0){
                self.imageArrsss =[returnVoucher componentsSeparatedByString:@","];

            }
            NSLog(@"self.imageArr == %@",  self.imageArr);
            
        }else{
            NSString *returnVoucher =self.detailModel.returnVoucher;
            if(self.detailModel.returnVoucher.length > 0){
            self.imageArr =[returnVoucher componentsSeparatedByString:@","];
                self.imageArrsss =[returnVoucher componentsSeparatedByString:@","];

            }
            if(self.tagIndex == OrderRefundExpressState){
                NSString *returnVoucher =self.detailModel.expressVoucher;
                if(self.detailModel.expressVoucher.length > 0){
                    self.imageArr =[returnVoucher componentsSeparatedByString:@","];
                }
            }
        
            
        }
        if(weakself.orderNo.length > 0){
            if(self.detailModel.logisticStatus.integerValue == 1){//货物状态（1未收到货，2已收到货）
                self.logisticStatusStr = @"未收到货";
            }else{
                self.logisticStatusStr = @"已收到货";
            }
            self.logisticStatus =self.detailModel.logisticStatus.integerValue;
            self.refundReason = self.detailModel.refundReason;
            self.refuseReason = self.detailModel.refuseReason;
            
            self.returnReason = self.detailModel.returnReason;
           

        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
#pragma mark--getOrderDetailUrl
-(void)getOrderDetailUrl{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_model.orderNo forKey:@"orderNo"];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
//    [params setValue:lat forKey:@"latitude"];
//    [params setValue:lng forKey:@"longitude"];
    if(lat.length > 0 && lng.length > 0){
        [params setValue:lat forKey:@"latitude"];
        [params setValue:lng forKey:@"longitude"];
    }
    WS(weakself);
    [XJHttpTool post:L_orderDetailUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        if ([code intValue] ==  200) {
            self.vaModel = [LLGoodModel mj_objectWithKeyValues:responseObj[@"data"]];

        }
        self.totalPrice = 0.0;
        for(LLGoodModel *model in  self.vaModel.appOrderListGoodsVos){
            self.totalPrice += model.goodsNum.integerValue*model.salesPrice.floatValue;
            self.goodsNum += model.goodsNum.integerValue;

        }
        [self.tableView reloadData];
     
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}
-(void)getsonReaData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"AppOrderAfterReasonArr") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        NSString *content = data[@"content"];
        [self.dataReasonArr addObjectsFromArray:[content componentsSeparatedByString:@","]];
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}
-(void)getExpessData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];

    WS(weakself);
    [XJHttpTool post:L_apiapporderafterExpress method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [self.dataExArr removeAllObjects];
        [self.dataExArr addObjectsFromArray:[LLGoodModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]]];

    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark 仅退款
-(void)postMonData{
    if(self.logisticStatus <=0){
        [MBProgressHUD showError:@"请选择货物状态" toView:self.view];
        return;
    }
  
    if(self.isUpload){
        if(self.imageArr.count > 0){
            [self getlListImage:self.imageArr indexs:0 tags:1];
        }else{
            [self postMonDataAll:@""];
        }
    }else{
        [self postMonDataAll:[self.imageArr componentsJoinedByString:@","]];
    }
}
-(void)postMonDataAll:(NSString*)imageStr{
    if(self.logisticStatus <=0){
        [MBProgressHUD showError:@"请选择货物状态" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *des;
    [param setValue:@"1" forKey:@"afterType"];//售后类型(1退款，2退款退货，3库存补发
    LLReturnApplyComTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    des = cell.detailsLabel.text;
    [param setValue:@(self.logisticStatus)forKey:@"logisticStatus"];//售后类型(1退款，2退款退货，3库存补发
    if(des.length > 0){
        [param setValue:des forKey:@"returnReason"];
    }
    [param setValue:_model.orderNo forKey:@"orderNo"];
    [param setValue:_refundReason forKey:@"refundReason"];
    [param setValue:@(_totalPrice) forKey:@"refundPrice"];

    
    if(imageStr.length > 0){
        [param setValue:imageStr forKey:@"returnVoucher"];
    }
    [XJHttpTool post:FORMAT(@"%@",L_apiapporderafterapply) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        if(self.tapAction){
            self.tapAction();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
     
    }];
}
#pragma mark 仅库存补发
-(void)postStockData{
    LLReturnApplyOnmonyComCell *cells =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];

    if(cells.detailsLabel.text.integerValue > self.goodsNum ){
        [MBProgressHUD showError:@"补发数量不足" toView:self.view];
        return;
    }
    if(self.logisticStatus <=0){
        [MBProgressHUD showError:@"请选择货物状态" toView:self.view];
        return;
    }
    if(self.isUpload){
        if(self.imageArr.count > 0){
            [self getlListImage:self.imageArr indexs:0 tags:3];
        }else{
            [self postStockDataAll:@""];
        }
    }else{
        [self postStockDataAll:[self.imageArr componentsJoinedByString:@","]];
    }
 
 
}
-(void)postStockDataAll:(NSString*)imageStr{
    LLReturnApplyOnmonyComCell *cells =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *des;
    [param setValue:@"3" forKey:@"afterType"];//售后类型(1退款，2退款退货，3库存补发
    LLReturnApplyComTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    des = cell.detailsLabel.text;
    [param setValue:@(self.logisticStatus)forKey:@"logisticStatus"];//售后类型(1退款，2退款退货，3库存补发
    if(des.length > 0){
        [param setValue:des forKey:@"returnReason"];
    }
    [param setValue:_model.orderNo forKey:@"orderNo"];
    [param setValue:_refundReason forKey:@"refundReason"];
    [param setValue:cells.detailsLabel.text forKey:@"patchNum"];

    
    if(imageStr.length > 0){
        [param setValue:imageStr forKey:@"returnVoucher"];
    }
    [XJHttpTool post:FORMAT(@"%@",L_apiapporderafterapply) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        if(self.tapAction){
            self.tapAction();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
     
    }];
}
#pragma mark 退款退货
-(void)postTuikaunData{
    if(self.logisticStatus <=0){
        [MBProgressHUD showError:@"请选择货物状态" toView:self.view];
        return;
    }
    if(self.refundReason.length <=0){
        [MBProgressHUD showError:@"请选择售后原因" toView:self.view];
        return;
    }
    if(self.isUpload){
        if(self.imageArrsss.count > 0){
            [self getlListImage:self.imageArrsss indexs:0 tags:2];
        }else{
            [self postTuikaunDataAll:@""];
        }
    }else{
        [self postTuikaunDataAll:[self.imageArrsss componentsJoinedByString:@","]];
    }
   
 
}
-(void)postTuikaunDataAll:(NSString *)imagesStr{
    LLReturnApplyOnmonyComCell *cells =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *des;
    [param setValue:@"2" forKey:@"afterType"];//售后类型(1退款，2退款退货，3库存补发
    LLReturnApplyComTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    des = cell.detailsLabel.text;
    [param setValue:@(self.logisticStatus)forKey:@"logisticStatus"];//售后类型(1退款，2退款退货，3库存补发
    if(des.length > 0){
        [param setValue:des forKey:@"returnReason"];
    }
    [param setValue:@(_totalPrice) forKey:@"refundPrice"];

    [param setValue:_model.orderNo forKey:@"orderNo"];
    [param setValue:_refundReason forKey:@"refundReason"];
    if(imagesStr.length > 0){
        [param setValue:imagesStr forKey:@"returnVoucher"];
    }
    if(self.detailModel){
        [param setValue:self.detailModel.orderNo forKey:@"orderNo"];
    }
    [XJHttpTool post:FORMAT(@"%@",L_apiapporderafterapply) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        if(self.tapAction){
            self.tapAction();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
     
    }];
}
-(void)getlListImage:(NSArray *)aMessages indexs:( NSInteger)index tags:(NSInteger)tags{
    NSLog(@"index= %ld",index);
    __block NSInteger indexs = index;
    WS(weakself);
    if(aMessages.count > index){
        [XJHttpTool uploadWithImageArr:aMessages[index] url:FORMAT(@"%@%@",apiQiUrl,L_apifileUploaderimages) filename:@"" name:@"" mimeType:@"" parameters:@{} progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
                
            } success:^(id  _Nonnull response) {
                NSDictionary *dic = response[@"data"];
                NSMutableArray *temp = [NSMutableArray array];
                [temp addObject:dic[@"name"]];
                [weakself.imageeList addObject:dic[@"name"]];
                indexs++;
                [weakself getlListImage:aMessages indexs:indexs tags:tags];
            } fail:^(NSError * _Nonnull error) {
                
            }] ;
    }else{
        if(tags == 2){
            [self postTuikaunDataAll:[self.imageeList componentsJoinedByString:@","]];
        }else if(tags == 3){
            [self postStockDataAll:[self.imageeList componentsJoinedByString:@","]];
        }else if(tags == 1){
            [self postMonDataAll:[self.imageeList componentsJoinedByString:@","]];
        }else if(tags == 4){
            [self postDataExAll:[self.imageeList componentsJoinedByString:@","]];
        }
   
    }
}
#pragma mark 补交快递信息
-(void)postDataEx{
    if(!self.expressModel){
        [MBProgressHUD showError:@"请选择快递公司" toView:self.view];
        return;
    }
    LLReturnApplyComTextCell *cells = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:5]];
    NSString  *danhao = cells.detailsLabel.text;
    if(danhao.length <=0){
        [MBProgressHUD showError:@"请输入快递单号" toView:self.view];
        return;
    }
    if(self.isUpload){
        if(self.imageArr.count > 0){
            [self getlListImage:self.imageArr indexs:0 tags:4];
        }else{
            [self postDataExAll:@""];
        }
    }else{
        [self postDataExAll:[self.imageArr componentsJoinedByString:@","]];
    }

}
-(void)postDataExAll:(NSString *)imageStr{
    LLReturnApplyComTextCell *cells = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:5]];
    NSString  *danhao = cells.detailsLabel.text;
    if(danhao.length <=0){
        [MBProgressHUD showError:@"请输入快递单号" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(self.logisticStatus)forKey:@"expressNum"];//售后类型(1退款，2退款退货，3库存补发
    if(imageStr.length > 0){//还没有对接
        [param setValue:imageStr forKey:@"expressVoucher"];
    }
    [param setValue:danhao forKey:@"expressNum"];
    [param setValue:self.expressModel.ID forKey:@"expressId"];//
    [param setValue:_model.orderNo forKey:@"orderNo"];
    
    [XJHttpTool post:FORMAT(@"%@",L_apiapporderaftereditExpress) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        if(self.tapAction){
            self.tapAction();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
     
    }];

}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    
    if(_orderNo.length > 0 && _tagIndex != OrderRefundExpressState ){
        if(self.detailModel.orderAfterStatus.integerValue == 4 || (self.detailModel.expressNum > 0 && self.detailModel.orderAfterStatus.integerValue == 4)){//售后失败
            
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(CGFloatBasedI375(0));
                make.top.offset(SCREEN_top);
                make.bottom.equalTo(weakself.boView.mas_top).equalTo(-CGFloatBasedI375(10));
            }];
            [self.boView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.offset(CGFloatBasedI375(0));
                make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(50)));
            }];
            [self.sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(CGFloatBasedI375(15));
                make.right.offset(-CGFloatBasedI375(15));
                make.top.offset(CGFloatBasedI375(6));
                make.height.offset(CGFloatBasedI375(37));
            }];
        }else{
            
            if(self.detailModel.orderAfterStatus.integerValue == 1){//审核中
                self.bottomView.hidden = NO;
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset(CGFloatBasedI375(0));
                    make.top.offset(SCREEN_top);
                    make.bottom.equalTo(weakself.bottomView.mas_top).offset(0);
                }];
                [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.offset(CGFloatBasedI375(0));
                    make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(50) ));
                }];
                
            }else{
                self.bottomView.hidden = YES;
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.offset(CGFloatBasedI375(0));
                    make.top.offset(SCREEN_top);
                }];
            }
            
        }
    }else{
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(CGFloatBasedI375(0));
            make.top.offset(SCREEN_top);
            make.bottom.equalTo(weakself.boView.mas_top).equalTo(-CGFloatBasedI375(10));
        }];
        [self.boView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(CGFloatBasedI375(0));
            make.height.offset(DeviceXTabbarHeigh(CGFloatBasedI375(50)));
        }];
        [self.sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(CGFloatBasedI375(15));
            make.right.offset(-CGFloatBasedI375(15));
            make.top.offset(CGFloatBasedI375(6));
            make.height.offset(CGFloatBasedI375(37));
        }];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_tagIndex == OrderRefundOnlyMonState){
        if(section == 0){
            return  _model.appOrderListGoodsVos.count;
        }else if(section == 2){
            return 3;
        }else if(section == 3){
            if(self.detailModel.orderAfterStatus.integerValue != 4){
            if(self.detailModel){
                if(self.detailModel.returnVoucher.length <= 0){
                    return 1;
                }
            }
            }
            return 2;
        }
        return 1;
    }else if (_tagIndex == OrderRefundStockState){
        if(section == 0){
            return  _model.appOrderListGoodsVos.count;
        }else if(section == 2){
            return 3;
        }else if(section == 3){
            if(self.detailModel.orderAfterStatus.integerValue != 4){
                if(self.detailModel){
                    if(self.detailModel.returnVoucher.length <= 0){
                        return 1;
                    }
                }
            }
            return 2;
        }
        return 1;
    }else if (_tagIndex == OrderRefundBothMonState){
        if(section == 0){
            return  _model.appOrderListGoodsVos.count;
        }else if(section == 2 || section == 4){
            return 3;
        }else if(section == 3){
            if(self.detailModel.orderAfterStatus.integerValue != 4){
            if(self.detailModel){
                if(self.detailModel.returnVoucher.length <= 0){
                    return 1;
                }
            }
            }
            return 2;
        }
        return 1;
    }else if (_tagIndex == OrderRefundExpressState){
        if(section == 0){
            return  _model.appOrderListGoodsVos.count;
        }else if(section == 2 || section == 4){
            return 3;
        }else if(section == 3){
            if(self.detailModel){
                if(self.detailModel.returnVoucher.length <= 0){
                    return 1;
                }
            }
            return 2;
        }else if(section == 5){
            if(self.detailModel.orderAfterStatus.integerValue == 4 || self.detailModel.orderAfterStatus.integerValue == 2|| self.detailModel.orderAfterStatus.integerValue == 5|| self.detailModel.orderAfterStatus.integerValue == 3){
                return 3;
            }
            if(self.detailModel){
                if(self.detailModel.expressVoucher.length <= 0){
                    return 2;
                }
                
            }
    
        }
        return 1;
    }
    if(section == 0){
        return  _model.appOrderListGoodsVos.count;
    }else if(section == 2){
        return 2;
    }else if(section == 3){
     
        return 2;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_tagIndex == OrderRefundOnlyMonState){
        return 4;
    }else if (_tagIndex == OrderRefundStockState){
        return 4;
    }else if (_tagIndex == OrderRefundBothMonState){
        return 4;
    }else if (_tagIndex == OrderRefundExpressState){
        return 6;
    }else{
        return 5;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_tagIndex == OrderRefundOnlyMonState){
        if(indexPath.section == 0){
            return CGFloatBasedI375(105);
        }else if(indexPath.section == 2){
            if(indexPath.row == 0){
                return CGFloatBasedI375(64);
            }
            return CGFloatBasedI375(44);
        }else if(indexPath.section == 3){
            if(indexPath.row == 0){
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(110);
        }
        return CGFloatBasedI375(44);
    }else if(_tagIndex == OrderRefundStockState){
        if(indexPath.section == 0){
            return CGFloatBasedI375(105);
        }else if(indexPath.section == 2){
            if(indexPath.row == 0){
                return CGFloatBasedI375(64);
            }
            return CGFloatBasedI375(44);
        }else if(indexPath.section == 3){
            if(indexPath.row == 0){
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(110);
        }
        return CGFloatBasedI375(44);
    }else if (_tagIndex == OrderRefundBothMonState){
        if(indexPath.section == 0){
            return CGFloatBasedI375(105);
        }else if(indexPath.section == 2){
            if(indexPath.row == 0){
                return CGFloatBasedI375(64);
            }
            return CGFloatBasedI375(44);
        }else if(indexPath.section == 3){
            if(indexPath.row == 0){
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(110);
        }else if(indexPath.section == 4){
            return CGFloatBasedI375(44);
        }
        return CGFloatBasedI375(44);
    }else if (_tagIndex == OrderRefundExpressState){
        if(indexPath.section == 0){
            return CGFloatBasedI375(105);
        }else if(indexPath.section == 2){
            if(indexPath.row == 0){
                return CGFloatBasedI375(64);
            }
            return CGFloatBasedI375(44);
        }else if(indexPath.section == 3){
            if(indexPath.row == 0){
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(110);
        }else if(indexPath.section == 4){
            return CGFloatBasedI375(44);

        }else if(indexPath.section == 5){
            if(indexPath.row == 2){
                return CGFloatBasedI375(110);
            }
            return CGFloatBasedI375(44);

        }
        return CGFloatBasedI375(44);
        
    }else{
        if(indexPath.section == 0){
            return CGFloatBasedI375(105);
        }else if(indexPath.section == 2){
            if(indexPath.row == 0){
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(44);
        }else if(indexPath.section == 3){
            if(indexPath.row == 0){
                return CGFloatBasedI375(44);
            }
            return CGFloatBasedI375(110);
        }
        return CGFloatBasedI375(44);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if(_tagIndex == OrderRefundOnlyMonState){
//        if(section == 5){
//            return CGFloatBasedI375(200);
//        }
//    }else if(_tagIndex == OrderRefundStockState){
//        if(section ==3){
//            return CGFloatBasedI375(200);
//        }
//    }else{
//        if(section ==5){
//            return CGFloatBasedI375(200);
//        }
//    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_tagIndex == OrderRefundBothMonState ||_tagIndex == OrderRefundExpressState){
        if(section == 0 || section == 4 || section == 5){
            return CGFloatBasedI375(44);
        }
        return CGFloatBasedI375(10);
    }
    if(section != 0){
        return 10;
    }
    return CGFloatBasedI375(44);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    if(_tagIndex == OrderRefundBothMonState ||_tagIndex == OrderRefundExpressState){
        if(section == 0 || section == 4 || section == 5){
            UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(44))];
            UILabel*nameLabel1 = [[UILabel alloc]init];
            nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
            nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
            nameLabel1.textAlignment = NSTextAlignmentLeft;
            nameLabel1.userInteractionEnabled = YES;
            if(section == 0){
            nameLabel1.text = @"售后商品";
                header.backgroundColor = White_Color;
            }else if (section == 4){
                nameLabel1.text = @"商家已同意退货，请尽快退货";
                    header.backgroundColor = [UIColor clearColor];
            }else if (section == 5){
                nameLabel1.text = @"请填写物流信息";
                    header.backgroundColor = [UIColor clearColor];
            }
            [header addSubview:nameLabel1];
            [nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset(CGFloatBasedI375(44));
                make.right.offset(-CGFloatBasedI375(37));
                make.left.offset(CGFloatBasedI375(15));
                make.top.offset(CGFloatBasedI375(0));
            }];
         
            return header;
        }
        return nil;;
    }else{
        if(section != 0){
            return nil;;
        }
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(44))];
        UILabel*nameLabel1 = [[UILabel alloc]init];
        nameLabel1.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        nameLabel1.textColor =[UIColor colorWithHexString:@"#333333"];
        nameLabel1.textAlignment = NSTextAlignmentLeft;
        nameLabel1.userInteractionEnabled = YES;
        nameLabel1.text = @"售后商品";
        [header addSubview:nameLabel1];
        [nameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(CGFloatBasedI375(44));
            make.right.offset(-CGFloatBasedI375(37));
            make.left.offset(CGFloatBasedI375(15));
            make.top.offset(CGFloatBasedI375(0));
        }];
        header.backgroundColor = White_Color;
        return header;
    }
 
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(_tagIndex == OrderRefundOnlyMonState){
        if(section != 5){
            return nil;;
        }
    }else if(_tagIndex == OrderRefundStockState){
        if(section !=3){
            return nil;;        }
    }else{
        if(section != 5){
            return nil;;
        }
    }
    return nil;;
}
-(void)clickAddress{
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    if(_tagIndex == OrderRefundOnlyMonState){
        return  [self deallWith:tableView index:indexPath];
    }else if(_tagIndex == OrderRefundStockState){
        return  [self deallStockWith:tableView index:indexPath];
    }else if(_tagIndex == OrderRefundBothMonState){
        return  [self deallBothMonwiWith:tableView index:indexPath];
    }else if(_tagIndex == OrderRefundExpressState){
        return  [self deallHuowiWith:tableView index:indexPath];
    }else{
        
        return  [self deallComwiWith:tableView index:indexPath];
    }
}
#pragma mark 默认cell
-(UITableViewCell *)deallComwiWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    WS(weakself);
    if(indexPath.section == 0){
    LLReturnServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnServiceCellid];
        cell.model = _model.appOrderListGoodsVos[indexPath.row];
    return cell;
    }else if(indexPath.section == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        if(self.reason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.reason;
        }
        return cell;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
            cell.nameLabel1.text = @"货物状态";
            cell.detailsLabel.text= @"请选择";
            if(self.logisticStatusStr.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.logisticStatusStr;
            }
            return cell;
        }
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"选择原因";
        cell.detailsLabel.text= @"请选择";
        if(self.refundReason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.refundReason;
        }
        return cell;
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
                LLReturnApplyComTextCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComTextCellid];
                cell.nameLabel1.text = @"申请说明";
                cell.detailsLabel.placeholder = @"选填";
            if(self.returnReason.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.returnReason;
            }
            if(_detailModel){
                cell.detailsLabel.enabled = NO;
            }
                return cell;
        }
        LLReturnApplyComPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComPicCellid];
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.imageArr = image;
            };
        return cell;
    }else{
        XYOrderQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYQuestionCell" forIndexPath:indexPath];
        cell.questionLabel.text = @"售后遇到问题？";
        return  cell;
    }
   
}
#pragma mark 仅退款cell
-(UITableViewCell *)deallWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    WS(weakself);
    if(indexPath.section == 0){
    LLReturnServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnServiceCellid];
        cell.model = _model.appOrderListGoodsVos[indexPath.row];
    return cell;
    }else if(indexPath.section == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        if(self.reason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.reason;
        }
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            cell.accessoryView = nil;
        }
        return cell;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            LLReturnApplyOnmonyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyOnmonyComCellid];
            cell.nameLabel1.text = @"退款金额  ";
            NSLog(@"_vaModel.refundPrice == %.2f",_totalPrice);
               cell.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"￥%.2f",_totalPrice),@""] fonts:@[[UIFont systemFontOfSize:12],[UIFont boldFontWithFontSize:15]] colors:@[Main_Color,Main_Color]];
            cell.noticeLabel.text= FORMAT(@"可修改，最多￥%.2f，含发货邮费￥%@",_totalPrice,_vaModel.freight.length <=0?@"0.00":_vaModel.freight);
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.detailsLabel.enabled = NO;
            }
            return cell;
        } else if(indexPath.row == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"货物状态";
        cell.detailsLabel.text= @"请选择";
        if(self.logisticStatusStr.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.logisticStatusStr;
        }
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.accessoryView = nil;
            }
        return cell;
        }
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"选择原因";
        cell.detailsLabel.text= @"请选择";
        if(self.refundReason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.refundReason;
        }
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            cell.accessoryView = nil;
        }
        return cell;
    }else{
        if(indexPath.row == 0){
                LLReturnApplyComTextCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComTextCellid];
                cell.nameLabel1.text = @"申请说明";
                cell.detailsLabel.placeholder = @"选填";
            cell.detailsLabel.enabled = YES;
            if(self.returnReason.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.returnReason;
            }
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.detailsLabel.enabled = NO;
                if(self.returnReason.length <= 0){
                    cell.detailsLabel.text = @"无";
                }
            }
                return cell;
        }
        LLReturnApplyComPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComPicCellid];
        if( self.detailModel.orderAfterStatus.integerValue == 4){
            cell.picView.isEdits = YES;
        }
        if(self.detailModel){
            cell.picView.datas =    self.imageArr.mutableCopy;
        }
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.isUpload = YES;
                weakself.imageArr = image;
            };
        return cell;
    }
   
}
#pragma mark 退货退款cell
-(UITableViewCell *)deallBothMonwiWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    WS(weakself);
    if(indexPath.section == 0){
    LLReturnServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnServiceCellid];
        cell.model = _model.appOrderListGoodsVos[indexPath.row];
    return cell;
    }else if(indexPath.section == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        if(self.reason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.reason;
        }
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            cell.accessoryView = nil;
        }
        return cell;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            LLReturnApplyOnmonyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyOnmonyComCellid];
            cell.nameLabel1.text = @"退款金额  ";
            NSLog(@"_vaModel.refundPrice == %.2f",_totalPrice);
               cell.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"￥%.2f",_totalPrice),@""] fonts:@[[UIFont systemFontOfSize:12],[UIFont boldFontWithFontSize:15]] colors:@[Main_Color,Main_Color]];
            cell.noticeLabel.text= FORMAT(@"可修改，最多￥%.2f，含发货邮费￥%@",_totalPrice,_vaModel.freight.length <=0?@"0.00":_vaModel.freight);
            if(self.detailModel){
                cell.detailsLabel.enabled = NO;
            }
            return cell;
        } else if(indexPath.row == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"货物状态";
        cell.detailsLabel.text= @"请选择";
            if(self.logisticStatusStr.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.logisticStatusStr;
            }
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.accessoryView = nil;
            }
        return cell;
        }
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"选择原因";
        cell.detailsLabel.text= @"请选择";
        if(self.refundReason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.refundReason;
        }
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            cell.accessoryView = nil;
        }
        return cell;
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
                LLReturnApplyComTextCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComTextCellid];
                cell.nameLabel1.text = @"申请说明";
                cell.detailsLabel.placeholder = @"选填";
            if(self.returnReason.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.returnReason;
            }
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.detailsLabel.enabled = NO;
                if(self.returnReason.length <= 0){
                    cell.detailsLabel.text =@"无";
                    }
            }
                return cell;
        }
        
        LLReturnApplyComPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComPicCellid];
        if( self.detailModel.orderAfterStatus.integerValue == 4){
            cell.picView.isEdits = YES;
        }
        if(self.detailModel){
           cell.picView.datas = self.imageArrsss.mutableCopy;
        }
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.isUpload = YES;
                weakself.imageArrsss = image;
            };
        return cell;
    }else{
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"货物状态";
        cell.detailsLabel.text= @"";
        cell.accessoryType = UITableViewCellAccessoryNone;
        if(indexPath.row == 0){
            cell.nameLabel1.text = @"收货人姓名";
            cell.detailsLabel.text=self.vaModel.appAddressInfoVo.receiveName;
        }else if(indexPath.row == 1){
            cell.nameLabel1.text = @"收货人手机号";
            cell.detailsLabel.text=self.vaModel.appAddressInfoVo.receivePhone;
        }else{
            cell.nameLabel1.text = @"退货地址";
            cell.detailsLabel.text=FORMAT(@"%@%@",self.vaModel.appAddressInfoVo.locations,self.vaModel.appAddressInfoVo.address);

        }
        return cell;
    }
   
}
#pragma mark 退货退款cell 提交物流
-(UITableViewCell *)deallHuowiWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    WS(weakself);
    if(indexPath.section == 0){
    LLReturnServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnServiceCellid];
        cell.model = _model.appOrderListGoodsVos[indexPath.row];
    return cell;
    }else if(indexPath.section == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        if(self.reason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.reason;
        }
        if(self.detailModel){
            cell.accessoryView = nil;
        }
        return cell;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            LLReturnApplyOnmonyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyOnmonyComCellid];
            cell.nameLabel1.text = @"退款金额  ";
            NSLog(@"_vaModel.refundPrice == %.2f",_totalPrice);
               cell.detailsLabel.attributedText = [self getAttribuStrWithStrings:@[FORMAT(@"￥%.2f",_totalPrice),@""] fonts:@[[UIFont systemFontOfSize:12],[UIFont boldFontWithFontSize:15]] colors:@[Main_Color,Main_Color]];
            cell.noticeLabel.text= FORMAT(@"可修改，最多￥%.2f，含发货邮费￥%@",_totalPrice,_vaModel.freight.length <=0?@"0.00":_vaModel.freight);
            if(self.detailModel){
                cell.detailsLabel.enabled  =NO;
            }
            return cell;
        } else if(indexPath.row == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"货物状态";
        cell.detailsLabel.text= @"请选择";
            if(self.logisticStatusStr.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.logisticStatusStr;
            }
            if(self.detailModel){
                cell.accessoryView = nil;
            }
        return cell;
        }
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"选择原因";
        cell.detailsLabel.text= @"请选择";
        if(self.refundReason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.refundReason;
        }
        if(self.detailModel){
            cell.accessoryView = nil;
        }
        return cell;
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
                LLReturnApplyComTextCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComTextCellid];
                cell.nameLabel1.text = @"申请说明";
                cell.detailsLabel.placeholder = @"选填";
            if(self.returnReason.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.returnReason;
            }
            if(self.detailModel){
                cell.detailsLabel.enabled = NO;
                if( self.returnReason.length <= 0){
                    cell.detailsLabel.text = @"无";
                }
            }
                return cell;
        }
     
        LLReturnApplyComPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComPicCellid];
        if(self.detailModel){
           cell.picView.datas = self.imageArrsss.mutableCopy;
        }
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.imageArrsss = image;
            };
        return cell;
    }else if(indexPath.section == 4){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"货物状态";
        cell.detailsLabel.text= @"";
        cell.accessoryView = nil;
        if(indexPath.row == 0){
            cell.nameLabel1.text = @"收货人姓名";
            cell.detailsLabel.text=self.detailModel.businessReceiverName;
        }else if(indexPath.row == 1){
            cell.nameLabel1.text = @"收货人手机号";
            cell.detailsLabel.text=self.detailModel.businessReceiverPhone;
        }else{
            cell.nameLabel1.text = @"退货地址";
            cell.detailsLabel.text=FORMAT(@"%@",self.detailModel.businessReceiverAddress);
       

        }
        return cell;
    }else{
        if(indexPath.row == 0){
            LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
            cell.nameLabel1.text = @"物流公司";
            cell.detailsLabel.text=self.expressModel.title;
            if(self.detailModel.expressNum.length > 0 && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.accessoryView = nil;
            }else{
                cell.detailsLabel.text = @"请选择物流公司";
                cell.detailsLabel.textColor= lightGray9999_Color;
                UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 20, 6, 11)];;
                imageView.image = [UIImage imageNamed:@"allowimag"];
                cell.accessoryView = imageView;
                if(self.expressModel.title.length > 0){
                    cell.detailsLabel.text=self.expressModel.title;
                    cell.detailsLabel.textColor= Black_Color;
                }
                
            }
            return cell;
        }else if(indexPath.row == 1){
            LLReturnApplyComTextCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComTextCellid];
            cell.nameLabel1.text = @"运单号码";
            cell.detailsLabel.placeholder = @"请输入运单号";
            if(self.detailModel){
                cell.detailsLabel.text = self.detailModel.expressNum;
            }
            cell.accessoryView = nil;
            if(self.detailModel.expressNum.length > 0 && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.detailsLabel.enabled = NO;
            }
            return cell;
        }
        LLReturnApplyComPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComPicCellid];
        //售后状态(1待审核，2用户待发货 3已通过，4已拒绝 5平台待收货)
        if(self.detailModel.orderAfterStatus.integerValue == 2 || self.detailModel.orderAfterStatus.integerValue == 4){
            cell.picView.isEdits = YES;
        }
        if(self.detailModel){
           cell.picView.datas = self.imageArr.mutableCopy;
        }
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.isUpload = YES;
                weakself.imageArr = image;
            };
        return cell;
    }
   
}
#pragma mark 库存补发cell
-(UITableViewCell *)deallStockWith:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    WS(weakself);
    if(indexPath.section == 0){
    LLReturnServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnServiceCellid];
        cell.model = _model.appOrderListGoodsVos[indexPath.row];
    return cell;
    }else if(indexPath.section == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        if(self.reason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.reason;
        }
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){

            cell.accessoryView = nil;
        }
        return cell;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            LLReturnApplyOnmonyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyOnmonyComCellid];
            cell.nameLabel1.text = @"补发数量";
            cell.detailsLabel.text= self.goodsNum <=0?@"0": FORMAT(@"%ld",self.goodsNum);
            cell.noticeLabel.text= FORMAT(@"可修改,最多%ld件",self.goodsNum <=0?0: self.goodsNum) ;
            cell.detailsLabel.enabled = YES;
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.detailsLabel.enabled = NO;
            }
            return cell;
        } else if(indexPath.row == 1){
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"货物状态";
        cell.detailsLabel.text= @"请选择";
            if(self.logisticStatusStr.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.logisticStatusStr;
            }
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.accessoryView = nil;
            }
        return cell;
        }
        LLReturnApplyComCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComCellid];
        cell.nameLabel1.text = @"选择原因";
        cell.detailsLabel.text= @"请选择";
        if(self.refundReason.length > 0){
            cell.detailsLabel.textColor = Black_Color;
            cell.detailsLabel.text = self.refundReason;
        }
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            cell.accessoryView = nil;
        }
        return cell;
    }else{
        if(indexPath.row == 0){
                LLReturnApplyComTextCell *cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComTextCellid];
                cell.nameLabel1.text = @"申请说明";
                cell.detailsLabel.placeholder = @"选填";
            cell.detailsLabel.enabled = YES;
            if(self.returnReason.length > 0){
                cell.detailsLabel.textColor = Black_Color;
                cell.detailsLabel.text = self.returnReason;
            }
            if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
                cell.detailsLabel.enabled = NO;
                if(self.returnReason.length <= 0){
                    cell.detailsLabel.text = @"无";
                }
            }
                return cell;
        }
        LLReturnApplyComPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLReturnApplyComPicCellid];
        if( self.detailModel.orderAfterStatus.integerValue == 4){
            cell.picView.isEdits = YES;
        }
        if(self.detailModel){
            cell.picView.datas = self.imageArr.mutableCopy;
        }
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.isUpload= YES;
                weakself.imageArr = image;
            };
        return cell;
    }
   
}

-(void)clickshowView:(NSInteger)status{
    if(self.showView){
        self.showView = nil;
    }
    [self showView];
    self.showView.titles = @"售后类型";
    if(self.ShowKucu == YES){//库存
        self.showView.datas = @[@"库存补发"];
    }else{
        self.showView.datas = @[@"退款",@"退款退货",@"库存补发"];
    }
    if(status == 1){
        self.showView.titles = @"货物状态";
        self.showView.datas = @[@"已收到货",@"未收到货"];
    }else if(status == 2){
        self.showView.titles = @"选择原因";
        self.showView.datas = self.dataReasonArr.mutableCopy;
    }else if(status == 3){
        self.showView.titles = @"物流公司";
        self.showView.datas = self.dataExArr.mutableCopy;
    }

    self.showView.indexs = self.indextag;

    [self.showView showActionSheetView];
    WS(weakself);
    self.showView.getDatasBlocks = ^(LLGoodModel * _Nonnull model, NSInteger tagindex, NSInteger indexs) {
        weakself.expressModel = model;
        [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:5]] withRowAnimation:UITableViewRowAnimationAutomatic];

    };
    self.showView.getDatasBlock = ^(NSString * _Nonnull datas, NSInteger tagindex, NSInteger indexs) {
     
        if(status  == 1){
            NSArray *tilts =  @[@"2",@"1"];
            weakself.logisticStatus = [FORMAT(@"%@",tilts[tagindex])integerValue];
            weakself.logisticStatusStr = datas;
        }else if(status  == 2){
            weakself.refundReason = datas;;
        }else if(status  == 3){
            weakself.indextag = indexs;
        }else{
            weakself.reason = datas;
            if(weakself.ShowKucu == YES){//库存
                weakself.tagIndex = OrderRefundStockState;
            }else{
                if(tagindex == 0){
                    weakself.tagIndex = OrderRefundOnlyMonState;
                }else if(tagindex == 1){
                    weakself.tagIndex = OrderRefundBothMonState;
                }else{
                    weakself.tagIndex = OrderRefundStockState;
                }
            }
        }
        [weakself.tableView reloadData];

    };
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if(_tagIndex == OrderRefundOnlyMonState){
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            return;;
        }
        if(indexPath.section == 2 &&indexPath.row == 1  ){//货物状态
            [self clickshowView:1];
        }else if(indexPath.section == 1){
            [self clickshowView:0];
        }else if(indexPath.section == 2 &&indexPath.row == 2  ){//选择原因
            [self clickshowView:2];
        }
    }else if(_tagIndex == OrderRefundStockState){
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            return;;
        }
        if(indexPath.section == 2 &&indexPath.row == 1  ){//货物状态
            [self clickshowView:1];
        }else if(indexPath.section == 1){
            [self clickshowView:0];
        }else if(indexPath.section == 2 &&indexPath.row == 2  ){//选择原因
            [self clickshowView:2];
        }
    }else if(_tagIndex == OrderRefundExpressState){
     
        if(indexPath.section == 2 &&indexPath.row == 1  ){//货物状态
            if(self.detailModel){
                return;;
            }
            [self clickshowView:1];
        }else if(indexPath.section == 1){
            if(self.detailModel){
                return;;
            }
            [self clickshowView:0];
        }else if(indexPath.section == 2 &&indexPath.row == 2  ){//选择原因
            if(self.detailModel){
                return;;
            }
            [self clickshowView:2];
        }else if(indexPath.section == 5 &&indexPath.row == 0  ){//选择快递公司
            if(self.detailModel.expressNum.length > 0 && self.detailModel.orderAfterStatus.integerValue != 4){
                return;;
            }
            [self clickshowView:3];
        }
    }else if(_tagIndex == OrderRefundBothMonState){
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            return;;
        }
        if(indexPath.section == 2 &&indexPath.row == 1  ){//货物状态
            [self clickshowView:1];
        }else if(indexPath.section == 1){
            [self clickshowView:0];
        }else if(indexPath.section == 2 &&indexPath.row == 2  ){//选择原因
            [self clickshowView:2];
        }
    }  else{
        if(self.detailModel && self.detailModel.orderAfterStatus.integerValue != 4){
            return;;
        }
        if(indexPath.section == 2 &&indexPath.row == 0  ){//货物状态
            [self clickshowView:1];
        }else if(indexPath.section == 1){
            [self clickshowView:0];
        }else if(indexPath.section == 2 &&indexPath.row == 1  ){//选择原因
            [self clickshowView:2];
        }else if(indexPath.section == 5 &&indexPath.row == 0  ){//选择快递公司
            [self clickshowView:3];
        }
        if (indexPath.section == 4) {
            
            WS(weakself);
            XYServiceTipsViewController *serviceVC = [[XYServiceTipsViewController alloc]init];
            serviceVC.pushBlock = ^(UIViewController * view) {
                [weakself.navigationController pushViewController:view animated:YES];
            };
            serviceVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            serviceVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:serviceVC animated:YES completion:nil];
        }
    }
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor colorWithHexString:@"#f5f5f5"];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
        [ _tableView  registerClass:[LLReturnApplyComCell class] forCellReuseIdentifier:LLReturnApplyComCellid];
        [ _tableView  registerClass:[LLReturnServiceCell class] forCellReuseIdentifier:LLReturnServiceCellid];
        [ _tableView  registerClass:[XYOrderQuestionTableViewCell class] forCellReuseIdentifier:@"XYQuestionCell"];
        [ _tableView  registerClass:[LLReturnApplyComMonCell class] forCellReuseIdentifier:LLReturnApplyComMonCellid];
        [ _tableView  registerClass:[LLReturnApplyComTextCell class] forCellReuseIdentifier:LLReturnApplyComTextCellid];
        [ _tableView  registerClass:[LLReturnApplyComPicCell class] forCellReuseIdentifier:LLReturnApplyComPicCellid];
        [ _tableView  registerClass:[LLReturnServiceComCell class] forCellReuseIdentifier:LLReturnServiceComCellid];
        [ _tableView  registerClass:[LLReturnApplyOnmonyComCell class] forCellReuseIdentifier:LLReturnApplyOnmonyComCellid];

        
    }
    return _tableView;
}
-(LLReturnShowView *)showView{
    if(!_showView){
        _showView = [[LLReturnShowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

        
    }
    return _showView;;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UIView *)boView{
    if(!_boView){
        _boView = [[UIView alloc]init];
        _boView.backgroundColor = White_Color;
        [self.view addSubview:_boView];
    }
    return _boView;;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.layer.cornerRadius = CGFloatBasedI375(37)/2;
        _sureButton.layer.masksToBounds = YES;
        [_sureButton setTitle:@"提交" forState:UIControlStateNormal];
        _sureButton.backgroundColor = Main_Color;
        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.boView addSubview:self.sureButton];
    }
    return _sureButton;
}
-(void)clickTap:(UIButton *)sender{
    
    if(_tagIndex == OrderRefundOnlyMonState){
        [self postMonData];
    }else if(_tagIndex == OrderRefundBothMonState){
        [self postTuikaunData];
    }else if(_tagIndex == OrderRefundExpressState){
        [self postDataEx];
    }else{
        [self postStockData];
    }
    
    
}
-(NSMutableArray *)dataExArr{
    if(!_dataExArr){
        _dataExArr = [NSMutableArray array];
    }
    return _dataExArr;
}
-(NSMutableArray *)dataReasonArr{
    if(!_dataReasonArr){
        _dataReasonArr = [NSMutableArray array];
    }
    return _dataReasonArr;
}
-(NSMutableArray *)imageeList{
    if(!_imageeList){
        _imageeList = [NSMutableArray array];
    }
    return _imageeList;
}
-(LLMeorderDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLMeorderDetailBottomView alloc]init];
        [_bottomView.payBtn setTitle:@"取消售后" forState:UIControlStateNormal];
        _bottomView.payBtn.hidden = NO;
        _bottomView.paytext.hidden = YES;
        _bottomView.hidden = YES;
        WS(weakself);
        _bottomView.ActionBlock = ^(NSString * _Nonnull tagName) {
            if ([tagName isEqual:@"取消售后"]) {
                [UIAlertController showAlertViewWithTitle:@"提示" Message:@"取消售后将不能再次提交" BtnTitles:@[@"取消",@"确认"] ClickBtn:^(NSInteger index) {
                    if(index == 1){
                        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
                        [params setValue:weakself.detailModel.orderNo forKey:@"orderNo"];
                        [XJHttpTool post: FORMAT(@"%@/%@",L_apiapporderaftercancel,weakself.detailModel.orderNo) method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
                            NSDictionary *data = responseObj[@"data"];
                            [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
                            if(weakself.tapAction){
                                weakself.tapAction();
                            }
                            [weakself getDetailData];
                            
                        } failure:^(NSError * _Nonnull error) {
                            
                        }];
                    }

                }];
            
            }
        };
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}
@end
