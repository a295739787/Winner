//
//  HttpAdress.h
//  HuaSheng
//
//  Created by 杨波 on 2018/5/3.
//  Copyright © 2018年 ebenny. All rights reserved.
//  网络接口API地址

#ifndef HttpAdress_h
#define HttpAdress_h

#define kSmartDeviceLoginTokenKey @"token"
#define MORENODATA @"zanwushuju"

/*
 原型地址：https://u.pmdaniu.com/Any23
 接口地址：http://dyj.gzchuangtuo.com/swagger-ui/index.html#/
 接口域名:http://ds21015.gddishu.com/  */
//#define API_HOST @"http://192.9.200.148/"
//#define ImageUrl @"http://192.9.200.148/"

#define KEY128 @"izr3fM*(PQxtckLV"
#define KEYIV @"9N-^bkRq831FziJj"
#define APPID @"10102"
#define APPKEY @"G#nJr$e%Ub3H0gOITQ1(FcYmq67vZ&S*8NC9RLdlAM^hDBPyVkw!jto=)sXE"
#define APPVERSION @"1.0.1"
#define DEVICEID UIDevice.currentDevice.identifierForVendor.UUIDString

//  线下
//#define API_HOST @"http://api_test.dayingjiamall.com"
//#define API_IMAGEHOST @"http://api_test.dayingjiamall.com/api/file/Image/images/"
//#define apiQiUrl @"http://api_test.dayingjiamall.com"
//  线上
#define API_HOST @"https://api.dayingjiamall.com"
#define API_IMAGEHOST @"https://api.dayingjiamall.com/api/file/Image/images/"
#define apiQiUrl @"https://api.dayingjiamall.com"


//#define API_imageUrl @"http://img01.lygouwu.com/"
//#define apiQiUrl @"http://qr4pnc7zx.hn-bkt.clouddn.com/"
//#define API_imageUrl @"http://qr4pnc7zx.hn-bkt.clouddn.com/cats/"
//#define API_HOST @"http://vuedemo.mohuifu.top/"
//#define ImageUrl @"http://vuedemo.mohuifu.top"

#define L_getUser @""
#define MORENNODATA @"img_quesheng"

#define findTag @"find"  //发现
#define signTag @"sign"  //签到
#define preferredTag @"preferred"  //优选
#define discountTag @"discount"  //   特惠
#define popularityTag @"popularity"  //人气
#define fgood_productTag @"good_product"  //好物
#define brand_onlineTag @"brand_online"  // 品牌直供




/*  发送验证码  */
#define L_apiappsmssend @"/api/app/sms/send"
/*  获取声网token  */
#define L_imagora @"/im/agora"

/*  提现  */
#define L_apiappuserbalancewithdrawal @"/api/app/user/balance/withdrawal"

/*  售后详情  */
#define L_apiapporderaftergetById @"/api/app/order/after/getById"

/*  登录  */
#define L_apioauthLogin @"/api/oauth/Login"
/*  零售区  */
#define L_apiappgoodshome @"/api/app/goods/home"
/* 详情 */
#define L_apiappgoodshomegetInfo  @"/api/app/goods/getInfo"
/* 规格详情 */
#define L_apiappgoodgetGoodsSpecsPrice  @"/api/app/goods/getGoodsSpecsPrice"
/* 加入购物车 */
#define L_apiappcartadd  @"/api/app/cart/add"
/* 获取确认订单 */
#define L_apiapporderconfirm  @"/api/app/order/confirm"
/* 验证当前定位是否存在队列（空则没有队列） */
#define L_apiapporderqueuecity  @"/api/app/order/queue/city"

/* 惊喜红包商品购买记录 */
#define L_apiappredgoodsgetList  @"/api/app/red/goods/getList"
/* 上传图片 */
#define L_apifileUploaderimages  @"/api/file/Uploader/images"
/* 轮播图 */
#define L_apiappgoodsgetGoodsCarousel  @"/api/app/goods/getGoodsCarousel"
/* 售后订单 */
#define L_apiapporderaftergetList  @"/api/app/order/after/getList"
/* 售后订单删除 */
#define L_apiapporderaftergetdel  @"/api/app/order/after/del"
/* 选择地址*/
#define L_apiapporderupdateAddress  @"/api/app/order/updateAddress"



/* 发布评价 */
#define L_apiappgoodstevaluateadd  @"/api/app/goods/evaluate/add"

