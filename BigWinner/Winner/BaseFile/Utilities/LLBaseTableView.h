//
//  LLBaseTableView.h
//  LLuxuryPowerProject
//
//  Created by Lijun on 2018/7/16.
//  Copyright © 2018年 Lijun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LLBaseTableView : UITableView
// 无数据占位图点击的回调函数
@property (copy,nonatomic) void(^noContentViewTapedBlock)(void);

@property (nonatomic,assign) CGFloat originYs;/** <#class#> **/
/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType imagename:(NSString *)imageName noticename:(NSString *)noticename;

/* 移除无数据占位图 */
- (void)removeEmptyView;
@end
