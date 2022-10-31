//
//  QMChatRoomViewController.h
//  IMSDK
//
//  Created by lishuijiao on 2020/9/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QMChatInputView;
@class QMChatMoreView;
@class QMChatFaceView;
@class QMRecordIndicatorView;
@class QMChatAssociationInputView;

typedef enum : NSUInteger {
    QMDarkStyleDefault = 1, /**系统自定义*/
    QMDarkStyleOpen, /**打开暗黑模式*/
    QMDarkStyleClose, /**关闭暗黑模式*/
} QMDarkStyle;

@interface QMChatRoomViewController : LMHBaseViewController

@property (nonatomic, strong) UITableView *chatTableView; // 消息列表

@property (nonatomic, strong) QMChatInputView *chatInputView; //输入工具条

@property (nonatomic, strong) QMChatFaceView *faceView; // 表情面板

@property (nonatomic, strong) QMChatMoreView *addView; // 扩展面板

@property (nonatomic, strong) QMRecordIndicatorView *recordeView; // 录音动画面板

@property (nonatomic, strong) QMChatAssociationInputView *associationView; // xbot联想输入面板

@property (nonatomic, strong) UIView *coverView;//蒙版

@property (nonatomic, copy) NSString *peerId; // 技能组ID

@property (nonatomic, copy) NSString *scheduleId; //日程id

@property (nonatomic, copy) NSString *processId; //流程id

@property (nonatomic, copy) NSString *currentNodeId; //入口节点中访客选择的流转节点id

@property (nonatomic, copy) NSString *entranceId; //入口节点中_id

@property (nonatomic, copy) NSString *processType; //流程中节点类型 (人工 机器人 …)

@property (nonatomic, copy) NSArray * LeaveArray; //日程管理的留言数据

@property (nonatomic, copy) NSString *avaterStr; // 用户头像

@property (nonatomic, assign) BOOL isOpenSchedule; //是否开启日程管理

@property (nonatomic, assign) BOOL isPush; // 判断是否为正常页面跳转

@property (nonatomic, assign) BOOL isOpenVideo; //是否开启视频权限
//是否开启暗黑模式
@property (nonatomic, assign) QMDarkStyle darkStyle;
@property (nonatomic,strong) LLGoodModel *model;/** <#class#> **/
///点击返回按钮的回调
@property (nonatomic, copy) void(^disMissViewBlock)(void);

- (void)sendFileMessageWithName: (NSString *)fileName AndSize: (NSString *)fileSize AndPath: (NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
