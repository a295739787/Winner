//
//  LLStorageModel.h
//  Winner
//
//  Created by YP on 2022/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class LLStorageListModel;

@interface LLStorageModel : NSObject

@property (nonatomic,strong)NSArray<LLStorageListModel *>*list;

@end


@interface LLStorageListModel : NSObject

@property (nonatomic,copy)NSString *buyBackPrice;
@property (nonatomic,copy)NSString *coverImage;
@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *goodsNum;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *range;
@property (nonatomic,copy)NSString *rangeType;
@property (nonatomic,copy)NSString *specsValName;

@end

NS_ASSUME_NONNULL_END
