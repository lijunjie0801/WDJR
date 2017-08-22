//
//  DueInDetailsViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "DueInDetailsViewController.h"
#import "MyInvesRecoderCell.h"
#import "ReturnMoneyModel.h"

@interface DueInDetailsViewController ()
{
    int pageNum;
}

@property(nonatomic, strong) NSMutableArray *daishouMoneyArray;

@end

@implementation DueInDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _daishouMoneyArray = [NSMutableArray array];
    
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
    
    pageNum =1;
    [_daishouMoneyArray removeAllObjects];
    [self.tableView reloadData];
    [ReturnMoneyModel requestDaiReturnMoneyModelandPage:pageNum andStatus:@"N" SuccessHandle:^(id object) {
        
        NSArray *array = (NSArray *)object;
        
        [_daishouMoneyArray addObjectsFromArray:array];
        
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
    [ReturnMoneyModel requestDaiReturnMoneyModelandPage:pageNum andStatus:@"N" SuccessHandle:^(id object) {
        
        NSArray *array = (NSArray *)object;
        
        [_daishouMoneyArray addObjectsFromArray:array];
        
        [self finishRequest];
        [_svc hideLoadingView];
        
        [self.tableView reloadData];
        
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
}







#pragma mark  ---UITableViewCell------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _daishouMoneyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInvesRecoderCell *cell = [MyInvesRecoderCell myInvesRecoderCellTableView:tableView];
    
    
    ReturnMoneyModel *model = _daishouMoneyArray[indexPath.row];
    
    cell.titlelbl.text = [NSString stringWithFormat:@"借款标题：%@",model.title];
    cell.moneylbl.text = [NSString stringWithFormat:@"回款金额：%@元",model.amount];
    
    if ([model.status isEqualToString:@"N"]) {
        
        cell.stateslbl.text = @"状态：回款处理中";
    }else if ([model.status isEqualToString:@"S"]){
        
        cell.stateslbl.text = @"状态：已回款";
    }
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReturnMoneyModel *model =_daishouMoneyArray[indexPath.row];
    [_svc pushViewController:_svc.myInvestDetailesViewController withObjects:@{@"ReturnMoneyModel":model,@"typeNum":@2}];
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
