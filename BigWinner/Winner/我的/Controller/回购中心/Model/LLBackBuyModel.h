//
//  LLBackBuyModel.h
//  Winner
//
//  Created by YP on 2022/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LLBackBuyListModel;

@interface LLBackBuyModel : NSObject

@property (nonatomic,strong)NSArray<LLBackBuyListModel *>*list;

@end


@interface LLBackBuyListModel : NSObject


@property (nonatomic,copy)NSString *backNum;
@property (nonatomic,copy)NSString *backPrice;
@property (nonatomic,copy)NSString *backTotalPrice;
@property (nonatomic,copy)NSString *coverImage;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *goodsId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *specsValName;
@property (nonatomic,copy)NSString *status;

@end

NS_ASSUME_NONNULL_END
