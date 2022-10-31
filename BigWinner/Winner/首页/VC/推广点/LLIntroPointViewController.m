//
//  LLIntroPointViewController.m
//  Winner
//
//  Created by 廖利君 on 2022/3/6.
//

#import "LLIntroPointViewController.h"
#import "LLIntroPointCell.h"
#import "LLIntroPointPicCell.h"
#import "AdressListView.h"
#import "LLMapChoiceViewController.h"
#import "LLMapChoiceViewController.h"
@interface LLIntroPointViewController ()<UITableViewDelegate,UITableViewDataSource,LLCommonDelegate>
@property (nonatomic,strong) LLBaseTableView *tableView;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showImage;/** <#class#> **/
@property (nonatomic,strong) UIView *boView;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic,strong)AdressListView *adressView;
@property (nonatomic,strong)NSString *address;//详细地址
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *area;//区
@property (nonatomic,strong)NSString *city;//市
@property (nonatomic,strong) NSMutableArray *adressList;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *contentArr;/** <#class#> **/
@property (nonatomic,strong) LLGoodModel *models;/** <#class#> **/
@property (nonatomic, copy) NSString *content;

@end

@implementation LLIntroPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"推广点申请";
    if(_status == RoleStatusPeisong){
        self.customNavBar.title = @"配送员申请";
    }
    
    [self setLayout];
    [self getProvinceUrl];
//    if(_refuseStutas){
        [self getDetailUrl];
    [self getRuleData];
//    }
}
-(void)getDetailUrl{
    WS(weakself);
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *url = L_apiappusershopgetById;
    if(_status == RoleStatusPeisong){
        url = L_apiappuserdeliverygetById;
    }
    [XJHttpTool post:url method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.models =  [LLGoodModel mj_objectWithKeyValues:data];
        if(self.models){
        if(weakself.status == RoleStatusPeisong){
            /*
             {
               "code": 0,
               "data": {
                 "address": "string",
                 "area": "string",
                 "certificatesNumber": "string",
                 "city": "string",
                 "gender": 0,
                 "province": "string",
                 "realName": "string",
                 "refuseReason": "string",
                 "status": 0,
                 "telePhone": "string"
               },
               "msg": "string"
             }
             */

            self.contentArr[0][0] = FORMAT(@"%@",data[@"realName"]);
            NSInteger gender = [FORMAT(@"%@",data[@"gender"]) integerValue];
            self.contentArr[0][1] = FORMAT(@"%@",data[@"gender"]);
            self.contentArr[0][2] = FORMAT(@"%@",data[@"telePhone"]);
            self.contentArr[0][3] = FORMAT(@"%@",data[@"certificatesNumber"]);
            self.contentArr[0][4] = FORMAT(@"%@%@%@",data[@"province"],data[@"city"],data[@"area"]);
             self.province =FORMAT(@"%@",data[@"province"]);;
            self.area =FORMAT(@"%@",data[@"area"]);;
            self.city =FORMAT(@"%@",data[@"city"]);;
            self.contentArr[1][0] = FORMAT(@"%@",data[@"certificatesFront"]);
            self.contentArr[2][0] = FORMAT(@"%@",data[@"certificatesReverse"]);
            self.contentArr[3][0] = FORMAT(@"%@",data[@"photo"]);
            self.contentArr[0][5] = FORMAT(@"%@",data[@"address"]);
        }else{
         
            self.contentArr[0][0] = FORMAT(@"%@",data[@"name"]);
            self.contentArr[0][1] = FORMAT(@"%@",data[@"telePhone"]);
            self.contentArr[0][3] = FORMAT(@"%@",data[@"address"]);
            self.contentArr[0][2] = FORMAT(@"%@%@%@",data[@"province"],data[@"city"],data[@"area"]);
            self.contentArr[1][0] = FORMAT(@"%@",data[@"shopPhoto"]);
            self.contentArr[2][0] = FORMAT(@"%@",data[@"businessLicense"]);
            self.province =FORMAT(@"%@",data[@"province"]);;
           self.area =FORMAT(@"%@",data[@"area"]);;
           self.city =FORMAT(@"%@",data[@"city"]);;
        }
            
            if(self.models.status == 1|| self.models.status == 2){
                self.boView.hidden = YES;
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.offset(SCREEN_top);
                    make.left.right.bottom.mas_equalTo(CGFloatBasedI375(0));
                }];
            }
            if(self.models.status == 1){
                [JXUIKit showErrorWithStatus:@"待审核"];
            }else if(self.models.status == 2){
                [JXUIKit showErrorWithStatus:@"审核已通过"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else if(self.models.status == 3){
                [JXUIKit showErrorWithStatus:FORMAT(@"审核不通过:%@，请重新申请",self.models.refuseReason) ];
            }
        }
      
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
-(void)getProvinceUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:L_provinceUrl method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        if ([code intValue] == 200) {
            NSArray *data = responseObj[@"data"];
            [self.adressList removeAllObjects];
            [self.adressList addObjectsFromArray:data];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [JXUIKit showErrorWithStatus:@"接口地址报错"];
    }];
    
}
-(void)getRuleData{
    NSString *url = @"AppUserShopNotice";
    if(_status == RoleStatusPeisong){
        url = @"AppUserDeliveryClerkNotice";
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,url) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.content = data[@"content"];
        [self.tableView reloadData];
//        self.customNavBar.title = data[@"title"];
//        [self creatHtml:data[@"content"]];
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}

