//
//  LLDyPicView.m
//  LLPensionProject
//
//  Created by lijun L on 2019/7/14.
//  Copyright © 2019年 lijun L. All rights reserved.
//


#import "LLReturnPicView.h"

@interface LLReturnPicView()<DWQImagePickerSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,JJPhotoDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIView     *boxView;
@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) DWQImagePickerSheet *imgPickerActionSheet;
@property (nonatomic, strong) UICollectionView *pickerCollectionView;
@property (nonatomic,strong) NSMutableArray *arrSelected;
@property (nonatomic,strong) NSMutableArray *bigImgDataArray;
@property (nonatomic,strong) NSArray *getBigImageArray;
@property (nonatomic,strong) NSArray *bigImageArray;
@property (nonatomic,strong) NSMutableArray *images;/** class **/
@property (nonatomic,assign) NSInteger maxCount;
@property (nonatomic,strong) NSMutableArray *imageArray;

@end
@implementation LLReturnPicView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor =White_Color;
        self.maxCount = 9;
        [self addSubview:self.boxView];
        [self.boxView addSubview:self.pickerCollectionView];
        [self setLayout];
    }
    return self;
}
#define btnHeight (SCREEN_WIDTH-CGFloatBasedI375(80))/5
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.height.offset(btnHeight);
        make.right.offset(CGFloatBasedI375(0));
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.pickerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.right.offset(CGFloatBasedI375(0));
        make.bottom.offset(CGFloatBasedI375(0));
        
        make.top.offset(CGFloatBasedI375(0));

    }];
}
-(void)setIsEdits:(BOOL)isEdits{
    _isEdits = isEdits;
}
-(void)setDatas:(NSArray *)datas{
    _datas = datas;
    [self.imageArray removeAllObjects];
    [self.imageArray addObjectsFromArray:_datas];
    [self.pickerCollectionView reloadData];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_datas.count && !_isEdits){
        return  self.imageArray.count;
    }
    return self.imageArray.count==self.maxCount?self.imageArray.count:self.imageArray.count+1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"DWQPhotoCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"DWQPhotoCell"];
    DWQPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"DWQPhotoCell" forIndexPath:indexPath];
 
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 4.0f;
    cell.backgroundColor = [UIColor clearColor];
    cell.profilePhoto .userInteractionEnabled = YES;
    cell.BigImgView.userInteractionEnabled = YES;
    if (indexPath.row ==  self.imageArray.count) {
        if(_maxCount ==   self.imageArray.count){
            cell.profilePhoto.hidden = YES;
            cell.closeButton.hidden = YES;
        }else{
            cell.profilePhoto.hidden = NO;

            [cell.profilePhoto setImage:[UIImage imageNamed:@"upload"]];
        }
        cell.closeButton.hidden = YES;
    }
    else{
        NSString *imageStr = self.imageArray[indexPath.item];
        if([imageStr isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic =self.imageArray[indexPath.item];
            [cell.profilePhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
            
        }else    if([imageStr isKindOfClass:[UIImage class]]){
            [cell.profilePhoto setImage:self.imageArray[indexPath.item]];
        }else{
            [cell.profilePhoto sd_setImageWithUrlString:self.imageArray[indexPath.item]];
        }
        cell.closeButton.hidden = NO;
        cell.profilePhoto.hidden = NO;
        
    }
    [cell setBigImgViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    if(_datas.count && !_isEdits){
        cell.closeButton.hidden = YES;
        cell.closeButton.enabled = NO;
    }
    return cell;
}
#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    if(_datas.count && !_isEdits){
        return;;
    }
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    [self.pickerCollectionView reloadData];
    if(self.selectBlock){
        self.selectBlock(self.imageArray.mutableCopy, [self.imageArray componentsJoinedByString:@","], CGFloatBasedI375(65)*1);
    }
    if((self.imageArray.count > 4 &&  self.imageArray.count < 8) || self.imageArray.count == 4){
        [self.boxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(btnHeight+btnHeight+10);
        }];
    }else if(self.imageArray.count >= 8){
        [self.boxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(btnHeight+btnHeight+btnHeight+30);
        }];
    }else{
        [self.boxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(btnHeight);
        }];
    }
}
#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UIGestureRecognizer *)gestureRecognizer{
    [self endEditing:YES];
  
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    //
    if (index == ( self.imageArray.count)) {
        if(_datas.count && !_isEdits){
            return;;
        }
        [self endEditing:YES];
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        DWQPhotoCell *cell = (DWQPhotoCell*)[_pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
        if (!cell.BigImgView || !cell.BigImgView.image) {
            
            if([self.imageArray[index] isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = self.imageArray[index];
                [cell setBigImgViewWithImage:[self getImageFromURL:dic[@"img"]]];
            }else if([self.imageArray[index] isKindOfClass:[UIImage class]]){
                [cell setBigImgViewWithImage:self.imageArray[index]];
            }else{
                NSString *problemImages;
                if([self.imageArray[index]  containsString:@"http"]){
                    problemImages =[NSString stringWithFormat:@"%@",self.imageArray[index] ];
                }else{
                    problemImages =[NSString stringWithFormat:@"%@%@",API_IMAGEHOST,self.imageArray[index] ];
                }
                [cell setBigImgViewWithImage:[self getImageFromURL:problemImages]];
            }
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImgView] selecImageindex:0];
    }
}
-(UIImage *) getImageFromURL:(NSString *)fileURL{
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
    
        return result;
    
}
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}
//获得大图
- (NSArray*)getBigImageArrayWithALAssetArray:(NSArray*)ALAssetArray{
    _bigImgDataArray = [NSMutableArray array];
    NSMutableArray *bigImgArr = [NSMutableArray array];
    for (ALAsset *set in ALAssetArray) {
        [bigImgArr addObject:[self getBigIamgeWithALAsset:set]];
    }
    _bigImageArray = bigImgArr;
    return _bigImgDataArray;
}
- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [_bigImgDataArray addObject:imageData];
    
    return [UIImage imageWithData:imageData];
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(btnHeight ,btnHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{return UIEdgeInsetsMake(CGFloatBasedI375(0), CGFloatBasedI375(0), CGFloatBasedI375(0), CGFloatBasedI375(0));//分别为上、左、下、右
    
}
    
#pragma mark - 选择图片
- (void)addNewImg{
    [self endEditing:YES];
    WS(weakself);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:weakself];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.hideWhenCanNotSelect = YES;
    imagePickerVc.oKButtonTitleColorNormal = Black_Color;
    imagePickerVc.barItemTextColor = Black_Color;
    imagePickerVc.iconThemeColor = Black_Color;
    imagePickerVc.naviTitleColor = Black_Color;
    imagePickerVc.oKButtonTitleColorDisabled = Black_Color;
//    imagePickerVc.selectedAssets =self.imageArray;
    // 相册选择照片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto){
        if (!photos[0]) {
            return ;
        }
        [self.imageArray removeAllObjects];
        [self.imageArray addObjectsFromArray:photos];
        if(self.selectBlock){
            self.selectBlock(self.imageArray.mutableCopy, [self.imageArray componentsJoinedByString:@","], CGFloatBasedI375(65)*1);
        }
//        [self uploadUrl];
//        [weakself getlListImage:self.imageArray indexs:0];
        
        if((self.imageArray.count > 4 &&  self.imageArray.count < 8) || self.imageArray.count == 4){

            [self.boxView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(btnHeight+btnHeight+10);
            }];
        }else if(self.imageArray.count >= 8){
            [self.boxView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(btnHeight+btnHeight+btnHeight+30);
            }];
        }else{
            [self.boxView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(btnHeight);
            }];
        }
        [self.pickerCollectionView reloadData];

          
    }];
        
    
    imagePickerVc.navigationBar.barTintColor = Main_Color;
    [[UIViewController getCurrentController] presentViewController:imagePickerVc animated:YES completion:nil];
