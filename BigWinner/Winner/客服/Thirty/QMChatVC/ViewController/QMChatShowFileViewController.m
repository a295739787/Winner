//
//  QMChatShowFileViewController.m
//  IMSDK
//
//  Created by lishuijiao on 2020/10/23.
//

#import "QMChatShowFileViewController.h"
#import <WebKit/WebKit.h>

@interface QMChatShowFileViewController ()

@end

@implementation QMChatShowFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:isDarkStyle ? QMColor_Nav_Bg_Dark : QMColor_Nav_Bg_Light];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        
    button.frame = CGRectMake(10, QM_kStatusBarHeight + 5, 60, 30);
    [button setTitle:NSLocalizedString(@"button.back", nil) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    CGRect webFrame = CGRectMake(0, kStatusBarAndNavHeight, QM_kScreenWidth, QM_kScreenHeight - kStatusBarAndNavHeight);
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:webFrame configuration:config];
    
    [self.view addSubview:webView];
    
    if (self.isForm) {
        NSString *encodedString = [self.filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *weburl = [NSURL URLWithString:encodedString];
        [webView loadRequest:[NSURLRequest requestWithURL:weburl]];
    }else {
        NSString * filePath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",self.filePath];
        // 中文路径要encode
        if ([filePath hasPrefix:@"http"]) {
            NSString * fileUrl = [filePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:fileUrl];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        } else {
            NSURL *url = [NSURL fileURLWithPath:filePath];
            [webView loadFileURL:url allowingReadAccessToURL:url];
        }
    }
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
