//
//  XJHttpTool.m
//  Wulitou
//
//  Created by 雷小军 on 2017/3/14.
//  Copyright © 2017年 ZongmingYin. All rights reserved.
//

#import "XJHttpTool.h"
#import "AFmanager.h"

@implementation XJHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    AFJSONResponseSerializer * respons = [AFJSONResponseSerializer serializer];
    respons.removesKeysWithNullValues = YES;
    manager.responseSerializer = respons;
    //加上这一句即可
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    url = [API_HOST stringByAppendingString:url];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"image/png", nil];
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
    if(token.length > 0){
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"X-EB-Token"];
    }
    NSLog(@"我发送的 url == %@  字段是== %@",url,params);
    [manager GET:url parameters:params headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
               
               if([responseObject isKindOfClass:[NSDictionary class]]){
                   NSLog(@"服务器返回的数据 == %@",responseObject);
                   success(responseObject);
               }else{
                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                   NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                   //                NSLog(@"服务器返回的数据 == %@",dict);
                   success(str);
               }
           }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
              NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        
              NSLog(@"服务器返回的错误数据 == %@",errorStr);
        [JXUIKit showErrorWithStatus:@"无网络连接，请检查网网络"];
              if (failure) {
                  
                  failure(error);
              }
    }];
  
}
+ (void)get:(NSString *)url method:(HTTPMethod)method params:(NSMutableDictionary *)params  isToken:(BOOL)istoken success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    AFJSONResponseSerializer * respons = [AFJSONResponseSerializer serializer];
    respons.removesKeysWithNullValues = YES;
    manager.responseSerializer = respons;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"image/png",@"text/plain", nil];
           NSMutableDictionary *dictionay = [NSMutableDictionary dictionary];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    if(istoken == YES){
 
        NSString * token =    [NSString isBlankString:  [NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ]]?@"":[NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ];
        if(token.length > 0){
            [dictionay setObject:token forKey:@"token"];
        }else{
               
        }
        
    }
    [dictionay addEntriesFromDictionary:params];
    NSString * token =    [NSString isBlankString:  [NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ]]?@"":[NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ];;
    if(token.length > 0){
        [dictionay setObject:token forKey:@"token"];
    }
    NSLog(@"我发送的 url == %@  字段是== %@",url,dictionay);
    switch (method) {
        case GET:
                  [self geturl:manager url:url param:dictionay isToken:istoken success:success  failure:failure];

            break;
            case POST:
                       [self posturl:manager url:url param:dictionay isToken:istoken success:success  failure:failure];

                       break;
            
        default:
            break;
    }
   
}
+ (void)posts:(NSString *)url method:(HTTPMethod)method params:(NSMutableDictionary *)params isToken:(BOOL)istoken success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
        AFHTTPSessionManager *manager = [AFmanager shareManager];
    //    [manager.securityPolicy setAllowInvalidCertificates:YES];
    //    AFJSONResponseSerializer * respons = [AFJSONResponseSerializer serializer];
    //    respons.removesKeysWithNullValues = YES;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",nil];
    //    manager.responseSerializer = respons;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"image/png",@"text/plain", nil];
               NSMutableDictionary *dictionay = [NSMutableDictionary dictionary];
    //    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        
        if(istoken == YES){
     
            NSString * token =    [NSString isBlankString:  [NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ]]?@"":[NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ];;
            if(token.length > 0){
                [dictionay setObject:token forKey:@"token"];
            }else{
                   
            }
            
        }

        [dictionay addEntriesFromDictionary:params];
    //    NSString * token =    [NSString isBlankString:  [NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ]]?@"":[NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token ];;
    //    if(token.length > 0){
    //        [dictionay setObject:token forKey:@"token"];
    //    }
        NSLog(@"我发送的 url == %@  字段是== %@",url,dictionay);
        switch (method) {
            case GET:
                      [self geturl:manager url:url param:dictionay isToken:istoken success:success  failure:failure];

                break;
                case POST:
                           [self posturl:manager url:url param:dictionay isToken:istoken success:success  failure:failure];

                           break;
                
            default:
                break;
        }
       
}

