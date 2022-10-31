//
//  QuestionModel.h
//  Winner
//
//  Created by YP on 2022/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : NSObject<MJKeyValue>

@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;

@end

NS_ASSUME_NONNULL_END
