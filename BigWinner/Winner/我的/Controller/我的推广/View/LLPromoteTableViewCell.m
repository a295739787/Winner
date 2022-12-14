//
//  LLPromoteTableViewCell.m
//  Winner
//
//  Created by YP on 2022/1/22.
//

#import "LLPromoteTableViewCell.h"

@interface LLPromoteTableViewCell ()

@property (nonatomic,strong)UIImageView *bottomImgView;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UIImageView *shareImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIImageView *codeImgView;
@property (nonatomic,strong) UIView *midView;/** <#class#> **/
@property (nonatomic,assign) SSDKPlatformType Platform;

@end

@implementation LLPromoteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark--createUI
-(void)createUI{
    
    [self.contentView addSubview:self.bottomImgView];
    [self.bottomImgView addSubview:self.shareImgView];
    [self.bottomImgView addSubview:self.imgView];
    [self.imgView addSubview:self.headerImgView];
    [self.imgView addSubview:self.nameLabel];
    [self.imgView addSubview:self.noteLabel];
    [self.imgView addSubview:self.codeImgView];
    [self.bottomImgView addSubview:self.midView];

    
    
    [self.bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CGFloatBasedI375(161));
        make.centerX.mas_equalTo(self.bottomImgView);
        make.width.mas_equalTo(CGFloatBasedI375(290));
        make.height.mas_equalTo(CGFloatBasedI375(465));
    }];
    
    [self.shareImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgView);
        make.top.mas_equalTo(CGFloatBasedI375(55));
        make.width.height.mas_equalTo(CGFloatBasedI375(60));
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgView);
        make.top.mas_equalTo(self.headerImgView.mas_bottom).offset(CGFloatBasedI375(8));
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgView);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(CGFloatBasedI375(14));
    }];
    [self.codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgView);
        make.top.mas_equalTo(self.noteLabel.mas_bottom).offset(CGFloatBasedI375(24));
        make.width.height.mas_equalTo(CGFloatBasedI375(76));
    }];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(CGFloatBasedI375(90));
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(CGFloatBasedI375(14));

    }];
    [self creatui];
}
#define buttonTag2 200
-(void)creatui{
    NSArray *titles = @[@"????????????",@"??????????????????",@"????????????"];
    NSArray *images = @[@"fxwx",@"fxpyq",@"bctp"];
    for (int i = 0; i < titles.count; i++) {
        CGFloat w =SCREEN_WIDTH/3;
        CGFloat h =CGFloatBasedI375(65);
        CGFloat x = CGFloatBasedI375(0)+(w + CGFloatBasedI375(0))*(i%3);
        CGFloat y =CGFloatBasedI375(0)+(h + CGFloatBasedI375(0))*(i/3);
        LLShowView *button = [[LLShowView alloc]init];;
        button.frame = CGRectMake(x, y, w, h);
        button.style = ShowViewNormalImage40State;
        button.tag = 100+i;
        button.backgroundColor = [UIColor clearColor];
        button.titlelable.text = titles[i];
        button.showimage.image = [UIImage imageNamed:images[i]];
        [self.midView addSubview:button];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareBtnClickbao:)];
            [button addGestureRecognizer:tap];
        [self.midView addSubview:button];
    }
}
-(void)shareBtnClickbao:(UITapGestureRecognizer *)sender{
    LLShowView *showimage  =(LLShowView *)sender.view;
    if( [showimage.titlelable.text isEqual:@"????????????"]){
        self.Platform = SSDKPlatformSubTypeWechatSession;
        [self share];
    }else if( [showimage.titlelable.text isEqual:@"????????????"]){
        [self clickSave];
    }else{
        self.Platform = SSDKPlatformSubTypeWechatTimeline;
        [self share];
    }

}
-(void)share{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",@"11"]
                                     images:[self getImage:self.imgView] //????????????????????????
                                        url:nil
                                      title:[NSString stringWithFormat:@"%@",@"111"]
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:self.Platform //???????????????????????????
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // ????????????....}];
        NSLog(@"error == %@",error);
         if(state  == SSDKResponseStateSuccess){//????????????
             [MBProgressHUD showSuccess:@"????????????"];
         }else if (state == SSDKResponseStateFail){
             [MBProgressHUD showError:@"????????????"];
         }else if (state == SSDKResponseStateCancel){
             [MBProgressHUD showSuccess:@"????????????"];
         }
         
     }];
}
//??????????????????
- (UIImage *)getImage:(UIView *)shareView
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.imgView.frame.size.width,self.imgView.frame.size.height ), NO, 0.0); //currentView ?????????view  ????????????????????????????????????????????????????????????
    [self.imgView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext???????????????????????????????????????????????????
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//????????????????????????????????????????????????
    UIGraphicsEndImageContext();//???????????????????????????????????????????????????
    return viewImage;
}

