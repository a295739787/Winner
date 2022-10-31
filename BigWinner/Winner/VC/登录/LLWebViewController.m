//
//  PLWebViewController.m
//  PieLifeApp
//
//  Created by libj on 2019/8/2.
//  Copyright © 2019 Libj. All rights reserved.
//

#import "LLWebViewController.h"
#import <WebKit/WebKit.h>

@interface LLWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property ( nonatomic, strong ) WKUserContentController *userContentController;
@property (nonatomic, copy) NSString *content;
@end

@implementation LLWebViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MBProgressHUD hideActivityIndicator];
}

-(void)viewWillAppear:(BOOL)animate{
    [super viewWillAppear:animate];
    if (!self.isHiddenNavgationBar) {
        //显示系统导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.isHiddenNavgationBar) {
        //隐藏系统导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
//    self.customNavBar.title = _name;
    [self getData];
    
}
-(void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XJHttpTool post:FORMAT(@"%@/%@",L_apiappsystemconfiggetById,_htmlStr) method:GET params:params isToken:YES success:^(id  _Nonnull responseObj) {
        NSDictionary *data = responseObj[@"data"];
        self.customNavBar.title = data[@"title"];
        [self creatHtml:data[@"content"]];
    } failure:^(NSError * _Nonnull error) {
     
    }];
    
}

-(void)creatHtml:(NSString *)content{
    NSString *htmlHeader = FORMAT(@"<html meta charset=utf-8><meta http-equiv=X-UA-Compatible content=\"IE=edge\"><meta content=\"width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0;\" name=viewport><head></head> <style type=\"text/css\">body {font-family: PingFangSC-Regular, sans-serif;} p{font-size:15px;}div{font-size:16px;}</style><body><head><style>img{max-width:%fpx !important;}</style></head>",SCREEN_WIDTH-15);
    _htmlStr  = FORMAT(@"%@%@</body></html>",htmlHeader,content);
    [_webView loadHTMLString:_htmlStr baseURL:nil];
//        [_webView loadHTMLString:_htmlStr baseURL:nil];
    _webView.navigationDelegate = self;
}
- (NSURL *)smartURLForString:(NSString *)str {
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}

-(void)loadWebView{
   
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 偏好设置
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    //
    //    // 设置cookie
    config.processPool = [[WKProcessPool alloc] init];
    NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
    
    cookieDict[@"userId"] = @"";
    
    NSMutableString *cookie = @"".mutableCopy;
    for (NSString *key in cookieDict.allKeys) {
        [cookie appendFormat:@"document.cookie = '%@=%@';\n",key,cookieDict[key]];
    }
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    //    self.userContentController = userContentController;
    config.userContentController = userContentController;
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    //        config.mediaPlaybackRequiresUserAction = false;
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    
    WKUserContentController *userCC = config.userContentController;
    self.userContentController = userContentController;
    
    [userCC addScriptMessageHandler:self name:@"submit"];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self.webView  sizeToFit];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SCREEN_top);
        make.left.right.bottom.equalTo(0);
    }];
    
}

- (void)setHtmlStr:(NSString *)htmlStr {
    _htmlStr = htmlStr;
    self.content = htmlStr;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [MBProgressHUD hideActivityIndicator];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [MBProgressHUD hideActivityIndicator];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [MBProgressHUD showActivityIndicator];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [MBProgressHUD hideActivityIndicator];
}

#pragma mark - WKNavigationDelegate
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    NSString *urlString = navigationAction.request.URL.absoluteString;
    if ([urlString containsString:@"ktph5Login"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    //允许跳转
    //    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

#pragma mark -WKScriptMessageHandler

- (void)userContentController:(WKUserContentController*)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message{
    NSLog(@"%@",message.name);
    if ([message.name isEqualToString:@"submit"]) {
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [MBProgressHUD hideActivityIndicator];
}

@end
