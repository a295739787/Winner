//
//  MacroDefinition.h
//  FindWorker
//
//  Created by lijun L on 2019/7/11.
//  Copyright © 2019年 zhiqiang meng. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

#define LEFT_X(a)               CGRectGetMinX(a.frame)         //控件左边面的X坐标
#define NW(a)               CGRectGetMaxX(a.frame)         //控件右面的X坐标
#define TOP_Y(a)                CGRectGetMinY(a.frame)         //控件上面的Y坐标
#define NH(a)                   CGRectGetMaxY(a.frame)         //控件下面的Y坐标
#define CENTER_X(a)             CGRectGetMidX(a.frame)         //控件的中心X坐标
#define CENTER_Y(a)             CGRectGetMidY(a.frame)


#define WS(weakself) __weak __typeof(&*self)weakself = self

#define CODEWIDTH CGFloatBasedI375(80)
#define morenPic @"touxiang"
#define MORENPIC @"more"
#import "ButtonManager.h"
#import "UIView+Extension.h"
#define morenpic @""
#define allowimageGray @"allowimag"

#define morentouxiang @"headimages"
#define morepicunlong @"unlonimage"
#define backTopimaes @"backTopimage"

#define LLgetmaindata @"getmaindata"
#define LLgetSearchData @"getSearchData"
#define LLgetHotData @"getHotData"
#define LLgetBrandData @"getBrandData"
#define LLgetTabData @"getTabData"
#define LLgetTabListData @"getTabListData"
#define LLNSNumberVCTabName @"LLNSNumberVCTabName"
#define LLClassTabName @"LLClassTabName"
#define LLClassTabListName @"LLClassTabListName"
#define LLClassTabListTimeName @"LLClassTabListtimeName"
#define LLClasshomeperson @"L_homeperson"
#define LLClasshomepersonName @"L_homepersonName"
#define LLClassDoordListName @"LLDoordListName"
#define LLClassDoorListTimeName @"LLClassTabListtimeName"


#define  WechatAppID @"wxa5f63bde43b7e56d"
#define  WechatAppScret @"7fb82d3977082d0bd3f1a391bacb7fca"
#define HX_AppKey @""
#define  Jpush_AppKey @"868406af652f1761fb593604"
#define Kefuyun @"1424191023068019#kefuchannelapp75293"
#define Teamid @"75293"
#define  GDAppID @"4152d7b2c129d7890fa686a48db21029"

/** 主颜色 */
#define Main_Color [UIColor colorWithHexString:@"#D53329"]
#define MainTitle_Color [UIColor HexString:@"#333333"]
#define BG_Color [UIColor HexString:@"F0EFED"]
#define ViewBG_Color [UIColor HexString:@"F5F6FA"]
#define TextLightGray_Color [UIColor HexString:@"BABFCD"]
#define TextBlack_Color [UIColor HexString:@"#333333"]
#define BlackTitleFont443415 [UIColor colorWithHexString:@"#443415"]

//不同屏幕尺寸字体适配
#define kScreenWidthRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)
#define kScreenHeightRatio (UIScreen.mainScreen.bounds.size.height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]    //用这个就好了


#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define FORMAT(f, ...)      [NSString stringWithFormat:f, ## __VA_ARGS__]
#define SL_kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define SL_kScreenWidth   [[UIScreen mainScreen] bounds].size.width


#define PASSWORKZ_ZH  @"[A-Za-z0-9_]{6,40}"
#define  PHONE  @"(0[0-9]{2,3})+([2-9][0-9]{6,7})"
#define  phone_zh @"^[1][3-9]+\\d{9}"

///对属性解释
#define YYModelExplain + (NSDictionary *)modelContainerPropertyGenericClass
///替换属性名 /*本地的：返回的*/
#define YYModelLocaKey_SerKey + (NSDictionary *)modelCustomPropertyMapper

#define isPAD_or_IPONE4  (iPhone4Retina ||isPad)

// 该方法不能识别出ipad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
// 暂用该方法判断是否为ipad
#define isPad (([[UIScreen mainScreen] currentMode].size.width/[[UIScreen mainScreen] currentMode].size.height==(float)3/4) && SCREEN_WIDTH !=375.0)

#define iPhone4Retina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6         (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)||(SCREEN_HEIGHT==667.0 &&SCREEN_WIDTH==375.0))

#define iPhone6plus        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

//#define  IS_X_ ((IS_IPHONE_X||IS_IPHONE_Xr||IS_IPHONE_Xs_Max)?YES:NO)
#define  IS_X_ (([UIScreen mainScreen].bounds.size.height) >= 812 ? YES : NO)

