//
//  WriteLeaderViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "WriteLeaderViewController.h"

@interface WriteLeaderViewController ()<UITextFieldDelegate>{
    UITextField *name;
    UITextField *phone;
    UITextField *apart;
}



@end

@implementation WriteLeaderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    name.text = [_dict objectForKey:@"myLeader"];
    phone.text = [_dict objectForKey:@"leaderPhone"];
    apart.text = [_dict objectForKey:@"leaderDep"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"所在单位扶贫挂帮分管领导";
    [self createBarLeftWithImage:@"nav_return"];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:back];
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 39)];
    backview.backgroundColor = [UIColor colorHexString:@"fbefbe"];
    [back addSubview:backview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-100, 9.5, 200, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorHexString:@"2a2a2a"];
    label.text = @"请填写真实的信息，谢谢配合!";
    [backview addSubview:label];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-100-20, 9.5, 20, 20)];
    image.contentMode = UIViewContentModeCenter;
    image.image = [UIImage imageNamed:@"myself_caution"];
    [backview addSubview:image];
    
    NSArray *arr = @[@"领导姓名",@"联系电话",@"所属部门"];
    
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 39+51*i, 87, 51)];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = arr[i];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(87, 39+51+51*i, zScreenWidth-87, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        
        
        [back addSubview:line];
        
        [back addSubview:label];
    }
    
    name = [[UITextField alloc]initWithFrame:CGRectMake(87, 39, zScreenWidth-87, 50)];
    name.font = [UIFont systemFontOfSize:16];
    name.delegate = self;
    name.placeholder = @"请填写真实姓名";
    name.returnKeyType = UIReturnKeyDone;
    name.backgroundColor = [UIColor whiteColor];
    [back addSubview:name];
    
    phone = [[UITextField alloc]initWithFrame:CGRectMake(87, 39+51, zScreenWidth-87, 50)];
    phone.font = [UIFont systemFontOfSize:16];
    phone.delegate = self;
    phone.placeholder = @"请填写有效联系电话";
    phone.returnKeyType = UIReturnKeyDone;
    phone.backgroundColor = [UIColor whiteColor];
    [back addSubview:phone];
    
    apart = [[UITextField alloc]initWithFrame:CGRectMake(87, 39+51*2, zScreenWidth-87, 50)];
    apart.font = [UIFont systemFontOfSize:16];
    apart.delegate = self;
    apart.placeholder = @"请填写所属部门";
    apart.returnKeyType = UIReturnKeyDone;
    apart.backgroundColor = [UIColor whiteColor];
    [back addSubview:apart];
    
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(17, zScreenHeight-150, zScreenWidth-34, 44)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    [btn setBackgroundColor:[UIColor colorHexString:@"1a3055"]];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    [back addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)done{
    
    if (name.text.length>0 && phone.text.length>0 && apart.text.length>0) {
        
        NSDictionary *dic = @{@"myLeader":name.text,@"leaderDep":apart.text,@"leaderPhone":phone.text};
        
        [HTTPRequest postWithURL:@"yrycapi/user/changemyleader" method:@"POST" params:dic ProgressHUD:nil controller:self response:^(id json) {
            
            [ZJStaticFunction alertView:self.view msg:@"提交成功"];
            
            self.callBackBlock(@"back");
            
            [self.navigationController popViewControllerAnimated:NO];
            
        } error400Code:^(id failure) {
            NSLog(@"error:%@",failure);
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"输入正确的信息"];
    }
    
    
    
    NSLog(@"hahahahha");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == name) {
        [name resignFirstResponder];
    }else if (textField == phone){
        [phone resignFirstResponder];
    }else if (textField == apart){
        [apart resignFirstResponder];
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
