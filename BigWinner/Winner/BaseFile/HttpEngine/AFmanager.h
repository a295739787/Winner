//
//  AFmanager.h
//  Wulitou
//
//  Created by 雷小军 on 2017/5/9.
//  Copyright © 2017年 雷小军. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFmanager : AFHTTPSessionManager

+(AFHTTPSessionManager *)shareManager;


@end
