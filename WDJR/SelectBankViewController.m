
//
//  SelectBankViewController.m
//  WDJR
//
//  Created by lijunjie on 2017/8/2.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "SelectBankViewController.h"
#import "UIImageView+WebCache.h"
@interface SelectBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *ListArray;

@end

@implementation SelectBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"选择银行";
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view =_tableview;
    //[self getListData];
    [self getdata];
}
-(void)getdata{
    [RequestManager getRequestWithURLPath:KURLBankList withParamer:nil completionHandler:^(id responseObject) {
        
        NSLog(@"resp:%@",responseObject);
        
        if ([responseObject[@"result"] integerValue]==1){
            _ListArray=responseObject[@"data"][@"list"];
            [self.tableview reloadData];

        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
    }];
    
    


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=_ListArray[indexPath.row];
    NSString * const cellIdentifier = @"CellIdentifier";
//    UITableViewCell *cell=[[UITableViewCell alloc]init];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"ico"]]];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  //  [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"ico"]]];
    cell.imageView.image=[UIImage imageWithData:data];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,59,WIDTH,1)];
    v.backgroundColor=RGB(244, 244, 244);
    [cell.contentView addSubview:v];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dic=_ListArray[indexPath.row];
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate selectBank:dic[@"name"]:dic[@"id"]];
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