-(void)clickSave{
    NSLog(@"11111");
        // ?????????????????????
    UIImageWriteToSavedPhotosAlbum([self getImage:self.imgView],self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    
}
#pragma mark ????????????????????????
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo
{
    NSString*message =@"??????";
    if(!error) {
        message =@"?????????????????????";
        [MBProgressHUD showSuccess:message toView:self];
    }
}
-(void)setModel:(LLPersonalModel *)model{
    _model = model;
    self.nameLabel.text = _model.nickName;
    self.noteLabel.text = FORMAT(@"%@???????????????????????????",_model.nickName);
    [self.headerImgView sd_setImageWithUrlString:FORMAT(@"%@",_model.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    self.codeImgView.image =   [self createQRCodeWithTargetString:FORMAT(@"%@",_model.invitationLink) logoImage:[UIImage imageNamed:@"savelogo"]];

}
- (UIImage *)createQRCodeWithTargetString:(NSString *)targetString logoImage:(UIImage *)logoImage {
    // 1.?????????????????????????????????
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    // 2.?????????????????????
    NSString *targetStr = targetString;
    NSData *targetData = [targetStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:targetData forKey:@"inputMessage"];
    
    // 3.???????????????
    CIImage *image = [filter outputImage];
    
    // 4.????????????: size ????????????????????????????????????
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image size:[UIScreen mainScreen].bounds.size.width];
    
    //5.??????LOGO
    //5.1?????????????????????
    UIGraphicsBeginImageContext(img.size);
    //5.2???????????????LOGO??????
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
//    UIImage *centerImg = logoImage;
//    CGFloat centerW=img.size.width*0.25;
//    CGFloat centerH=centerW;
//    CGFloat centerX=(img.size.width-centerW)*0.5;
//    CGFloat centerY=(img.size.height -centerH)*0.5;
//    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    //5.3????????????????????????
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    //5.4?????????????????????
    UIGraphicsEndImageContext();

    //6.?????????????????????
    return finalImg;
}

- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image size:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.??????bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.??????bitmap?????????
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}
#pragma mark--lazy
-(UIImageView *)bottomImgView{
    if (!_bottomImgView) {
        _bottomImgView = [[UIImageView alloc]init];
        _bottomImgView.backgroundColor = [UIColor whiteColor];
        _bottomImgView.userInteractionEnabled = YES;

        _bottomImgView.image = [UIImage imageNamed:@"tghb_bg"];
    }
    return _bottomImgView;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.image = [UIImage imageNamed:@"??????"];
        _imgView.userInteractionEnabled = YES;

    }
    return _imgView;
}
-(UIImageView *)shareImgView{
    if (!_shareImgView) {
        _shareImgView = [[UIImageView alloc]init];
        _shareImgView.backgroundColor = [UIColor clearColor];
        _shareImgView.image = [UIImage imageNamed:@"share_bg"];
        _shareImgView.userInteractionEnabled = YES;
    }
    return _shareImgView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
        _headerImgView.userInteractionEnabled = YES;
        _headerImgView.layer.masksToBounds = YES;
        _headerImgView.layer.cornerRadius = CGFloatBasedI375(60/2);
    }
    return _headerImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorFromRGB(0xD40006);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _nameLabel.text = @"?????????";
    }
    return _nameLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x443415);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _noteLabel.text = @"????????????????????????????????????";
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}
-(UIImageView *)codeImgView{
    if (!_codeImgView) {
        _codeImgView = [[UIImageView alloc]init];
        _codeImgView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *QrCodeTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(qrCodeLongPress:)];
        self.codeImgView.userInteractionEnabled = YES;
        [self.codeImgView addGestureRecognizer:QrCodeTap];
    }
    return _codeImgView;
}
- (UIView *)midView{
    if(!_midView){
        _midView = [[UIView alloc]init];
        _midView.backgroundColor = [UIColor clearColor];
    }
    return _midView;;
}
- (void)qrCodeLongPress:(UILongPressGestureRecognizer *)pressSender {
    if (pressSender.state != UIGestureRecognizerStateBegan) {
        return;//??????????????????????????????
    }
    
    UIImageView *imgV =self.imgView;
    
    //???????????????
    CIContext *context = [[CIContext alloc] init];
    //?????????????????????
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    //????????????????????????,??????????????????
    CIImage *imageCI = [[CIImage alloc] initWithImage:imgV.image];
    NSArray *features = [detector featuresInImage:imageCI];
    CIQRCodeFeature *codef = (CIQRCodeFeature *)features.firstObject;
        
    //??????????????????
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"???????????????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(imgV.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    }];
    UIAlertAction *identifyAction = [UIAlertAction actionWithTitle:@"???????????????" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", codef.messageString);
        NSString *images = [self stringValueFrom:self.imgView.image];
        NSLog(@"images == %@",images);
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"??????" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     
        
    }];
    [alert addAction:saveAction];
    [alert addAction:identifyAction];
    [alert addAction:cancelAction];

    [[UIViewController getCurrentController] presentViewController:alert animated:YES completion:nil];
}
-(NSString *)stringValueFrom:(UIImage *)image{
    ///?????????????????????
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    // ??????????????????
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    NSString *resultStr;
    if (features.count == 0) {
        return @"?????????????????????????????????";
    }
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        resultStr = feature.messageString;
    }
    return resultStr;
}

@end
