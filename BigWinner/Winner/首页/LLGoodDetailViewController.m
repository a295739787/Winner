//
//  LLGoodDetailViewController.m
//  Winner
//
//  Created by mac on 2022/2/9.
//

#import "LLGoodDetailViewController.h"
#import "LLGoodDetailCell.h"
#import "LLGoodDetailHeadView.h"
#import "XHWebImageAutoSize.h"
#import "LLPraiseAllCell.h"
#import "LLGoodBoView.h"
#import "ChoseGoodsTypeAlert.h"
#import "SizeAttributeModel.h"
#import "GoodsTypeModel.h"
#import "Header.h"
#import "LLStoreSureOrderViewController.h"
#import "LLShopCarViewController.h"
#import "LLSurpriseRegBagSureOrderViewController.h"
#import <WebKit/WebKit.h>
#import "LLPingjianSureOrderViewController.h"
#import "LLSurpriseRegBagViewController.h"
#import "LLGoodPraiseViewController.h"
#import "QMChatRoomViewController.h"
#import "PLLocationManage.h"
#import "Winner-Swift.h"

static NSString *const LLGoodPicCellid = @"LLGoodPicCell";
static NSString *const LLGoodDetailCellid = @"LLGoodDetailCell";
static NSString *const LLPraiseAllCellid = @"LLPraiseAllCell";
@interface LLGoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate, WKNavigationDelegate>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLGoodDetailHeadView *goodHeadView ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model ;/** <#class#> **/
@property (nonatomic,strong) LLGoodBoView *boView;/** <#class#> **/
@property (nonatomic,strong) GoodsModel *skuModel;/** <#class#> **/
@property (nonatomic, copy) NSString *goodsNum;
@property (nonatomic, copy) NSString *goodsSpecsPriceId;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic,strong) UILabel *redLabel;/** <#class#> **/
@property (nonatomic,strong) LLShareView *shareView;/** <#class#> **/
@property (nonatomic,assign) BOOL clickTap;/** class **/

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger stock;/** class **/
@property (nonatomic,strong)     ChoseGoodsTypeAlert  *alert;/** <#class#> **/

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic,strong) NSDictionary *dictionary;/** <#class#> **/
@property (nonatomic,assign) BOOL isConnecting;/** class **/
@property (nonatomic, assign) CGFloat webViewHeight;
@end

