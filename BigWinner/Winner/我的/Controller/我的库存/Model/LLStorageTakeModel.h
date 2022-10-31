//
//  LLStorageTakeModel.h
//  Winner
//
//  Created by YP on 2022/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LLappAddressInfoVoModel;
@class LLappUserStockListVoModel;

@interface LLStorageTakeModel : NSObject

@property (nonatomic,copy)NSString *goodsNum;

@end



@interface LLappAddressInfoVoModel : NSObject

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *distanceSphere;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *isDefault;
@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *locations;
@property (nonatomic,copy)NSString *longitude;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *receiveName;
@property (nonatomic,copy)NSString *receivePhone;

@end


@interface LLappUserStockListVoModel : NSObject


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