+ (void) post:(NSString *)url method:(HTTPMethod)method params:(NSMutableDictionary *)params  isToken:(BOOL)istoken success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    NSMutableDictionary *dictionay = [NSMutableDictionary dictionary];
    if(istoken == YES){
        if([UserModel sharedUserInfo].token.length > 0){
        NSString *Authorization = [NSString stringWithFormat:@"%@",[UserModel sharedUserInfo].token];
        [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
        }
    }
    [dictionay addEntriesFromDictionary:params];
    url = [apiQiUrl stringByAppendingString:url];
    NSLog(@"我发送的 url == %@  字段是== %@",url,dictionay);
    switch (method) {
        case GET:
                  [self geturl:manager url:url param:dictionay isToken:istoken success:success  failure:failure];

            break;
            case POST:
                       [self posturl:manager url:url param:dictionay isToken:istoken success:success  failure:failure];

                       break;
            
        default:
            break;
    }
   
}
+ (void)posturl:(AFHTTPSessionManager *)manager url:(NSString *)url param:(NSDictionary *)dictionay isToken:(BOOL)isToken success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [manager POST:url parameters:dictionay headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
                   if([responseObject isKindOfClass:[NSDictionary class]]){
                        NSLog(@"服务器返回的数据 == %@",responseObject);
                       NSInteger  status = [[NSString stringWithFormat:@"%@",responseObject[@"code"]]integerValue];
                       if(status  == 200){
                           success(responseObject);
                       }else   if(status  == -1 &&[responseObject[@"msg"] isEqual:@"缺少token参数"] ){//重新登录
                                failure(nil);
                           AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                          [dele loginVc];
                       }else   if(status  == 600){//重新登录
                           failure(nil);
                           [AccessTool  removeUserInfo];
                           [UserModel resetModel:nil];
                           AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                           [dele showAlertVc];
                  }else   if(status  == 602){//重新登录
                                failure(nil);
//                           [JXUIKit showErrorWithStatus:@"token验证失败"];
                           [AccessTool  removeUserInfo];
                           [UserModel resetModel:nil];
                      AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                      [dele loginVc];
                       }else    if(status  == 601 ){//重新登录
                           failure(nil);
                      [AccessTool  removeUserInfo];
                      [UserModel resetModel:nil];
                           AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                           [dele showAlertReforceVc];
                  }  else   if(status  == 10011){//重新登录
                           failure(nil);
                       }else{
                           NSLog(@"错误 == %@",responseObject);
                           [JXUIKit showErrorWithStatus:responseObject[@"msg"]];
                           failure(nil);
                           //默认是普通会员,从banner申请推广员,如果申请了,那app就是显示推广员的tabbar,如果申请配送员,app就显配送员的tabbar?
                           
                       }
                   }else{
                       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                       NSInteger  code = [[NSString stringWithFormat:@"%@",dict[@"code"]]integerValue];
                       
                       NSLog(@"服务器返回的数据 == %@",dict);
                       if(code  == 200){
                           success(responseObject);
                       }else{
                           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

                           [MBProgressHUD showError:dict[@"msg"]];
                       }
                   }
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
               NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        if(data){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [JXUIKit showErrorWithStatus:@"无网络连接，请检查网网络"];
               NSLog(@"服务器返回的错误数据 == %@",errorStr);
               if (failure) {
                   
                   failure(error);
               }
        }
    }];

}
+ (void)geturl:(AFHTTPSessionManager *)manager url:(NSString *)url param:(NSDictionary *)dictionay isToken:(BOOL)isToken success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [manager GET:url parameters:dictionay headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                     if([responseObject isKindOfClass:[NSDictionary class]]){
                          NSLog(@"服务器返回的数据 == %@",responseObject);
                         NSInteger  status = [[NSString stringWithFormat:@"%@",responseObject[@"code"]]integerValue];
                         if(status  == 200){
                            
                             success(responseObject);
                         }else   if(status  == -1 &&[responseObject[@"msg"] isEqual:@"缺少token参数"] ){//重新登录
                                  failure(nil);
                             AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            [dele loginVc];
                         }else   if(status  == -1 &&[responseObject[@"msg"] isEqual:@"密码已重置"] ){//重新登录
                                  failure(nil);
                             AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            [dele loginVc];
                         }else   if(status  == 600){//重新登录
                             failure(nil);
                             [AccessTool  removeUserInfo];
                             [UserModel resetModel:nil];
                             AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                             [dele showAlertVc];
                    }else   if(status  == 602){//重新登录
                                  failure(nil);
//                             [JXUIKit showErrorWithStatus:@"token验证失败"];
                             [AccessTool  removeUserInfo];
                             [UserModel resetModel:nil];
                        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [dele loginVc];
                         }else    if(status  == 601 ){//重新登录
                             failure(nil);
                        [AccessTool  removeUserInfo];
                        [UserModel resetModel:nil];
                             AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
                             [dele showAlertReforceVc];
                    }else   if(status  == 10011){//重新登录
                                    failure(nil);
                                         }else{
                                             [JXUIKit showErrorWithStatus:responseObject[@"msg"]];

                             NSLog(@"错误 == %@",responseObject);
                               failure(nil);
                                             
                                         }
                     }else{
                         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                         NSInteger  code = [[NSString stringWithFormat:@"%@",dict[@"code"]]integerValue];
                         
                         NSLog(@"服务器返回的数据 == %@",dict);
                         if(code  == 200){
                             success(responseObject);
                         }else{
                             [MBProgressHUD showError:responseObject[@"msg"]];
                         }
                     }
                 }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
                NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"服务器返回的错误数据 == %@",errorStr);
       
        
        [JXUIKit showErrorWithStatus:@"无网络连接，请检查网网络"];
                if (failure) {
                    
                    failure(error);
                }
    }];
  
}
+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSMutableDictionary *)params isToken:(BOOL)istoken success:(void (^)(id))success error:(void (^)(NSString *))error failure:(void (^)(NSError *))failure {
    
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    //    [manager.securityPolicy setAllowInvalidCertificates:YES];
    AFJSONResponseSerializer * respons = [AFJSONResponseSerializer serializer];
    respons.removesKeysWithNullValues = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    if(istoken == YES && [UserModel sharedUserInfo].token){
        NSMutableDictionary *dictionay = params;
        //        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@""];
        [dictionay setObject:[UserModel sharedUserInfo].token forKey:@"token"];
        
    }
    NSLog(@"我发送的 url == %@  字段是== %@",url,params);
    [params setObject:[NSString getCurrentTimes] forKey:@"timestamp"];
 return   [manager POST:url parameters:params headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (success) {
                    if(![responseObject isKindOfClass:[NSDictionary class]]){
                        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    }
                    NSInteger  code = [[NSString stringWithFormat:@"%@",responseObject[@"code"]]integerValue];
        //            if ([url rangeOfString:L_orderbuy].length) {
        //                code = 402;
        //            }
                    if(code  == 200){
                        NSLog(@"服务器返回的数据 == %@",responseObject);
                        success(responseObject);
                    } else {
                         if (error) {
                                             error(responseObject[@"msg"]);
                                         }
                                         [MBProgressHUD showError:responseObject[@"msg"]];
                        NSLog(@"错误 == %@",responseObject);

                    }
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
            NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"服务器返回的错误数据 == %@",errorStr);
        [JXUIKit showErrorWithStatus:@"网络错误"];
            if (failure) {
                failure(error);
            }
    }];
  
}

