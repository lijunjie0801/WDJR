 

#import "URLManager.h"

////////////////////////////////////正式环境/////////////////////////////////////

#if DEBUG
NSString *const KBaseURL                     = @"http://app.wdjr999.com/api/app/";
#else
NSString *const KBaseURL                     = @"http://app.wdjr999.com/api/app/";
#endif

////////////////////////////////////测试/////////////////////////////////////
//#if DEBUG
//NSString *const KBaseURL                     = @"https://dep.wdjr999.com/api/app/";
//#else
//NSString *const KBaseURL                     = @"https://dep.wdjr999.com/api/app/";
//#endif

//用户行为
NSString *const KURLStringSendSma            = @"v1/sms/verify-code";//获取验证码

NSString *const KURLStringSendsms            = @"v1/pnr/sms";//new获取验证码

NSString *const KURLRecharge            = @"v1/deal/recharge";//充值


NSString *const KURLStringLogin              = @"v1/login";//用户登录
NSString *const KURLStringRegister           = @"v1/register";//用户注册
NSString *const KULStringResetPassword       = @"/user/reg";//忘记密码


NSString *const KULAdBanner                  = @"v1/slides";//广告栏
NSString *const KULhomeTouBiao               = @"v1/borrows/recent/";//首页，投标
NSString *const KULInvestRecoder              = @"v1/borrow/";//投资记录
//还款计划
NSString *const KULRepaymentSchdlue              = @"v1/borrow/";//还款计划

NSString *const KULBorrowList                = @"v1/borrows?";//我要理财中借款列表

NSString *const KULMyBalance                = @"v1/user/account";//我的，余额

NSString *const KULMyAsset                    = @"v1/user/asset";//当前用户积分/代金券

NSString *const KULMyInvests                   = @"v1/record/invests?";//投资记录

NSString *const KULSecondInvests               = @"v1/record/rights?status=N&";//再投项目

NSString *const KULReturnMoney                 = @"v1/record/collects?";//已回款和待收明细

//资金记录
NSString *const KULAllRecord                 = @"v1/record/accounts?";//全部资金记录
NSString *const KULTopUpRecord               = @"v1/record/recharges?";//充值记录
NSString *const KULWithdrawRecord            = @"v1/record/withdraws?";//提现记录
NSString *const KULJiFenRecord               = @"v1/record/scores?";//积分记录
NSString *const KULVouchRecord               = @"v1/record/vouchers?";//代金券记录
NSString *const KULInviteRecord              = @"v1/record/followers?";//好友邀请记录



NSString *const KULZiDongTouBiao              = @"v1/user/invest/plan";//我自动投标

NSString *const KULChangePwd                = @"v1/security/password/modify";//修改密码

NSString *const KURLFindPwd                  = @"v1/password/reset"; //找回密码


NSString *const KURLdealTender                     = @"v1/deal/tender"; //投标

NSString *const KURLtopUp                        = @"v1/deal/recharge"; //充值

NSString *const KURLUserStatus                        = @"v1/user/depository/status"; //用户状态

NSString *const KURLBankList                        = @"v1/pnr/banks"; //银行列表

NSString *const KURLAreaList                        = @"v1/pnr/areas"; //省市列表
NSString *const KURLUserPnr                        = @"v1/user/pnr"; //当前用户汇付信息

NSString *const KURLSecurity                = @"v1/security/eaccount"; //查询贵州银行电子账户

NSString *const KURLPayment                = @"v1/security/password/payment"; //修改交易密码


NSString *const KURLHomeMessage                     = @"v1/news/rolling"; //首页滚动消息

NSString *const KURLwithDraw                   = @"v1/deal/cash"; //提现

NSString *const KURLbankCard                   = @"v1/security/bank-card"; //绑定银行卡

NSString *const KURLbankListCard               = @"v1/security/bank-cards"; //银行卡列表


NSString *const KURLHuiFu                      = @"v1/user/pnr/reg"; //开通汇付天下

NSString *const KURLActivate                      = @"v1/user/pnr/activate"; //存管激活

NSString *const KURLPhoneRenZheng              = @"v1/security/mobile/auth"; //手机认证


NSString *const KURLShowVoucher                = @"v1/user/asset"; //展示代金券

NSString *const KURLVoucherExchange            = @"v1/voucher/exchange"; //代金券兑换


//h5界面
NSString *const KURLPingTaiShuJu           = @"v1/h5/statement";//平台数据

