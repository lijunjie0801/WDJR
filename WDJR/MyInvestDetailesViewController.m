//
//  MyInvestDetailesViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/11/8.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MyInvestDetailesViewController.h"
#import "MyInvesterModel.h"
#import "SecondInvesterModel.h"
#import "ReturnMoneyModel.h"
@interface MyInvestDetailesViewController ()
{
    int typeNum;
}
@property(nonatomic, strong) MyInvesterModel *myInvesterModel;
@property(nonatomic, strong) SecondInvesterModel *secondInvesterModel;
@property(nonatomic, strong) ReturnMoneyModel *returnMoneyModel;


@end

@implementation MyInvestDetailesViewController
-(void)setIntentDic:(NSDictionary *)intentDic
{
    typeNum =[intentDic[@"typeNum"] integerValue];
    if (typeNum == 0) {
        
         self.myInvesterModel = (MyInvesterModel *)intentDic[@"MyInvesterModel"];
    }else if (typeNum ==1){
    
        self.secondInvesterModel = (SecondInvesterModel *)intentDic[@"SecondInvesterModel"];
    }else{
    
        self.returnMoneyModel = (ReturnMoneyModel *)intentDic[@"ReturnMoneyModel"];
    }
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详细信息";
}


#pragma mark UITableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (typeNum == 0) {
        
        return 9;
    }else if(typeNum ==1){
    
        return 8;
    }
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.font = shisiFont;
    cell.textLabel.textColor = [AppAppearance sharedAppearance].titleTextColor;
    
    if (typeNum == 0) {
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"借款标题： %@",self.myInvesterModel.title];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"投标金额： %@",self.myInvesterModel.amount];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"状态：    %@%@",@"    ",self.myInvesterModel.status_display];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"投标奖励： %@",self.myInvesterModel.reward_tender];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"续投奖励： %@",self.myInvesterModel.reward_keep];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"利息：    %@%@",@"    ",self.myInvesterModel.interest];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"待收金额： %@",self.myInvesterModel.collect];
            
        }else if (indexPath.row ==7){
            
            cell.textLabel.text = [NSString stringWithFormat:@"投标时间： %@",self.myInvesterModel.created_at];
            
        }else if (indexPath.row ==8){
            
            cell.textLabel.text = [NSString stringWithFormat:@"投标方式： %@",self.myInvesterModel.way_display];
        }
       
    }else if (typeNum ==1){
    
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"项目名称：%@",self.secondInvesterModel.title];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"本金：%@%@",@"       ",self.secondInvesterModel.amount];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"利息：%@%@",@"       ",self.secondInvesterModel.interest];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"已回本金：%@",self.secondInvesterModel.amount_yes];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"已收利息：%@",self.secondInvesterModel.interest_yes];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"开始时间：%@",self.secondInvesterModel.start_date];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"结束时间：%@",self.secondInvesterModel.end_date];
            
        }else if (indexPath.row ==7){
            
            cell.textLabel.text = [NSString stringWithFormat:@"还息日：%@%@",@"   ",self.secondInvesterModel.repay_day];
            
        }
    }else{
    
    
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"借款标题：    %@",self.returnMoneyModel.title];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"本息：%@%@",@"           ",self.returnMoneyModel.amount];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"本金：%@%@",@"           ",self.returnMoneyModel.principle];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"利息：%@%@",@"           ",self.returnMoneyModel.interest];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"期数：%@%@/%@",@"            ",self.returnMoneyModel.borrow_num,self.returnMoneyModel.periods];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"计息天数：    %@",self.returnMoneyModel.interest_days];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"投标时间：    %@",self.returnMoneyModel.created_at];
            
        }else if (indexPath.row ==7){
            
            cell.textLabel.text = [NSString stringWithFormat:@"应还款时间：%@",self.returnMoneyModel.end_date];
            
        }else if (indexPath.row ==8){
            
            if ([self.returnMoneyModel.status isEqualToString:@"S"]) {
                
                 cell.textLabel.text = [NSString stringWithFormat:@"状态：  %@%@",@"        ",@"已还"];
            }else{
            
                 cell.textLabel.text = [NSString stringWithFormat:@"状态：  %@%@",@"        ",@"未还"];
            }
            
           
            
        }
        
        
    }
    
 
    
    
    return cell;
    
}


-(BOOL)shouldShowGetMore
{
    return NO;
}

-(BOOL)shouldShowRefresh
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
