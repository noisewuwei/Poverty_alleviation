//
//  ViewController.m
//  Poverty alleviation
//
//  Created by 吴畏 on 2017/12/26.
//  Copyright © 2017年 吴畏. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "AttenceViewController.h"
#import "HelpViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "MissionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HelpViewController *helpvc = [HelpViewController alloc];
    UINavigationController *helpn = [[UINavigationController alloc]initWithRootViewController:helpvc];
    helpn.tabBarItem.title = @"帮扶指导";
    
    helpn.tabBarItem.image = [[UIImage imageNamed:@"home_icon1+"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    helpn.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_icon1_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorHexString:@"#999999"],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
    [helpn.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    NSShadow *shad = [[NSShadow alloc] init];
    shad.shadowColor = [UIColor whiteColor];
    NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorHexString:@"#1a2f55"],NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
    [helpn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    AttenceViewController *attencevc = [AttenceViewController alloc];
    UINavigationController *attencen = [[UINavigationController alloc]initWithRootViewController:attencevc];
    attencen.tabBarItem.title = @"首页";
    
    attencen.tabBarItem.image = [[UIImage imageNamed:@"home_icon6_unselected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    attencen.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_icon6_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [attencen.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [attencen.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    
    
    MessageViewController *messagevc = [MessageViewController alloc];
    UINavigationController *messagen = [[UINavigationController alloc]initWithRootViewController:messagevc];
    messagen.tabBarItem.title = @"党建扶贫";
    
    messagen.tabBarItem.image = [[UIImage imageNamed:@"home_icon3+"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    messagen.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_icon3_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    [messagen.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    MineViewController *minevc = [MineViewController alloc];
    UINavigationController *minen = [[UINavigationController alloc]initWithRootViewController:minevc];

    minen.tabBarItem.title = @"我";
    
    minen.tabBarItem.image = [[UIImage imageNamed:@"home_icon4+"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    minen.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_icon4_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    [minen.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    MissionViewController *missvc = [MissionViewController alloc];
    UINavigationController *missn = [[UINavigationController alloc]initWithRootViewController:missvc];
    missn.tabBarItem.title = @"扶贫任务";
    
    missn.tabBarItem.image = [[UIImage imageNamed:@"home_icon5"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    missn.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_icon5_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影

    [missn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    NSArray *arr = @[attencen,helpn,messagen,missn,minen];
    
    [self setViewControllers:arr animated:YES];
    
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([ZJStoreDefaults getObjectForKey:@"userinfo"]) {
        NSDictionary *userdic = [NSDictionary dictionary];
        userdic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
        NSDictionary *dict = @{@"userPhone":[userdic objectForKey:@"userPhone"],@"password":[userdic objectForKey:@"password"]};
        [HTTPRequest postWithURL:@"yrycapi/user/login" method:@"POST" params:dict ProgressHUD:self.Hud controller:self response:^(id json) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            [ZJStoreDefaults setObject:dic forKey:@"userinfo"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeinfo" object:nil userInfo:nil];
            
        } error400Code:^(id failure) {
            NSLog(@"error:%@",failure);
        }];
    }else{
        LoginViewController *lgvc = [[LoginViewController alloc] init];
        UINavigationController *lgn = [[UINavigationController alloc]initWithRootViewController:lgvc];
        [self presentViewController:lgn animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