@implementation LLGoodDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)locations{
[[PLLocationManage shareInstance] requestLocationWithCompletionBlock:^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull regeocode, NSError * _Nonnull error) {
    NSLog(@"%@",regeocode);
    
    if (location == nil) {
        return ;
    }
    NSString *lat =[NSString stringWithFormat:@"%.5f",location.coordinate.latitude];
    NSString *lng =[NSString stringWithFormat:@"%.5f",location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults]setObject:lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setObject:lng forKey:@"lng"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",regeocode.city,regeocode.district] forKey:@"areaname"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",regeocode.province,regeocode.city] forKey:@"provincecity"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.city] forKey:@"city"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.province] forKey:@"province"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.district] forKey:@"district"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.street] forKey:@"street"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",regeocode.building] forKey:@"building"];

    [[NSUserDefaults standardUserDefaults]synchronize];
  
}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webViewHeight = 0.0;

    self.customNavBar.title = @"商品详情";
    [self createWebView];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"fx"]];
    WS(weakself);
    self.customNavBar.onClickRightButton = ^{
        [weakself shareOnClick];
    };
    [self setLayout];
    [self getDatas];

    self.clickTap=NO;
    [self locations];
    
    self.customNavBar.onClickLeftButton = ^{
        if(weakself.status == RoleStatusRedBag){
            UINavigationController *navC = weakself.navigationController;
                NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                for (UIViewController *vc in navC.viewControllers) {
                    [viewControllers addObject:vc];
                    if ([vc isKindOfClass:[LLSurpriseRegBagViewController class]]) {
                        break;
                    }
                }
                if (viewControllers.count == navC.viewControllers.count) {
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [navC setViewControllers:viewControllers animated:YES];
                }
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
}
- (void)dealloc
{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
-(void)getDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";//商品类型（1普通商品、2惊喜红包商品、3品鉴商品）
    if(_status == RoleStatusStore){
        type = @"1";
    }else if(_status == RoleStatusRedBag){
        type = @"2";
    }else if(_status == RoleStatusStockPeisong){
        type = @"4";
    }
    WS(weakself);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [MBProgressHUD showActivityIndicator];
    UIActivityIndicatorView *ActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    ActivityIndicator.frame = CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGAffineTransform transform = CGAffineTransformMakeScale( 1.2, 1.2);
    ActivityIndicator.transform= transform;

    ActivityIndicator.center = CGPointMake(self.view.centerX, self.view.centerY);
    [self.tableView addSubview:ActivityIndicator];
    [ActivityIndicator startAnimating];
    [XJHttpTool post:FORMAT(@"%@/%@/%@",L_apiappgoodshomegetInfo,type,_ID) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *data = responseObj[@"data"];
        
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        NSLog(@"stock == %@", data[@"stock"]);
        NSLog(@"purchasePrice  == %@", data[@"purchasePrice"]);
        if(weakself.status == RoleStatusStockPeisong){
            self.model.salesPrice = self.model.purchasePrice;
        }
        [self creatHtml:self.model.details];
        self.boView.hidden = NO;
        self.goodHeadView.model = self.model;
        self.boView.status = weakself.status;
        self.boView.model =  self.model;
        [self dealWithsku];
        [self.tableView reloadData];
//        [UIView performWithoutAnimation:^{
//          [self.tableView  beginUpdates];
//          [self.tableView  endUpdates];
//        }];
        //菊花停止旋转
        [ActivityIndicator stopAnimating];
        //菊花隐藏
        [ActivityIndicator setHidesWhenStopped:YES];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideActivityIndicator];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.boView.hidden = NO;
        //菊花停止旋转
        [ActivityIndicator stopAnimating];
        //菊花隐藏
        [ActivityIndicator setHidesWhenStopped:YES];
    }];
}
-(void)getNumDatas{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";//商品类型（1普通商品、2惊喜红包商品、3品鉴商品）
    if(_status == RoleStatusStore){
        type = @"1";
    }else if(_status == RoleStatusRedBag){
        type = @"2";
    }
    [XJHttpTool post:FORMAT(@"%@/%@/%@",L_apiappgoodshomegetInfo,type,_ID) method:GET params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.model = [LLGoodModel mj_objectWithKeyValues:data];
        self.boView.model =  self.model;
  
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)creatHtml:(NSString *)content{
    NSString *htmlHeader = FORMAT(@"<html meta charset=utf-8><meta http-equiv=X-UA-Compatible content=\"IE=edge\"><meta content=\"width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0;\" name=viewport><head></head> <style type=\"text/css\">body {font-family: PingFangSC-Regular, sans-serif;} p{font-size:15px;}div{font-size:16px;}</style><body><head><style>img{max-width:%fpx !important;}</style></head>",SCREEN_WIDTH-15);
    NSString*htmlStr  = FORMAT(@"%@%@</body></html>",htmlHeader,content);
    [_webView loadHTMLString:htmlStr baseURL:nil];
    _webView.navigationDelegate = self;
}
- (void)createWebView
{
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    wkWebConfig.userContentController = wkUController;
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkUController addUserScript:wkUserScript];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1) configuration:wkWebConfig];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.userInteractionEnabled = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView sizeToFit];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [self.scrollView addSubview:self.webView];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        // 方法一
        UIScrollView *scrollView = (UIScrollView *)object;
        CGFloat height = scrollView.contentSize.height;
        self.webViewHeight = height;
        self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
        self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, height);
//        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationNone];
        [UIView performWithoutAnimation:^{
          [self.tableView  beginUpdates];
          [self.tableView  endUpdates];
        }];
    }
}
-(void)initKefu{
    
    WS(weakself);
    XYServiceTipsViewController *serviceVC = [[XYServiceTipsViewController alloc]init];
    serviceVC.pushBlock = ^(UIViewController * view) {
        [weakself.navigationController pushViewController:view animated:YES];
    };
    serviceVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    serviceVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:serviceVC animated:YES completion:nil];
    
    
