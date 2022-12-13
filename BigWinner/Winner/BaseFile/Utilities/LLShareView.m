//
//  LLShareView.m
//  ShopApp
//
//  Created by lijun L on 2021/4/7.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import "LLShareView.h"
#import "LLShowView.h"

@interface LLShareView ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UIButton *sureButton;/** <#class#> **/
@property (nonatomic,strong)     UILabel *label1;/** <#class#> **/
@property (nonatomic,strong) UIView *goodView;/** <#class#> **/
@property (nonatomic,strong)     UILabel *noticelabel;/** <#class#> **/
@property (nonatomic,strong) UIImageView *goodImage;/** <#class#> **/
@property(nonatomic,strong)UILabel *titlelable;
@property(nonatomic,strong)UILabel *pricelable;
@property (nonatomic,strong) UILabel *oldpricelable;/** <#class#> **/
@property (nonatomic,strong) UILabel *deLabel;/** <#class#> **/
@property (nonatomic,strong) UIImageView *codeImage;/** <#class#> **/
@property (nonatomic,strong) UILabel *boLabel;/** <#class#> **/
@property (nonatomic,strong) UIImageView *logoImage;/** <#class#> **/
@property (nonatomic,strong) UIImageView *showimage;/** <#class#> **/
@property (nonatomic,strong) NSDictionary *datas;/** <#class#> **/

@end
@implementation LLShareView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setLayout];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideActionSheetView)];
        tap.delegate = self;
        tap.cancelsTouchesInView = YES;
        [self addGestureRecognizer:tap];
        
        [SSDKAuthViewStyle setTitle:@"授权界面1"];
        [SSDKAuthViewStyle setTitleColor:Black_Color];
        [SSDKAuthViewStyle setCancelButtonLabelColor:Black_Color];
        [SSDKAuthViewStyle setCancelButtonLeftMargin:15];
        [SSDKAuthViewStyle setNavigationBarBackgroundColor:[UIColor redColor]];
        [SSDKAuthViewStyle setNavigationBarBackgroundColor:[UIColor redColor]];
        if (@available(iOS 13.0, *)) {
            [SSDKAuthViewStyle setStatusBarStyle:UIStatusBarStyleLightContent];
        } else {
            // Fallback on earlier versions
        }
        
        [self getImage];
    }
    return self;
}
///**解决点击子view穿透到父视图的问题*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.backView]) {
        return NO;
    }
    return YES;
}
-(void)getImage{
  
}

#pragma mark ============= 布局 =============
-(void)setLayout{
    WS(weakself);
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.left.bottom.mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(175));
     }];
    self.label1 = [[UILabel alloc]init];
    self.label1.text = @"分享";
    self.label1.textColor = [UIColor colorWithHexString:@"#333333"];
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
    [self.backView addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.top.mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(CGFloatBasedI375(40));
    }];

    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(CGFloatBasedI375(0));
        make.top.equalTo(weakself.label1.mas_bottom).mas_equalTo(CGFloatBasedI375(10));
        make.bottom.equalTo(weakself.sureButton.mas_top).mas_equalTo(-CGFloatBasedI375(10));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(CGFloatBasedI375(0));
        make.bottom.mas_equalTo(CGFloatBasedI375(0));
        make.height.mas_equalTo(DeviceXTabbarHeigh(30));
    }];
    [self  layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.backView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backView.layer.mask = maskLayer;
 
    [self creatui];
}

//截图比较清楚
- (UIImage *)getImage:(UIView *)shareView
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.goodView.frame.size.width,self.goodView.frame.size.height ), NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.goodView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
    return viewImage;
}

