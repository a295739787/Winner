//
//  LLSurpriseRegBagRecordViewController.m
//  Winner
//
//  Created by mac on 2022/2/7.
//

#import "LLSurpriseRegBagRecordDetailViewController.h"
#import "LLSurpriseRegBagRecordViewCell.h"
#import "LLSurpriseRegBagRecordDetailGoodView.h"
static NSString *const LLSurpriseRegBagRecordViewCellid = @"LLSurpriseRegBagRecordViewCell";

@interface LLSurpriseRegBagRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;/** <#class#> **/
@property (nonatomic,strong) LLSurpriseRegBagRecordDetailGoodView *goodView ;/** <#class#> **/
@property(nonatomic,strong)UIView *backView;
@property (nonatomic,strong) NSMutableArray *dataArr ;/** <#class#> **/
@property (nonatomic,strong) UILabel *titlelable ;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/

@end

@implementation LLSurpriseRegBagRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_Color;
    self.customNavBar.title = @"惊喜商品详情";
    if(_tagIndex == 0){//进行中

    }else{//红包已到账
 
    }
    [self getData:YES];
}
-(void)getData:(BOOL)isLoad{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_ID forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappredgoodsgetRedById,_ID) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.model = [LLGoodModel mj_objectWithKeyValues:responseObj[@"data"]];
        if(self.model.redStatus == 1){//红包到账状态（1未到账、2已到账）
            [self setLayout];
        }else{
            [self setDoneLayout];
        }
        self.goodView.datas =responseObj[@"data"];
        [self creatData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
-(void)setLayout{
    WS(weakself);
    [self.goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(190));
        make.right.offset(-CGFloatBasedI375(10));

    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(130));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.equalTo(weakself.goodView.mas_bottom).offset(CGFloatBasedI375(10));

    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(40));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.mas_equalTo(CGFloatBasedI375(0));
    }];
    [self creatPaixufirbutton:NO];
}
-(void)setDoneLayout{
    WS(weakself);
    [self.goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.top.mas_equalTo(SCREEN_top+CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(210));
        make.right.offset(-CGFloatBasedI375(10));

    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(10));
        make.height.offset(CGFloatBasedI375(160));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.equalTo(weakself.goodView.mas_bottom).offset(CGFloatBasedI375(10));

    }];
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(40));
        make.right.offset(-CGFloatBasedI375(10));
        make.top.mas_equalTo(CGFloatBasedI375(0));
    }];
    self.goodView.totalJinglable.hidden = NO;
    self.goodView.noticeJinglable.hidden = NO;

    [self creatPaixufirbutton:YES];
}
#define btnTag 200
-(void)creatData{
    if(self.model.redStatus == 1){//红包到账状态（1未到账、2已到账）
        LLSurpriseRegBagRecordDetailLitterView *btn = [self.view viewWithTag:btnTag];
        btn.delable.text = self.model.orderNo;
        LLSurpriseRegBagRecordDetailLitterView *btn1 = [self.view viewWithTag:btnTag+1];
        btn1.delable.text = self.model.createTime;
    }else{
        LLSurpriseRegBagRecordDetailLitterView *btn = [self.view viewWithTag:btnTag];
        btn.delable.text = self.model.orderNo;
        LLSurpriseRegBagRecordDetailLitterView *btn1 = [self.view viewWithTag:btnTag+1];
        btn1.delable.text = self.model.createTime;
        LLSurpriseRegBagRecordDetailLitterView *btn2 = [self.view viewWithTag:btnTag+2];
        btn2.delable.text = self.model.redToTime;
    }
}
#pragma mark - 创建界面
-(void)creatPaixufirbutton:(BOOL)isShow{
    NSArray *titlearr = @[@"订单编号",@"下单时间"];
    NSArray *imager = @[@"0",@"0"];
    if(isShow){
        titlearr = @[@"订单编号",@"下单时间",@"红包到账时间"];
        imager = @[@"0",@"2021-01-02 10:07:55",@"2021-01-02 10:07:55"];
    }
    for (int i = 0; i < titlearr.count; i ++) {
        CGFloat w = SCREEN_WIDTH-CGFloatBasedI375(20);
        CGFloat h =CGFloatBasedI375(34);
        CGFloat x = CGFloatBasedI375(0);
        CGFloat y =CGFloatBasedI375(50)+(h + CGFloatBasedI375(0))*(i%titlearr.count);
        LLSurpriseRegBagRecordDetailLitterView *btn = [[LLSurpriseRegBagRecordDetailLitterView alloc]initWithFrame:CGRectMake(x,y,w,h)];
        btn.tag = i+btnTag;
        btn.titlelable.text = titlearr[i];
        btn.delable.text = imager[i];
        [self.backView addSubview:btn];
        [self.dataArr addObject:btn];
        
    }
}
-(LLSurpriseRegBagRecordDetailGoodView *)goodView{
    if(!_goodView){
        _goodView = [[LLSurpriseRegBagRecordDetailGoodView alloc]init];
        [self.view addSubview:self.goodView];
    }
    return _goodView;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatBasedI375(10);
        [self.view addSubview:_backView];
    }
    return _backView;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"订单信息";
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(15)];
        [self.backView addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}
@end
