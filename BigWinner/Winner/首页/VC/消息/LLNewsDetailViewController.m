//
//  LLNewsDetailViewController.m
//  Winner
//
//  Created by mac on 2022/1/30.
//

#import "LLNewsDetailViewController.h"
#import "LLNewsModel.h"

@interface LLNewsDetailViewController ()
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *delable;
@property (nonatomic,strong)UILabel *detailLabel;
@end

@implementation LLNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"消息详情";
    self.view.backgroundColor = BG_Color;
    [self setLayout];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateName" object:nil];
    [self requesturl];
}
-(void)setLayout{
    WS(weakself);
    [self.titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(16)+SCREEN_top);
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
    }];
    [self.delable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(10));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.top.equalTo(weakself.delable.mas_bottom).offset(CGFloatBasedI375(20));
    }];
}

-(void)requesturl{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.ID forKey:@"id"];
    WS(weakself);
    [XJHttpTool post:FORMAT(@"%@/%@",L_messageInfoUrl,self.ID) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            
            LLNewsListModel *listModel = [LLNewsListModel yy_modelWithJSON:responseObj[@"data"]];
            
            if ([listModel.type intValue] == 1) {
                //系统消息
                weakself.titlelable.text = @"系统消息";
            }else if ([listModel.type intValue] == 2){
                //订单消息
                weakself.titlelable.text = @"订单消息";
            }else{
                //配送消息
                weakself.titlelable.text = @"配送消息";
            }
            weakself.delable.text = listModel.createTime;
            weakself.detailLabel.text = listModel.content;
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.text = @"系统消息";
        _titlelable.textColor =BlackTitleFont443415;
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(16)];
        [self.view addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}

-(UILabel *)delable{
    if(!_delable){
        _delable =[[UILabel alloc]init];
        _delable.text = @"2021-12-20 15:02:05";
        _delable.textColor = [UIColor colorWithHexString:@"#999999"];
        _delable.textAlignment = NSTextAlignmentLeft;
        _delable.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.view addSubview:self.delable];
        _delable.numberOfLines = 2;
    }
    return _delable;
}
-(UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel =[[UILabel alloc]init];
        _detailLabel.text = @"";
        _detailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self.view addSubview:self.detailLabel];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

@end
