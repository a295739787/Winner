//
//  LLNoticeContentView.h
//  LLuxuryPowerProject
//
//  Created by Lijun on 2018/7/16.
//  Copyright © 2018年 Lijun. All rights reserved.
//

#import <UIKit/UIKit.h>

// 无数据占位图的类型
typedef NS_ENUM(NSInteger, NoContentType) {
    LLCollectionNoDataView = 1,//收藏页面
    LLAddressNoDataView = 2,//收货页面
    LLIntegerNoDataView = 3,//积分
    LLOtherNoDataView,
    NoContentTypeOrder,
    NoContentTypeNetwork
};

@interface LLNoticeContentView : UIView
@property (nonatomic,strong) UILabel *topLabel;
/** 图片名 **/
@property (nonatomic,copy) NSString *imageName;
/** 提示 **/
@property (nonatomic,copy) NSString *noticeName;
/** 无数据占位图的类型 */
@property (nonatomic,assign) NSInteger type;
@end
