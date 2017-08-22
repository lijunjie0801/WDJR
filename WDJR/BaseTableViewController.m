//
//  BaseTableViewController.m
//  GZB
//
//  Created by fyaex001 on 16/3/8.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SVPullToRefresh.h"
//#import "AFNetworking.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize tableView = _tableView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _rows = [NSMutableArray array];
        
    }
    return self;
}

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    Class class = [self tableViewClass];
    _tableView = [[class alloc] initWithFrame:self.view.bounds style:[self tableViewStyle]];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    __weak typeof (self) weakSelf = self;
    if ([self shouldShowRefresh]) {
        
        [_tableView addPullToRefreshWithActionHandler:^{
            
            __strong typeof (self) strongSelf = weakSelf;
            [strongSelf willTriggerRequestRefresh];
            [strongSelf requestRefresh];
        }];
        [_tableView.pullToRefreshView setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
        [_tableView.pullToRefreshView setTitle:@"松手开始刷新" forState:SVPullToRefreshStateTriggered];
        [_tableView.pullToRefreshView setTitle:@"刷新中..." forState:SVPullToRefreshStateLoading];
    }
    
    if ([self shouldShowGetMore]) {
        
        [_tableView addInfiniteScrollingWithActionHandler:^{
            
            __strong typeof (self) strongSelf = weakSelf;
            if ([strongSelf.tableView.pullToRefreshView state] == SVPullToRefreshStateTriggered) {
                return ;
            }
            [strongSelf willTriggerRequestGetMore];
            [strongSelf requestGetMore];
        }];
    }
    [self.view addSubview:_tableView];
    
    UIView *topView = [self topView];
    UIView *bottomView = [self bottomView];
    
    CGRect rect = self.view.bounds;
    CGRect slice,remainder;
    
    CGRectDivide(rect, &slice, &remainder, topView.bounds.size.height, CGRectMinYEdge);
    topView.frame = slice;
    
    topView.autoresizingMask = topView.autoresizingMask | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth ^ UIViewAutoresizingFlexibleHeight;
    [self.view addSubview: topView];
    
    rect = remainder;
    
    CGRectDivide(rect, &slice, &remainder, bottomView.bounds.size.height, CGRectMaxYEdge);
    // bottomView.frame = slice;
    bottomView.frame = CGRectMake(0, rect.size.height-bottomView.bounds.size.height-17, bottomView.bounds.size.width, bottomView.bounds.size.height+14);
    bottomView.autoresizingMask = bottomView.autoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth ^ UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:bottomView];
    
    _tableView.frame = remainder;
    
}




-(void)reloadData
{
    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void)setHideGetMore:(BOOL)hide
{
    [_tableView.infiniteScrollingView setEnabled:!hide];
}

/*
 
 SVPullToRefreshStateStopped：刷新停止状态，还没有触发刷新操作。
 SVPullToRefreshStateTriggered：刷新操作被触发，但还没有开始发送请求（只要用户手还没松开，不会发送请求）
 SVPullToRefreshStateLoading：已经发送请求，但数据还没回来，这时菊花一直在转。这时候UITableView的contentInset已经修改，使PullToRefreshView可见。
 SVPullToRefreshStateAll：初始化的时候用的。
 */
-(void)finishRequest
{
    if (_tableView.pullToRefreshView.state == SVPullToRefreshStateLoading) {
        [_tableView.pullToRefreshView stopAnimating];
    }
    if (_tableView.infiniteScrollingView.state == SVPullToRefreshStateLoading) {
        [_tableView.infiniteScrollingView stopAnimating];
    }
    
}


-(Class)tableViewClass
{
    
    return [UITableView class];
    
}


#pragma mark --overridable
-(BOOL)shouldShowGetMore
{
    return YES;
}

-(BOOL)shouldShowRefresh
{
    return YES;
}

-(void)toTriggerRequestRefresh
{
    [_tableView triggerPullToRefresh];
}


-(void)toTriggerRequestGetMore
{
    [_tableView triggerInfiniteScrolling];
}

-(void)willTriggerRequestRefresh
{
    //    [self requestRefresh];
}
-(void)requestRefresh
{
    //NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}
-(void)willTriggerRequestGetMore
{
    
}
-(void)requestGetMore
{
    // NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}

-(UIView*)bottomView {
    return nil;
}

-(UIView *)topView {
    return nil;
}


#pragma mark -tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}



//取出每个cell距离默认距离左边15的距离
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}




#pragma mark-----ScrollView的代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //把键盘叫回去，思路：让控制器所管理的UIView结束编辑
    [self.view endEditing:YES];
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
