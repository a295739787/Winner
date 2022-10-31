//
//  XJHttpTool.h
//  Wulitou
//
//  Created by llj on 2017/3/14.
//  Copyright © 2017年 llj. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;
/*!
 *
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^XJUploadProgress)(int64_t bytesWritten,
 
                                 int64_t totalBytesWritten);

/*!
 *
 *  请求成功的回调
 *
 *  @param response 服务端返回的数据类型
 */
typedef void(^XJResponseSuccess)(id response);

/*!
 *
 *  网络响应失败时的回调
 *
 *  @param error 错误信息
 */
typedef void(^XJResponseFail)(NSError *error);

@interface XJHttpTool : NSObject
/**
 上传视频
 
 @param video image description
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)httpUploadImagWithvideo:(NSData *)video
                       progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress
                        success:(void (^)(id responseObj))success
                        failure:(void (^)(NSError *error))failure;

+ (void)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary *)parameters
                             progress:(XJUploadProgress)progress
                              success:(XJResponseSuccess)success
                                 fail:(XJResponseFail)fail;

+(void)uploadWithImageArr:(UIImage *)images url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(XJUploadProgress)progress success:(XJResponseSuccess)success fail:(XJResponseFail)fail;

+ (void)uploadWithImage:(NSArray *)images url:(NSString *)url filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(XJUploadProgress)progress success:(void (^)(id))success error:(void (^)(NSString *))error failure:(void (^)(NSError *))failure;

/**  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url method:(HTTPMethod)method params:(NSMutableDictionary *)params isToken:(BOOL)istoken success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSMutableDictionary *)params isToken:(BOOL)istoken success:(void (^)(id))success error:(void (^)(NSString *))error failure:(void (^)(NSError *))failure;
+ (void)get:(NSString *)url method:(HTTPMethod)method params:(NSMutableDictionary *)params  isToken:(BOOL)istoken success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)posts:(NSString *)url method:(HTTPMethod)method params:(NSMutableDictionary *)params isToken:(BOOL)istoken success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
