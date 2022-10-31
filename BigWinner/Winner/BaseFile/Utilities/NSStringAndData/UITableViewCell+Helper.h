//
//  UITableViewCell+UITableViewCell_Helper.h
//  YFTableViewCell
//
//  Created by Dandre on 2017/10/29.
//  Copyright © 2017年 Saxue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Helper)
    
/**
 cell 当前所在的UITableView对象
 */
@property (readonly) UITableView *tableView;
    
/**
 cell 当前的indexPath
 */
@property (readonly) NSIndexPath *indexPath;

@end
