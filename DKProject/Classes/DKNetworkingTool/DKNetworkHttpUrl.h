//
//  DKNetworkHttpUrl.h
//  GardenManager
//
//  Created by 王 on 2019/6/14.
//  Copyright © 2019 wisezone. All rights reserved.
//

#define  CML_Private_KEY @"VyODgyMjMzHuAZGlmZmMDkdOG=" //请求参数加密

#if DEBUG
#define DK_BaseUrl [[NSUserDefaults standardUserDefaults] valueForKey:NewUrlStringUserDefault]?:NewDevelopmentUrlString
#else
#define DK_BaseUrl NewDistributionUrlString
#endif

#if DEBUG
#define DK_BaseH5Url [[NSUserDefaults standardUserDefaults] valueForKey:NewH5UrlStringUserDefault]?:NewH5DevelopmentUrlString
#else
#define DK_BaseH5Url NewH5DistributionUrlString
#endif

#define NewDevelopmentUrlString @"http://hxapi.fudaojun.com/"//新测试接口地址
#define NewDistributionUrlString @"https://hxapi.huaxin.club/"//新正式接口地址

#define NewH5DevelopmentUrlString @"http://wb.dytest.dayi.im/hx/"//新h5测试接口地址
#define NewH5DistributionUrlString @"https://h5.huaxin.club/"//新h5正式接口地址

#define NewLocalUrlString @"http://fudaojun.f3322.net:8003/"//新本地接口地址

///当前地址
#define NewUrlStringUserDefault @"NewGardenManagerUrlString"
///当前h5地址
#define NewH5UrlStringUserDefault @"NewH5GardenManagerUrlString"


#pragma - mark V4 Api
#pragma - mark 商品
/// 新增/编辑商品
static NSString * const V4_Goods_PostAdd = @"api/v4/goods/add";
/// 商品详情
static NSString * const V4_Goods_GetDetail = @"api/v4/goods/detail";
/// 商品列表
static NSString * const V4_Goods_GetList = @"api/v4/goods/list";

#pragma - mark Active Api
#pragma - mark 浇水活动
///浇水/领露珠
static NSString * const Active_PostAddWater = @"api/active/add_water";

#pragma - mark Goods Api
#pragma - mark 商品
///新增/编辑商品
static NSString * const V3_Goods_PostAdd = @"api/v3/goods/add";
///商品详情
static NSString * const V3_Goods_GetDetail = @"api/v3/goods/detail";
///商品列表
static NSString * const V3_Goods_GetList = @"api/v3/goods/list";
///上架/下架/删除商品
static NSString * const V3_Goods_PutUpdate = @"api/v3/goods/update";
///添加分销商品到店铺
static NSString * const V3_Goods_PostAddDistributionGoodToStore = @"api/v3/goods/addDistributionGoodToStore";
///商品列表
static NSString * const V3_Goods_GetCollectStoreGoodsList = @"api/v3/goods/collectStoreGoodsList";
///分销商品类别
static NSString * const V3_Goods_GetDistributionGoodsClassify = @"api/v3/goods/distributionGoodsClassify";
///分销商品详情
static NSString * const V3_Goods_GetDistributionGoodsDetail = @"api/v3/goods/distributionGoodsDetail";
///分销商城
static NSString * const V3_Goods_GetDistributionGoodsList = @"api/v3/goods/distributionGoodsList";
///我的分销
static NSString * const V3_Goods_GetListMyDistributionGoods = @"api/v3/goods/getListMyDistributionGoods";
///下架分销商品
static NSString * const V3_Goods_PostRemoveDistributionGoods = @"api/v3/goods/removeDistributionGoods";

#pragma - mark 商品分类
///新增/编辑商品分类
static NSString * const V3_Goods_PostClassAdd = @"api/v3/goods/class/add";
///删除商品分类
static NSString * const V3_Goods_DeleteClassDel = @"api/v3/goods/class/del";
///商品分类列表
static NSString * const V3_Goods_GetClassList = @"api/v3/goods/class/list";

#pragma - mark 运费模版
///新增/编辑运费模版
static NSString * const V3_Goods_PostTempAdd = @"api/v3/goods/temp/add";
///删除运费模版
static NSString * const V3_Goods_DeleteTempDel = @"api/v3/goods/temp/del";
///运费模版列表
static NSString * const V3_Goods_GetTempList = @"api/v3/goods/temp/list";


