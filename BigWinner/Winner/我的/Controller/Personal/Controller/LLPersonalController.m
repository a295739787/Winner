//
//  LLPersonalController.m
//  Winner
//
//  Created by YP on 2022/1/21.
//

#import "LLPersonalController.h"
#import "LLPersonalHeaderView.h"
#import "LLPersonalTableCell.h"
#import "LLPersonalChangeVC.h"
#import "LLCertificationController.h"
#import "LLAddBankCardController.h"
#import "LLPersonalTableCell.h"

@interface LLPersonalController ()<UITableViewDelegate,UITableViewDataSource,JJPhotoDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *imageArray;/** <#class#> **/
@property (nonatomic, copy) NSString *headerImgStr;

@end

@implementation LLPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"个人资料";
    [self.view addSubview:self.tableView];
    
    NSString *nickName =[self.personalModel.nickName length] > 0 ? self.personalModel.nickName : @"";
    NSString *account =[self.personalModel.account length] > 0 ? self.personalModel.account : @"";
    NSString *realName = [self.personalModel.realName length] > 0 ? @"已实名" : @"未实名";
    
    self.dataArray = [[NSMutableArray alloc]initWithObjects:nickName,account,realName, nil];
    [self.tableView reloadData];
    
}
-(void)getPersonalUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [XJHttpTool post:L_getUserInfo method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.personalModel = [LLPersonalModel mj_objectWithKeyValues:data];

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView reloadData];
}
#pragma mark - 选择图片
- (void)addNewImg{
    [self.view endEditing:YES];
    WS(weakself);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.hideWhenCanNotSelect = YES;
    imagePickerVc.oKButtonTitleColorNormal = White_Color;
    imagePickerVc.barItemTextColor = Black_Color;
    imagePickerVc.iconThemeColor = Black_Color;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.cropRect = CGRectMake(CGFloatBasedI375(10), SCREEN_HEIGHT*0.5-(SCREEN_WIDTH-CGFloatBasedI375(20))*0.5, SCREEN_WIDTH-CGFloatBasedI375(20), SCREEN_WIDTH-CGFloatBasedI375(20));
    imagePickerVc.naviTitleColor = Black_Color;
    imagePickerVc.oKButtonTitleColorDisabled = Black_Color;
    // 相册选择照片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto){
        if (!photos[0]) {
            return ;
        }
        [self.imageArray removeAllObjects];
        [self.imageArray addObjectsFromArray:photos];
        [self uploadUrl];
    }];
        
    
    imagePickerVc.navigationBar.barTintColor = Main_Color;
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}
-(void)uploadUrl{
    [XJHttpTool uploadWithImageArr:self.imageArray[0] url:FORMAT(@"%@%@",apiQiUrl,L_apifileUploaderimages) filename:@"" name:@"" mimeType:@"" parameters:@{} progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
            
        } success:^(id  _Nonnull response) {
            NSDictionary *dic = response[@"data"];
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:dic[@"name"]];
            [self updateUserInfoUtl:temp.mutableCopy];
        } fail:^(NSError * _Nonnull error) {
            
        }] ;
}
#pragma mark--提交修改申请
-(void)updateUserInfoUtl:(NSArray *)pic{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:[pic componentsJoinedByString:@","] forKey:@"value"];
    [params setObject:@"2" forKey:@"type"];
    WS(weakself);
    [XJHttpTool post:L_UpdateUserInfo method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
            
        NSString *code = responseObj[@"code"];
        
        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateName" object:nil];
            self.headerImgStr = [pic componentsJoinedByString:@","];
            [self.tableView reloadData];
        }
        
        } failure:^(NSError * _Nonnull error) {
            
        }];
}
#pragma mark
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LLPersonalTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"LLPersonalTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textStr = @[@"昵称",@"手机号码",@"实名认证"][indexPath.row];
        cell.contextStr = self.dataArray[indexPath.row];
        cell.index = indexPath.row;
        return cell;
    }
    if ([self.personalModel.isBank intValue] == 0) {
        LLPersonalBankTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLPersonalBankTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    LLMeBankCardTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeBankCardTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.personalModel = self.personalModel;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(67);
    }
    return [self.personalModel.isBank intValue] == 0 ? CGFloatBasedI375(54) : CGFloatBasedI375(148);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFloatBasedI375(140);
    }
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        LLPersonalHeaderView *headerView = [[LLPersonalHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
        if (self.personalModel) {
            headerView.headerImgStr = self.personalModel.headIcon;
        }
        if(self.headerImgStr.length > 0){
            headerView.headerImgStr = self.headerImgStr;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addNewImg)];
        [headerView.headerImgView addGestureRecognizer:tap];
        return headerView;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LLPersonalChangeVC *changeVC = [[LLPersonalChangeVC alloc]init];
            NSString *nickName = self.personalModel.nickName;
            changeVC.nameStr = nickName;
            WS(weakself);
            changeVC.changeSuccessBlock = ^(NSString * _Nonnull changeText) {
                weakself.personalModel.nickName = changeText;
                [weakself.dataArray replaceObjectAtIndex:0 withObject:changeText];
                [weakself.tableView reloadData];
            };
            [self.navigationController pushViewController:changeVC animated:YES];
        }else if (indexPath.row == 2){
            if ([self.personalModel.realName length] <= 0) {
                LLCertificationController *certificationVC = [[LLCertificationController alloc]init];
                WS(weakself);
                certificationVC.certificationBlock = ^(NSString * _Nonnull realname) {
                    weakself.personalModel.realName = realname;
                    [weakself.dataArray replaceObjectAtIndex:2 withObject:@"已实名"];
                    [weakself.tableView reloadData];
                };
                [self.navigationController pushViewController:certificationVC animated:YES];
            }
        }
    }else if (indexPath.section == 1){
//        if ([self.personalModel.isBank intValue] == 0) {
            LLAddBankCardController *addVC = [[LLAddBankCardController alloc]init];
           addVC.ID = self.personalModel.bankId;
            WS(weakself);
            addVC.addBankSuccessBlock = ^(NSMutableDictionary * _Nonnull dict) {
                [weakself getPersonalUrl];
//                weakself.personalModel.isBank = @"1";
//                weakself.personalModel.bankName = dict[@"bankName"];
//                weakself.personalModel.bankCardNum = dict[@"bankCardNum"];
//                weakself.personalModel.bankId = dict[@"id"];
//                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//                [weakself.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:addVC animated:YES];
//        }
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLPersonalTableCell class] forCellReuseIdentifier:@"LLPersonalTableCell"];
        [_tableView registerClass:[LLPersonalBankTableCell class] forCellReuseIdentifier:@"LLPersonalBankTableCell"];
        [_tableView registerClass:[LLMeBankCardTableCell class] forCellReuseIdentifier:@"LLMeBankCardTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
