//
//  InvestRecodersViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/7.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "InvestRecodersViewController.h"
#import "InvestRecoderModel.h"
#import "InvesterRecordersCell.h"
@interface InvestRecodersViewController ()
{

    int pageNum;
    
}

@property(nonatomic, strong) NSString *salt;

@property(nonatomic, strong) NSMutableArray *investRModelArray;


@end

@implementation InvestRecodersViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    
    self.salt           = intentDic[@"salt"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageNum = 1;
    _investRModelArray = [NSMutableArray array];
    self.title = @"投资记录";
    
    [self requestRefresh];
}


-(void)requestRefresh
{
    pageNum = 1;
    [_investRModelArray removeAllObjects];
    [self.tableView reloadData];
    
    [InvestRecoderModel requestInvestRecoderModelOfSize:pageNum andSalt:self.salt CompletionHandler:^(id object) {
        
        NSArray *array = (NSArray *)object;
        [_investRModelArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self finishRequest];
        [_svc hideLoadingView];
        
        
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
}


//上拉刷新
-(void)requestGetMore
{
    pageNum+=1;
    
    [InvestRecoderModel requestInvestRecoderModelOfSize:pageNum andSalt:self.salt CompletionHandler:^(id object) {
        
        NSArray *array = (NSArray *)object;
        [_investRModelArray addObjectsFromArray:array];   
        [self.tableView reloadData];
        [self finishRequest];
        [_svc hideLoadingView];
        
        
        
    } failHandler:^(NSError *error, NSUInteger statusCode) {
        
        [self finishRequest];
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
    }];
}







#pragma mark  ---UITableViewDelegate-----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.investRModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvesterRecordersCell *cell = [InvesterRecordersCell InvesterRecordersCellWithTableView:tableView];
    
    InvestRecoderModel *model = self.investRModelArray[indexPath.row];
    cell.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    cell.investRecoderModel = model;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
