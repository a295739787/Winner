//
//  LLEvaulateViewController.m
//  Winner
//
//  Created by YP on 2022/3/15.
//

#import "LLEvaulateViewController.h"
#import "LLEvaluteHeaderView.h"
#import "LLFeedbackInoutTableCell.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "LLMeOrderDetailHeaderView.h"

@interface LLEvaulateViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LLEvaluteHeaderViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *evaulateBtn;

@property (nonatomic,strong)NSMutableArray *selelctPhotos;
@property (nonatomic,strong)NSMutableArray *selelctAssets;
@property (nonatomic,strong)UIImagePickerController *imagePickerVC;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *asstesArray;
@property (nonatomic,strong) NSMutableArray *imageeList;/** <#class#> **/

@property (assign, nonatomic) NSInteger currentIndex;
@property (nonatomic,strong)NSMutableArray *contentArray;


@end

@implementation LLEvaulateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(LLappOrderListGoodsVos *mode in _model.appOrderListGoodsVos){
        [self.contentArray addObject:@{}];
    }
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"评价";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.evaulateBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_top);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom - CGFloatBasedI375(44));
    }];
    
    [self.evaulateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SCREEN_Bottom);
        make.height.mas_equalTo(CGFloatBasedI375(44));
    }];
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.asstesArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.appOrderListGoodsVos.count; i++) {
        NSMutableArray * array = [[NSMutableArray alloc]init];
        [self.dataArray addObject:array];
        [self.asstesArray addObject:array];
    }
}
#pragma mark 仅退款
-(void)postMonData{
    __block BOOL isShow = NO;
    [self.contentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        NSArray *img = dic[@"image"];
        NSLog(@"img == %@",img);
        if(img.count > 0){
            isShow = YES;
            [self getlListImage:img indexs:0 tags:idx];
        }
    }];
    if(!isShow){
        [self postdatas];
    }
    [self.view endEditing:YES];
  
}
-(void)postdatas{
    NSMutableArray *img = [NSMutableArray array];
    NSMutableArray *titls = [NSMutableArray array];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSMutableArray *goodAs = [NSMutableArray array];

    [self.contentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        NSMutableDictionary *goodpram = [NSMutableDictionary dictionary];
        [goodpram setValue:dic[@"goodsId"] forKey:@"goodsId"];
        [goodpram setValue: dic[@"title"] forKey:@"content"];
        [goodpram setValue: dic[@"image"] forKey:@"images"];
        NSString *star = dic[@"star"];
        [goodpram setValue:star.length <= 0?@"5":star forKey:@"star"];
        [goodAs addObject:goodpram.mutableCopy];
    }];
    if(goodAs.count <= 0){
        return;;
    }
    [param setValue:goodAs forKey:@"appOrderEvaluateListForms"];
    [param setValue:_model.orderNo forKey:@"orderNo"];
    [XJHttpTool post:FORMAT(@"%@",L_apiappgoodstevaluateadd) method:POST params:param isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [JXUIKit showSuccessWithStatus:responseObj[@"msg"]];
        if(self.tapAction){
            self.tapAction();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
     
    }];
}
-(void)getlListImage:(NSArray *)aMessages indexs:( NSInteger)index tags:(NSInteger)tags{
    NSLog(@"index= %ld",index);
    __block NSInteger indexs = index;
    WS(weakself);
    if(aMessages.count > index){
        [XJHttpTool uploadWithImageArr:aMessages[index] url:FORMAT(@"%@%@",apiQiUrl,L_apifileUploaderimages) filename:@"" name:@"" mimeType:@"" parameters:@{} progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
                
            } success:^(id  _Nonnull response) {
                NSDictionary *dic = response[@"data"];
                NSMutableArray *temp = [NSMutableArray array];
                [temp addObject:dic[@"name"]];
                [weakself.imageeList addObject:dic[@"name"]];
                indexs++;
                [weakself getlListImage:aMessages indexs:indexs tags:tags];
            } fail:^(NSError * _Nonnull error) {
                
            }] ;
    }else{
        [MBProgressHUD hideHUD];
        [MBProgressHUD hideActivityIndicator];

        NSDictionary *dic = self.contentArray[tags];
        NSMutableDictionary *goodpram= [NSMutableDictionary dictionary];
        [goodpram setValue:dic[@"goodsId"] forKey:@"goodsId"];
        [goodpram setValue: dic[@"title"] forKey:@"title"];
        [goodpram setValue: [self.imageeList componentsJoinedByString:@","] forKey:@"image"];
        [goodpram setValue: dic[@"start"] forKey:@"star"];
        NSLog(@"dic == %@  goodpram == %@",dic,goodpram);
        [self.contentArray replaceObjectAtIndex:tags withObject:goodpram];
        if(self.contentArray.count-1 == tags){
            
            [self postdatas];
        }
   
    }
}