/* 提交订单 */
#define L_apiappordersubmit  @"/api/app/order/submit"
/* 订单支付成功信息 */
#define L_apiapporderpaysuccess  @"/api/app/order/pay/success"
/* 支付 */
#define L_apiapppay  @"/api/app/pay"
/* 品鉴 */
#define L_apiappjudgegoodsgetJudgeGoodsList  @"/api/app/judge/goods/getJudgeGoodsList"

/* 首页 */
#define L_apiappgoodshome  @"/api/app/goods/home"
/* 购物车 */
#define L_apiappcartgetList  @"/api/app/cart/getList"
/* 购物车加减 */
#define L_apiappcarteditNum  @"/api/app/cart/editNum"
/* 购物车删除 */
#define L_apiappcartdel  @"/api/app/cart/del"

/* 惊喜红包详情 */
#define L_apiappredgoodsgetRedById  @"/api/app/red/goods/getRedById"

/* 货物评价列表 */
#define L_apiappgoodsevaluategetList  @"/api/app/goods/evaluate/getList"

/* 取消售后 */
#define L_apiapporderaftercancel  @"/api/app/order/after/cancel"


/* 推广点申请 */
#define L_apiappusershopapply  @"/api/app/user/shop/apply"
/* 配送员申请 */
#define L_apiappuserdeliveryapply  @"/api/app/user/delivery/clerk/apply"
/* 配送员申详情 */
#define L_apiappuserdeliverygetById  @"/api/app/user/delivery/clerk/getById"
/* 推广点申请详情 */
#define L_apiappusershopgetById  @"/api/app/user/shop/getById"

/* 配送库存 */
#define L_apiappjudgegoodsdiststockgetList  @"/api/app/judge/goods/dist/stock/getList"

/* 任务大厅*/
#define L_apiapptaskorderlist  @"/api/app/task/order/list"
/* 抢单*/
#define L_apiapptaskordertask  @"/api/app/task/order/task"
/* 提货核销*/
#define L_apiapptaskorderpick  @"/api/app/task/order/pick"
/* 获取任务订单数量*/
#define L_apiapptaskordernum  @"/api/app/task/order/num"
/* 惊喜红包列表*/
#define L_apiappredgoodsgetRedGoodsList  @"/api/app/red/goods/getRedGoodsList"
/* 绑定手机号*/
#define L_apiapptaskbindphone  @"/api/app/user/bind/phone"
/* 退出登录*/
#define L_apioauthLogout  @"/api/oauth/Logout"
/* 退出登录*/
#define L_apiappuserLogout  @"/api/app/user/logout"

/* 获取零售区商品列表*/
#define L_apiappgoodsgetGoodsList  @"/api/app/goods/getGoodsList"

/* 转单*/
#define L_apiapptaskorderturn  @"/api/app/task/order/turn"
/* 个人中心 */
/* 获取用户信息 */
#define L_getUserInfo  @"/api/app/user/getUserInfo"
/* 获取提现提示 */
#define L_getById @"/api/app/system/config/getById/APPWithdrawTips"
/* 编辑用户信息 */
#define L_UpdateUserInfo @"/api/app/user/updateById"
/* 推广员信息编辑 */
#define L_updateUserById @"/api/app/user/updateUserById"

/* 实名认证 */
#define L_RealAuth @"/api/app/user/realAuth"
/* 添加银行卡*/
#define L_addBankUrl @"/api/app/user/bank/add"
/* 确认收货*/
#define L_apiapporderconfirmReceive @"/api/app/order/confirmReceive"
/* 删除订单*/
#define L_apiapporderdelete @"/api/app/order/delete"
/*取消订单*/
#define L_apiappordercancel @"/api/app/order/cancel"
/* 申请开票*/
#define L_getOrderBillPodurl @"/api/app/order/invoice/apply"
/* 获取开票详情*/
#define L_getOrderBillDeialUrl @"/api/app/order/invoice/getById"

/*消息列表*/
#define L_messageUrl @"/api/app/user/getMessageList"
/*消息详情*/
#define L_messageInfoUrl @"/api/app/user/getMessageInfo"

/*提交快递信息*/
#define L_apiapporderaftereditExpress @"/api/app/order/after/editExpress"

