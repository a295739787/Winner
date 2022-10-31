//
//  LLZhuxiaoViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/5/24.
//

#import "LLZhuxiaoViewController.h"

@interface LLZhuxiaoViewController ()
@property (nonatomic,strong) UIView *backView;/** <#class#> **/
@property (nonatomic,strong) UILabel *label1;/** <#class#> **/
@property (nonatomic,strong) UILabel *label2;/** <#class#> **/
@property (nonatomic,strong) UILabel *label3;/** <#class#> **/
@property (nonatomic,strong) UILabel *label4;/** <#class#> **/
@property (nonatomic,strong) UILabel *label5;/** <#class#> **/
@property (nonatomic,strong) UILabel *label6;/** <#class#> **/
@property (nonatomic,strong) UILabel *label7;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/

@end

@implementation LLZhuxiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customNavBar.title = @"注销账号";
    self.view.backgroundColor  = BG_Color;
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.top.mas_equalTo(SCREEN_top);
        make.height.mas_equalTo(CGFloatBasedI375(330));
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.top.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.label1.mas_bottom).offset(CGFloatBasedI375(30));
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.label2.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.label3.mas_bottom).offset(CGFloatBasedI375(30));
    }];
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.label4.mas_bottom).offset(CGFloatBasedI375(30));
    }];
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.label5.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    [self.label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.top.mas_equalTo(self.label6.mas_bottom).offset(CGFloatBasedI375(30));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CGFloatBasedI375(0));
        make.right.mas_equalTo(-CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(44));
        make.top.mas_equalTo(self.backView.mas_bottom).offset(CGFloatBasedI375(20));
    }];
}

-(UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc]init];
        _label1.textColor = UIColorFromRGB(0x443415);
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(15)];
        _label1.text = @"为保证你的帐号安全，在你提交的注销申请生效前， 需同时满足以下条件：";
        [self.backView addSubview:_label1];
        _label1.numberOfLines=0;
    }
    return _label1;
}
-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc]init];
        _label2.textColor = UIColorFromRGB(0x443415);
        _label2.textAlignment = NSTextAlignmentLeft;
        _label2.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _label2.text = @"1.帐号财产已结清";
        [self.backView addSubview:_label2];
    }
    return _label2;
}
-(UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc]init];
        _label3.textColor = UIColorFromRGB(0x666666);
        _label3.textAlignment = NSTextAlignmentLeft;
        _label3.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _label3.text = @"没有资产、欠款、未结清的资金和虚拟权益 本帐号及通过本帐号介入的第三方中没有未完成或存在争议的服务";
        _label3.numberOfLines=0;
        [self.backView addSubview:_label3];
    }
    return _label3;
}
-(UILabel *)label4{
    if (!_label4) {
        _label4 = [[UILabel alloc]init];
        _label4.textColor = UIColorFromRGB(0x443415);
        _label4.textAlignment = NSTextAlignmentLeft;
        _label4.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _label4.text = @"2.帐号处于安全状态";
        _label4.numberOfLines=0;
        [self.backView addSubview:_label4];
    }
    return _label4;
}
-(UILabel *)label5{
    if (!_label5) {
        _label5 = [[UILabel alloc]init];
        _label5.textColor = UIColorFromRGB(0x443415);
        _label5.textAlignment = NSTextAlignmentLeft;
        _label5.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _label5.text = @"3.帐号权限已解除";
        _label5.numberOfLines=0;
        [self.backView addSubview:_label5];
    }
    return _label5;
}
-(UILabel *)label6{
    if (!_label6) {
        _label6 = [[UILabel alloc]init];
        _label6.textColor = UIColorFromRGB(0x666666);
        _label6.textAlignment = NSTextAlignmentLeft;
        _label6.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(12)];
        _label6.text = @"帐号已解除与其他产品授权登录或绑定关系";
        _label6.numberOfLines=0;
        [self.backView addSubview:_label6];
    }
    return _label6;
}
-(UILabel *)label7{
    if (!_label7) {
        _label7 = [[UILabel alloc]init];
        _label7.textColor = UIColorFromRGB(0x443415);
        _label7.textAlignment = NSTextAlignmentLeft;
        _label7.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _label7.text = @"4.帐号无任何纠纷，包括投诉举报";
        _label7.numberOfLines=0;
        [self.backView addSubview:_label7];
    }
    return _label7;
}
- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = White_Color;
        [self.view addSubview:_backView];
    }
    return _backView;;
}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认注销" forState:UIControlStateNormal];
        _sureButton.backgroundColor =White_Color;
        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#443415"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(15)];
        [_sureButton addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.sureButton];
    }
    return _sureButton;
}
-(void)clickTap:(UIButton *)sender{
    [UIAlertController showAlertViewWithTitle:@"确定注销此账号?" Message:@"" BtnTitles:@[@"取消",@"确定"] ClickBtn:^(NSInteger index) {
        if(index == 1){
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [XJHttpTool post:FORMAT(@"%@",L_apiappuserLogout) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
                [AccessTool  removeUserInfo];
                [UserModel resetModel:nil];
                AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [dele loginMainVc];
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
    }];
 
}
@end
