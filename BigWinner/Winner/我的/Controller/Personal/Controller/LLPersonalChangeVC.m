//
//  LLPersonalChangeVC.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLPersonalChangeVC.h"
#import "Winner-Swift.h"
@interface LLPersonalChangeVC ()

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UITextField *textField;

@end

@implementation LLPersonalChangeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = UIColorFromRGB(0xF0EFED);
    self.customNavBar.title = @"修改昵称";
    
    
    [self.customNavBar wr_setLeftButtonWithTitle:@"取消" titleColor:UIColorFromRGB(0x999999)];
    [self.customNavBar wr_setRightButtonWithTitle:@"完成" titleColor:UIColorFromRGB(0x443415)];
    
    WS(weakself);
    self.customNavBar.onClickLeftButton = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.customNavBar.onClickRightButton = ^{
        [weakself updateUserInfoUtl];
    };
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.textField];
    
    
    _textField.text = self.nameStr;
    [_textField becomeFirstResponder];
    
}
#pragma mark--cancleBtnClick
-(void)cancleBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--443415
-(void)confirmBtnClick:(UIButton *)btn{
    
}
#pragma mark--textFieldChange
-(void)textFieldChange:(UITextField *)textField{
    
    
}
#pragma mark--提交修改申请
-(void)updateUserInfoUtl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_textField.text forKey:@"value"];
    [params setObject:@"1" forKey:@"type"];
    WS(weakself);
    [XJHttpTool post:L_UpdateUserInfo method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
            
        NSString *code = responseObj[@"code"];
        
        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            
            if (weakself.changeSuccessBlock) {
                weakself.changeSuccessBlock(weakself.textField.text);
            }
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
        } failure:^(NSError * _Nonnull error) {
            
        }];
}
#pragma mark--lazy
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, CGFloatBasedI375(44))];
        _bottomView.backgroundColor = [UIColor  whiteColor];
    }
    return _bottomView;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGFloatBasedI375(15), 0, SCREEN_WIDTH - CGFloatBasedI375(30), CGFloatBasedI375(44))];
        _textField.textColor = UIColorFromRGB(0x443415);
        _textField.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _textField.textAlignment = NSTextAlignmentLeft;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}


@end