#pragma - mark pay Api
#pragma - mark 支付
///支付宝
static NSString * const AliPay_PostPayApp = @"api/pay/alipay/app";
///微信App支付
static NSString * const WX_PostPayApp = @"api/pay/wx/app";


#pragma - mark V3 Api
#pragma - mark 版面详情
///美图/问答列表
static NSString * const V3_Botany_GetNewsList = @"api/v3/botany/get_news_list";

#pragma - mark 店铺

///申请开店
static NSString * const V3_Store_PostApplyStore = @"api/v3/store/applyStore";
///校验邀请码的合法性
static NSString * const V3_Store_GetCheckStoreCode = @"api/v3/store/checkStoreCode";
///店铺收藏/取消收藏
static NSString * const V3_Store_PutCollect = @"api/v3/store/collect";
///我的店铺收藏
static NSString * const V3_Store_GetCollectList = @"api/v3/store/collect_list";
///我收藏的店铺详情
static NSString * const V3_Store_GetDetail = @"api/v3/store/detail";
///银行列表
static NSString * const V3_Store_GetBankList = @"api/v3/store/getBank";
///店铺标签列表
static NSString * const V3_Store_GetStoreTagList = @"api/v3/store/getStoreTag";
///团队收益
static NSString * const V3_Store_GetTeamData = @"api/v3/store/getTeamData";
///店铺主页
static NSString * const V3_Store_PostHome = @"api/v3/store/home";
///店铺详情
static NSString * const V3_Store_GetItem = @"api/v3/store/item";
///修改店铺信息
static NSString * const V3_Store_PutModify = @"api/v3/store/modify";
///店铺详情(新)
static NSString * const V3_Store_GetNewItem = @"api/v3/store/newItem";
///修改店铺banner信息
static NSString * const V3_Store_PutUpdateBanner = @"api/v3/store/update_banner";
///店铺收支统计
static NSString * const V3_Store_GetStoreAcc = @"api/v3/store/store_acc";
///店铺收支明细
static NSString * const V3_Store_GetStoreItem = @"api/v3/store/store_item";
///提现
static NSString * const V3_Store_PutWithdrawal = @"api/v3/store/withdrawal";
///提现详情
static NSString * const V3_Store_GetWithdrawalDetail = @"api/v3/store/withdrawal_detail";
///提现记录
static NSString * const V3_Store_GetWithdrawalList = @"api/v3/store/withdrawal_list";

#pragma - mark 订单管理
///取消订单
static NSString * const V3_Order_PutNewCancel = @"api/v3/order/newCancel";
///订单详情
static NSString * const V3_Order_GetNewDetail = @"api/v3/order/newDetail";
///订单列表
static NSString * const V3_Order_GetOrderList = @"api/v3/order/orderList";
///立即发货
static NSString * const V3_Order_PutNewSendDelivery = @"api/v3/order/newSendDelivery";

#pragma - mark 发帖管理
///帖子详情
static NSString * const V3_News_GetNewsDetail = @"api/v3/news/get_news_detail";
///帖子回复列表
static NSString * const V3_News_GetNewsReply = @"api/v3/news/get_news_reply";
///帖子列表
static NSString * const V3_News_GetList = @"api/v3/news/list";

#pragma - mark 个人中心
///个人中心
static NSString * const V3_User_GetMe = @"api/v3/user/get_me";
///打卡
static NSString * const V3_User_Punch = @"api/v3/user/punch";
///附近花友
static NSString * const V3_User_GetNearUser = @"api/v3/user/getNearUser";

///获取赠品领取状态
static NSString * const V3_User_GetReceiveStatus = @"api/v3/user/getReceiveStatus";
///赠品领取
static NSString * const V3_User_PostActivityReceive = @"api/v3/user/activityReceive";

#pragma - mark 贡献榜
///月榜
static NSString * const V3_User_GetUserRank = @"api/v3/user/getUserRank";


#pragma - mark 收货地址
/// 区
static NSString * const V3_Store_GetArea = @"api/v3/store/area";
/// 市
static NSString * const V3_Store_GetCity = @"api/v3/store/city";
/// 省
static NSString * const V3_Store_GetProvince = @"api/v3/store/province";

