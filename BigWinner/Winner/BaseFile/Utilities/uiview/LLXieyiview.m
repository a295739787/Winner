//
//  LLXieyiview.m
//  LLMiaiProject
//
//  Created by lijun L on 2019/3/9.
//  Copyright © 2019年 lijun L. All rights reserved.
//

#import "LLXieyiview.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>

@interface LLXieyiview ()<UIGestureRecognizerDelegate,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) UIView *backView;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) WKWebView *webView;/** <#class#> **/
@property (nonatomic,strong) UILabel *noticeLabel;/** <#class#> **/
@property (nonatomic,strong) UIButton *sureBtn1;
@property (nonatomic,strong) UIView *lineView;/** <#class#> **/
@property (nonatomic,strong) UIView *lineView1;/** <#class#> **/
@property (nonatomic,strong) UILabel *priceLabel;/** <#class#> **/

@end
@implementation LLXieyiview

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setLayout];
        [self getData];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];;
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,@"/h5/#/pages/agreement/agreement?id=AppPrivacyAgreement"]]]];

    }
    return self;
}
-(void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,@"AppServiceAgreement") method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        [self creatHtml:data[@"content"]];
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}

-(void)creatHtml:(NSString *)content{
    NSString *htmlHeader = FORMAT(@"<html meta charset=utf-8><meta http-equiv=X-UA-Compatible content=\"IE=edge\"><meta content=\"width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0;\" name=viewport><head></head> <style type=\"text/css\">body {font-family: PingFangSC-Regular, sans-serif;} p{font-size:15px;}div{font-size:16px;}</style><body><head><style>img{max-width:%fpx !important;}</style></head>",SCREEN_WIDTH-15);
    NSString * htmlStrs = FORMAT(@"%@%@</body></html>",htmlHeader,content);
    [_webView loadHTMLString:htmlStrs baseURL:nil];
//        [_webView loadHTMLString:_htmlStr baseURL:nil];
    _webView.navigationDelegate = self;
}
-(void)setLayout{

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(CGFloatBasedI375(35));
        make.right.offset(-CGFloatBasedI375(35));
        make.height.offset(CGFloatBasedI375(500));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.offset(15);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(self.noticeLabel.mas_bottom).offset(10);
        make.bottom.offset(-CGFloatBasedI375(65));
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(CGFloatBasedI375(0));
        make.bottom.offset(-CGFloatBasedI375(60));
        make.height.offset(CGFloatBasedI375(1));
    }];
    [self.sureBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset((SCREEN_WIDTH-CGFloatBasedI375(30))/2);
        make.bottom.offset(0);
        make.height.offset(CGFloatBasedI375(60));
    }];
//    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.sureBtn1.mas_right).offset(0);
//        make.width.offset(CGFloatBasedI375(1));
//        make.bottom.offset(0);
//        make.height.offset(CGFloatBasedI375(60));
//    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.offset((SCREEN_WIDTH-CGFloatBasedI375(30))/2);
        make.bottom.offset(0);
        make.height.offset(CGFloatBasedI375(60));
    }];
//    self.sureBtn1.backgroundColor = Red_Color;
}
-(UIView *)backView{
    if(!_backView){
        _backView  = [[UIView alloc]init];
                _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 10;
        [self addSubview: self.backView];
        _backView.backgroundColor = [UIColor whiteColor];

    }
    return _backView;
}

-(UILabel *)noticeLabel{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.font = [UIFont boldFontWithFontSize:CGFloatBasedI375(15)];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.text = @"隐私保护提示";
        _noticeLabel.textColor = [UIColor blackColor];
        [self.backView addSubview:self.noticeLabel];
        
    }
    return _noticeLabel;
}

- (WKWebView *)webView{
    if (! _webView ) {
            NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        self.webView = [[WKWebView alloc]init];
        // 添加js调用
        self.webView.scrollView.bounces = NO;
        self.webView.userInteractionEnabled = YES;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;

        [self.backView addSubview:self.webView];
    }
    return _webView;
}
-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];;
        [_sureBtn addTarget:self action:@selector(pickerEnsureBtnTarget) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview: self.sureBtn];
    }
    return _sureBtn;
}
-(UIButton *)sureBtn1{
    if(!_sureBtn1){
        _sureBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn1 setTitle:@"取消" forState:UIControlStateNormal];
        [_sureBtn1 setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _sureBtn1.titleLabel.font = [UIFont fontWithName:@"arial" size:CGFloatBasedI375(14)];;
        [_sureBtn1 addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview: self.sureBtn1];
    }
    return _sureBtn1;
}
-(void)backclick{
    exit(0);
}
- (UIView *)lineView1{
    if(!_lineView1){
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = BG_Color;
        [self.backView addSubview:_lineView1];
    }
    return _lineView1;;
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BG_Color;
        [self.backView addSubview:_lineView];
    }
    return _lineView;;
}
-(void)pickerEnsureBtnTarget{
    [[NSUserDefaults standardUserDefaults]setObject:@"yindao" forKey:@"firstXiyi"];
    [self hideActionSheetView];
}
/********************  Animation  *******************/

- (void)showActionSheetView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [self layoutIfNeeded];
    
    CGRect tempFrame = self.backView.frame;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            self.backView.frame = tempFrame;
        }];
    }];
}

- (void)hideActionSheetView {
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25f animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
    }];
}
@end
