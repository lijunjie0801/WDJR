 

#import <Foundation/Foundation.h>

extern NSString *const KBaseURL;  //服务器地址

//用户行为

extern NSString *const KURLHomeMessage; //首页滚动消息


extern NSString *const KURLStringSendSma;//获取验证码
extern NSString *const KURLStringLogin;//用户登录
extern NSString *const KURLStringRegister;//用户注册
extern NSString *const KULStringResetPassword;//忘记密码

extern NSString *const KULAdBanner;//广告栏
extern NSString *const KULhomeTouBiao;//首页，投标信息
extern NSString *const KULInvestRecoder;//投资记录
extern NSString *const KULRepaymentSchdlue;//还款计划
extern NSString *const KULBorrowList;//我要理财中借款列表

extern NSString *const KULMyBalance;//我的，余额
extern NSString *const KULMyAsset;//当前用户积分/代金券
extern NSString *const KULMyInvests;//投资记录
extern NSString *const KULSecondInvests;//再投项目
extern NSString *const KULReturnMoney;//已回款和待收明细


//资金记录
extern NSString *const KULAllRecord;//全部资金记录
extern NSString *const KULTopUpRecord;//充值记录
extern NSString *const KULWithdrawRecord;//提现记录
extern NSString *const KULJiFenRecord;//积分记录
extern NSString *const KULVouchRecord;//代金券记录
extern NSString *const KULInviteRecord;//好友邀请记录


extern NSString *const KULZiDongTouBiao;//我自动投标

extern NSString *const KULChangePwd;//修改密码

extern NSString *const KURLFindPwd; //忘记密码

extern NSString *const KURLdealTender; //投标

extern NSString *const KURLtopUp; //充值
extern NSString *const KURLwithDraw; //提现
extern NSString *const KURLHuiFu; //开通汇付天下
extern NSString *const KURLActivate; //存管激活
extern NSString *const KURLPayment; //修改交易密码
extern NSString *const KURLbankCard; //绑定银行卡
extern NSString *const KURLbankListCard; //银行卡列表
extern NSString *const KURLPhoneRenZheng; //手机认证
extern NSString *const KURLContact;//联系方式
extern NSString *const KURLShowVoucher; //展示代金券
extern NSString *const KURLVoucherExchange; //代金券兑换



//h5界面
extern NSString *const KURLPingTaiShuJu;//平台数据
extern NSString *const KURLTouZiZhiNanWangZhan;//投资指南网站介绍
extern NSString *const KURLAboutUs;//关于我们

extern NSString *const KURLInviteAward;//推荐有奖

extern NSString *const KURLProblem;//常见问题
extern NSString *const KURLMoreNews;//更多新闻
extern NSString *const KURLReview;//审核项目
extern NSString *const KURLFengKeng;//风控
extern NSString *const KURLXunCheXinXi;//寻车信息
extern NSString *const KURLFaBuCheYuan;//发布品牌车源
extern NSString *const KURLFengKuangDiJiaCheYuan;//疯狂低价车源
extern NSString *const KURLFaBuXinCheInfo;//发布寻车信息
extern NSString *const KURLGoodCardJinRong;//好车金融
extern NSString *const KURLGoodCardBaoXian;//好车保险
extern NSString *const KURLGoodCareMore;//品牌车源 更多
extern NSString *const KURLSignin;//签到
extern NSString *const KURLFaBuPinPaiQuanXian;//发布品牌车源权限
extern NSString *const KURLFengKuangDiJiaCheYuanQuanXian;//疯狂低价车源权限




extern NSString *const KURLFuWuChang;//服务商
extern NSString *const KURLYuTao;//鱼淘
extern NSString *const KURLZhaoMuBaoMing;//招募报名
extern NSString *const KURLZuiNiuDiaoYuRen;//最牛钓鱼人
extern NSString *const KURLWeather;//天气
extern NSString *const KURLJinRiTuiJian;//今日推荐
extern NSString *const KURLMapLocation;//地图

extern NSString *const KURLWoDePingJia;//我的评价
extern NSString *const KURLWoDeShouCang;//我的收藏

extern NSString *const KURLWoYaoHeZuo;//我要合作

//我的界面

extern NSString *const KURLJiaoYiRecord;//交易记录
extern NSString *const KURLMyInfo;//个人信息
extern NSString *const KURLMyMoney;//我的钱包
extern NSString *const KURLMyOrder;//我的订单
extern NSString *const KURLXiTongMessage;//系统消息
extern NSString *const KURLMyRenZheng;//个人认证
extern NSString *const KURLCompanyRenZheng;//公司认证
extern NSString *const KURLMyFaBuPinPaiCheYuan;//我发布的品牌车源
extern NSString *const KURLMyFaBuXuCheInfo;//我发布的寻车信息
extern NSString *const KURLMyShouChang;//我的收藏
extern NSString *const KURLMyGuanZhu;//我的关注
extern NSString *const KURLHuiYuanJiFen;//会员积分
extern NSString *const KURLYaoQingHaoYou;//邀请好友

extern NSString *const KURLPaySuccess;//支付成功后

extern NSString *const KURLAddBank;//添加银行卡

extern NSString *const KURLBringForward;//转账

extern NSString *const KURLUserStatus; //用户状态

extern NSString *const KURLBankList; //银行列表

extern NSString *const KURLAreaList; //省市列表

extern NSString *const KURLStringSendsms;//new获取验证码

extern NSString *const KURLSecurity; //查询贵州银行电子账户

extern NSString *const KURLUserPnr; //当前用户汇付信息

extern NSString *const KURLRecharge;//充值
@interface URLManager : NSObject
+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path;
@end
