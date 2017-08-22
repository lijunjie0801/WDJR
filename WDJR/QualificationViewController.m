//
//  QualificationViewController.m
//  WDJR
//
//  Created by zlkj on 2017/3/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "QualificationViewController.h"
#import "HomeModel.h"
#import "PhoModel.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

//资质认证
@interface QualificationViewController ()

@property(nonatomic, strong) NSArray *itemsArray;


@property(nonatomic, strong) HomeModel  *homeModel;

@end

@implementation QualificationViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    
    self.homeModel           = intentDic[@"HomeModel"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"资质认证";
    
    self.itemsArray = @[@"抵押房产信息",@"借款人资料",@"代理人资料",@"合作图片",@"房产图片"];
    
    _tableView.showsVerticalScrollIndicator = NO;    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.itemsArray[indexPath.row];
    cell.textLabel.textColor = [AppAppearance sharedAppearance].title2TextColor;
    cell.textLabel.font = shiliuFont;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
        //抵押房产信息
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@v1/h5/house/%@/info",KBaseURL,self.homeModel.salt]}];
        
        
    }else if (indexPath.row ==1){
    
        //借款人资料
        NSArray *dicArray = (NSArray *)self.homeModel.houseDic[@"borrower_photos"];
        
        NSArray *array = [MTLJSONAdapter modelsOfClass:[PhoModel class] fromJSONArray:dicArray error:nil];
        NSMutableArray *imgUrl = [NSMutableArray array];
        for (PhoModel *model in array) {
            
            [imgUrl addObject:model.imgStr];
        }
        
        NSInteger count = imgUrl.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        
        for (int i = 0; i<count; i++) {
            
            // 替换为中等尺寸图片
            NSString *url = [imgUrl[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            //                NSString *url =[NSString stringWithFormat:@"%@",_homeModel.pledge[i]];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            photo.srcImageView.image = [UIImage imageNamed:@"timeline_image_loading"]; // 来源于哪个UIImageView
            [photos addObject:photo];
        }
        
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        //browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
        
        browser.currentPhotoIndex = 0;
        browser.photos = photos; // 设置所有的图片
        [browser show];
        
    }else if (indexPath.row ==2){
    
        //代理人资料
        NSArray *dicArray = (NSArray *)self.homeModel.houseDic[@"agent_photos"];
        
        NSArray *array = [MTLJSONAdapter modelsOfClass:[PhoModel class] fromJSONArray:dicArray error:nil];
        NSMutableArray *imgUrl = [NSMutableArray array];
        for (PhoModel *model in array) {
            
            [imgUrl addObject:model.imgStr];
        }
        
        NSInteger count = imgUrl.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        
        for (int i = 0; i<count; i++) {
            
            // 替换为中等尺寸图片
            NSString *url = [imgUrl[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            //                NSString *url =[NSString stringWithFormat:@"%@",_homeModel.pledge[i]];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            photo.srcImageView.image = [UIImage imageNamed:@"timeline_image_loading"]; // 来源于哪个UIImageView
            [photos addObject:photo];
        }
        
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        //browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
        
        browser.currentPhotoIndex = 0;
        browser.photos = photos; // 设置所有的图片
        [browser show];
        
        
    }else if (indexPath.row ==3){
    
        //合同图片
        NSArray *dicArray = (NSArray *)self.homeModel.houseDic[@"contract_photos"];
        
        NSArray *array = [MTLJSONAdapter modelsOfClass:[PhoModel class] fromJSONArray:dicArray error:nil];
        NSMutableArray *imgUrl = [NSMutableArray array];
        for (PhoModel *model in array) {
            
            [imgUrl addObject:model.imgStr];
        }
        
        NSInteger count = imgUrl.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        
        for (int i = 0; i<count; i++) {
            
            // 替换为中等尺寸图片
            NSString *url = [imgUrl[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            //                NSString *url =[NSString stringWithFormat:@"%@",_homeModel.pledge[i]];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            photo.srcImageView.image = [UIImage imageNamed:@"timeline_image_loading"]; // 来源于哪个UIImageView
            [photos addObject:photo];
        }
        
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        //browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
        
        browser.currentPhotoIndex = 0;
        browser.photos = photos; // 设置所有的图片
        [browser show];
        
        
    }else{
    
         //房产图片
        NSArray *dicArray = (NSArray *)self.homeModel.houseDic[@"house_photos"];
        
        NSArray *array = [MTLJSONAdapter modelsOfClass:[PhoModel class] fromJSONArray:dicArray error:nil];
        NSMutableArray *imgUrl = [NSMutableArray array];
        for (PhoModel *model in array) {
            
            [imgUrl addObject:model.imgStr];
        }
        
        NSInteger count = imgUrl.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        
        for (int i = 0; i<count; i++) {
            
            // 替换为中等尺寸图片
            NSString *url = [imgUrl[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            //                NSString *url =[NSString stringWithFormat:@"%@",_homeModel.pledge[i]];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            photo.srcImageView.image = [UIImage imageNamed:@"timeline_image_loading"]; // 来源于哪个UIImageView
            [photos addObject:photo];
        }
        
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        //browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
        
        browser.currentPhotoIndex = 0;
        browser.photos = photos; // 设置所有的图片
        [browser show];
        
        
        
        
        
       
        
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}



-(BOOL)shouldShowRefresh
{
    return NO;
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
