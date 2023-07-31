//
//  LeaderInfoViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "LeaderInfoViewController.h"
#import "WriteLeaderViewController.h"

@interface LeaderInfoViewController (){
    UILabel *namelab;
    UILabel *phonelab;
    UILabel *apartlab;
    
    NSDictionary *dic;
}

@end

@implementation LeaderInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:back];
    
    UIView *back2 = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back2.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    
    
    self.title = @"编辑信息";
    [self createBarLeftWithImage:@"nav_return"];
    [self createRightTitle:@"编辑" titleColor:[UIColor blackColor]];
    
    NSArray *arr = @[@"领导姓名",@"联系电话",@"所属部门"];
    
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10+51*i, 87, 50)];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.text = arr[i];
        label.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 10+51+51*i, zScreenWidth, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        
        
        [back addSubview:line];
        
        [back addSubview:label];
    }
    
    namelab = [[UILabel alloc]initWithFrame:CGRectMake(87, 10, zScreenWidth-87, 50)];
    namelab.font = [UIFont systemFontOfSize:16];
    namelab.textAlignment = NSTextAlignmentCenter;
    namelab.backgroundColor = [UIColor whiteColor];
    namelab.textColor = [UIColor colorHexString:@"121212"];
    
    phonelab = [[UILabel alloc]initWithFrame:CGRectMake(87, 10+51*1, zScreenWidth-87, 50)];
    phonelab.font = [UIFont systemFontOfSize:16];
    phonelab.textAlignment = NSTextAlignmentCenter;
    phonelab.backgroundColor = [UIColor whiteColor];
    phonelab.textColor = [UIColor colorHexString:@"121212"];
    
    apartlab = [[UILabel alloc]initWithFrame:CGRectMake(87, 10+51*2, zScreenWidth-87, 50)];
    apartlab.font = [UIFont systemFontOfSize:16];
    apartlab.textAlignment = NSTextAlignmentCenter;
    apartlab.backgroundColor = [UIColor whiteColor];
    apartlab.textColor = [UIColor colorHexString:@"121212"];
    
    [back addSubview:namelab];
    [back addSubview:phonelab];
    [back addSubview:apartlab];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-50, 44, 100, 100)];
    image.contentMode = UIViewContentModeCenter;
    image.image = [UIImage imageNamed:@"myself_caution-1"];
    [back2 addSubview:image];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-53, 44+100+50, 106, 35)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    [btn setBackgroundColor:[UIColor colorHexString:@"1a3055"]];
    [btn setTitle:@"添加领导" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    [back2 addSubview:btn];
    
    [self load];
    
}

- (void)load{
    [HTTPRequest postWithURL:@"yrycapi/user/getmyleaderinfo" method:@"GET" params:nil ProgressHUD:nil controller:self response:^(id json) {
        
        dic = [NSDictionary dictionaryWithDictionary:json];
        
        namelab.text = [dic objectForKey:@"myLeader"];
        phonelab.text = [dic objectForKey:@"leaderPhone"];
        apartlab.text = [dic objectForKey:@"leaderDep"];
        
        
        NSLog(@"success:%@",json);
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
}


- (void)done{
    WriteLeaderViewController *wvc = [[WriteLeaderViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

-(void)showRight:(UIButton *)sender{
    WriteLeaderViewController *wvc = [[WriteLeaderViewController alloc]init];
    wvc.dict = dic;
    wvc.callBackBlock = ^(NSString *text){ 
        
        [self load];
        
    };
    [self.navigationController pushViewController:wvc animated:YES];
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
