//
//  AdressListView.h
//  xkb
//
//  Created by YP on 2019/3/29.
//  Copyright © 2019年 刘文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectAdressConfirmBlock)(NSMutableDictionary *dict);

@interface AdressListView : UIView

@property (assign, nonatomic) NSInteger type;

@property (nonatomic,strong)NSArray *dataArray;
@property (assign, nonatomic) NSInteger index;//层级 0省 1市 2区/县

@property (nonatomic,copy)selectAdressConfirmBlock adressBlock;

-(void)show;


@end
