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
    NSArray *titles = @[@"分享给微信好友",@"保存图片"];
    NSArray *images = @[@"fxwx",@"bctp"];
    for (int i = 0; i < titles.count; i++) {
        CGFloat w =SCREEN_WIDTH/2;
        CGFloat h =CGFloatBasedI375(65);
        CGFloat x = CGFloatBasedI375(0)+(w + CGFloatBasedI375(0))*(i%2);
        CGFloat y =CGFloatBasedI375(0)+(h + CGFloatBasedI375(0))*(i/ 2);
        LLShowView *button = [[LLShowView alloc]init];;
        button.frame = CGRectMake(x, y, w, h);
        button.style = ShowViewNormalImage40State;
        button.tag = i;
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
    if( [showimage.titlelable.text isEqual:@"分享给微信好友"]){
        self.Platform = SSDKPlatformSubTypeWechatSession;
        [self share];
    }else    if( [showimage.titlelable.text isEqual:@"保存图片"]){
        [self clickSave];
    }

}
-(void)share{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",@"11"]
                                     images:[self getImage:self.imgView] //传入要分享的图片
                                        url:nil
                                      title:[NSString stringWithFormat:@"%@",@"111"]
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:self.Platform //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
        NSLog(@"error == %@",error);
         if(state  == SSDKResponseStateSuccess){//分享成功
             [MBProgressHUD showSuccess:@"分享成功"];
         }else if (state == SSDKResponseStateFail){
             [MBProgressHUD showError:@"分享失败"];
         }else if (state == SSDKResponseStateCancel){
             [MBProgressHUD showSuccess:@"分享成功"];
         }
         
     }];
}
//截图比较清楚
- (UIImage *)getImage:(UIView *)shareView
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.imgView.frame.size.width,self.imgView.frame.size.height ), NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.imgView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    return viewImage;
}

-(void)clickSave{
    NSLog(@"11111");
        // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum([self getImage:self.imgView],self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    
}
#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo
{
    NSString*message =@"提示";
    if(!error) {
        message =@"成功保存到相册";
        [MBProgressHUD showSuccess:message toView:self];
    }
}
-(void)setModel:(LLPersonalModel *)model{
    _model = model;
    self.nameLabel.text = _model.nickName;
    self.noteLabel.text = FORMAT(@"%@邀请你加入大赢家！",_model.nickName);
    [self.headerImgView sd_setImageWithUrlString:FORMAT(@"%@",_model.headIcon) placeholderImage:[UIImage imageNamed:morentouxiang]];
    self.codeImgView.image =   [self createQRCodeWithTargetString:FORMAT(@"%@",_model.invitationLink) logoImage:[UIImage imageNamed:@"savelogo"]];

}
- (UIImage *)createQRCodeWithTargetString:(NSString *)targetString logoImage:(UIImage *)logoImage {
    // 1.创建一个二维码滤镜实例
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    // 2.给滤镜添加数据
    NSString *targetStr = targetString;
    NSData *targetData = [targetStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:targetData forKey:@"inputMessage"];
    
    // 3.生成二维码
    CIImage *image = [filter outputImage];
    
    // 4.高清处理: size 要大于等于视图显示的尺寸
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image size:[UIScreen mainScreen].bounds.size.width];
    
    //5.嵌入LOGO
    //5.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //5.2将二维码的LOGO画入
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
//    UIImage *centerImg = logoImage;
//    CGFloat centerW=img.size.width*0.25;
//    CGFloat centerH=centerW;
//    CGFloat centerX=(img.size.width-centerW)*0.5;
//    CGFloat centerY=(img.size.height -centerH)*0.5;
//    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    //5.3获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    //5.4关闭图像上下文
    UIGraphicsEndImageContext();

    //6.生成最终二维码
    return finalImg;
}

- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image size:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
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
        _imgView.image = [UIImage imageNamed:@"指纹"];
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
        _nameLabel.text = @"张小小";
    }
    return _nameLabel;
}
-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.textColor = UIColorFromRGB(0x443415);
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(15)];
        _noteLabel.text = @"张小小邀请你加入大赢家！";
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
        return;//长按手势只会响应一次
    }
    
    UIImageView *imgV =self.imgView;
    
    //创建上下文
    CIContext *context = [[CIContext alloc] init];
    //创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    //直接开始识别图片,获取图片特征
    CIImage *imageCI = [[CIImage alloc] initWithImage:imgV.image];
    NSArray *features = [detector featuresInImage:imageCI];
    CIQRCodeFeature *codef = (CIQRCodeFeature *)features.firstObject;
        
    //弹出选项列表
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(imgV.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    }];
    UIAlertAction *identifyAction = [UIAlertAction actionWithTitle:@"识别二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", codef.messageString);
        NSString *images = [self stringValueFrom:self.imgView.image];
        NSLog(@"images == %@",images);
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     
        
    }];
    [alert addAction:saveAction];
    [alert addAction:identifyAction];
    [alert addAction:cancelAction];

    [[UIViewController getCurrentController] presentViewController:alert animated:YES completion:nil];
}
-(NSString *)stringValueFrom:(UIImage *)image{
    ///系统识别二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    NSString *resultStr;
    if (features.count == 0) {
        return @"请检查图片是不是二维码";
    }
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        resultStr = feature.messageString;
    }
    return resultStr;
}

@end