//    [QMConnect sdkGetWebchatScheduleConfig:^(NSDictionary * _Nonnull scheduleDic) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.dictionary = scheduleDic;
//            NSLog(@"self.dictionary == %@",self.dictionary);
//            if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
//                NSLog(@"日程管理");
//                [self starSchedule];
//            }else{
//                NSLog(@"技能组");
//                [self getPeers];
//            }
//        });
//    } failBlock:^{
//        [self getPeers];
//    }];
}
#pragma mark - 技能组选择
- (void)getPeers {
    [QMConnect sdkGetPeers:^(NSArray * _Nonnull peerArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *peers = peerArray;
            self.isConnecting = NO;
            if (peers.count == 1 && peers.count != 0) {
                [self showChatRoomViewController:[peers.firstObject objectForKey:@"id"] processType:@"" entranceId:@""];
            }else {
                [self showPeersWithAlert:peers messageStr:NSLocalizedString(@"title.type", nil)];
            }
        });
    } failureBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.indicatorView stopAnimating];
            self.isConnecting = NO;
        });
    }];
}

#pragma mark - 日程管理
- (void)starSchedule {
    self.isConnecting = NO;
    if ([self.dictionary[@"scheduleId"] isEqual: @""] || [self.dictionary[@"processId"] isEqual: @""] || [self.dictionary objectForKey:@"entranceNode"] == nil || [self.dictionary objectForKey:@"leavemsgNodes"] == nil) {
        [QMRemind showMessage:NSLocalizedString(@"title.sorryconfigurationiswrong", nil)];
    }else{
        NSDictionary *entranceNode = self.dictionary[@"entranceNode"];
        NSArray *entrances = entranceNode[@"entrances"];
        if (entrances.count == 1 && entrances.count != 0) {
//            [self showChatRoomViewController:[entrances.firstObject objectForKey:@"processTo"] processType:[entrances.firstObject objectForKey:@"processType"] entranceId:[entrances.firstObject objectForKey:@"_id"]];
        }else{
            [self showPeersWithAlert:entrances messageStr:NSLocalizedString(@"title.schedule_type", nil)];
        }
    }
}
- (void)showPeersWithAlert: (NSArray *)peers messageStr: (NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"title.type", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.isConnecting = NO;
    }];
    [alertController addAction:cancelAction];
    for (NSDictionary *index in peers) {
        UIAlertAction *surelAction = [UIAlertAction actionWithTitle:[index objectForKey:@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.dictionary[@"scheduleEnable"] integerValue] == 1) {
                [self showChatRoomViewController:[index objectForKey:@"processTo"] processType:[index objectForKey:@"processType"] entranceId:[index objectForKey:@"_id"]];
            }else{
                [self showChatRoomViewController:[index objectForKey:@"id"] processType:@"" entranceId:@""];
            }
        }];
        [alertController addAction:surelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 跳转聊天界面
- (void)showChatRoomViewController:(NSString *)peerId processType:(NSString *)processType entranceId:(NSString *)entranceId {
    if (!peerId.length) {
        [QMRemind showMessage:@"peerId不能为空"];
        return;
    }
    WS(weakself);
    if(self.clickTap == NO){
        self.clickTap = YES;
    QMChatRoomViewController *chatRoomViewController = [[QMChatRoomViewController alloc] init];
        chatRoomViewController.disMissViewBlock = ^{
            weakself.clickTap = NO;
        };
    chatRoomViewController.peerId = peerId;
    chatRoomViewController.isPush = NO;
    chatRoomViewController.avaterStr = @"";
    chatRoomViewController.model = self.model;
    chatRoomViewController.darkStyle = QMDarkStyleDefault;
    if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
        if (!processType.length && !entranceId.length) {
            [QMRemind showMessage:@"processType和entranceId为必传参数"];
            return;
        }
        chatRoomViewController.isOpenSchedule = true;
        chatRoomViewController.scheduleId = self.dictionary[@"scheduleId"];
        chatRoomViewController.processId = self.dictionary[@"processId"];
        chatRoomViewController.currentNodeId = peerId;
        chatRoomViewController.processType = processType;
        chatRoomViewController.entranceId = entranceId;
    }else{
        chatRoomViewController.isOpenSchedule = false;
    }
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
    }
}

