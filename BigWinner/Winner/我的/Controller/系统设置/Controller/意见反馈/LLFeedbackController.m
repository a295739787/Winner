//
//  LLFeedbackController.m
//  Winner
//
//  Created by YP on 2022/1/25.
//

#import "LLFeedbackController.h"
#import "LLFeedbackSuccessController.h"
#import "LLFeedbackInoutTableCell.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface LLFeedbackController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *selelctPhotos;
@property (nonatomic,strong)NSMutableArray *selelctAssets;
@property (nonatomic,strong)UIImagePickerController *imagePickerVC;
@property (nonatomic,strong) NSMutableArray *imageeList;/** <#class#> **/

@property (nonatomic,strong)NSString *content;

@end

@implementation LLFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
#pragma mark--createUI
-(void)createUI{
    
    self.customNavBar.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
#pragma mark--requestUrl
-(void)requestUrl:(NSString *)name{
    LLFeedbackInoutTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:cell.textView.text forKey:@"content"];
    if (name) {
        [params setObject:name forKey:@"images"];
    }
    
    WS(weakself);
    [XJHttpTool post:L_feedVackUrl method:POST params:params isToken:YES success:^(id  _Nonnull responseObj) {
        
        NSString *code = responseObj[@"code"];
        [MBProgressHUD showSuccess:responseObj[@"msg"]];
        
        if ([code intValue] == 200) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LLFeedbackSuccessController *successVC = [[LLFeedbackSuccessController alloc]init];
                [weakself.navigationController pushViewController:successVC animated:YES];
            });
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark--feedbackBtnClick
-(void)feedbackBtnClick:(UIButton *)btn{
    LLFeedbackInoutTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    if ([cell.textView.text length] <= 0) {
        [JXUIKit showErrorWithStatus:@"请输入反馈内容"];
        return;
    }else{
        NSLog(@"self.selelctPhotos = %@",self.selelctPhotos);
        if (self.selelctPhotos.count > 0) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self getlListImage:self.selelctPhotos indexs:0 tags:0];
        }else{
            //没有图片
            [self requestUrl:nil];
        }
    }
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self requestUrl:[self.imageeList componentsJoinedByString:@","]];
        
   
    }
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLFeedbackInoutTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLFeedbackInoutTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleStr = @"反馈内容";
    cell.type = 0;
    WS(weakself);
    cell.inputBlock = ^(NSString * _Nonnull contentStr, NSInteger indexSection) {
        
    };
    cell.updateImgArrayBlock = ^(NSInteger deleteIndex, NSInteger indexSection) {
        
        [weakself.selelctPhotos removeObjectAtIndex:deleteIndex];
    };
    cell.openBlock = ^(NSInteger indexSection) {
        [self openAlbum];
    };
    if (_selelctPhotos) {
        cell.selectPhotos = _selelctPhotos;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFloatBasedI375(193);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFloatBasedI375(64);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:tableView.tableFooterView.frame];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *feedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    feedbackBtn.frame = CGRectMake(0, CGFloatBasedI375(20), SCREEN_WIDTH, CGFloatBasedI375(44));
    feedbackBtn.backgroundColor = [UIColor whiteColor];
    [feedbackBtn setTitle:@"立即反馈" forState:UIControlStateNormal];
    [feedbackBtn setTitleColor:UIColorFromRGB(0x443415) forState:UIControlStateNormal];
    feedbackBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(16)];
    [feedbackBtn addTarget:self action:@selector(feedbackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:feedbackBtn];
    
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFloatBasedI375(10);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_top, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_top) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF0EFED);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LLFeedbackInoutTableCell class] forCellReuseIdentifier:@"LLFeedbackInoutTableCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)imageeList{
    if(!_imageeList){
        _imageeList = [NSMutableArray array];
    }
    return _imageeList;
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
