//
//  LLNewsModel.h
//  Winner
//
//  Created by YP on 2022/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LLNewsListModel;

@interface LLNewsModel : NSObject

@property (nonatomic,strong)NSArray <LLNewsListModel *>*list;

@end


@interface LLNewsListModel : NSObject

@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,assign) BOOL isRead;/** class **/

@end

NS_ASSUME_NONNULL_END
