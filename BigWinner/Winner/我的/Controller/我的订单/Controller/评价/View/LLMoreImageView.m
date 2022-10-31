//
//  LLMoreImageView.m
//  LLPensionProject
//
//  Created by lijun L on 2019/7/12.
//  Copyright © 2019年 lijun L. All rights reserved.
//

#import "LLMoreImageView.h"
@interface LLMoreImageView ()<JJPhotoDelegate>
@property (nonatomic,strong) NSMutableArray *datas;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *imageArray;/** <#class#> **/
@property (nonatomic,strong) NSMutableArray *imageViewArray;/** <#class#> **/
@property (nonatomic, strong) NSArray *imageViewsArray;
@property (nonatomic, assign) CGFloat width;

@end
@implementation LLMoreImageView
- (void)setHeights:(CGFloat)heights{
    _heights = heights;
    
}
//- (instancetype)initWithModel:(LLGoodModel*)model{
//    
//}

- (void)setData:(NSArray *)data{
    _data = data;
//    [self.datas removeAllObjects];
//    [self.datas addObjectsFromArray:_data];
    //    删除缓存中的view
    for (UIImageView *imageView in self.subviews) {
        [imageView removeFromSuperview];
    }
    NSInteger couns = 0;
    CGFloat widths = 0;
    CGFloat hei = 0;
    if(_data.count > 3){
        couns = 2;
        widths =(SCREEN_WIDTH-CGFloatBasedI375(32*5)-CGFloatBasedI375(4))/couns;
    }else{
        couns = 1;

        if(_heights == 0){
            hei = (SCREEN_WIDTH-CGFloatBasedI375(40))/couns;
            widths = (SCREEN_WIDTH-CGFloatBasedI375(40))/couns;
        }else{
            hei = _heights-CGFloatBasedI375(0);
            widths = CGFloatBasedI375(200);
        }
    }
    [self.imageViewArray removeAllObjects];
    [self.imageArray removeAllObjects];

    for (int i = 0; i < _data.count; i++) {
        CGFloat w = (SCREEN_WIDTH-CGFloatBasedI375(40))/3;
        CGFloat h = w;
        CGFloat x = CGFloatBasedI375(10)+(w + CGFloatBasedI375(10))*(i%3);
        CGFloat y = 0+(h + CGFloatBasedI375(10))*(i/3);

        UIImageView *showImgae = [[UIImageView alloc]init];
        showImgae.frame = CGRectMake(x, y, w, h);
        showImgae.tag = i;
        showImgae.layer.masksToBounds = YES;
        showImgae.layer.cornerRadius = CGFloatBasedI375(5);
        showImgae.contentMode = UIViewContentModeScaleAspectFill;
        NSString *problemImages =[NSString stringWithFormat:@"%@%@",apiQiUrl,_data[i]];
        [showImgae sd_setImageWithUrlString:FORMAT(@"%@",_data[i]) placeholderImage:[UIImage imageNamed:morenpic]];
        [self addSubview:showImgae];
        [self.imageArray addObject:problemImages];
        [self.imageViewArray addObject:showImgae];
        showImgae.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showpic:)];
        [showImgae addGestureRecognizer:tap];

    }
}

//聊天图片放大浏览
-(void)showpic:(UITapGestureRecognizer *)tap
{
    NSLog(@"imageViewArray == %@  imageArray == %@",self.imageViewArray,self.imageArray);
    NSInteger view = tap.view.tag;
    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    mg.delegate = self;
    [mg showNetworkPhotoViewer:self.imageViewArray urlStrArr:self.imageArray selecImageindex:view];
    
    
}
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}


