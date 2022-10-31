//
//  LLIntroPointPicCell.m
//  Winner
//
//  Created by 廖利君 on 2022/3/6.
//

#import "LLIntroPointPicCell.h"
@interface LLIntroPointPicCell ()<DWQImagePickerSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,JJPhotoDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIView     *boxView;
@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) DWQImagePickerSheet *imgPickerActionSheet;
@property (nonatomic, strong) UICollectionView *pickerCollectionView;
@property (nonatomic,strong) NSMutableArray *arrSelected;
@property (nonatomic,strong) NSMutableArray *bigImgDataArray;
@property (nonatomic,strong) NSArray *getBigImageArray;
@property (nonatomic,strong) NSArray *bigImageArray;
//@property (nonatomic,strong) NSMutableArray *images;/** class **/
@property (nonatomic,assign) NSInteger maxCount;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIView *backView ;/** <#class#> **/
@property (nonatomic,assign) NSInteger *index ;/** <#class#> **/
@property (nonatomic,copy) NSString *str ;/** <#class#> **/

@end
@implementation LLIntroPointPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ============= 头部 =============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.maxCount = 3;
        [self setLayout];
    }
    return self;
}
#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
//    self.boxView.backgroundColor = Red_Color;
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(0));
        make.top.bottom.offset(CGFloatBasedI375(0));
        make.right.offset(CGFloatBasedI375(0));
    }];
    [self.titlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.top.offset(CGFloatBasedI375(15));
//        make.height.offset(CGFloatBasedI375(25));
    }];
    [self.pickerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(15));
        make.right.offset(-CGFloatBasedI375(15));
        make.bottom.offset(-CGFloatBasedI375(0));
        
        make.top.equalTo(weakself.titlelable.mas_bottom).offset(CGFloatBasedI375(10));

    }];
}
-(void)setModel:(LLGoodModel *)model{
    _model = model;
}
-(void)setImages:(NSString *)images{
    _images = images;
    [self.imageArray removeAllObjects];
    if(_images.length > 0){
        NSArray *titls = [_images componentsSeparatedByString:@","];
        [self.imageArray addObjectsFromArray:titls];
        if(_model.status == 1 || _model.status == 2){
          _maxCount = self.imageArray.count;
        }
        [self.pickerCollectionView reloadData];
    }
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count==3?self.imageArray.count:self.imageArray.count+1;
    
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
            
        }else{
            if([self.imageArray[indexPath.item] isKindOfClass:[UIImage class]]){
            [cell.profilePhoto setImage:self.imageArray[indexPath.item]];
            }else{
                [cell.profilePhoto sd_setImageWithUrlString:self.imageArray[indexPath.item]];
            }
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
    
    return cell;
}
#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    if(_model){
        return;;
    }
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    [self.pickerCollectionView reloadData];
    
}
#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UIGestureRecognizer *)gestureRecognizer{
    [self endEditing:YES];
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    //
    if (index == ( self.imageArray.count)) {
        [self endEditing:YES];
        if(_model.status == 1 || _model.status == 2){
            return;;
        }
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
            }else  if([self.imageArray[index] isKindOfClass:[NSString class]]){
                [cell setBigImgViewWithImage:[self getImageFromURL:self.imageArray[index]]];
            }else{
                [cell setBigImgViewWithImage:self.imageArray[index]];
            }
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImgView] selecImageindex:0];
    }
}
-(UIImage *) getImageFromURL:(NSString *)fileURL{
    if(![fileURL containsString:@"http"]){
        fileURL = FORMAT(@"%@%@",API_IMAGEHOST,fileURL);
    }
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
    return CGSizeMake(CGFloatBasedI375(65) ,CGFloatBasedI375(63));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{return UIEdgeInsetsMake(CGFloatBasedI375(0), CGFloatBasedI375(0), CGFloatBasedI375(0), CGFloatBasedI375(0));//分别为上、左、下、右
    
}
    
#pragma mark - 选择图片
- (void)addNewImg{
    [self endEditing:YES];
    WS(weakself);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:weakself];
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
        [self.pickerCollectionView reloadData];
        CGFloat count = 0;
        [self uploadUrl];

        
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
-(void)uploadUrl{
    [XJHttpTool uploadWithImageArr:self.imageArray[0] url:FORMAT(@"%@%@",apiQiUrl,L_apifileUploaderimages) filename:@"" name:@"" mimeType:@"" parameters:@{} progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
            
        } success:^(id  _Nonnull response) {
            NSDictionary *dic = response[@"data"];
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:dic[@"name"]];
            if(self.selectBlock){
                self.selectBlock(temp.mutableCopy, dic[@"name"], CGFloatBasedI375(65)*1);
            }
        } fail:^(NSError * _Nonnull error) {
            
        }] ;
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
    [XJHttpTool uploadWithImageArr:self.imageArray.mutableCopy url:L_apifileUploaderimages filename:@"" name:@"" mimeType:@"" parameters:@{} progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
            
        } success:^(id  _Nonnull response) {
            
        } fail:^(NSError * _Nonnull error) {
            
        }] ;
//    if(self.selectBlock){
//        self.selectBlock(self.imageArray.mutableCopy, @"", CGFloatBasedI375(65)*count);
//    }
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
        [self.boxView addSubview:self.pickerCollectionView];
    }
    return _pickerCollectionView;
}
- (UIView *)boxView{
    if (!_boxView) {
        _boxView = [[UIView alloc]init];;
        _boxView.backgroundColor = White_Color;
        [self.contentView addSubview:_boxView];
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
-(void)setStatus:(RoleStatus)status{
    _status = status;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable = [[UILabel alloc]init];
        _titlelable.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.textColor = [UIColor colorWithHexString:@"#443415"];
        _titlelable.text = @"自拍照 (请上传近期自拍照)";
        [self.boxView addSubview:self.titlelable];
        _titlelable.numberOfLines  = 0;
    }
    return _titlelable;
}
- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
    }
    return   _imagePickerController;
}

@end