#define  DCTopNavH ((IS_X_)?88:64)

#define IsPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarCGFloatBasedI375 UIInterfaceOrientationPortraitUpsideDown)

///尺寸比率
#define  RATIO  (SCREEN_WIDTH/320)
#define  RATIO_IPHONE6  (SCREEN_WIDTH/375)
#define iphoneXTop    ((IS_X_)?20:0)

#define SCREEN_top    ((IS_X_)?44:44)+CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define SCREEN_Bottom    ((IS_X_)?34:0)
#define  Landscape_RATIO  (SCREEN_HEIGHT/320)

//-------------------适配-------------------------
UIKIT_STATIC_INLINE CGFloat CGFloatBasedI375(CGFloat size) {
    // 对齐到2倍数
    return trunc(size * UIScreen.mainScreen.bounds.size.width / 375 * 2) / 2.0;
}


/********** 颜色 **********/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 浅蓝色 */
#define LightBlue_Main_Color UIColorFromRGB(0x18C2EF)
/** 草绿色 在线状态 */
#define GrassGreen_Color UIColorFromRGB(0xB6DB19)
/** 教师端主色调 */
#define TeacherMain_Color UIColorFromRGB(0x79C108)
/** 黑色 */
#define Black_Color UIColorFromRGB(0x3B3E40)
/** 黑色(按钮) */
#define Black_Button_Color UIColorFromRGB(0x575966)
/** 红色 */
#define Red_Color UIColorFromRGB(0xFF0000)
/** 白色 */
#define White_Color UIColorFromRGB(0xffffff)
/** 导航条 浅白色 */
#define LightWhite_Color UIColorFromRGB(0xf6f6f6)
/** 浅蓝 */
#define LightBlue_Color UIColorFromRGB(0xD0E6EB)
/** 深蓝 */
#define Blue_Color UIColorFromRGB(0xACCDD9)
/** 字体灰色 */
#define FontGray_Color UIColorFromRGB(0xABABAB)
/** 浅灰色 */
#define LightGray_Color UIColorFromRGB(0xE8E8E8)
/** 线条灰色 */
#define LineGray_Color UIColorFromRGB(0xEFEFEF)
/** 按钮深灰 */
#define DarkGray_Color UIColorFromRGB(0x97948C)
/** 灰色边框色 */
#define BorderGray_Color  [[UIColor grayColor]CGColor]

/** 灰色 */
#define lineView_Color [UIColor colorWithHexString:@"#EDEDED"]
#define lightGrayCCCC_Color [UIColor colorWithHexString:@"#CCCCCC"]
#define lightGrayF5F5_Color [UIColor colorWithHexString:@"#F5F5F5"]
#define lightGray9999_Color [UIColor colorWithHexString:@"#999999"]

#define lightGrayEDED_Color [UIColor colorWithHexString:@"#EDEDED"]
#define lightGrayFFFF_Color [UIColor colorWithHexString:@"#FFFFFF"]
#define lightGrayE6E6_Color [UIColor colorWithHexString:@"#E6E6E6"]
#define lightGrayF5F9_Color [UIColor colorWithHexString:@"#F4F5F9"]
#define colorTabBackF4F8_Color [UIColor colorWithHexString:@"#F3F4F8"]
#define lightGray8888_Color [UIColor colorWithHexString:@"#888888"]
#define red2D55_Color [UIColor colorWithHexString:@"#FF2D55"]
#define lightGray1919_Color [UIColor colorWithHexString:@"#191919"]
#define lightGrayA1A1_Color [UIColor colorWithHexString:@"#A1A1A1"]
#define lightblack1A1A_Color [UIColor colorWithHexString:@"#1A1A1A"]
#define lightblack8A8A_Color [UIColor colorWithHexString:@"#8A8A88"]
#define lightGrayF0F0_Color [UIColor colorWithHexString:@"#F0F0F0"]
#define lightGrayA0A0_Color [UIColor colorWithHexString:@"#A0A0A0"]
#define lightGrayE5E5_Color [UIColor colorWithHexString:@"#E5E5E5"]
#define Black0607_Color [UIColor colorWithHexString:@"#0A0607"]
#define Black0000_Color [UIColor colorWithHexString:@"#000000"]
#define Black3333_Color [UIColor colorWithHexString:@"#333333"]
#define Blue2C84CC_Color [UIColor colorWithHexString:@"#2C84CC"]
#define Blue292929_Color [UIColor colorWithHexString:@"#292929"]
#define Black292929_Color [UIColor colorWithHexString:@"#292929"]

//导航栏和状态栏的高
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

