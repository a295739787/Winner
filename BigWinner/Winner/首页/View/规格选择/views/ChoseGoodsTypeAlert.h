//
//  ChoseGoodsTypeAlert.h
//  MeiXiangDao_iOS
//
//  Created by 澜海利奥 on 2017/9/26.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SizeAttributeModel.h"
@class GoodsModel;
@interface ChoseGoodsTypeAlert : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)GoodsModel *model;
@property (nonatomic,assign) RoleStatus status ;/** <#class#> **/
@property (nonatomic,assign) NSInteger stock;/** class **/

@property (nonatomic, copy)void (^selectSize)(NSString *goodsId,NSString *goodsNum,NSString *goodsSpecsPriceId,NSInteger tags,NSInteger stock,NSString *speceStr);
-(void)hideView;
-(void)showView;
-(void)initData:(GoodsModel *)model;
-(instancetype)initWithFrame:(CGRect)frame andHeight:(float)height;//height 白色弹框高度，自己想设多高设多高
@end
