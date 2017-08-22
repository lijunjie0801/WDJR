//
//  RepaymentScheduleViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/12.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "RepaymentScheduleViewController.h"
#import "MyInvesRecoderCell.h"
#import "RepaymentScheduleModel.h"

//还款计划
@interface RepaymentScheduleViewController ()


@property(nonatomic, strong) NSString *salt;
@property(nonatomic, strong) NSArray *repaymentArray;

@end

@implementation RepaymentScheduleViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    
    self.salt           = intentDic[@"salt"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"还款计划";
    _repaymentArray = [[NSArray alloc] init];
    
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-45);
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
    [RepaymentScheduleModel requestRepaymentScheduleModelSalt:self.salt SuccessHandle:^(id object) {
        
        NSArray *array = (NSArray *)object;
        
        _repaymentArray = array;
        
        [self.tableView reloadData];
        [self finishRequest];
        [_svc hideLoadingView];
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
}


#pragma mark  ---UITableViewCell------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _repaymentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInvesRecoderCell *cell = [MyInvesRecoderCell myInvesRecoderCellTableView:tableView];
    
    RepaymentScheduleModel *model = _repaymentArray[indexPath.row];
    
    cell.titlelbl.text = [NSString stringWithFormat:@"还款日：%@",model.repay_date];
    cell.moneylbl.text = [NSString stringWithFormat:@"利息：%@元",model.interest];
    cell.stateslbl.text = [NSString stringWithFormat:@"状态：%@",model.status_display];
 
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RepaymentScheduleModel *model = _repaymentArray[indexPath.row];
    [_svc pushViewController:_svc.moneyRecordDetailViewController withObjects:@{@"RepaymentScheduleModel":model,@"typeNum":@6}];
}

-(BOOL)shouldShowGetMore
{
    return NO;
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
