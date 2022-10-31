//
//  LLBuyBackBuyController.m
//  Winner
//
//  Created by YP on 2022/1/23.
//

#import "LLBuyBackBuyController.h"
#import "LLMeBuyBackTableCell.h"
#import "LLBuyBackView.h"
#import "LLbuybackSuccessVC.h"
#import "LLBackBuyPodModel.h"
#import "LLBackBuySuccessModel.h"

@interface LLBuyBackBuyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLBuybackBottomView *bottomView;
@property (nonatomic,strong)LLBuybackConfirmView *confirmView;

@property (nonatomic,strong)LLBackBuyPodModel *backBuyModel;
@property (nonatomic,strong)NSString *goodsNum;

@end

@implementation LLBuyBackBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"回购下单";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self requestUrl];
}
#pragma mark--reRuestUrl
-(void)requestUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.ID forKey:@"id"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_redgoodsbuybackbyId,self.ID) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        
        if ([code intValue] == 200) {
            weakself.backBuyModel = [LLBackBuyPodModel yy_modelWithJSON:responseObj[@"data"]];
            weakself.goodsNum = weakself.backBuyModel.goodsNum;
            weakself.bottomView.buyBackPrice = FORMAT(@"%.2f",weakself.backBuyModel.buyBackPrice.floatValue * weakself.goodsNum.integerValue);
        }
        
        [weakself.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark--回购下单
-(void)getBackBuyOrderurl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.backBuyModel.ID forKey:@"id"];
    [params setObject:self.goodsNum forKey:@"goodsNum"];
    WS(weakself);
    [XJHttpTool post:L_BackBuyPodUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
//        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            if(self.tapAction){
                self.tapAction();
            }
            LLBackBuySuccessModel *successModel = [LLBackBuySuccessModel yy_modelWithJSON:responseObj[@"data"]];
            LLbuybackSuccessVC *successVC = [[LLbuybackSuccessVC alloc]init];
            successVC.successModel = successModel;
            [weakself.navigationController pushViewController:successVC animated:YES];
        }
        [weakself.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    
}

#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLMeBuyBackTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeBuyBackTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isbuyHidden = YES;
    if (_backBuyModel) {
        cell.backBuyModel = self.backBuyModel;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(98);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLBuyBackView *footerView = [[LLBuyBackView alloc]initWithFrame:tableView.tableFooterView.frame];
    if (_backBuyModel) {
        footerView.backBuyModel = self.backBuyModel;
    }
    WS(weakself);
    footerView.LLBackBuyCountBtnBlock = ^(NSInteger count) {
        weakself.goodsNum = [NSString stringWithFormat:@"%ld",count];
        CGFloat price = [weakself.backBuyModel.buyBackPrice floatValue];
        CGFloat totlePrice = price * count;
        weakself.bottomView.buyBackPrice = [NSString stringWithFormat:@"%.2f",totlePrice];

    };
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - CGFloatBasedI375(50) - SCREEN_Bottom) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLMeBuyBackTableCell class] forCellReuseIdentifier:@"LLMeBuyBackTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(LLBuybackBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLBuybackBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGFloatBasedI375(50) - SCREEN_Bottom, SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
        WS(weakself);
        _bottomView.buybackBlock = ^{
            
            CGFloat price = [weakself.backBuyModel.buyBackPrice floatValue];
            CGFloat totlePrice = price;

            weakself.confirmView.totalCount = weakself.goodsNum;
            weakself.confirmView.totlePrice = [NSString stringWithFormat:@"%.2f",totlePrice*weakself.goodsNum.integerValue];
            [weakself.confirmView show];
        };
    }
    return _bottomView;
}
-(LLBuybackConfirmView *)confirmView{
    if (!_confirmView) {
        _confirmView = [[LLBuybackConfirmView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _confirmView.confirmBtnBlock = ^{
            //确认回购
            [weakself getBackBuyOrderurl];
        };
    }
    return _confirmView;
}

@end
