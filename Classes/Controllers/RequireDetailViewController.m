//
//  RequireDetailViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/24.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "RequireDetailViewController.h"

@interface RequireDetailViewController (){
    UILabel *titleLab;
    UILabel *timeLab;
    UITextView *conLab;
    UIView *back;
}

@end

@implementation RequireDetailViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleLab.text = [_dict objectForKey:@"title"];
    timeLab.text = [_dict objectForKey:@"createDate"];
    conLab.text = [_dict objectForKey:@"content"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    self.title = @"需求详情";
    [self createBarLeftWithImage:@"nav_return"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:view];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth/2-150, zNavigationHeight+20, 300, 25)];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [self.view addSubview:titleLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth/2-150, zNavigationHeight+20+25, 300, 20)];
    timeLab.textColor = [UIColor colorHexString:@"888888"];
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    [self.view addSubview:timeLab];
    
    back = [[UIView alloc] initWithFrame:CGRectMake(15, timeLab.frame.origin.y+20+20, zScreenWidth-30, zScreenHeight-200)];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 4;
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, back.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorHexString:@"fdba44"];
    [back addSubview:line];
    
    conLab = [[UITextView alloc] initWithFrame:CGRectMake(23, 19, zScreenWidth-15*2-23*2, back.frame.size.height-19-80)];
    conLab.textColor = [UIColor colorHexString:@"888888"];
    conLab.textAlignment = NSTextAlignmentLeft;
    conLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    conLab.editable = NO;
    [back addSubview:conLab];
    
    
    
    
    // Do any additional setup after loading the view.
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
