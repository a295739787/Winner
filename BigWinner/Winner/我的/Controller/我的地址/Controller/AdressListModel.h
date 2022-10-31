//
//  AdressListModel.h
//  Winner
//
//  Created by YP on 2022/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdressListModel : NSObject<MJKeyValue>

@property (nonatomic,strong)NSArray *list;

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *ID;
@property (assign, nonatomic)BOOL isDefault;
@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *longitude;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *receiveName;
@property (nonatomic,copy)NSString *receivePhone;

@property (nonatomic,copy) NSString *locations;/** <#class#> **/

@property (nonatomic,strong)AdressListModel *pagination;

@property (nonatomic,copy)NSString *currentPage;
@property (nonatomic,copy)NSString *pageSize;
@property (nonatomic,copy)NSString *total;


@end

NS_ASSUME_NONNULL_END
