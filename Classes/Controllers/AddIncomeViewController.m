//
//  AddIncomeViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/6/1.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddIncomeViewController.h"

@interface AddIncomeViewController ()<UITextFieldDelegate>{
    UIView *whiteview;
    UITextField *text;
}

@end

@implementation AddIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor yellowColor];
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
    
    
    NSArray *arr = @[@"工资性收入",@"计划生育金",@"生态补偿金",@"生产经营性收入",@"低保金",@"其他转移性收入",@"财产性收入",@"五保金",@"转移性收入",@"养老保险金",@"家庭年总收入",@"纯收入",@"人均纯收入"];
    
    for (int i=0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+(31+10)*i, 110, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = arr[i];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-28-30, 10+(31+10)*i, 30, 31)];
        label2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label2.textAlignment = NSTextAlignmentRight;
        label2.textColor = [UIColor colorHexString:@"888888"];
        label2.backgroundColor = [UIColor whiteColor];
        label2.text = @"元";
        
        [whiteview addSubview:label2];
        [whiteview addSubview:label];
    }
    
    for (int i = 0; i<13; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28-30, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 100+i;
        [whiteview addSubview:text];
    }
    
    
    
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
    }
    return YES;
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
