//
//  InViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "InViewController.h"

@interface InViewController (){
    UILabel *titleLab;
    UILabel *timeLab;
    UITextView *conLab;
    NSDictionary *dic;
    UIButton *btn;
    UIView *back;
}

@end

@implementation InViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HTTPRequest postWithURL:@"yrycapi/task/receivetaskdetail" method:@"POST" params:@{@"taskId":_Id,@"townTaskId":_townId} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"12121212%@",json);
        
        dic = [NSDictionary dictionaryWithDictionary:json];
        
        titleLab.text = [dic objectForKey:@"taskName"];
        timeLab.text = [NSString stringWithFormat:@"完成时间:%@-%@",[dic objectForKey:@"startDate"],[dic objectForKey:@"endDate"]];
        conLab.text = [dic objectForKey:@"taskContent"];
        
        if ([[dic objectForKey:@"status"] isEqualToString:@"未完成"]) {
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
            [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
            [back addSubview:btn];
        }else{
            [btn setTitle:[dic objectForKey:@"status"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor grayColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [back addSubview:btn];
        }
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    self.title = @"我收到的任务";
    [self createBarLeftWithImage:@"nav_return"];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth/2-150, zNavigationHeight+20, 300, 25)];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titleLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth/2-150, zNavigationHeight+20+25, 300, 20)];
    timeLab.textColor = [UIColor colorHexString:@"888888"];
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:timeLab];
    
    back = [[UIView alloc] initWithFrame:CGRectMake(15, timeLab.frame.origin.y+20+20, zScreenWidth-30, zScreenHeight-250)];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 4;
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    conLab = [[UITextView alloc] initWithFrame:CGRectMake(23, 19, zScreenWidth-15*2-23*2, back.frame.size.height-19-80)];
    conLab.textColor = [UIColor colorHexString:@"888888"];
    conLab.textAlignment = NSTextAlignmentLeft;
    conLab.font = [UIFont systemFontOfSize:13];
    conLab.editable = NO;
    [back addSubview:conLab];
    
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(back.frame.size.width/2-40, back.frame.size.height-15-39, 80, 39)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 6;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    // Do any additional setup after loading the view.
}

- (void)done{
    
    if ([[dic objectForKey:@"status"] isEqualToString:@"未完成"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        NSDate *datenow = [NSDate date];
        
        NSString *currentTimeString = [formatter stringFromDate:datenow];
        
        NSDictionary *param = @{@"appTaskMemberDetailId":[NSString stringWithFormat:@"%@",[dic objectForKey:@"appTaskMemberDetailId"]],@"endDate":currentTimeString};
        
        [HTTPRequest postWithURL:@"yrycapi/task/completetask" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"12121212%@",json);
            
            self.callBackBlock(@"back");
    
            
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor grayColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }
    
    
    
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
