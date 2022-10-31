//
//  UITableViewCell+UITableViewCell_Helper.m
//  YFTableViewCell
//
//  Created by Dandre on 2017/10/29.
//  Copyright © 2017年 Saxue. All rights reserved.
//

#import "UITableViewCell+Helper.h"

@implementation UITableViewCell (Helper)
    
- (UITableView *)tableView
{
    return [self view:self superClass:[UITableView class]];
}
    
- (NSIndexPath *)indexPath
{
    return [self.tableView indexPathForCell:self];
}
    
- (id)view:(__kindof UIView *)view superClass:(Class)class
{
    id cls = view.superview;
    if ([cls isKindOfClass:class]) {
        return cls;
    }else{
        return [self view:cls superClass:class];
    }
}


    
@end
