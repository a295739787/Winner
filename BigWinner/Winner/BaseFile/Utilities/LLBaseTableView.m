//
//  LLBaseTableView
//  LLBaseTableView
//
//  Created by lijun on 2018/7/9.
//  Copyright © 2018年 lijun. All rights reserved.
//

#import "LLBaseTableView.h"
#import "LLNoticeContentView.h"
#import "Winner-Swift.h"

@interface LLBaseTableView (){
    LLNoticeContentView *_noContentView;
}

@end
@implementation LLBaseTableView

/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */

- (void)showEmptyViewWithType:(NSInteger)emptyViewType imagename:(NSString *)imageName noticename:(NSString *)noticename{
    self.backgroundColor = [UIColor clearColor];
    // 如果已经展示无数据占位图，先移除
    if (_noContentView) {
        [_noContentView removeFromSuperview];
        _noContentView = nil;
    }
    
    //------- 再创建 -------//
    _noContentView = [[LLNoticeContentView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    if(_originYs > 0){
        _noContentView.y = _originYs;
    }
    [self addSubview:_noContentView];
    _noContentView.imageName = imageName;
    _noContentView.noticeName = noticename;
    _noContentView.type = emptyViewType;
    
    //------- 添加单击手势 -------//
    [_noContentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noContentViewDidTaped:)]];
}

/* 移除无数据占位图 */
- (void)removeEmptyView{
    [_noContentView removeFromSuperview];
    _noContentView = nil;
}

// 无数据占位图点击
- (void)noContentViewDidTaped:(LLNoticeContentView *)noContentView{
    if (self.noContentViewTapedBlock)
    {
        self.noContentViewTapedBlock(); // 调用回调函数
    }
}


@end