-(void)clickSave{
    NSLog(@"11111");
        // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum([self getImage:self.goodView],self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    
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
-(void)setIsBao:(BOOL)isBao{
    _isBao = isBao;

}
#define buttonTag2 200
-(void)creatui{
    NSArray *titles = @[@"微信好友",@"朋友圈",@"生成海报",@"复制链接"];
    NSArray *images = @[@"wx",@"pyq",@"genPoster",@"copyLink"];
    for (int i = 0; i < titles.count; i++) {
        CGFloat w =SCREEN_WIDTH/4;
        CGFloat h =CGFloatBasedI375(55);
        CGFloat x = CGFloatBasedI375(0)+(w + CGFloatBasedI375(0))*(i%4);
        CGFloat y =CGFloatBasedI375(0)+(h + CGFloatBasedI375(0))*(i/ 4);
        LLShowView *button = [[LLShowView alloc]init];;
        button.frame = CGRectMake(x, y, w, h);
        button.style = ShowViewNormalImage40State;
        button.tag = i;
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
    if( [showimage.titlelable.text isEqual:@"微信好友"]){
        self.Platform = SSDKPlatformSubTypeWechatSession;
        [self share];
    }else  if( [showimage.titlelable.text isEqual:@"朋友圈"]){
        self.Platform = SSDKPlatformSubTypeWechatTimeline;
        [self share];
    }else  if( [showimage.titlelable.text isEqual:@"生成海报"]){
       //生成海报
        
        if (self.posterBlock) {
            self.posterBlock();
        }
    }else{
        //复制链接
        if (self.linkUrl == nil || [self.linkUrl isEqual: @""]) {
            [MBProgressHUD showError:@"复制失败"];
        }else{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:self.linkUrl];
            [MBProgressHUD showSuccess:@"复制成功"];
        }
        [self hideActionSheetView];
    }

}

-(void)setIsVite:(BOOL)isVite{
    _isVite = isVite;
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
}
-(void)setNameUrl:(NSString *)nameUrl{
    _nameUrl = nameUrl;
}
-(void)setNotice:(NSString *)notice{
    _notice = notice;
}
-(void)setLinkUrl:(NSString *)linkUrl{
    _linkUrl = linkUrl;
    
}
-(void)setOldpriceStr:(NSString *)oldpriceStr{
    _oldpriceStr = oldpriceStr;
}
-(void)setPriceStr:(NSString *)priceStr{
    _priceStr = priceStr;
}
-(void)share{
    NSString *imageurl =[NSString stringWithFormat:@"%@",_imageUrl];
    if(imageurl.length <= 0){
        imageurl = @"http://mj.mohuifu.top/public/logo.png";
    }
    if(_notice.length <= 0){
        _notice = @"我在大赢家发现了一个不错的商品，快来看看吧";
    }
    [self hideActionSheetView];
    //创建分享参数
    if(self.Platform == SSDKPlatformTypeSinaWeibo){
        _notice = FORMAT(@"%@ %@",_notice,_linkUrl);
    }
    NSString *liks = FORMAT(@"%@&invite=%@",_linkUrl,[UserModel sharedUserInfo].userId);
    NSLog(@"imageurl == %@",imageurl);
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",_notice]
                                     images:imageurl //传入要分享的图片
                                        url:[NSURL URLWithString:liks ]
                                      title:[NSString stringWithFormat:@"%@",_nameUrl]
                                       type:SSDKContentTypeAuto];
    
    //进行分享
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
//-(void)shareBtnClick:(UITapGestureRecognizer *)sender{
//
//    if(_block){
//        _block(sender.view.tag-buttonTag2,@"");
//    }
//}
-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"取消" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [_sureButton setTitleColor:lightGray9999_Color forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(hideActionSheetView) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.sureButton];
    }
    return _sureButton;
}
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.backgroundColor =[UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        [self addSubview:_backView];
    }
    return _backView;
}
-(UIView *)goodView{
    if(!_goodView){
        _goodView = [[UIView alloc]init];
        _goodView.backgroundColor =[UIColor whiteColor];
        _goodView.userInteractionEnabled = YES;
        [self addSubview:_goodView];
        _goodView.layer.masksToBounds = YES;
        _goodView.layer.cornerRadius = CGFloatBasedI375(5);
    }
    return _goodView;
}
-(UIView *)midView{
    if(!_midView){
        _midView = [[UIView alloc]init];
        _midView.backgroundColor =[UIColor whiteColor];
        _midView.userInteractionEnabled = YES;
        [self.backView addSubview:_midView];
    }
    return _midView;
}