#pragma mark 加入购物车  立即购买
-(void)postDatas:(NSInteger)tags{
    if(self.stock <= 0){
        [JXUIKit showErrorWithStatus:@"库存不足"];
        return;;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *type = @"1";
    NSString *url = L_apiappcartadd;
    if(tags == 1){//立即购买  LLSurpriseRegBagSureOrderViewController
        type = @"2";
       
        if(_status == RoleStatusRedBag){//惊喜红包
            if(self.goodsSpecsPriceId.length <= 0){
                return;
                
            }
            LLSurpriseRegBagSureOrderViewController *vc = [[LLSurpriseRegBagSureOrderViewController alloc]init];
            vc.datas = @[self.model];
            vc.status =RoleStatusRedBag;
            vc.valueModel = self.model;
            vc.goodsNum = self.goodsNum;
            vc.goodsSpecsPriceId = self.goodsSpecsPriceId;
            [self.navigationController pushViewController:vc animated:YES];
        }else if(_status == RoleStatusStockPeisong){
            if(self.model.goodsSpecsPriceId.length <= 0){
                return;
                
            }
            LLPingjianSureOrderViewController *vc = [[LLPingjianSureOrderViewController alloc]init];
            vc.valueModel = self.model;
            vc.status = _status;
            vc.goodsNum = self.goodsNum;
            vc.distDistGoodsId =  self.model.ID;
            vc.goodsSpecsPriceId = self.model.goodsSpecsPriceId;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if(self.goodsSpecsPriceId.length <= 0){
                return;
                
            }
            LLStoreSureOrderViewController *vc = [[LLStoreSureOrderViewController alloc]init];
            vc.datas = @[self.model];
            vc.status =_status;
            vc.valueModel = self.model;
            vc.goodsNum = self.goodsNum;
            vc.goodsSpecsPriceId = self.goodsSpecsPriceId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if(self.goodsSpecsPriceId.length <= 0){
            return;
            
        }
        if(_status == RoleStatusRedBag){//惊喜红包
            [param setValue:self.ID forKey:@"goodsId"];
        }else{
        [param setValue:self.goodsId forKey:@"goodsId"];
        }
        [param setValue:self.goodsNum forKey:@"goodsNum"];
        [param setValue:self.goodsSpecsPriceId forKey:@"goodsSpecsPriceId"];

        WS(weakself);
    [XJHttpTool post:url method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        if(tags == 1){//立即购买
           
        }else{
            [weakself.alert hideView];
            if(weakself.status != RoleStatusRedBag){
               [self getNumDatas];
                [JXUIKit showWithString:responseObj[@"msg"]];
            }
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    }
}
-(void)dealWithsku{
    self.skuModel = [[GoodsModel alloc] init];
    NSArray *arrays = [self.model.images componentsSeparatedByString:@","];
    
    NSLog(@"self.model.images == %@",self.model.images);
    self.skuModel.imageId = arrays[0];
    self.skuModel.goodsNo = _ID;
    self.skuModel.title = self.model.name;
    self.skuModel.status = _status;
    self.skuModel.specsValName = self.model.specsValName;
    self.skuModel.scribingPrice = self.model.scribingPrice;
    self.skuModel.priceSales =  self.model.salesPrice;
    if(_stock == RoleStatusStockPeisong){
        self.skuModel.totalStock =  _stocks;
    }else{
        
        self.skuModel.totalStock =  self.model.stock;
    }
    self.skuModel.purchaseRestrictions = self.model.purchaseRestrictions;
    NSMutableArray *totals = [NSMutableArray array];
    NSMutableArray *temps = [NSMutableArray array];
    for(LLGoodModel *models in self.model.goodsSpecsLists){
        GoodsTypeModel *type = [[GoodsTypeModel alloc] init];
        type.selectIndex = 0;
        type.typeName = models.name;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        NSMutableArray *temp = [NSMutableArray array];
        for(LLGoodModel *model in models.goodsSpecsValLists){
            [param setValue:model.ID forKey:@"id"];
            [param setValue:model.name forKey:@"name"];
            [temp addObject:param.mutableCopy];
     
        }
        for(NSInteger i =0;i<models.goodsSpecsValLists.count;i++){
            LLGoodModel *model = models.goodsSpecsValLists[i];
            if(i == 0){
                [temps addObject:model.name];
            }
        }
        type.typeArray =temp;
        [totals addObject:type];
    }
    LLGoodDetailCell *cell  = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.delable.text = FORMAT(@"%@",[temps componentsJoinedByString:@","]);
    self.skuModel.itemsList = totals.mutableCopy;
}

-(void)showSku{
  _alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andHeight:kSize (450)];
     _alert.alpha = 0;
    _alert.status = _status;
     [[UIApplication sharedApplication].keyWindow addSubview:_alert];
    WS(weakself);
    _alert.selectSize = ^(NSString *goodsId, NSString *goodsNum, NSString *goodsSpecsPriceId,NSInteger tags,NSInteger stock,NSString *speceStr) {
        
        if([UserModel sharedUserInfo].token.length <= 0){
            [weakself.alert hideView];
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [dele loginVc];
        }else{
            weakself.stock = stock;
            weakself.goodsId = goodsId;
            weakself.goodsNum = goodsNum;
            weakself.goodsSpecsPriceId = goodsSpecsPriceId;
            LLGoodDetailCell *cell  = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.delable.text = speceStr;
            [weakself postDatas:tags];
        }

    };
     [_alert initData:self.skuModel];
     [_alert showView];
}
#pragma mark 分享
- (void)shareOnClick{
    NSLog(@"右边分享按钮点击事件");
    if(self.shareView){
        self.shareView = nil;
    }
    [self shareView];
    self.shareView.priceStr = self.goodHeadView.pricelable.text;
    self.shareView.oldpriceStr = self.goodHeadView.oldpricelable.text;
    NSString *type = @"1";
    if(_status == RoleStatusRedBag){
        type = @"2";
    }else if(_status == RoleStatusPingjian){
        type = @"3";
    }
    NSString *link = [NSString stringWithFormat:@"%@/h5/#/pages/productdetail/productdetail?type=%@&id=%@",apiQiUrl,type,self.model.goodsId];
    self.shareView.linkUrl = link;
    NSArray *images = [_model.images componentsSeparatedByString:@","];
    if([images[0] containsString:@"http"]){
        self.shareView.imageUrl  =[NSString stringWithFormat:@"%@",images[0]];
    }else{
        self.shareView.imageUrl  =[NSString stringWithFormat:@"%@%@",API_IMAGEHOST,images[0]];
    }
    self.shareView.nameUrl = [NSString stringWithFormat:@"%@",self.model.name];
    WS(weakself);
    self.shareView.posterBlock = ^{
        
        XYGoodsPosterViewController *vc = [[XYGoodsPosterViewController alloc] init];
        vc.QRCodeString = link;
        vc.goodsId = weakself.ID;
        vc.type = type;
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [weakself presentViewController:vc animated:YES completion:nil];
        
        [weakself.shareView hideActionSheetView];
    };
    
    [self.shareView showActionSheetView];
}
-(void)setLayout{
    WS(weakself);
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.offset(0);
//        make.top.offset(SCREEN_top);
//    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(DeviceXTabbarHeigh(CGFloatBasedI375(49)));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(weakself.boView.mas_top).offset(0);
        make.top.offset(SCREEN_top);
    }];
    self.tableView.tableHeaderView = self.goodHeadView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;;
    }else if(section == 1){
        return self.model.goodsEvaluateLists.count>3?2:self.model.goodsEvaluateLists.count==1?1:self.model.goodsEvaluateLists.count;
    }
    return 1;;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return CGFloatBasedI375(44);;
    }else if(indexPath.section == 1){
        if(self.model.goodsEvaluateLists.count){
            LLGoodModel *model = self.model.goodsEvaluateLists[indexPath.row];
            
            if(model.images.length > 0){
                NSArray *titles = [model.images componentsSeparatedByString:@","];
                if(titles.count <= 4){
                    return CGFloatBasedI375(200);;
                }else{
                    if(titles.count% 4 == 0){
                        return CGFloatBasedI375(100)+titles.count/4;;
                    }
                    return CGFloatBasedI375(90)*(titles.count/4+2);;
                }
                return CGFloatBasedI375(200);;
            }
            return CGFloatBasedI375(90);;
        }
        return CGFloatBasedI375(90);;
    }
    return _webViewHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0 || section == 1){
        return CGFloatBasedI375(10);
    }
    return CGFloatBasedI375(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1 || section == 2){
        return CGFloatBasedI375(44);;
    }
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 0 || section == 1){
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
        header.backgroundColor = BG_Color;
        return header;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        LLGoodSectionPraiseView*view = [[LLGoodSectionPraiseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(50))];
        view.backgroundColor = [UIColor whiteColor];
        view.totals = FORMAT(@"%ld",self.model.goodsEvaluateLists.count);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcomment)];
        [view addGestureRecognizer:tap];
        return view;
    }else if(section == 2){
        LLGoodSectionDetilasView*view = [[LLGoodSectionDetilasView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(44))];
        return view;
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    header.backgroundColor = BG_Color;
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LLGoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:LLGoodDetailCellid];
        
        return cell;
    }else if(indexPath.section == 1){
        LLPraiseAllCell *cell = [tableView dequeueReusableCellWithIdentifier:LLPraiseAllCellid];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if(self.model.goodsEvaluateLists.count){
            cell.model = self.model.goodsEvaluateLists[indexPath.row];
        }
        return cell;
    }
    UITableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:@"WebViewCell" forIndexPath:indexPath];
    [webCell.contentView addSubview:self.scrollView];
    return webCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        [self showSku];
    }else if(indexPath.section == 1){
        LLGoodPraiseViewController *vc = [[LLGoodPraiseViewController alloc]init];
        vc.goodsId = self.model.goodsId;;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)clickcomment{
    LLGoodPraiseViewController *vc = [[LLGoodPraiseViewController alloc]init];
    vc.goodsId = self.model.goodsId;;
    [self.navigationController pushViewController:vc animated:YES];
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
        [ _tableView  registerClass:[LLGoodPicCell class] forCellReuseIdentifier:LLGoodPicCellid];
        _tableView.estimatedRowHeight = 0;
        [ _tableView  registerClass:[LLGoodDetailCell class] forCellReuseIdentifier:LLGoodDetailCellid];
        [ _tableView  registerClass:[LLPraiseAllCell class] forCellReuseIdentifier:LLPraiseAllCellid];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"WebViewCell"];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}

