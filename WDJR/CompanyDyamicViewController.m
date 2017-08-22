//
//  CompanyDyamicViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/10/29.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "CompanyDyamicViewController.h"
#import "ComDymicViewController.h"
#import "WebsiteNoticeViewController.h"
#import "PublishAdvanceViewController.h"
#import "PlatformRuleViewController.h"
#import "TradeNewsViewController.h"

static CGFloat const titleH=44;
static CGFloat const navBarH=64;
static CGFloat const maxTitleScale=1.1;

@interface CompanyDyamicViewController ()<UIScrollViewDelegate>


@property(nonatomic,weak)UIScrollView *titleScrolView;
@property(nonatomic,weak)UIScrollView *contentScrollView;

//选中按钮
@property(nonatomic,weak)UIButton *selTitleButton;

@property(nonatomic,strong)NSMutableArray *buttons;

@property(nonatomic, strong)UIView *selectView;
@property(nonatomic, strong)UIView *fristView;

@end

@implementation CompanyDyamicViewController

-(NSMutableArray *)buttons
{
    if (!_buttons) {
        
        _buttons=[NSMutableArray array];
    }
    return _buttons;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
  
    
    self.title = @"公司动态";
    
    //设置头部标题的scrollview
    [self setupTitleScrollView];
    //设置内容的ScrollView
    [self setupContentScrollView];
    //设置子视图
    [self addChildViewController];
    //设置头部标题的事件
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.contentScrollView.contentSize=CGSizeMake(self.childViewControllers.count*WIDTH, 0);
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.showsHorizontalScrollIndicator=NO;
    self.contentScrollView.delegate=self;
    
  
    
  
    
}




#pragma mark -设置头部标题栏
-(void)setupTitleScrollView
{
    //判断是否存在导航控制器来判读y值
    CGFloat y=self.navigationController ? navBarH : 0;
    CGRect rect=CGRectMake(0, 0, WIDTH, titleH);
    
    UIScrollView *titleScrollView=[[UIScrollView alloc] initWithFrame:rect];
    titleScrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:titleScrollView];
    self.titleScrolView=titleScrollView;
    
    
    _selectView = [[UIView alloc] init];
    _selectView.backgroundColor = [AppAppearance sharedAppearance].mainColor;
    [self.titleScrolView addSubview:_selectView];
}

#pragma mark -设置内容
-(void)setupContentScrollView
{
    CGFloat y=CGRectGetMaxY(self.titleScrolView.frame);
    CGRect rect=CGRectMake(0, y, WIDTH, HEIGHT-y);
    
    UIScrollView *contentScrollView=[[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:contentScrollView];
    self.contentScrollView=contentScrollView;
}



#pragma mark -添加子控制器
-(void)addChildViewController
{
    ComDymicViewController *comDymic = [[ComDymicViewController alloc] init];
    comDymic.title = @"公司动态";
    [self addChildViewController:comDymic];
    
    WebsiteNoticeViewController *website = [[WebsiteNoticeViewController alloc] init];
    website.title = @"网站公告";
    [self addChildViewController:website];
    
    PublishAdvanceViewController *publish = [[PublishAdvanceViewController alloc] init];
    publish.title = @"发标预告";
    [self addChildViewController:publish];
    
    PlatformRuleViewController *platform = [[PlatformRuleViewController alloc] init];
    platform.title = @"平台规则";
    [self addChildViewController:platform];
    
    TradeNewsViewController *tradeNews = [[TradeNewsViewController alloc] init];
    tradeNews.title = @"行业新闻";
    [self addChildViewController:tradeNews];
    
    
}

#pragma mark -设置标题的位置
-(void)setupTitle
{
    NSUInteger count=self.childViewControllers.count;
    
    CGFloat x=0;
    CGFloat w=100;
    CGFloat h=titleH;//titleH=44;
    for (int i=0; i<count; i++) {
        
        UIViewController *vc=self.childViewControllers[i];
        
        x=i*w;
        
        CGRect rect=CGRectMake(x, 0, w, h);
        UIButton *btn=[[UIButton alloc] initWithFrame:rect];
        
        btn.tag=i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchDown];
        [self.buttons addObject:btn];
        [self.titleScrolView addSubview:btn];
        
        if (i==0) {
            [self chick:btn];
            //_selectView.frame= CGRectMake(0,titleH-3, 100, 3);
           
        }
        
    }
    self.titleScrolView.contentSize=CGSizeMake(count*w, 0);
    self.titleScrolView.showsHorizontalScrollIndicator=NO;
}

//按钮点击
-(void)chick:(UIButton *)btn
{
    [self selTitleBtn:btn];
    
    NSUInteger i=btn.tag;
    CGFloat x=i*WIDTH;
    
    [self setUpOneChildViewController:i];
    self.contentScrollView.contentOffset=CGPointMake(x, 0);
    
    
   

    
}

//选中按钮
- (void)selTitleBtn:(UIButton *)btn
{
    [self.selTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //每次变换前都要置位，不然你变换用的坐标系统不是屏幕坐标系统（即绝对坐标系统），而是上一次变换后的坐标系统
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);
    
    self.selTitleButton = btn;
    [self setupTitleCenter:btn];
}

//按钮被点击，内容视图显示出来
- (void)setUpOneChildViewController:(NSUInteger)i
{
    CGFloat x = i * WIDTH;
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, WIDTH, HEIGHT - self.contentScrollView.frame.origin.y);
    
    [self.contentScrollView addSubview:vc.view];
    
}

-(void)setupTitleCenter:(UIButton *)btn
{
    
    CGFloat offset=btn.center.x - WIDTH * 0.5;
//        NSLog(@"offset=%f",offset);
//        NSLog(@"btn.center.x=%f",btn.center.x);
//        NSLog(@"btn.origin.x=%f",btn.frame.origin.x);
    if (offset<0) {
        
        offset=0;
    }
    CGFloat maxOffset=self.titleScrolView.contentSize.width-WIDTH;
    if (offset>maxOffset) {
        offset=maxOffset;
    }
    [self.titleScrolView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    _selectView.frame= CGRectMake(btn.frame.origin.x,titleH-3, 100, 3);
    
}


#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger i = self.contentScrollView.contentOffset.x / WIDTH;
    [self selTitleBtn:self.buttons[i]];
    [self setUpOneChildViewController:i];
}

//只要滚动UIScrollView就会调用
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / WIDTH;
    NSInteger rightIndex = leftIndex + 1;
    
    //    NSLog(@"%zd,%zd",leftIndex,rightIndex);
    
    UIButton *leftButton = self.buttons[leftIndex];
    
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        rightButton = self.buttons[rightIndex];
    }
    
    CGFloat scaleR = offsetX / WIDTH - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
