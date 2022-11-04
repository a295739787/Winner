//
//  LLAddrssTableView.h
//  ShopApp
//
//  Created by lijun L on 2021/7/13.
//  Copyright © 2021 lijun L. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LLAddrssTableView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong ) UISearchBar * searchBarView ;

@property (nonatomic, strong)NSArray * array;
@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, assign) NSInteger  selectIndex;

@property (nonatomic,copy) void(^choicePoi)(AMapPOI *poi);/** <#class#> **/
@property (nonatomic,copy) void(^textblock)(NSString *text);/** <#class#> **/
///弹出键盘
@property (nonatomic,copy) void(^textFieldDidBegin)(NSString *text);
///回退键盘
@property (nonatomic,copy) void(^textFieldDidEnd)(NSString *text);
@end

NS_ASSUME_NONNULL_END