-(LLGoodDetailHeadView *)goodHeadView{
    if(!_goodHeadView){
        _goodHeadView = [[LLGoodDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(107)+SCREEN_WIDTH)];
//        _goodHeadView.hidden = YES;
    }
    return _goodHeadView;;
}
-(LLGoodBoView *)boView{
    if(!_boView){
        _boView = [[LLGoodBoView alloc]init];
        self.boView.hidden = YES;
        [self.view addSubview:self.boView];
        WS(weakself);
        _boView.ActionBlock = ^(NSInteger tagindex) {
            
            if(tagindex == 1 || tagindex == 2 ){//
                [weakself showSku];
            }else if(tagindex == 3){
                if([UserModel sharedUserInfo].token.length <= 0){
                    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [dele loginVc];
                    return ;
                }
                LLShopCarViewController *vc = [[LLShopCarViewController alloc]init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else if(tagindex == 4){
                if([UserModel sharedUserInfo].token.length <= 0){
                    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [dele loginVc];
                    return ;
                }
                [weakself initKefu];
            }
          
        };
    }
    return _boView;;
}

-(LLShareView *)shareView{
    if(!_shareView){
        _shareView = [[LLShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _shareView.isBao = NO;
        _shareView.hidden = YES;
        [self.view addSubview:_shareView];
    }
    return _shareView;
}
@end
