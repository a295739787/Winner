//
//  LLOrderApplymarkController.m
//  Winner
//
//  Created by YP on 2022/1/26.
//

#import "LLOrderApplymarkController.h"
#import "LLAftermarkView.h"
#import "LLMeOrderListTableCell.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface LLOrderApplymarkController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LLAftermarkBottomView *bottomView;

@property (nonatomic,strong)NSMutableArray *selelctPhotos;
@property (nonatomic,strong)NSMutableArray *selelctAssets;
@property (nonatomic,strong)UIImagePickerController *imagePickerVC;


@end

@implementation LLOrderApplymarkController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"申请售后";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}
#pragma mark

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
    TZImagePickerController *imagePC = [[TZImagePickerController alloc]initWithMaxImagesCount:4 delegate:self];
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



#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LLMeOrderListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLMeOrderListTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goodsType = 100;
        
        return cell;
    }else if (indexPath.section == 1){
        LLOrderAftermarkTypeSelelctTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderAftermarkTypeSelelctTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftStr = @"售后类型";
        cell.rightStr = @"售后类型";
    
        
        return cell;
    }else if(indexPath.section == 2){
        LLOrderAftermarkTypeSelelctTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderAftermarkTypeSelelctTableCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftStr = @[@"货物状态",@"选择原因"][indexPath.row];
        cell.rightStr =  @[@"请选择",@"请选择"][indexPath.row];;
        
        return cell;
    }
    LLOrderAftermarkUploadImgTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLOrderAftermarkUploadImgTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WS(weakself);
    cell.openBlock = ^{
        [self openAlbum];
    };
    if (_selelctPhotos) {
        cell.selectPhotos = _selelctPhotos;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGFloatBasedI375(110);
    }else if (indexPath.section == 3){
        return CGFloatBasedI375(110 );
    }
    return CGFloatBasedI375(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFloatBasedI375(54);
    }else if(section == 2){
        return CGFloatBasedI375(75);
    }else if(section == 3){
        return CGFloatBasedI375(54);
    }
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        LLAftermarkView *headerView = [[LLAftermarkView alloc]initWithFrame:tableView.tableHeaderView.frame];
        headerView.isHidden = YES;
        return headerView;
    }else if (section == 2){
        LLAfertmarkTypeView *headerView = [[LLAfertmarkTypeView alloc]initWithFrame:tableView.tableHeaderView.frame];
        
        return headerView;
    }else if (section == 3){
        LLAftermarkView *headerView = [[LLAftermarkView alloc]initWithFrame:tableView.tableHeaderView.frame];
        headerView.isHidden = NO;
        return headerView;
    }
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top - SCREEN_Bottom - CGFloatBasedI375(50)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF2F2F2);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLOrderAftermarkUploadImgTableCell class] forCellReuseIdentifier:@"LLOrderAftermarkUploadImgTableCell"];
        [_tableView registerClass:[LLMeOrderListTableCell class] forCellReuseIdentifier:@"LLMeOrderListTableCell"];
        [_tableView registerClass:[LLOrderAftermarkTypeSelelctTableCell class] forCellReuseIdentifier:@"LLOrderAftermarkTypeSelelctTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(LLAftermarkBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LLAftermarkBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_Bottom - CGFloatBasedI375(50), SCREEN_WIDTH, CGFloatBasedI375(50) + SCREEN_Bottom)];
    }
    return _bottomView;
}

-(NSMutableArray *)selelctPhotos{
    if (!_selelctPhotos) {
        _selelctPhotos = [[NSMutableArray alloc]init];
    }
    return _selelctPhotos;
}
-(NSMutableArray *)selelctAssets{
    if (!_selelctAssets) {
        _selelctAssets = [[NSMutableArray alloc]init];
    }
    return _selelctAssets;
}
-(UIImagePickerController*)imagePickerVC{
    if (!_imagePickerVC) {
        _imagePickerVC = [[UIImagePickerController alloc]init];
        _imagePickerVC.delegate = self;
    }
    return _imagePickerVC;
}

@end