#pragma - mark 首页
///启动图
static NSString * const V3_Index_GetLaunchPage = @"api/v3/index/get_launch_page";
///唤醒
static NSString * const V3_Index_PostUpdateState = @"api/v3/index/get_update_state";
///首页banner
static NSString * const V3_Index_GetHomePage = @"api/v3/index/hm_home_page";
///时景美图
static NSString * const V3_Index_GetHomeSt = @"api/v3/index/hm_home_st";
///首页个人统计信息弹窗
static NSString * const V3_Index_GetRemind = @"api/v3/index/hmt_remind";
///搜索
static NSString * const V3_Index_Search = @"api/v3/index/search";
///获取天气
static NSString * const V3_Index_Weather = @"api/v3/index/weather";
///获取分享二维码
static NSString * const V3_Index_QrCode = @"api/v3/index/qcode";

#pragma - mark 我的花园
///花园四季
static NSString * const V3_Garden_GardenSeasons = @"api/v3/garder/garden_seasons";
///花园四季-列表
static NSString * const V3_Garden_GardenSeasonsList = @"api/v3/garder/garden_seasons_list";

#pragma - mark 植物大全
///一级,二级大类
static NSString * const V3_Botany_GetItem = @"api/v3/botany/hm_item";
///三级大类
static NSString * const V3_Botany_GetPlanList = @"api/v3/botany/plan_list";
///四级大类
static NSString * const V3_Botany_GetPlanSon = @"api/v3/botany/plan_son";


#pragma - mark V2 Api
#pragma - mark 版本更新
///版本更新
static NSString * const Login_PostGetVersion = @"api/v2/login/get_version";

#pragma - mark 登录注册模版
///微信登录注册
static NSString * const Login_PostWxBind = @"api/v2/login/wx_bind";

#pragma - mark 首页模版
///消息-（新）
static NSString * const Index_GetNewsReply = @"api/v2/index/get_news_reply";
///未读消息数-（新）
static NSString * const Index_GetNoticeCount = @"api/v2/index/get_notice_count";
///消息
static NSString * const Index_PostNewsReply = @"api/v2/index/get_news_reply";
///热门搜索
static NSString * const Index_GetPopularSearches = @"api/v2/index/get_popular_searches";

#pragma - mark 个人中心
///个人中心
static NSString * const User_GetMe = @"api/v2/user/get_me";
///我发表的
static NSString * const User_GetNewsListPerson = @"api/v2/user/get_news_list_person";
///我的收藏列表
static NSString * const User_GetNewsMyStore = @"api/v2/user/get_news_my_store";
///我参与的
static NSString * const User_GetNewsMyReply = @"api/v2/user/get_news_my_reply";
///我的关注/我的粉丝
static NSString * const User_GetMyFans = @"api/v2/user/get_my_fans";
///关注/取消关注
static NSString * const User_PostSetAtten = @"api/v2/user/set_atten";
///更新个人信息
static NSString * const User_PostSetUserInfo = @"api/v2/user/set_user_info";
///用户发表的晒图和精华 过滤了问答帖子
static NSString * const User_GetOtherNewsListPerson = @"api/v2/user/get_othernews_list_person";
///用户发表的问题
static NSString * const User_GetOtherProblemListPerson = @"api/v2/user/get_otherproblem_list_person";
///微信绑定
static NSString * const User_PostWxBind = @"api/v2/user/wx_bind";


#pragma - mark 个人中心-版主
///我的版块
static NSString * const User_GetMySection = @"api/v2/user/get_my_section";
///植物版块
static NSString * const User_GetPlantNews = @"api/v2/user/get_plant_news";
///修订申请/审核记录
static NSString * const User_GetRevisionList = @"api/v2/user/get_revision_list";
///审核记录详情-是否有操作权限
static NSString * const User_GetCheckAuth = @"api/v2/user/check_auth";


#pragma - mark 个人中心-专家
///品种审核/审核记录
static NSString * const User_GetPlantRevisionList = @"api/v2/user/get_plant_revision_list";


#pragma - mark 发帖管理
///帖子详情
static NSString * const News_GetNewsDetail = @"api/v2/news/get_news_detail";
///版主模块-帖子详情
static NSString * const News_GetAdminNewsDetail = @"api/v2/news/news_detail";

#pragma - mark 帖子管理
///发帖子
static NSString * const News_PostAddNews = @"api/v2/news/add_news";
///帖子加精
static NSString * const News_PostAddJH = @"api/v2/news/add_jh";
///取消加精
static NSString * const News_PostCancelJH = @"api/v2/news/canal_jh";
///版主屏蔽文章
static NSString * const News_PostBlockArticles = @"api/v2/news/block_articles";
///版主解除屏蔽文章
static NSString * const News_PostUnBlockArticles = @"api/v2/news/un_block_articles";
///编辑帖子
static NSString * const News_PostEditNews = @"api/v2/news/edit_news";
///问答选项
static NSString * const News_GetWDOption = @"api/v2/news/wd_option";
///问答搜索
static NSString * const News_GetWDSearch = @"api/v2/news/wd_search";
///更改文章所属植物版块
static NSString * const News_PostEditNewsPlant = @"api/v2/news/edit_news_plant";


