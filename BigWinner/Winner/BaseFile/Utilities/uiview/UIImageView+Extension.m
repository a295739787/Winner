//
//  UIImageView+Extension.m
//  PieLifeApp
//
//  Created by libj on 2019/8/8.
//  Copyright © 2019 Libj. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)


- (void)sd_setImageWithUrlString:(NSString *)urlStr {
    [self sd_setImageWithUrlString:urlStr placeholderImage:[UIImage imageNamed:morenpic]];
}
- (void)sd_setImageWithUrlString:(NSString *)urlStr placeholderImageName:(NSString * _Nullable )placeholderImageName {
    [self sd_setImageWithUrlString:urlStr placeholderImage:[UIImage imageNamed:@""]];
}

- (void)sd_setImageWithUrlString:(NSString *)urlStr placeholderImage:(UIImage * _Nullable)placeholderImage {
    // 解决中文名字问题
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if ([urlStr containsString:@"https"] || [urlStr containsString:@"http"]) {
            [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholderImage];
        }else {
            [self sd_setImageWithURL:[NSURL URLWithString:FORMAT(@"%@%@",API_IMAGEHOST,urlStr)] placeholderImage:placeholderImage];
        }
    
 
}

@end