//    if (!_imgPickerActionSheet) {
//        _imgPickerActionSheet = [[DWQImagePickerSheet alloc] init];
//        _imgPickerActionSheet.delegate = self;
//    }
//    if (_arrSelected) {
//        _imgPickerActionSheet.arrSelected = _arrSelected;
//    }
//    _imgPickerActionSheet.maxCount = 3;
//    [_imgPickerActionSheet showImgPickerActionSheetInView:[self controller]];
}

#pragma mark - 相册完成选择得到图片
-(void)getSelectImageWithALAssetArray:(NSArray *)ALAssetArray thumbnailImageArray:(NSArray *)thumbnailImgArray{
    //（ALAsset）类型 Array
    _arrSelected = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    [self.imageArray removeAllObjects];
    [self.imageArray addObjectsFromArray:thumbnailImgArray];
    [self.pickerCollectionView reloadData];
    WS(weakself);
            CGFloat count = 0;
    
//    if(self.imageArray.count %3 == 0){
//         count = self.imageArray.count/3;
//    }else{
//           count = self.imageArray.count/3+1;
//    }
//    if(self.imageArray.count >=3){
//           count = (self.imageArray.count/3+1)*CGFloatBasedI375(110);
//       }else{
//             count =CGFloatBasedI375(65);
//       }
//        [self.boxView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(CGFloatBasedI375(0));
//            make.height.offset(count);
//            make.right.offset(CGFloatBasedI375(0));
//            make.centerY.equalTo(weakself.mas_centerY);
//        }];
//        [self.pickerCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(CGFloatBasedI375(0));
//            make.right.offset(CGFloatBasedI375(0));
//            make.bottom.offset(CGFloatBasedI375(0));
//
//            make.top.offset(CGFloatBasedI375(0));
//
//        }];
    [self layoutIfNeeded];
//    CGRect rect = self.frame;
//    rect.size.height = self.boxView.BottomY+CGFloatBasedI375(10);
//    self.frame = rect;
    if(self.selectBlock){
        self.selectBlock(self.imageArray.mutableCopy, @"", CGFloatBasedI375(65)*count);
    }
}


-(UICollectionView *)pickerCollectionView{
    if(!_pickerCollectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumInteritemSpacing = CGFloatBasedI375(0);
        flowLayout.minimumLineSpacing = CGFloatBasedI375(0);
        
        self.pickerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, self.boxView.height) collectionViewLayout:flowLayout];
        
        self.pickerCollectionView.delegate=self;
        self.pickerCollectionView.dataSource=self;
        self.pickerCollectionView.backgroundColor = [UIColor clearColor];
        
        if(_bigImageArray.count == 0) {
            _bigImageArray = [NSMutableArray array];
        }
        if(_bigImageArray.count == 0){
            _bigImageArray = [NSMutableArray array];
        }
        _pickerCollectionView.scrollEnabled = NO;
    }
    return _pickerCollectionView;
}
- (UIView *)boxView{
    if (!_boxView) {
        _boxView = [[UIView alloc]init];;
        _boxView.backgroundColor = White_Color;
    }
    return _boxView;
}

-(NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)arrSelected{
    if(!_arrSelected){
        _arrSelected = [NSMutableArray array];
    }
    return _arrSelected;
}
- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
    }
    return   _imagePickerController;
}

@end