#pragma mark--evalusteBtnClick
-(void)evalusteBtnClick:(UIButton *)btn{
    
}
- (void)inputTableViewCell:(LLEvaluteHeaderView *)cell index:(NSIndexPath* )indexs content:(NSDictionary *)datas;{
    NSLog(@"indexs == %ld  datas == %@",indexs.section,datas);
    [self.contentArray replaceObjectAtIndex:indexs.section withObject:datas];
//    [self.tableView reloadData];
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return  _model.appOrderListGoodsVos.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLEvaluteHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:@"LLFeedbackInoutTableCell" forIndexPath:indexPath];
    cell.index = indexPath;
    cell.delegate = self;
    cell.famodel = _model;
    cell.model = _model.appOrderListGoodsVos[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.contentArray[indexPath.row];
    NSArray *datas = dic[@"image"];
    CGFloat heis = (SCREEN_WIDTH-CGFloatBasedI375(70))/4;
    if((datas.count > 4 &&  datas.count < 8) || datas.count ==4 ){
        return CGFloatBasedI375(193+100+heis+heis);
    }else if(datas.count >= 8){
        return CGFloatBasedI375(193+100+heis+heis+heis);
    }
    return CGFloatBasedI375(193+50+110);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(15);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LLmeOrderDetailInfoFooterView *footerView = [[LLmeOrderDetailInfoFooterView alloc]initWithFrame:tableView.tableFooterView.frame];
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    LLEvaluteHeaderView *headerView = [[LLEvaluteHeaderView alloc]initWithFrame:tableView.tableHeaderView.frame];
//    headerView.model =_model.appOrderListGoodsVos[section];
    return nil;
}

-(void)openCameraOrAlbum{
    
//    ChooseInfoView *choseInfoView = [[ChooseInfoView alloc]init];
//    choseInfoView.titleLab.text = @"选择图片";
//    WS(weakself);
//    [choseInfoView chooseHeadImgBlockBlock:^(NSInteger index) {
//
//        if (index == 1) {
//            //打开相机
//            [weakself openCamera];
//        }else{
//            //打开相册
//            [weakself openAlbum];
//        }
//    }];
    
    [self openAlbum];
}
#pragma mark--打开相机
-(void)openCamera{
    UIImagePickerControllerSourceType sourcrType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = sourcrType;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
            self.imagePickerVC.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        [self presentViewController:_imagePickerVC animated:YES completion:nil];
    }else{
        NSLog(@"模拟器无法打开照相机");
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        [[TZImageManager manager]savePhotoWithImage:image completion:^(NSError *error) {
//            if (error) {
//                NSLog(@"图片保存失败 %@",error);
//            }else{
//                [self openAlbum];
//                [picker dismissViewControllerAnimated:YES completion:nil];
//            }
//        }];
        [[TZImageManager manager] savePhotoWithImage:image completion:^(PHAsset *asset, NSError *error) {
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            }else{
                [self openAlbum];
                [picker dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}
#pragma mark--打开相册
-(void)openAlbum{
    TZImagePickerController *imagePC = [[TZImagePickerController alloc]initWithMaxImagesCount:3 delegate:self];
    imagePC.allowTakeVideo = NO;
    imagePC.allowPickingOriginalPhoto = NO;
    imagePC.selectedAssets = _selelctAssets;
    imagePC.modalPresentationStyle = UIModalPresentationPageSheet;
    WS(weakself);
    [imagePC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakself.selelctPhotos removeAllObjects];
        [weakself.selelctAssets removeAllObjects];
        
        weakself.selelctAssets = [[NSMutableArray alloc]initWithArray:assets];
        weakself.selelctPhotos = [[NSMutableArray alloc]initWithArray:photos];
        NSLog(@"=========555=========%@",weakself.dataArray);
        [weakself.dataArray replaceObjectAtIndex:weakself.currentIndex withObject:weakself.selelctPhotos];
        [weakself.asstesArray replaceObjectAtIndex:weakself.currentIndex withObject: weakself.selelctAssets];
        
        [weakself.tableView reloadData];
    }];
    [self presentViewController:imagePC animated:YES completion:nil];
}
#pragma mark--TZImagePickerControllerDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLEvaluteHeaderView class] forCellReuseIdentifier:@"LLFeedbackInoutTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(UIButton *)evaulateBtn{
    if (!_evaulateBtn) {
        _evaulateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _evaulateBtn.backgroundColor = [UIColor whiteColor];
        [_evaulateBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        [_evaulateBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
        _evaulateBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
        [_evaulateBtn addTarget:self action:@selector(postMonData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaulateBtn;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)asstesArray{
    if (!_asstesArray) {
        _asstesArray = [[NSMutableArray alloc]init];
    }
    return _asstesArray;
}
-(NSMutableArray *)contentArray{
    if(!_contentArray){
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}
-(NSMutableArray *)imageeList{
    if(!_imageeList){
        _imageeList = [NSMutableArray array];
    }
    return _imageeList;
}
@end