+ (void)uploadWithImage:(UIImage *)image url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(XJUploadProgress)progress success:(XJResponseSuccess)success fail:(XJResponseFail)fail {
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    
    NSString *filenames;
    NSMutableDictionary *dictionay = [NSMutableDictionary dictionary];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
             imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:100];
             NSString *imageFileName = filenames;
             if (imageFileName == nil) {
                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                 formatter.dateFormat = @"yyyyMMddHHmmss";
                 NSString *str = [formatter stringFromDate:[NSDate date]];
                 imageFileName = [NSString stringWithFormat:@"%@.png", str];
                 
             }
             // 上传图片，以文件流的格式
             [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  success(dict);
              }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
                  fail(error);
              }
    }];

}
+(void)uploadWithImageArr:(UIImage *)images url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(XJUploadProgress)progress success:(XJResponseSuccess)success fail:(XJResponseFail)fail {
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSString *filenames;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"imageArr == %@",images);
//        for(int i = 0; i <imageArr.count; i++)
//          {
           NSString *imageFileName = @"file";
              if(  [images isKindOfClass:[UIImage class]]){
                  UIImage *image = images;
                  NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
                  if (imageFileName == nil || ![imageFileName isKindOfClass:[NSString class]] || imageFileName.length == 0) {
                      NSString *Name = [NSString stringWithFormat:@"%@%d", @"photo",0+1];
                      imageFileName = [NSString stringWithFormat:@"%@.png", Name];
                  }
                  [formData appendPartWithFileData:imageData name:@"file" fileName:@"file" mimeType:@"png"];
              }
//          }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
                  progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
              }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                   NSLog(@"获取的图片 == %@",dict);
                   success(dict);
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
                   fail(error);
               }
    }];
   
}
+ (void)uploadWithImage:(NSArray *)images url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(XJUploadProgress)progress success:(void (^)(id))success error:(void (^)(NSString *))error failure:(void (^)(NSError *))failure{
        AFHTTPSessionManager *manager = [AFmanager shareManager];
    
    NSString *filenames;
    NSMutableDictionary *dictionay = [NSMutableDictionary dictionary];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dictionay headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count; i++) {
              NSData *imageData = UIImagePNGRepresentation(images[i]);
              imageData = [self compressOriginalImage:images[i] toMaxDataSizeKBytes:100];
              NSString *imageFileName = filenames;
              if (imageFileName == nil) {
                  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                  formatter.dateFormat = @"yyyyMMddHHmmss";
                  NSString *str = [formatter stringFromDate:[NSDate date]];
                  imageFileName = [NSString stringWithFormat:@"%@_%d.png", str, i];
                  
              }
              // 上传图片，以文件流的格式
              [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
              }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
               if (success) {
                   success(dict);
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
             if (error) {
                 failure(error);
             }
    }];

}

+(NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

@end