-(UILabel *)oldpricelable{
    if(!_oldpricelable){
        _oldpricelable =[[UILabel alloc]init];
        _oldpricelable.text = @"¥0.00";
        _oldpricelable.textColor =lightGray9999_Color;
        _oldpricelable.textAlignment = NSTextAlignmentLeft;
        _oldpricelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self.goodView addSubview:self.oldpricelable];

    }
    return _oldpricelable;
}
-(UILabel *)titlelable{
    if(!_titlelable){
        _titlelable =[[UILabel alloc]init];
        _titlelable.textColor = [UIColor colorWithHexString:@"#333333"];
        _titlelable.textAlignment = NSTextAlignmentLeft;
        _titlelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(13)];
        [self.goodView addSubview:self.titlelable];
        _titlelable.numberOfLines =2;
    }
    return _titlelable;
}
-(UILabel *)noticelabel{
    if(!_noticelabel){
        _noticelabel =[[UILabel alloc]init];
        _noticelabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noticelabel.textAlignment = NSTextAlignmentLeft;
        _noticelabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        _noticelabel.text = @"大赢家推荐一个好物给你,请查收";
        [self.goodView addSubview:self.noticelabel];
        _noticelabel.adjustsFontSizeToFitWidth = YES;
    }
    return _noticelabel;
}
-(UILabel *)boLabel{
    if(!_boLabel){
        _boLabel =[[UILabel alloc]init];
        _boLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _boLabel.textAlignment = NSTextAlignmentCenter;
        _boLabel.text = @"长按或扫描图片";
        _boLabel.font = [UIFont systemFontOfSize:CGFloatBasedI375(12)];
        [self.goodView addSubview:self.boLabel];
    }
    return _boLabel;
}
-(UIImageView *)goodImage{
    if(!_goodImage){
        _goodImage = [[UIImageView alloc]init];
        _goodImage.contentMode = UIViewContentModeScaleAspectFill;
        _goodImage.clipsToBounds = YES;
        [self.goodView addSubview:_goodImage];
    }
    return _goodImage;;
}
-(UIImageView *)showimage{
    if(!_showimage){
        _showimage = [[UIImageView alloc]init];
        _showimage.image = [UIImage imageNamed:@"baoiamges"];
        [self.goodImage addSubview:_showimage];
    }
    return _showimage;;
}
-(UIImageView *)logoImage{
    if(!_logoImage){
        _logoImage = [[UIImageView alloc]init];
        _logoImage.image = [UIImage imageNamed:@"logoredinage"];
        [self.goodView addSubview:_logoImage];
    }
    return _logoImage;;
}
-(UIImageView *)codeImage{
    if(!_codeImage){
        _codeImage = [[UIImageView alloc]init];
        [self.goodView addSubview:_codeImage];
    }
    return _codeImage;;
}
-(UILabel *)pricelable{
    if(!_pricelable){
        _pricelable =[[UILabel alloc]init];
        _pricelable.text = @"价格 ￥0";
        _pricelable.textColor =Main_Color;
        _pricelable.textAlignment = NSTextAlignmentLeft;
        _pricelable.font = [UIFont systemFontOfSize:CGFloatBasedI375(14)];
        [self.goodView addSubview:self.pricelable];
    }
    return _pricelable;
}
/********************  Animation  *******************/

- (void)showActionSheetView {
    self.hidden = NO;
//    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
//        [UIView animateWithDuration:0.25f animations:^{
//            self.alpha = 1.0f;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.25f animations:^{
//            }];
//        }];
    
}

- (void)hideActionSheetView {
    self.hidden = YES;
    [UIView animateWithDuration:0.25f animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
//                [self removeFromSuperview];
            }];
        }
    }];
}
@end