-(NSMutableArray *)datas{
    if(!_datas){
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)imageViewArray{
    if(!_imageViewArray){
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}


- (instancetype)initWithWidth:(CGFloat)width{
    if (self = [super init]) {
        NSAssert(width>0, @"请设置图片容器的宽度");
        self.width = width;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];

    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i <20; i++) {
        UIImageView *imageView = [UIImageView new];
        
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}

- (CGFloat)setupPicUrlArray:(NSArray *)picUrlArray{
    _picUrlArray = picUrlArray;
    
    for (long i = _picUrlArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picUrlArray.count == 0) {
        return 0;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picUrlArray];
    CGFloat itemH = itemW;
    
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picUrlArray];
    CGFloat margin = 5;
    
    for (int i = 0; i< _picUrlArray.count; i++) {
        NSURL *obj     =  _picUrlArray[i];
        long columnIndex = i % perRowItemCount;
        long rowIndex    = i / perRowItemCount;
        
        UIImageView *imageView = self.imageViewsArray[i];
        if(_picUrlArray.count > 1){
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }else{
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:obj placeholderImage:[UIImage imageNamed:@"workgroup_img_defaultPhoto"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.width < itemW || image.size.height < itemW) {
                imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
            
        }
         ];
        
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        
    }
    
    int columnCount = ceilf(_picUrlArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    
    return h;
}
//- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
//{
//    _picPathStringsArray = picPathStringsArray;
//
//    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
//        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
//        imageView.hidden = YES;
//    }
//
//    if (_picPathStringsArray.count == 0) {
//        self.height = 0;
////        self.fixedHeight = @(0);
//        return;
//    }
//
//    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
//    CGFloat itemH = 0;
//    if (_picPathStringsArray.count == 1) {
//        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
//        if (image.size.width) {
//            itemH = image.size.height / image.size.width * itemW;
//        }
//    } else {
//        itemH = itemW;
//    }
//    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
//    CGFloat margin = 5;
//
//    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        long columnIndex = idx % perRowItemCount;
//        long rowIndex = idx / perRowItemCount;
//        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
//        imageView.hidden = NO;
//        imageView.image = [UIImage imageNamed:obj];
//        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
//    }];
//
//    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
//    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
//    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
//    self.width = w;
//    self.height = h;
//}

#define kGAP CGFloatBasedI375(5)
#define kThemeColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define kAvatar_Size 40
-(void)setSingleHeight:(CGFloat)singleHeight{
    _singleHeight = singleHeight;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    NSLog(@"111");
}
-(void)setCircle_type:(NSInteger)circle_type{
    _circle_type = circle_type;
}
- (void)setPicUrlArray:(NSArray *)picUrlArray{

    _picUrlArray = picUrlArray;
    [self.imageViewArray removeAllObjects];
    [self.imageArray removeAllObjects];
//    [self setup];
    for(NSInteger i =0;i<_picUrlArray.count;i++){
        if([_picUrlArray[i] containsString:@"http"]){
            NSString *problemImages =[NSString stringWithFormat:@"%@",_picUrlArray[i]];
            [self.imageArray addObject:problemImages];
        }else{
            NSString *problemImages =[NSString stringWithFormat:@"%@%@",apiQiUrl,_picUrlArray[i]];
            [self.imageArray addObject:problemImages];
        }
    }
    for (long i = _picUrlArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picUrlArray.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picUrlArray];
    CGFloat itemH =  [self itemHeightForPicPathArray:_picUrlArray];
//
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picUrlArray];
    CGFloat margin = CGFloatBasedI375(10);
    CGFloat jgg_width = SCREEN_WIDTH-2*kGAP-kAvatar_Size-50;

    CGFloat imageWidth = (SCREEN_WIDTH-CGFloatBasedI375(70+10))/3;
    CGFloat imageHeight =  imageWidth;
    int columnCount = ceilf(_picUrlArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    if (_picUrlArray.count == 1) {
        NSString *problemImages =[NSString stringWithFormat:@"%@%@",apiQiUrl,_picUrlArray[0]];
        if([_picUrlArray[0] containsString:@"http"]){
            problemImages =[NSString stringWithFormat:@"%@",_picUrlArray[0]];
        }else{
            problemImages =[NSString stringWithFormat:@"%@%@",apiQiUrl,_picUrlArray[0]];
        }
        NSArray *array = [problemImages componentsSeparatedByString:@":"];
        NSString *datastr = [array lastObject];
        array = [datastr componentsSeparatedByString:@"_"];
        CGFloat wdths = [[array firstObject] floatValue];
        CGFloat heihts = [[array lastObject] floatValue];
        CGFloat roadi  = 3;
        CGFloat totolWidth = SCREEN_WIDTH-CGFloatBasedI375(50);
        itemW =totolWidth/3;
        itemH =heihts*itemW/wdths;
    
//        if(heihts > 0&& wdths > 0){
//            if(heihts > wdths *6){
//                itemH =  CGFloatBasedI375(150);
//                itemW = itemH *wdths/heihts;
//            }else if (heihts > wdths *roadi){
//                itemW =totolWidth/2;
//                itemH = itemW *5/3;
//            }else if (heihts == wdths){
//                itemW =totolWidth*2/3;
//                itemH = itemW;
//            }else if (heihts > wdths*1.7){
//                itemW =totolWidth/8*3;
//                itemH = heihts*itemW/wdths;
//            }else if (heihts < wdths){
//                itemW =totolWidth*2/3;
//                itemH =itemW*heihts/wdths;
//            }else{
//
//            }
//
//        }else{
//            heihts = CGFloatBasedI375(150);
//            wdths = heihts;
//        }
        if(_isPraise){//评价进来
            itemH = itemW;
        }
        NSLog(@"itemH == %f",itemH);
        imageWidth =itemW;
        imageHeight = itemH;
        h = columnCount * itemH + (columnCount - 1) * margin;
    } else {
        itemH = itemW;
    }

    WS(weakself);
    for (int i = 0; i< _picUrlArray.count; i++) {
        NSURL *obj     = [NSURL URLWithString:FORMAT(@"%@%@",API_IMAGEHOST, _picUrlArray[i])];
        if([_picUrlArray[i] containsString:@"http"]){
            obj     = [NSURL URLWithString:FORMAT(@"%@", _picUrlArray[i])];
        }else{
            obj     = [NSURL URLWithString:FORMAT(@"%@%@",API_IMAGEHOST, _picUrlArray[i])];
        }
        UIImageView *imageView = self.imageViewsArray[i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = CGFloatBasedI375(5);
        imageView.hidden = NO;
//        imageView.backgroundColor = Red_Color;
        [self.imageViewArray addObject:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showpic:)];
        [imageView addGestureRecognizer:tap];
        imageView.frame =CGRectMake(0+(imageWidth + CGFloatBasedI375(10))*(i%3),0+(imageWidth + CGFloatBasedI375(10))*(i/3),imageWidth, imageHeight);
        [imageView sd_setImageWithURL:obj placeholderImage:[UIImage imageNamed:morenpic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.image = image;
        }
         ];
    }
    if(_picUrlArray.count <= 0){
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(h);
    }];
    }

 
}
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark - 图片压缩方法
-( UIImage *)imageWithImageSimple:( UIImage *)image scaledToSize:( CGSize )newSize{
    
    
    UIGraphicsBeginImageContext (newSize);
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:FORMAT(@"%@%@",apiQiUrl, fileURL)]];
    
    result = [UIImage imageWithData:data];
    
    
    
    return result;
    
}