#pragma - mark 植物大全
///三级-植物详情
static NSString * const Botany_PostGetPlantInfo = @"api/v2/botany/get_plant_info";
///搜索
static NSString * const Botany_PostGetPlantListSearch = @"api/v2/botany/get_plant_list_search";
///一级,二级大类
static NSString * const Botany_PostHMItem = @"api/v2/botany/hm_item";
///三级大类
static NSString * const Botany_PostPlantList = @"api/v2/botany/plan_list";
///四级大类
static NSString * const Botany_GetPlanSon = @"api/v2/botany/plan_son";
///收藏/取消收藏
static NSString * const V1_Botany_PostSetPlantStore = @"api/v1/botany/set_plant_store";
///收藏/取消收藏
static NSString * const Botany_PostSetPlantStore = @"api/v2/botany/set_plant_store";
///四级大类植物简介
static NSString * const Botany_PostSonInfo = @"api/v2/botany/son_info";


#pragma - mark V1 Api
#pragma - mark Person
///是否有手机，昵称，头像
static NSString * const HMGetUserStat = @"api/v1/index/get_user_stat";
///修改个人资料
static NSString * const HMUpdateUser = @"api/v1/index/update_user";
///个人资料
static NSString * const HMGetMeCount = @"api/v1/index/get_me";
///手机号注册
static NSString * const HMRegister = @"api/v1/login/login";
///微信注册
static NSString * const HMRegisterWX = @"api/v1/login/wx_bind";
///绑定微信
static NSString * const HMWXBind = @"api/v1/index/wx_bind";
///发送验证码
static NSString * const HMSetMobileCode = @"api/v1/login/verif_code";
///校验验证码
static NSString * const DCXVerifyMobileCode = @"DCXVerifyMobileCode.ashx";
///修改密码
static NSString * const HMUserPwdMod = @"HMUserPwdMod.ashx";
///找回密码
static NSString * const HMUserPwdGet = @"HMUserPwdGet.ashx";
///绑定手机号
static NSString * const HMBindMobile = @"api/v1/index/bind_mobile";
/////激活　统计　唤醒 0  注册1  登录2
static NSString * const HMUserUpdateStat = @"api/v1/index/get_update_state";
///举报用户
static NSString * const HMUserReport = @"api/v1/user/hm_user_report";
///发送意见反馈 type == 1
static NSString * const HMAddUserAdvice = @"api/v1/user/add_user_advice";
///发送意见反馈 type == 2
static NSString * const HMAddPlantAdvice = @"api/v1/user/add_plant_advice";