-(void)clcik{
    LLWebViewController *vc = [[LLWebViewController alloc]init];
    vc.isHiddenNavgationBar = YES;
    vc.htmlStr = @"AppServiceAgreement";
    vc.name = @"服务协议";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)postUrl{
    if(_status == RoleStatusPeisong){
        if([self.contentArr[0][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请输入姓名"];;
            return;;
        }
        if([self.contentArr[0][1] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择性别"];;
            return;;
        }
        if([self.contentArr[0][2] length] != 11){
            [JXUIKit showErrorWithStatus:@"请输入正确的手机号"];;
            return;;
        }
        if([self.contentArr[0][3] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请输入身份证号"];;
            return;;
        }
        if([self.contentArr[0][4] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择所在地区"];;
            return;;
        }
        if([self.contentArr[1][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择身份证正面照片"];;
            return;;
        }
        if([self.contentArr[2][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择身份证反面照片"];;
            return;;
        }
        if([self.contentArr[3][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择近期自拍照"];;
            return;;
        }
    }else{
        if([self.contentArr[0][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请输入店铺名称"];;
            return;;
        }
        if([self.contentArr[0][1] length] != 11){
            [JXUIKit showErrorWithStatus:@"请输入正确的手机号"];;
            return;;
        }
        if([self.contentArr[0][2] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择所在地区"];;
            return;;
        }
        if([self.contentArr[0][3] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择所在位置"];;
            return;;
        }
        if([self.contentArr[1][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择店面照片"];;
            return;;
        }
        if([self.contentArr[2][0] length] <= 0){
            [JXUIKit showErrorWithStatus:@"请选择营业执照片"];;
            return;;
        }
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *lat = [[NSUserDefaults standardUserDefaults]objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults]objectForKey:@"lng"];
    NSString *url = L_apiappusershopapply;
    if(_status == RoleStatusPeisong){
        url = L_apiappuserdeliveryapply;
        [params setValue:self.contentArr[0][5] forKey:@"address"];
        [params setValue:self.area forKey:@"area"];
        [params setValue:self.contentArr[0][1] forKey:@"gender"];
        [params setValue:self.city forKey:@"city"];
        [params setValue:self.contentArr[3][0] forKey:@"photo"];
        [params setValue:self.contentArr[0][0] forKey:@"realName"];
        [params setValue:self.province forKey:@"province"];
        [params setValue:self.contentArr[0][3] forKey:@"certificatesNumber"];
        [params setValue:self.contentArr[0][2] forKey:@"telePhone"];
        [params setValue:self.contentArr[1][0] forKey:@"certificatesFront"];
        [params setValue:self.contentArr[2][0] forKey:@"certificatesReverse"];

        
    }else{
        [params setValue:self.contentArr[0][3] forKey:@"address"];
        [params setValue:self.area forKey:@"area"];
        [params setValue:self.contentArr[2][0] forKey:@"businessLicense"];
        [params setValue:self.city forKey:@"city"];
//        [params setValue:lat forKey:@"latitude"];
//        [params setValue:lng forKey:@"longitude"];
        if(lat.length > 0 && lng.length > 0){
            [params setValue:lat forKey:@"latitude"];
            [params setValue:lng forKey:@"longitude"];
        }
        [params setValue:self.contentArr[0][0] forKey:@"name"];
        [params setValue:self.province forKey:@"province"];
        [params setValue:self.contentArr[1][0] forKey:@"shopPhoto"];
        [params setValue:self.contentArr[0][1] forKey:@"telePhone"];
    }
    if(self.models){
        [params setValue:self.models.ID forKey:@"id"];
    }
    WS(weakself);
    [XJHttpTool post:url method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
           [UserModel saveInfo];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
-(void)setLayout{
    WS(weakself);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SCREEN_top);
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.bottom.equalTo(weakself.boView.mas_top).equalTo(-CGFloatBasedI375(10));
    }];
    [self.boView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.height.equalTo(DeviceXTabbarHeigh(49));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGFloatBasedI375(6));
        make.left.mas_equalTo(CGFloatBasedI375(15));
        make.right.mas_equalTo(-CGFloatBasedI375(15));
        make.height.offset(CGFloatBasedI375(37));
    }];
    self.tableView.tableHeaderView = self.showImage;
}
static NSString *const LLIntroPointCellid = @"LLIntroPointCell";
static NSString *const LLIntroPointPicCellid = @"LLIntroPointPicCell";
static NSString *const LLIntroPointPicCell1id = @"LLIntroPointPicCell1";
-(void)getCellData:(NSString *)content indexs:(NSIndexPath*)indextag{
    self.contentArr[indextag.section][indextag.row] = content;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_status == RoleStatusPeisong){
        if(section == 0){
            return 6;
        }
        return 1;
    }
    if(section == 0){
        return 4;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_status == RoleStatusPeisong){
        return 4;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return CGFloatBasedI375(44);
    }
    return CGFloatBasedI375(110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(_status == RoleStatusPeisong){
        if(section != 3){
            return 0.001;
        }
        return CGFloatBasedI375(80);
    }
    if(section != 2){
        return 0.001;
    }
    return CGFloatBasedI375(80);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(10))];
    
    return header;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(_status == RoleStatusPeisong){
        if(section != 3){
            return nil;
        }
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(80))];
        header.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        UILabel *titles = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#666666"] textAlignment:NSTextAlignmentLeft numberOfLines:0 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@""];
        if(_status == RoleStatusPeisong){
            titles.text = @"";
            
        }
        titles.text = self.content;
        [header addSubview:titles];
        [titles mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(CGFloatBasedI375(15));
            make.bottom.offset(-CGFloatBasedI375(5));
            make.right.offset(-CGFloatBasedI375(15));
            
        }];
        return header;
    }
    if(section != 2){
        return nil;
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(80))];
    header.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    UILabel *titles = [JXUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor colorWithHexString:@"#666666"] textAlignment:NSTextAlignmentLeft numberOfLines:0 fontSize:CGFloatBasedI375(14) font:[UIFont systemFontOfSize:CGFloatBasedI375(14)] text:@"推广点须知：这里是推广点申请须知说明，请在后台自由配置，这里是推广点申请须知说明，请在后台自由配置。这里是推广点申请须知说明，请在后台自由配置。"];
//    if(_status == RoleStatusPeisong){
//        titles.text = @"配送员须知：这里是配送员申请须知说明，请在后台自由配置，这里是配送员申请须知说明，请在后台自由配置。这里是配送员申请须知说明，请在后台自由配置。";
//
//    }
    titles.text = self.content;
    [header addSubview:titles];
    [titles mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(CGFloatBasedI375(15));
        make.bottom.offset(-CGFloatBasedI375(5));
        make.right.offset(-CGFloatBasedI375(15));
    }];
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    if(indexPath.section == 0){
        LLIntroPointCell *cell = [tableView dequeueReusableCellWithIdentifier:LLIntroPointCellid];
        if(_status == RoleStatusPeisong){
            cell.btnTags = self.contentArr[indexPath.section][indexPath.row];;
            cell.getblock = ^(NSInteger tags, NSString * _Nonnull name) {
                weakself.contentArr[indexPath.section][indexPath.row] = FORMAT(@"%ld",tags);
            };
        }
        cell.indexPath = indexPath;
        cell.status = _status;
        cell.indexs = indexPath.row;
        cell.delegate = self;
        cell.model = self.models;
        cell.detailsLabel.text = self.contentArr[indexPath.section][indexPath.row];

        cell.conTX.text = self.contentArr[indexPath.section][indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        LLIntroPointPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLIntroPointPicCellid];
        cell.status = _status;
        cell.model = _models;
        cell.images =  self.contentArr[indexPath.section][indexPath.row];
        if(_status == RoleStatusPeisong){
            cell.titlelable.text = @"身份证正面(请上传身份证正面照片)";
        }else{
            cell.titlelable.text = @"店面照片";
        }
        cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
            weakself.contentArr[indexPath.section][indexPath.row] = pic;
            
        };
        return cell;
    }else{
        if(self.status == RoleStatusPeisong){
            if (indexPath.section == 2){
               LLIntroPointPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLIntroPointPicCellid];
               cell.status = _status;
               cell.model = _models;
               cell.images =  self.contentArr[indexPath.section][indexPath.row];
                cell.titlelable.text = @"身份证反面(请上传身份证背面照片)";
               cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                   weakself.contentArr[indexPath.section][indexPath.row] = pic;
                   
               };
               return cell;
           }
            LLIntroPointPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLIntroPointPicCellid];
            cell.status = _status;
            cell.model = _models;
            cell.images =  self.contentArr[indexPath.section][indexPath.row];
             cell.titlelable.text = @"自拍照(请上传近期自拍照)";
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.contentArr[indexPath.section][indexPath.row] = pic;
                
            };
            return cell;
        }else{
            LLIntroPointPicCell*cell = [tableView dequeueReusableCellWithIdentifier:LLIntroPointPicCell1id];
            cell.status = _status;
            cell.model = _models;
            cell.images =  self.contentArr[indexPath.section][indexPath.row];
            if(_status != RoleStatusPeisong){
                cell.titlelable.text = @"营业执照";
            }
            cell.selectBlock = ^(NSArray * _Nonnull image, NSString * _Nonnull pic, CGFloat heights) {
                weakself.contentArr[indexPath.section][indexPath.row] = pic;
                
            };
            return cell;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.models.status == 1|| self.models.status == 2){
        return;;
    }
    if(_status == RoleStatusPeisong){
        if((indexPath.section == 0 && indexPath.row == 4) || (indexPath.section == 0 && indexPath.row == 5)){
//            if(self.adressList.count > 0){
//                self.adressView.type = 0;
//                self.adressView.dataArray = self.adressList;
//                self.adressView.index = 0;
//                [self.adressView show];
//            }else{
//                [self getProvinceUrl];
//            }
            WS(weakself);
            LLMapChoiceViewController *vc = [[LLMapChoiceViewController alloc]init];
            vc.choicePoi = ^(AMapPOI * _Nonnull poi) {
                weakself.province = poi.province;
                weakself.city =poi.city;
                weakself.area = poi.district;
                NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",weakself.province,weakself.city,weakself.area];
                NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:3 inSection:0]; //刷新第0段第2行
                if(weakself.status == RoleStatusPeisong){
                    indexPathTT = [NSIndexPath indexPathForRow:4 inSection:0]; //刷新第0段第2行
                    LLIntroPointCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPathTT];
                    cell.detailsLabel.text = areaStr;
                    cell.detailsLabel.textColor = Black_Color;
                    weakself.contentArr[indexPathTT.section][indexPathTT.row] = areaStr;
                    weakself.contentArr[0][5] = poi.name;
                    LLIntroPointCell *cell1 = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
                    cell1.detailsLabel.text = poi.name;
                    cell1.detailsLabel.textColor = Black_Color;
                    weakself.contentArr[indexPathTT.section][indexPathTT.row] = areaStr;
                }else{
                    LLIntroPointCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPathTT];
                    cell.detailsLabel.text = areaStr;
                    cell.detailsLabel.textColor = Black_Color;
                    weakself.contentArr[indexPathTT.section][indexPathTT.row] = areaStr;
                }
     
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
    if(indexPath.section == 0 && indexPath.row == 2){

    }else if(indexPath.section == 0 && indexPath.row == 3){
        LLMapChoiceViewController *vc = [[LLMapChoiceViewController alloc]init];
        WS(weakself);
        vc.choicePoi = ^(AMapPOI * _Nonnull poi) {
            weakself.province = poi.province;
            weakself.city =poi.city;
            weakself.area = poi.district;
            NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",poi.province,poi.city,poi.district];
            weakself.contentArr[0][2]= areaStr;
            NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:2 inSection:0]; //刷新第0段第2行
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathTT,nil] withRowAnimation:UITableViewRowAnimationNone];
            weakself.contentArr[0][3]= poi.name;
            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    }
    
    
}
#pragma mark  懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[LLBaseTableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT)style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor  = [UIColor clearColor];
        [ _tableView  registerClass:[LLIntroPointCell class] forCellReuseIdentifier:LLIntroPointCellid];
        [ _tableView  registerClass:[LLIntroPointPicCell class] forCellReuseIdentifier:LLIntroPointPicCellid];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [ _tableView  registerClass:[LLIntroPointPicCell class] forCellReuseIdentifier:LLIntroPointPicCell1id];
        [self.view addSubview:self.tableView];
     
    }
    return _tableView;
}
-(UIImageView *)showImage{
    if (!_showImage) {
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFloatBasedI375(690))];
        _showImage.image =[UIImage imageNamed:@"ad_tgd"];
        if(_status == RoleStatusPeisong){
            _showImage.height = CGFloatBasedI375(1482);
            _showImage.image =[UIImage imageNamed:@"psysq"];
        }
        _showImage.userInteractionEnabled = YES;
        _showImage.clipsToBounds = YES;

    }
    return _showImage;
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
        _sureButton.layer.cornerRadius = CGFloatBasedI375(20);
        _sureButton.layer.masksToBounds = YES;
        [_sureButton setTitle:@"提交申请" forState:UIControlStateNormal];
        _sureButton.backgroundColor = Main_Color;
        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_sureButton addTarget:self action:@selector(postUrl) forControlEvents:UIControlEventTouchUpInside];
        [self.boView addSubview:self.sureButton];
    }
    return _sureButton;
}
-(AdressListView *)adressView{
    if (!_adressView) {
        _adressView = [[AdressListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WS(weakself);
        _adressView.adressBlock = ^(NSMutableDictionary *dict) {
            
            weakself.province = dict[@"provinceName"];
//            weakself.provinceId = dict[@"provinceId"];
            weakself.city = dict[@"cityName"];
//            weakself.cityId = dict[@"cityId"];
            weakself.area = dict[@"districtName"];
//            weakself.districtId = dict[@"districtId"];
            
            NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",weakself.province,weakself.city,weakself.area];
            NSIndexPath *indexPathTT = [NSIndexPath indexPathForRow:3 inSection:0]; //刷新第0段第2行
            if(weakself.status == RoleStatusPeisong){
                indexPathTT = [NSIndexPath indexPathForRow:4 inSection:0]; //刷新第0段第2行
            }
            LLIntroPointCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPathTT];
            cell.detailsLabel.text = areaStr;
            cell.detailsLabel.textColor = Black_Color;
            weakself.contentArr[indexPathTT.section][indexPathTT.row] = areaStr;
//            [weakself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathTT,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    return _adressView;
}
-(NSMutableArray *)adressList{
    if(!_adressList){
        _adressList = [NSMutableArray array];
    }
    return _adressList;
}
-(void)clickTap:(UIButton *)sender{
    
}
-(NSMutableArray *)contentArr{
    if(!_contentArr){
        if(_status == RoleStatusPeisong){
            _contentArr = [NSMutableArray arrayWithArray:@[@[@"",@"1",@"",@"",@"选择所在地区",@"选择所在位置"].mutableCopy,@[@""].mutableCopy,@[@""].mutableCopy,@[@""].mutableCopy]];
            
        }else{
            _contentArr = [NSMutableArray arrayWithArray:@[@[@"",@"",@"",@"选择所在地区"].mutableCopy,@[@""].mutableCopy,@[@""].mutableCopy]];
        }
    }
    return _contentArr;
}
@end