- (CGSize)neededSizeForPhoto:(CGSize)bubbleSize {

//bubbleSize  原尺寸

CGFloat maxWidth = SCREEN_WIDTH * 0.46;  //限制最大宽度或高度

CGFloat imageViewW = bubbleSize.width/2;
CGFloat imageViewH = bubbleSize.height/2;

CGFloat factor = 1.0f;

  if(imageViewW > imageViewH){

     if(imageViewW > maxWidth){

      factor = maxWidth/imageViewW;
      imageViewW = imageViewW*factor;
      imageViewH = imageViewH*factor;
     
    }else{

        if(imageViewH > maxWidth){

           factor = maxWidth/imageViewH;
           imageViewW = MAX(imageViewW*factor,46.0);  //限制宽度不能超过46.0
           imageViewH = imageViewH*factor;
   
          }

     }
  }
bubbleSize = CGSizeMake(imageViewW, imageViewH);

return bubbleSize;

}
//- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
//{
//    if (array.count == 1) {
//        return 120;
//    } else {
//        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
//        return w;
//    }
//}
//- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
//{
//
//    if (array.count < 3) {
//        return array.count;
//    } else if (array.count <= 4) {
//        return 2;
//    } else {
//        return 3;
//    }
//}
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array{
    if (array.count == 1) {
        return CGFloatBasedI375(150);
    } else {
        CGFloat itemW = (self.width -70) /3 ;
        return itemW;
    }
}
- (CGFloat)itemHeightForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 150;
    } else {
        CGFloat itemW = (self.width -70) /3 ;
        return itemW;
    }
}
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count == 4) {
        return 2;
    } else {
        return 3;
    }
}
@end
