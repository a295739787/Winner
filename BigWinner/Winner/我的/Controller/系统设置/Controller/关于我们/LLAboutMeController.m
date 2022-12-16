//
//  LLAboutMeController.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "LLAboutMeController.h"
#import "LLSystemTableCell.h"
#import "LLAboutMeView.h"
#import "LLMeAdressView.h"
#import "AFNetworking.h"

@interface LLAboutMeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)LLMeAdressDeleteView *updateView;
@property (nonatomic ,assign) BOOL showInfo;
@end

@implementation LLAboutMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getCurrentVersionInfo];
}

#pragma mark--createUI
-(void)createUI{
    
    self.customNavBar.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.noteLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-CGFloatBasedI375(62) - SCREEN_Bottom);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CGFloatBasedI375(10));
        make.centerX.mas_equalTo(self.view);
    }];
}
#pragma mark - 获取当前版本信息
-(void)getCurrentVersionInfo{
    
    WS(weakself);
    NSString *appStoreUrl = @"http://itunes.apple.com/lookup?id=1586242929";
    
    [[AFHTTPSessionManager manager] GET:appStoreUrl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int resultCount = [responseObject[@"resultCount"] intValue];
        if (resultCount > 0) {
            NSArray *results = responseObject[@"results"];
            NSDictionary *dic = results.firstObject;
            NSString *lineVersion = dic[@"version"];//线上版本
            NSString *locVersion = [[[NSBundle mainBundle]  infoDictionary] objectForKey:@"CFBundleShortVersionString"];//本地版本
            NSInteger result = [weakself compareOnlineVersion:lineVersion locVersion:locVersion];
            switch (result) {
                case -1:
                    //线上小
                    
                    weakself.showInfo = NO;
                    break;
                case 0:
                    //相同
                    
                    weakself.showInfo = NO;
                    break;
                case 1:
                    //线上大
                    
                    weakself.showInfo = YES;
                    weakself.updateView.textStr = [NSString stringWithFormat:@"新版本：%@",lineVersion];
                    [weakself.tableView reloadData];
                    break;
                default:
                    break;
            }
            

        }else{
            weakself.showInfo = NO;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakself.showInfo = NO;
    }];
    
}
#pragma mark - 版本比较
- (NSComparisonResult)compareOnlineVersion:(NSString*)online locVersion:(NSString*)local {
    NSArray* onlineArr = [online componentsSeparatedByString:@"."];
    NSArray* localArr = [local componentsSeparatedByString:@"."];
    NSInteger pos = 0;
    while ([onlineArr count] > pos || [localArr count] > pos) {
        NSInteger v1 = [onlineArr count] > pos ? [[onlineArr objectAtIndex:pos] integerValue] : 0;
        NSInteger v2 = [localArr count] > pos ? [[localArr objectAtIndex:pos] integerValue] : 0;
        if (v1 < v2) {
            //版本2大
            return NSOrderedAscending;
        }
        else if (v1 > v2) {
            //版本1大
            return NSOrderedDescending;
        }
        pos++;
    }
    //版本相同
    return NSOrderedSame;
}

#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLSystemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLSystemTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textStr = @[@"版本更新",@"服务协议",@"隐私保护指引"][indexPath.row];
    if (indexPath.row == 0) {
        if (self.showInfo == YES) {
            cell.infoStr = @"有新版本";
        }else{
            cell.infoStr = @"当前为新版本";
        }
    }else{
        cell.infoStr = @"";
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(198);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLAboutMeView *headerView = [[LLAboutMeView alloc]initWithFrame:tableView.tableHeaderView.frame];
    
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        if (self.showInfo == YES) {
            //版本更新
            [self.updateView show];
        }
    }else
        if (indexPath.row == 1){
            //服务协议
            
            LLWebViewController *vc = [[LLWebViewController alloc]init];
            vc.isHiddenNavgationBar = YES;
            vc.htmlStr = @"AppServiceAgreement";
            vc.name = @"服务协议";
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 2){
            //隐私保护指引
            
            LLWebViewController *vc = [[LLWebViewController alloc]init];
            vc.isHiddenNavgationBar = YES;
            vc.htmlStr = @"AppPrivacyAgreement";
            vc.name = @"隐私协议";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLSystemTableCell class] forCellReuseIdentifier:@"LLSystemTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(13)];
        _titleLabel.text = @"广东买卖易电子商务有限公司 版权所有";
    }
    return _titleLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x999999);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(10)];
        _noteLabel.text = @"Copyright © 2021 大赢家\nAll Rights Reserved.";
    }
    return _noteLabel;
}
-(LLMeAdressDeleteView *)updateView{
    if (!_updateView) {
        _updateView = [[LLMeAdressDeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _updateView.titleStr = @"有新版本更新";
        _updateView.textStr = @"新版本：1.0.2";
        _updateView.rightStr = @"更新";
        _updateView.deleteBtnBlock = ^{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/app/id1586242929?mt=8"]] options:@{} completionHandler:^(BOOL success) {
                
            }];
        };
    }
    return _updateView;
}

@end
