//
//  MoneyRecordDetailViewController.m
//  WDJR
//
//  Created by fyaex001 on 2016/12/8.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MoneyRecordDetailViewController.h"
#import "AllRecordModel.h"
#import "TopUpRecordModel.h"
#import "WithDrawRecordModel.h"
#import "JiFenRecordModel.h"
#import "VoucherRecordModel.h"
#import "InviteRecordModel.h"
#import "RepaymentScheduleModel.h"

@interface MoneyRecordDetailViewController ()
{
    int typeNum;
}

@property(nonatomic, strong) AllRecordModel *allRecordModel;
@property(nonatomic, strong) TopUpRecordModel *topUpRecordModel;
@property(nonatomic, strong) WithDrawRecordModel *withDrawRecordModel;
@property(nonatomic, strong) JiFenRecordModel *jiFenRecordModel;
@property(nonatomic, strong) VoucherRecordModel *voucherRecordModel;
@property(nonatomic, strong) InviteRecordModel *inviteRecordModel;
@property(nonatomic, strong) RepaymentScheduleModel *repaymentScheduleModel;


@end

@implementation MoneyRecordDetailViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    typeNum =[intentDic[@"typeNum"] integerValue];
    if (typeNum == 0) {
        
        _allRecordModel = (AllRecordModel *)intentDic[@"AllRecordModel"];
    }else if (typeNum ==1){
        
        _topUpRecordModel = (TopUpRecordModel *)intentDic[@"TopUpRecordModel"];
    }else if(typeNum == 2){
        
        _withDrawRecordModel = (WithDrawRecordModel *)intentDic[@"WithDrawRecordModel"];
    }else if(typeNum == 3){
        
        _jiFenRecordModel = (JiFenRecordModel *)intentDic[@"JiFenRecordModel"];
    }else if(typeNum == 4){
        
        _voucherRecordModel = (VoucherRecordModel *)intentDic[@"VoucherRecordModel"];
    }else if(typeNum == 5){
        
        _inviteRecordModel = (InviteRecordModel *)intentDic[@"InviteRecordModel"];
    }else if(typeNum == 6){
        
        _repaymentScheduleModel = (RepaymentScheduleModel *)intentDic[@"RepaymentScheduleModel"];
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
        
        return 7;
    }else if(typeNum ==1){
        
        return 6;
    }else if(typeNum ==2){
        
        return 9;
    }else if(typeNum ==3){
        
        return 7;
    }else if(typeNum ==4){
        
        return 7;
    }else if(typeNum ==5){
        
        return 6;
    }else{
    
        return 6;
    }
  
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
    
  
    //全部
    if (typeNum == 0) {
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"时间：  %@%@",@"    ",_allRecordModel.created_at];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"类型：  %@%@",@"    ",_allRecordModel.type];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"金额：  %@%@",@"    ",_allRecordModel.amount];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"可用余额：%@",_allRecordModel.usable];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"冻结金额：%@",_allRecordModel.frozen];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"待收金额：%@",_allRecordModel.collect];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"总金额：   %@",_allRecordModel.total];
            
        }
        
    }else if (typeNum ==1){
        //充值记录
      
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"订单号：   %@",_topUpRecordModel.ord_id];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"充值金额：%@",_topUpRecordModel.account];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"充值类型：%@",_topUpRecordModel.channel];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"状态：%@%@",@"       ",_topUpRecordModel.status_display];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"充值时间：%@",_topUpRecordModel.created_at];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"处理时间：%@",_topUpRecordModel.updated_at];
            
        }
    }else if(typeNum ==2) {
        //提现记录
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"提现银行：%@",_withDrawRecordModel.bank_name];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"银行卡号：%@",_withDrawRecordModel.bank_acc];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"提现金额：%@",_withDrawRecordModel.account];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"到账金额：%@",_withDrawRecordModel.account_actual];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"服务费：   %@",_withDrawRecordModel.serve_fee];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"状态：      %@",_withDrawRecordModel.status_display];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"提现时间：%@",_withDrawRecordModel.created_at];
            
        }else if (indexPath.row ==7){
            
            cell.textLabel.text = [NSString stringWithFormat:@"处理时间：%@",_withDrawRecordModel.deal_at];
            
        }else if (indexPath.row ==8){
            
            cell.textLabel.text = [NSString stringWithFormat:@"备注：%@%@",@"        ",_withDrawRecordModel.bank_name];
            
        }
        
        
    }else if (typeNum ==3){
        //积分记录
  
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"时间：%@%@",@"       ",_jiFenRecordModel.created_at];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"类型：%@%@",@"       ",_jiFenRecordModel.name];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"数额：%@%@",@"       ",_jiFenRecordModel.amount];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"可用余额：%@",_jiFenRecordModel.used];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"已使用：   %@",_jiFenRecordModel.created_at];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"总额：%@%@",@"       ",_jiFenRecordModel.total];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"备注：%@%@",@"       ",_jiFenRecordModel.remark];
            
        }
    
    }else if (typeNum ==4){
        //代金券记录
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"时间：%@%@",@"       ",_voucherRecordModel.created_at];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"类型：%@%@",@"       ",_voucherRecordModel.name];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"数额：%@%@",@"       ",_voucherRecordModel.amount];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"可用余额：%@",_voucherRecordModel.used];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"已使用：   %@",_voucherRecordModel.created_at];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"总额：%@%@",@"       ",_voucherRecordModel.total];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = [NSString stringWithFormat:@"备注：%@%@",@"       ",_voucherRecordModel.remark];
            
        }
    
    }else if (typeNum ==5){
        //好友邀请记
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"邀请时间：    %@",_inviteRecordModel.created_at];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"好友：%@%@",@"           ",_inviteRecordModel.username];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"累计投资额：%@",_inviteRecordModel.amount];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"奖励：%@%@",@"           ",_inviteRecordModel.reward];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"到期时间：    %@",_inviteRecordModel.end_at];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"状态：%@%@",@"          ",_inviteRecordModel.status_display];
            
        }
    
    }else{
    
        //还款计划
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"期数：%@%@",@"        ",_repaymentScheduleModel.borrow_num];
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = [NSString stringWithFormat:@"还款日：%@%@",@"    ",_repaymentScheduleModel.repay_date];
            
        }else if (indexPath.row ==2){
            
            cell.textLabel.text = [NSString stringWithFormat:@"还款本息：%@",_repaymentScheduleModel.amount];
            
            
        }else if (indexPath.row ==3){
            
            cell.textLabel.text = [NSString stringWithFormat:@"本金：%@%@",@"        ",_repaymentScheduleModel.principle];
            
        }else if (indexPath.row ==4){
            
            cell.textLabel.text = [NSString stringWithFormat:@"利息：%@%@",@"        ",_repaymentScheduleModel.interest];
            
        }else if (indexPath.row ==5){
            
            cell.textLabel.text = [NSString stringWithFormat:@"还款状态：%@",_repaymentScheduleModel.status_display];
            
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