//-------------------获取设备大小-------------------------
//判断是否为iPhone XS Max
#define kDevice_Is_iPhoneXRMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,  2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,  1792), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否为x
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否为78plus
#define kDevice_Is_iPhone78p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//NavBar高度
#define NavigationBar_HEIGHT 44
#define Navigation_HERGHT  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
#define iPhoneXBottomHeight  ([UIScreen mainScreen].bounds.size.height==812?34:0)
#define kTabBarHeight (kDevice_Is_iPhoneX ? 83 : 49)
#define kNavHeight (kDevice_Is_iPhoneX ? 88 : 64)
//#define DeviceXTabbarHeigh(a) (kDevice_Is_iPhoneX ?(a+34):a)
//#define DeviceXNavHeigh(a) (kDevice_Is_iPhoneX ?(a+24):a)
#define DeviceXTabbarHeigh(a) (kDevice_Is_iPhoneX ? (a+34):kDevice_Is_iPhoneXRMax?(a+34):kDevice_Is_iPhoneXR?(a+34) : a)

#define GD_AppKey @"b23830cc73d3a4e9cdc5660e19965293"
#define K_WX_AppID @"wxc16e17e3d8d36acd"
#define K_WX_AppSecret @"ffd1251ce1271c7a86ff94bd0e11e817"
#define K_ALIPAY_AppID @"2021002140616116"
#define K_QQ_AppID @"101967137"
#define K_QQ_AppSecret @"6263e92dbed5fab9490e29835bdfec48"
#define K_Sina_AppID @"3656628114"
#define K_Sina_AppSecret @"1dfbb1ebf2eb3609b08a9954eaa1f8fc"
#define K_Shengwang_AppID @"46258d7f18294b719d512873e1909dac"


#endif /* MacroDefinition_h */