#pragma - mark News
///全屏图片
static NSString * const HMGetLaunchPage = @"api/v1/index/get_launch_page";
///首页弹框
static NSString * const HMGetRemind = @"api/v1/index/hmt_remind";
///分类列表
static NSString * const HMGetItem = @"api/v1/botany/hm_item";
///子分类详情
static NSString * const HMGetSonInfo = @"api/v1/botany/son_info";
///四级列表
static NSString * const HMGetPlantSon = @"api/v1/botany/plan_son";
///成长记录
static NSString * const HMGetNewsListST = @"api/v1/user/get_news_list_st";
///植物列表
static NSString * const HMGetPlantListNew = @"api/v1/botany/plan_list";
///搜索植物
static NSString * const HMGetPlantListSearch = @"api/v1/botany/get_plant_list_search";
///我的植物
static NSString * const HMGetMyGarden = @"api/v1/garder/my_garden";
///关注植物
static NSString * const AHMSetPlantStore = @"api/v1/botany/set_plant_store";
///申请加精
static NSString * const HMUserReportJH = @"api/v1/user/user_report_jh";
///发帖子
static NSString * const HMAddNews = @"api/v1/news/add_news";
///编辑帖子
static NSString * const HMEditNews = @"api/v1/news/edit_news";
///发晒图
static NSString * const AHMAddNewsPic = @"api/v1/news/add_news_pic";
///删除帖子
static NSString * const HMDelNews = @"api/v1/news/del_news";
///专题详情
static NSString * const HMGetTagInfo = @"api/v1/index/get_tag_info";
///首页
static NSString * const HMGetHomePage = @"api/v1/index/hm_home_page";
///首页晒图
static NSString * const HMGetHomePageST = @"api/v1/index/hm_home_st";
///版面
static NSString * const HMGetPlantInfo = @"api/v1/garder/get_plant_info";
///获取帖子列表
static NSString * const HMGetNewsList = @"api/v1/garder/get_news_list";
///我发表的
static NSString * const HMGetNewsListPerson = @"api/v1/user/get_news_list_person";
///我收藏的
static NSString * const HMGetNewsMyStore = @"api/v1/user/get_news_my_store";
///我参与的
static NSString * const HMGetNewsMyReply = @"api/v1/user/get_news_my_reply";
///草稿箱
static NSString * const HMGetMyDraft = @"api/v1/news/get_my_draft";
///消息
static NSString * const HMGetNewsReplyMe = @"api/v1/index/get_news_reply";
///删除消息
static NSString * const HMNewsReplyMeDel = @"HMNewsReplyMeDel.ashx";
///标记消息
static NSString * const HMNewsReplyMeRead = @"api/v1/index/reply_meread";
///获取详情页
static NSString * const HMGetNewsDetail = @"api/v1/news/get_news_detail";
///获取评论列表
static NSString * const HMGetNewsReply = @"api/v1/news/get_news_reply";
///发评论
static NSString * const HMAddNewsReply = @"api/v1/news/add_news_reply";
///删除评论
static NSString * const HMNewsReplyDel = @"api/v1/news/deply_del";
///点赞
static NSString * const HMSetNewsStore = @"api/v1/news/set_news_store";
///收藏
static NSString * const HMSetNewsCollect = @"api/v1/news/set_news_collect";
///话题列表
static NSString * const AHMGetSon = @"AHMGetSon.ashx";
///花信币流水
static NSString * const HMGetUserGoldLog = @"api/v1/user/get_gold_log";
///贡献榜 Type 0周榜
static NSString * const HMGetUserRankWeek = @"api/v1/user/rank_week";
///贡献榜 Type 1总榜  
static NSString * const HMGetUserRank = @"api/v1/user/get_user_rank";



#pragma - mark h5 地址

#define DK_PROTOCOL_URL @"https://h5.huaxin.club/mobile/rule.html"// 用户协议.
#define DK_ABOUT_URL @"https://h5.huaxin.club/mobile/about.html"// 关于我们.
#define DK_SHARE_URL @"https://h5.huaxin.club/share/index.html"// 分享页面.

///用户协议
static NSString * const H5_Mobile_Rule = @"mobile/rule.html";
///关于我们
static NSString * const H5_Mobile_About = @"mobile/about.html";
///分享页面
static NSString * const H5_Share_Index = @"share/index.html";

///植物三级编辑
static NSString * const H5_Plant_Plant = @"plant/plant.html";
///植物四级编辑
static NSString * const H5_Plant_Varieties = @"plant/varieties.html";
///植物版主审核
static NSString * const H5_Plant_Audio = @"plant/audit.html";
///添加品种
static NSString * const H5_Plant_SubmitSon = @"plant/submitSon.html";
///品种审核
static NSString * const H5_Plant_AudioSon = @"plant/audit_son.html";
///个人浇水页面
static NSString * const H5_Water_Water = @"water/water.html";
///他人浇水页面
static NSString * const H5_Water_OtherWater = @"water/otherwater.html";
///更多动态
static NSString * const H5_Water_List = @"water/list.html";
///申请店铺协议
static NSString * const H5_ApplyShop_Protocol = @"mobile/explanation.html";


#pragma - mark 小程序地址

///四级详情链接  url: '/pages/wikipedia/details/index?sid='+ 参数sonid +'&title='+参数植物名称 + '&nameId='+参数  nameid
static NSString * const MiniProgramObject_SonDetail = @"/pages/wikipedia/details/index?";
///三级栽培链接  url: '/pages/wikipedia/third/index?nameId=' + nameId + '&sonId=' + sonId + '&title=' + name
static NSString * const MiniProgramObject_PlantDetail = @"/pages/wikipedia/third/index?";
/// 店铺链接 url: pages/shop/indexOther/index?storecode=c81524bcd5054f1bbe928f41a8cd6368&tab=2
/// tab=0 介绍 tab=1 动态 tab=2 商品 tab=3 上新
static NSString * const MiniProgramObject_Shop = @"/pages/shop/indexOther/index?";