NSString *const KURLTouZiZhiNanWangZhan    = @"v1/h5/introduce";//投资指南网站介绍

NSString *const KURLAboutUs                = @"v1/h5/about";//关于我们

NSString *const KURLInviteAward            = @"v1/h5/invite";//推荐有奖


NSString *const KURLProblem                = @"v1/h5/problem";//常见问题

NSString *const KURLMoreNews               = @"v1/notice/more";//更多新闻


NSString *const KURLReview                     = @"v1/h5/invest/review";//审核项目
NSString *const KURLFengKeng                   = @"v1/h5/invest/risk";//风控
NSString *const KURLXunCheXinXi                = @"/car/findcar";//寻车信息
NSString *const KURLFaBuCheYuan                = @"/car/release";//发布品牌车源
//
NSString *const KURLFengKuangDiJiaCheYuan     = @"/car/crazy";//疯狂低价车源
NSString *const KURLFaBuXinCheInfo            = @"/car/release_find";//发布寻车信息
NSString *const KURLGoodCardJinRong           = @"/finance/index";//好车金融
NSString *const KURLGoodCardBaoXian           = @"/finance/insurance";//好车保险

NSString *const KURLGoodCareMore         = @"/car/firstcar";//品牌车源 更多

NSString *const KURLSignin               = @"/sindex/signin";//签到

//发布品牌车源权限 /car/judge  疯狂低价车源权限 /car/crazy_judge


NSString *const KURLFaBuPinPaiQuanXian             = @"/car/judge";//发布品牌车源权限
NSString *const KURLFengKuangDiJiaCheYuanQuanXian  = @"/car/judge_crazy";//疯狂低价车源权限


NSString *const KURLZhaoMuBaoMing        = @"http://yyq.jiaozujin.com/ex/building";//招募报名
NSString *const KURLZuiNiuDiaoYuRen      = @"http://yyq.jiaozujin.com/ex/building";//最牛钓鱼人
//http://yyq.jiaozujin.com/ex/weather
//
NSString *const KURLWeather              = @"http://yyq.jiaozujin.com/ex/weather";//天气
NSString *const KURLJinRiTuiJian         = @"http://yyq.jiaozujin.com/ex/today";//今日推荐
NSString *const KURLWoDePingJia          = @"http://yyq.jiaozujin.com/mine/mycomment";//我的评价
NSString *const KURLWoDeShouCang         = @"http://yyq.jiaozujin.com/mine/mycollect";//我的收藏

NSString *const KURLWoYaoHeZuo           = @"http://yyq.jiaozujin.com/ex/coop";//我要合作


//我的界面
NSString *const KURLMyInfo                = @"/ucenter/uinfo";//个人信息
NSString *const KURLMyMoney               = @"/ucenter/mywallet";//我的钱包
NSString *const KURLMyOrder               = @"/ucenter/myorder";//我的订单
NSString *const KURLXiTongMessage         = @"/ucenter/system_art";//系统消息
NSString *const KURLMyRenZheng            = @"/ucenter/ucenter_approve";//个人认证
NSString *const KURLCompanyRenZheng       = @"/ucenter/commpany_approve";//公司认证
NSString *const KURLMyFaBuPinPaiCheYuan   = @"/ucenter/myrelease";//我发布的品牌车源
NSString *const KURLMyFaBuXuCheInfo       = @"/ucenter/myfind";//我发布的寻车信息
NSString *const KURLMyShouChang           = @"/ucenter/mycollection";//我的收藏
NSString *const KURLMyGuanZhu             = @"/ucenter/myfriend";//我的关注
NSString *const KURLHuiYuanJiFen          = @"/ucenter/mypoint";//会员积分
NSString *const KURLYaoQingHaoYou         = @"/ucenter/invite";//邀请好友

NSString *const KURLJiaoYiRecord         = @"/ucenter/deal";//交易记录

NSString *const KURLPaySuccess         = @"/order/payback/order_sn";//支付成功后


NSString *const KURLAddBank           = @"/ucenter/mybank";//添加银行卡

NSString *const KURLBringForward           = @"/ucenter/playm";//转账

NSString *const KURLContact             = @"v1/contact";//联系方式



@implementation URLManager

+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path
{
 
    return [KBaseURL stringByAppendingString:path];
}
+ (NSString *)requestOtherURLGenetatedWithURL:(NSString *const) path
{
    
    return [KBaseURL stringByAppendingString:path];
}
@end