/* 库存 回购中心*/
#define L_StorageUrl @"/api/app/red/goods/stock/getList"
/* 我的库存-获取提货下单*/
#define LL_StorageTakeUrl @"/api/app/red/goods/stock/take"
/* 提货下单*/
#define L_StorageTakeOrderUrl @"/api/app/red/goods/stock/take/order"
/* 回购记录*/
#define L_redgoodsbuybackbyId @"/api/app/red/goods/buy/back/byId"
/* 查看物流*/
#define L_apiappordergetExpress @"/api/app/order/getExpress"
/* 获取快递 */
#define L_apiapporderafterExpress @"/api/app/order/after/getExpress"

/* 0元*/
#define L_apiapporderpayZero @"/api/app/order/payZero"


/* 回购记录*/
#define L_BackBuybackListUrl @"/api/app/red/goods/buy/back/goods/getList"
/* 回购记录*/
#define L_BackBuyListUrl @"/api/app/red/goods/buy/back/getList"
/* 回购记录详情*/
#define L_BackBuyDetailUrl @"/api/app/red/goods/buy/back/getById"
/* 回购中心-回购下单*/
#define L_BackBuyPodUrl @"/api/app/red/goods/buy/back/order"

/*申请售后*/
#define L_apiapporderafterapply @"/api/app/order/after/apply"

/* 库存明细*/
#define L_getUserStockDetail @"/api/app/user/getUserStockDetail"
/* 用户钱包(累计收入/累计支出/余额)*/
#define L_getUserWallet @"/api/app/user/getUserWallet"
/* 用户钱包-明细*/
#define L_getRecord @"/api/app/user/balance/getRecord"
/* 用户钱包-明细详情*/
#define L_getUserRecordByrId @"/api/app/user/balance/getUserRecordByrId"

/* 收货地址 */
 /* 获取行政区域 */
#define L_provinceUrl @"/api/app/user/province/list"
 /* 收货地址列表 */
#define L_adressListUrl @"/api/app/receive/address/list"
 /* 添加收货地址 */
#define L_addAdressUrl @"/api/app/receive/address/add"
  /* 删除收货地址 */
#define L_deleteAdressUrl @"/api/app/receive/address/del"
/* 设置默认地址 */
#define L_adressIsDefaultUrl @"/api/app/receive/address/default"
/*排行榜 */
#define L_apiappgoodsgetRankingList @"/api/app/goods/getRankingList"
/* h5 */
#define L_apiappsystemconfiggetById @"/api/app/system/config/getById"

 /* 分享好友 */
/* 推广用户统计 */
#define L_promoteTeamUrl @"/api/app/user/balance/profit/user/team"
/* 推广用户列表 */
#define L_promoteUserListUrl @"/api/app/user/balance/profit/user/getList"
/* 交易记录 */
#define L_blanceListUrl @"/api/app/user/balance/getList"
/* 推广佣金明细*/
#define L_promoteDeatailUrl  @"/api/app/user/balance/profit/user/detail"

 /* 发票抬头 */
/* 添加编辑发票抬头 */
#define L_editorInvoceUrl  @"/api/app/invoice/add"
/* 发票抬头列表*/
#define L_invoceListUrl @"/api/app/invoice/getList"
/*删除发票*/
#define L_deleteBillUrl @"/api/app/invoice/del"

/* 系统设置 */
 /* 常见问题 */
#define L_getQuestionListUrl @"/api/app/system/problem/getList"
/*意见反馈*/
#define L_feedVackUrl @"/api/app/system/feedback/add"

/* 物流 */


 /* 我的订单 */
/* 订单列表 */
#define L_orderListUrl @"/api/app/order/getList"
#define L_orderDetailUrl @"/api/app/order/getById"

/* 我的酒卡 */
/* 绑卡 */
#define L_cardBindUrl @"/api/app/card/bind"
/* 酒卡列表 */
#define L_cardGetListUrl @"/api/app/card/getList"
/* 酒卡明细_当前酒卡 */
#define L_cardGetMyStockUrl @"/api/app/user/getMyStockDetail"
/* 酒卡明细_当前账号 */
#define L_cardGetBindRecordByUserId @"/api/app/card/getBindRecordByUserId"
/* 酒卡背景 */
#define L_cardGetSetInfoUrl @"/api/app/card/getSetInfo/1"

/* 推送消息 */
/* 已读 */
#define L_pushReadMessageUrl @"/api/app/user/readMessage"

#endif /* HttpAdress_h */
