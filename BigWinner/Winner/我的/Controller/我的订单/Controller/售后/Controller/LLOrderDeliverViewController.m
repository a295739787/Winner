//
//  LLOrderDeliverViewController.m
//  ShopApp
//
//  Created by lijun L on 2021/5/21.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLOrderDeliverViewController.h"
#import "LLOrderDeliverCell.h"

static NSString *const LLOrderDeliverCellid = @"LLOrderDeliverCell";
static NSString *const LLOrderDetailCellid = @"LLOrderDetailCell";

@interface LLOrderDeliverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) UIView *topView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *topimage;/** <#class#> **/
@property (nonatomic,strong) UILabel *titlelables;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *headModel;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *dataArr;/** <#class#> **/
@property (nonatomic,strong) UIView *btnView;/** <#class#> **/
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/

@end

@implementation LLOrderDeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"查看物流";
    [self setlaouts];
    if(!_derModel){
 
    }
    [self getwuliuUrl];
}
//L_uexpress
-(void)getwuliuUrl{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_orderNo forKey:@"orderNo"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappordergetExpress,_orderNo) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSLog(@"responseObj == %@",responseObj);
        NSDictionary *data = responseObj[@"data"];
        self.datas = data;
        NSArray *list = data[@"list"];
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:list];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

-(void)setlaouts{
    WS(weakself);
  
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.offset(SCREEN_top+CGFloatBasedI375(0));
    }];
//    self.tableView.tableHeaderView = self.topView;
 

}
#define btnTags 200
-(void)creatButton{
    [self.view layoutIfNeeded];
    for(UILabel *btn in self.btnView.subviews){
        [btn removeFromSuperview];
    }
    NSArray *tiles = @[@"物流状态：",@"承运公司：",@"快递编号：",@"发货时间："];
    for (int i = 0; i < tiles.count; i++) {
        CGFloat w = SCREEN_WIDTH-CGFloatBasedI375(70);
        CGFloat h = CGFloatBasedI375(30);
        CGFloat x =CGFloatBasedI375(15);
        CGFloat y = CGFloatBasedI375(10)+(h + CGFloatBasedI375(0))*(i% tiles.count);
        UILabel *button = [[UILabel alloc]init];;
        button.text = tiles[i];
        button.tag = btnTags+i;
        button.frame = CGRectMake(x, y, w, h);
        button.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];
        button.textAlignment = NSTextAlignmentLeft;
        button.textColor = BlackTitleFont443415;
        [self.btnView addSubview:button];
        button.numberOfLines  = 0;
        
    }
}
-(void)creatDatas:(NSDictionary *)data{
    
    UILabel *label2 = [self.view viewWithTag:btnTags+1];
    label2.text = FORMAT(@"承运公司：%@",data[@"expName"]);
    
    UILabel *label3 = [self.view viewWithTag:btnTags+2];
    label3.text = FORMAT(@"快递编号：%@",data[@"number"]);
    
    UILabel *label4 = [self.view viewWithTag:btnTags+3];
    label4.text = FORMAT(@"发货时间：%@",data[@"updateTime"]);
    
    UILabel *label1 = [self.view viewWithTag:btnTags];
    
    //投递状态 0快递收件(揽件)1.在途中 2.正在派件 3.已签收 4.派送失败 5.疑难件 6.退件签收
    NSInteger deliverystatus = [FORMAT(@"%@",data[@""])integerValue];
    NSString *str;
    if(deliverystatus == 0){
        str = @"快递收件(揽件)";
    }else if(deliverystatus == 1){
        str = @"在途中";
    }else if(deliverystatus == 2){
        str = @"正在派件";
    }else if(deliverystatus == 3){
        str = @"已签收";
    }else if(deliverystatus == 4){
        str = @"派送失败";
    }else if(deliverystatus == 5){
        str = @"疑难件";
    }else if(deliverystatus == 6){
        str = @"退件签收";
    }
    label1.text = FORMAT(@"物流状态：%@",str);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)return 1;
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 0){
        return nil;;
    }
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    view.backgroundColor = BG_Color;
    
    UIView *view11 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-CGFloatBasedI375(30), CGFloatBasedI375(10))];
    view11.backgroundColor = White_Color;
    [view addSubview:view11];
    [view11 layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view11.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(CGFloatBasedI375(10), CGFloatBasedI375(10))];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view11.bounds;
    maskLayer.path = maskPath.CGPath;
    view11.layer.mask = maskLayer;
    return view;;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return nil;;
    }
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    view.backgroundColor = BG_Color;
    
    UIView *view11 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-CGFloatBasedI375(30), CGFloatBasedI375(10))];
    view11.backgroundColor = White_Color;
    [view addSubview:view11];
    [view11 layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view11.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(CGFloatBasedI375(10), CGFloatBasedI375(10))];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view11.bounds;
    maskLayer.path = maskPath.CGPath;
    view11.layer.mask = maskLayer;
    return view;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 0.001;;
    }
    return CGFloatBasedI375(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.001;;
    }
    return CGFloatBasedI375(10);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LLOrderDeliverTopCell*cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderDeliverTopCell"];
        cell.datas = self.datas;
          return cell;;
    }
        LLOrderDeliverCell *cell = [tableView dequeueReusableCellWithIdentifier:LLOrderDeliverCellid];
      cell.datas = self.dataArr[indexPath.row];
      cell.indexs = indexPath.row;
    
        return cell;;
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = BG_Color;
//        [ _tableView  registerClass:[LLOrderDetailCell class] forCellReuseIdentifier:LLOrderDetailCellid];
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [ _tableView  registerClass:[LLOrderDeliverTopCell class] forCellReuseIdentifier:@"LLOrderDeliverTopCell"];

        [ _tableView  registerClass:[LLOrderDeliverCell class] forCellReuseIdentifier:LLOrderDeliverCellid];
//        MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
//        [header setRefreshingTarget:self refreshingAction:@selector(postUrl)];
//        _tableView.mj_header = header;
        [self.view addSubview:self.tableView];
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), 0, SCREEN_WIDTH-CGFloatBasedI375(15), CGFloatBasedI375(140))];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.layer.masksToBounds = YES;
        _topView.layer.cornerRadius = CGFloatBasedI375(10);
        [self.view addSubview:_topView];
    }
    return _topView;;
}
-(UIView *)btnView{
    if(!_btnView){
        _btnView = [[UIView alloc]init];
        _btnView.backgroundColor = [UIColor whiteColor];
        [self.topView addSubview:_btnView];
        _btnView.layer.masksToBounds = YES;
        _btnView.layer.cornerRadius = CGFloatBasedI375(10);
    }
    return _btnView;;
}

-(UIImageView *)topimage{
    if(!_topimage){
        _topimage = [[UIImageView alloc]init];
        _topimage.image = [UIImage imageNamed:@"wengxiniamges"];
        [self.topView addSubview:_topimage];
    }
    return _topimage;
}
-(UILabel *)titlelables{
    if(!_titlelables){
        _titlelables = [[UILabel alloc]init];
        _titlelables.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _titlelables.textAlignment = NSTextAlignmentLeft;
        _titlelables.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.topView addSubview:self.titlelables];
        _titlelables.numberOfLines  = 0;
        _titlelables.text = @"物流运输中";
    }
    return _titlelables;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