/**iOS 11 automaticallyAdjustsScrollViewInsets的问题*/
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0,*))  {\
scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \

#define QM_kStatusBarHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define kStatusBarAndNavHeight (QM_kStatusBarHeight + 44.0)
#define QM_IS_iPHONEX  ((QM_kStatusBarHeight > 20)?YES:NO)

#define QM_kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define QM_kScreenHeight (QM_IS_iPHONEX ? ([[UIScreen mainScreen] bounds].size.height - 34) : ([[UIScreen mainScreen] bounds].size.height))
#define kScreenAllHeight  [[UIScreen mainScreen] bounds].size.height

#ifndef kScale6
#define kScale6 (UIScreen.mainScreen.bounds.size.width/375.0)
#endif


#define QMDeVice (([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)?YES:NO)

#define kInputViewHeight 75

#define QMHEXRGB(hex)   [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]


#define QMChatTextMaxWidth (QM_kScreenWidth - 67 * 2 - 30)
#define kSafeArea (QM_IS_iPHONEX ? 34.0 : 0)

#define isDarkStyle ([QMPushManager share].isStyle)

#define QMWeakSelf \
__weak typeof(self) self_weak_ = self;

//-------------------获取设备大小-------------------------
//判断是否为iPhone XS Max
#define kDevice_Is_iPhoneXRMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,  2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,  1792), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否为x
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否为78plus
#define kDevice_Is_iPhone78p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//NavBar高度
#define NavigationBar_HEIGHT 44
#define StatusHeight 20
#define Navigation_HERGHT  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
#define iPhoneXBottomHeight  ([UIScreen mainScreen].bounds.size.height==812?34:0)
#define kTabBarHeight (kDevice_Is_iPhoneX ? 83 : 49)
#define kNavHeight (kDevice_Is_iPhoneX ? 88 : 64)
#define DeviceXNavHeigh(a) (IS_X_ ? (a+24) : a)
//#define DeviceXTabbarHeigh(a) (IS_X_ ? (a+34) : a)

#define QMStrongSelf \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(self) self = self_weak_;\
_Pragma("clang diagnostic pop")


static NSString *QM_PingFangSC_Med = @"PingFangSC-Medium";
static NSString *QM_PingFangSC_Reg = @"PingFangSC-Regular";
static NSString *QM_PingFangSC_Lig = @"PingFangSC-Light";
static NSString *QM_PingFangTC_Sem = @"PingFangTC-Semibold";



typedef enum : NSUInteger {
    ChatCall_video_Invite = 1, /**主动视频邀请*/
    ChatCall_video_beInvited, /**视频被邀请*/
    ChatCall_voice_Invite, /**主动语音邀请*/
    ChatCall_voice_beInvited, /**视频被邀请*/
} ChatCallType;


#define kMenuKeight      44.0
#define kHeaderHeight    (200.0)

#define kNavBarHeight    44
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kTopBarHeight   (kNavBarHeight + kStatusBarHeight)
#define KScreenHeight   [UIScreen mainScreen].bounds.size.height
#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kRandomColor    [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]

#define kRandomColor_A(Alpha)    [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:(Alpha)]


typedef NS_ENUM(NSInteger,ShowViewState) {
    ShowViewNormalState=0, // 正常
    ShowViewNormalImage24State=1, // 正常
    ShowViewNormalImage40State=2, // 正常
};

//订单状态 1待付款  2已支付  3待收货  4待评论  5已完成  -1过期
typedef NS_ENUM(NSInteger, OrderStatue) {
    Order_wait_Pay = 1,      // 待支付
    Order_wait_deliver = 2,   // 2已支付
    Order_wait_recive= 3,     // 3已发货 待收货
    Order_wait_praise = 4,  // 4     已收货 待评论
    Order_finish = 20,         // 已取消
       Order_Guoqi = 40,         // 已过期
    Order_close = 50,         // 买家关闭订单
    Order_Allrefuse= 30,         // 退款关闭
    Order_Done= 100,         // 已完成
};
typedef NS_ENUM(NSInteger,RecOrSubStatus) {
    RecOrSubStatusRecharge=1, // 充值
    RecOrSubStatusSub= 2,     //提现
};
typedef NS_ENUM(NSInteger,RedBagStatus) {
    RedBagTakeStatus=1, // 自己发的红包 还未领取
    RedBagReciStatus= 2,     //自己发的红包 别人领取
    RedBagOtherStatus= 3,     //别人发的红包
    RedBagTranserStatus= 4,     //转账
};
typedef NS_ENUM(NSInteger,LibaoStatus) {
    LibaoStatusCommon=0, // 普通商品
    LibaoStatusShopCar= 1,     //购物车
    LibaoStatusSureOrder= 2,     //确认订单
    LibaoStatusSureCollect=3, // 收藏
    LibaoStatusSureRecycle=4, // 回收
    LibaoStatusGoodCar=5, // 货物卡
    LibaoStatusGoodCarForm=6, // 购物车
    LibaoStatusChatGoodCar=7, // 聊天
    LibaoStatusGoodCarSub=8, // 提货
    LibaoStatusGoodCarRecord=9, // 货物数字商品
};
typedef NS_ENUM(NSInteger,GoodCarStatus) {
    GoodCarStatusTihuo=0, // 提货
    GoodCarStatusRecyle= 1,     //回收
    GoodCarStatusJiesan= 3,     //解散礼包
    GoodCarStatusHebing=4, // 合并

};
typedef NS_ENUM(NSInteger,DoorRuzhuStatus) {
    DoorRuzhuNewStatus=0, // 入驻
    DoorRuzhuShenheStatus= 1,     //审核中
    DoorRuzhuRefuseStatus= 50,     //拒绝
};
typedef NS_ENUM(NSInteger,OrderRefundState) {
    OrderRefundOnlyMonState=1, // 仅退款
    OrderRefundBothMonState= 2,     //退货退款
    OrderRefundStockState= 3,     //库存补发
    OrderRefundExpressState= 4,     //退货退款 已通过状态
};
typedef NS_ENUM(NSInteger,RoleStatus) {
    RoleStatusRedBag=1, // 惊喜红包
    RoleStatusStore=2, // 零售区
    RoleStatusPingjian=3, // 品鉴
    RoleStatusMainDetails=4, // 首页详情
    RoleStatusShopCar=5, // 购物车
    RoleStatusPeisong=6, // 配送员
    RoleStatusTuiguang=7, // 推广员
    RoleStatusStockPeisong=8, // 配送库存
    RoleStatusWaitOrder=9, // 待接单
    RoleStatusHadOrder=10, // 已接单
    RoleStatusDoneOrder=11, // 已完成
    RoleStatusTransOrder=12, // 已转单
    RoleStatusGeneral=13, // 普通用户

};
#define APPKEYHX @"1128210407148694#uu"
#define SHOPCARCOUNT @"SHOPCARCOUNT"

#define KEYGOODS @"goods"//货物卡
#define KEYREDBAG @"redbag"//红包
#define KEYTRANSTER @"transfer"//转账
#define KEYTSUCCESS @"redbagSucc"//红包转账成功
#define KEYQIAODAO @"Qiandao"//红包转账成功
#define KEYGOODDETAIL @"order_goods"//商品
#define KEYLOCATION @"location"//定位
#define KEYMINGPIAN @"mingpian"//名片
#define KEYTGROUP @"grouphi"//群聊打招呼

#define KEYSTATE @"state"//

