//
//  AddHelpMethodViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/6/1.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddHelpMethodViewController.h"

@interface AddHelpMethodViewController (){
    UIView *whiteview;
}

@end

@implementation AddHelpMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:back];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-49-6)];
    scrollView.contentSize = CGSizeMake(zScreenWidth, zScreenHeight*1.7);
    scrollView.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-zNavigationHeight-6-34-49, zScreenWidth, 49)];
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [doneBtn addTarget:self action:@selector(confirme:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 6, zScreenWidth, zScreenHeight*1.7-6)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:whiteview];
    
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
