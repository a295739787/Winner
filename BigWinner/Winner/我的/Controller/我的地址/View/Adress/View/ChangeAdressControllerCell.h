//
//  ChangeAdressControllerCell.h
//  xkb
//
//  Created by YP on 2019/3/22.
//  Copyright © 2019年 刘文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputAdressBlock)(NSString *address,NSInteger index);

@interface ChangeAdressControllerCell : UITableViewCell

@property (assign, nonatomic) NSInteger index;
@property (nonatomic,strong)NSString *leftStr;
@property (nonatomic,strong)NSString *rightStr;

@property (nonatomic,copy)InputAdressBlock adressBlock;

@end
