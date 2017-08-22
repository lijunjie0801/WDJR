//
//  TopUpRecordViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "TopUpRecordViewController.h"
#import "MoneyRecordDetailViewController.h"
#import "ActionSheetPicker-3.0/ActionSheetPicker.h"
#import "MyInvesRecoderCell.h"
#import "TopUpRecordModel.h"


@interface TopUpRecordViewController ()<UITextFieldDelegate>
{
    int pageNum;
}

@property(nonatomic, strong) UIView *headerView;
@property (strong, nonatomic)  UITextField *startDateTtx;
@property (strong, nonatomic)  UITextField *endDateTxt;
@property (strong, nonatomic)  UIButton *searchBtn;

@property(nonatomic, strong) NSMutableArray *topUpModelArray;

@end

@implementation TopUpRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _topUpModelArray = [[NSMutableArray alloc] init];
    
    _headerView = [self headerViews];
    [self.view addSubview:_headerView];
    
    _tableView.frame = CGRectMake(0, 55, WIDTH, HEIGHT-55-45);
    
    _tableView.showsVerticalScrollIndicator   = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self requestRefresh];
    
}

-(void)requestRefresh
{
    pageNum = 1;
    [_topUpModelArray removeAllObjects];
    [_tableView reloadData];
    [_svc  showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow ];
    
    [TopUpRecordModel requestTopUpRecordModelStartDate:self.startDateTtx.text andEndData:self.endDateTxt.text andPage:pageNum SuccessHandle:^(id object) {
        
        
        NSArray *array = (NSArray *)object;
        
        [_topUpModelArray addObjectsFromArray:array];
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
    
}

-(void)requestGetMore
{
    pageNum+=1;
    [TopUpRecordModel requestTopUpRecordModelStartDate:self.startDateTtx.text andEndData:self.endDateTxt.text andPage:pageNum SuccessHandle:^(id object) {
        
        
        NSArray *array = (NSArray *)object;
        
        [_topUpModelArray addObjectsFromArray:array];
        [self finishRequest];
        [_svc hideLoadingView];
        [self.tableView reloadData];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
}


-(UIView *)headerViews
{
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        _headerView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 60, 21)];
        lbl.text = @"查询时间";
        lbl.font = shisiFont;
        lbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        [_headerView addSubview:lbl];
        
        _startDateTtx = [[UITextField alloc] init];
        _startDateTtx.frame = CGRectMake(CGRectGetMaxX(lbl.frame)+5, 13, (WIDTH-165)/2, 25);
        _startDateTtx.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _startDateTtx.layer.borderColor=[[AppAppearance sharedAppearance].title2TextColor CGColor];
        _startDateTtx.borderStyle = UITextBorderStyleNone;
        _startDateTtx.layer.borderWidth=1.0f;
        [_startDateTtx addTarget:self action:@selector(selectStartDate) forControlEvents:UIControlEventTouchUpOutside];
        _startDateTtx.tag = 100;
        self.startDateTtx.font = shisanFont;
        self.startDateTtx.textColor = [AppAppearance sharedAppearance].title2TextColor;
        self.startDateTtx.textAlignment = NSTextAlignmentCenter;
        _startDateTtx.delegate = self;
        [_headerView addSubview:_startDateTtx];
        
        UILabel *dao = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_startDateTtx.frame)+5, 15, 15, 21)];
        dao.text = @"到";
        dao.font = shisiFont;
        dao.textColor = [AppAppearance sharedAppearance].title2TextColor;
        [_headerView addSubview:dao];
        
        _endDateTxt = [[UITextField alloc] init];
        _endDateTxt.frame = CGRectMake(CGRectGetMaxX(dao.frame)+5, 13, (WIDTH-165)/2, 25);
        _endDateTxt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _endDateTxt.layer.borderWidth=1.0f;
        _endDateTxt.layer.borderColor=[[AppAppearance sharedAppearance].title2TextColor CGColor];
        _endDateTxt.borderStyle = UITextBorderStyleNone;
        [_endDateTxt addTarget:self action:@selector(selectEndDate) forControlEvents:UIControlEventTouchUpInside];
        _endDateTxt.userInteractionEnabled = YES;
        _endDateTxt.tag = 200;
        self.endDateTxt.font = shisanFont;
        self.endDateTxt.textColor = [AppAppearance sharedAppearance].title2TextColor;
        self.endDateTxt.textAlignment = NSTextAlignmentCenter;
        _endDateTxt.delegate = self;
        [_headerView addSubview:_endDateTxt];
        
        
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-60, 10, 50, 30)];
        _searchBtn.backgroundColor = [AppAppearance sharedAppearance].yellowColor;
        _searchBtn.titleLabel.font = shisiFont;
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.layer.cornerRadius = 10;
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
        [_headerView addSubview:_searchBtn];
        
        
        
        
        //获取当前时间
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        //当前时间
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        //距离当前时间的时间差
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = nil;
        
        comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        [adcomps setYear:0];
        [adcomps setMonth:-1];
        [adcomps setDay:0];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
        //上一个月的时间
        NSString *qiandateString = [dateFormatter stringFromDate:newdate];
        
        self.startDateTtx.text = qiandateString;
        self.endDateTxt.text = dateString;
        
        
        
        
    }
    return _headerView;
}

//选择开始日期
- (void)selectStartDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2000];
    NSDate *minDate = [calendar dateFromComponents:minimumDateComponents];
    NSDate *maxDate = [NSDate date];
    
    [ActionSheetDatePicker showPickerWithTitle:@"选择开始日期" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:minDate maximumDate:maxDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.startDateTtx.text = [dateFormatter stringFromDate:(NSDate *)selectedDate];
        self.startDateTtx.font = shisanFont;
        self.startDateTtx.textColor = [AppAppearance sharedAppearance].title2TextColor;
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
}

/**
 *  选择结束日期
 *
 *  @param sender <#sender description#>
 */
- (void)selectEndDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2000];
    NSDate *minDate = [calendar dateFromComponents:minimumDateComponents];
    NSDate *maxDate = [NSDate date];
    
    [ActionSheetDatePicker showPickerWithTitle:@"选择结束日期" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:minDate maximumDate:maxDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.endDateTxt.text = [dateFormatter stringFromDate:(NSDate *)selectedDate];
        self.endDateTxt.font = shisanFont;
        self.endDateTxt.textColor = [AppAppearance sharedAppearance].title2TextColor;
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField.tag == 100) {
        
        [self selectStartDate];
    }else{
        
        [self selectEndDate];
    }
    
    return NO;
}


-(void)searchClick
{
    
    [self requestRefresh];
    
    
}



#pragma mark  ---UITableViewCell------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _topUpModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInvesRecoderCell *cell = [MyInvesRecoderCell myInvesRecoderCellTableView:tableView];
    
    TopUpRecordModel *model = _topUpModelArray[indexPath.row];
    
    cell.titlelbl.text = [NSString stringWithFormat:@"订单号：%@",model.ord_id];
    cell.moneylbl.text = [NSString stringWithFormat:@"充值金额：%@元",model.account];
    
    cell.stateslbl.text = [NSString stringWithFormat:@"状态：%@",model.status_display];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TopUpRecordModel *model = _topUpModelArray[indexPath.row];
    [_svc pushViewController:_svc.moneyRecordDetailViewController withObjects:@{@"TopUpRecordModel":model,@"typeNum":@1}];
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
