//
//  ChangePasswordViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/10.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>{
    UITextField *oldpass;
    UITextField *newpass1;
    UITextField *newpass2;
}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    [self createBarLeftWithImage:@"nav_return"];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:back];
    
    NSArray *arr = @[@"旧密码",@"新密码",@"新密码"];
    
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 51*i, 87, 51)];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = arr[i];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(87, 51+51*i, zScreenWidth-87, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        
        
        [back addSubview:line];
        
        [back addSubview:label];
    }
    
    oldpass = [[UITextField alloc]initWithFrame:CGRectMake(87, 0, zScreenWidth-87, 50)];
    oldpass.font = [UIFont systemFontOfSize:16];
    oldpass.delegate = self;
    oldpass.placeholder = @"请输入旧密码";
    oldpass.returnKeyType = UIReturnKeyDone;
    oldpass.backgroundColor = [UIColor whiteColor];
    [back addSubview:oldpass];
    
    newpass1 = [[UITextField alloc]initWithFrame:CGRectMake(87, 51, zScreenWidth-87, 50)];
    newpass1.font = [UIFont systemFontOfSize:16];
    newpass1.delegate = self;
    newpass1.placeholder = @"请输入新密码";
    newpass1.returnKeyType = UIReturnKeyDone;
    newpass1.backgroundColor = [UIColor whiteColor];
    [back addSubview:newpass1];
    
    newpass2 = [[UITextField alloc]initWithFrame:CGRectMake(87, 51*2, zScreenWidth-87, 50)];
    newpass2.font = [UIFont systemFontOfSize:16];
    newpass2.delegate = self;
    newpass2.placeholder = @"请再次输入新密码";
    newpass2.returnKeyType = UIReturnKeyDone;
    newpass2.backgroundColor = [UIColor whiteColor];
    [back addSubview:newpass2];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(17, zScreenHeight-150, zScreenWidth-34, 44)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    [btn setBackgroundColor:[UIColor colorHexString:@"1a3055"]];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    [back addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)done{
    if (oldpass.text.length>0 && newpass1.text.length>0 && newpass2.text.length>0) {
        
        if ([newpass1.text isEqualToString:newpass2.text]) {
            NSDictionary *dic = @{@"originaPassword":oldpass.text,@"newPassword":newpass1.text};
            
            [HTTPRequest postWithURL:@"yrycapi/user/changepassword" method:@"POST" params:dic ProgressHUD:nil controller:self response:^(id json) {
                
                NSDictionary *userdic = [NSDictionary dictionary];
                userdic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
                NSDictionary *dict = @{@"userPhone":[userdic objectForKey:@"userPhone"],@"password":newpass1.text};
                [HTTPRequest postWithURL:@"yrycapi/user/login" method:@"POST" params:dict ProgressHUD:self.Hud controller:self response:^(id json) {
                    NSLog(@"success:%@",json);
                    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
                    [ZJStoreDefaults setObject:dic forKey:@"userinfo"];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeinfo" object:nil userInfo:nil];
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    
                } error400Code:^(id failure) {
                    NSLog(@"error:%@",failure);
                }];

                
            } error400Code:^(id failure) {
                NSLog(@"error:%@",failure);
            }];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"两次新密码输入不一致"];
        }
        
        
    }else{
        [ZJStaticFunction alertView:self.view msg:@"输入正确的信息"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == oldpass) {
        [oldpass resignFirstResponder];
    }else if (textField == newpass1){
        [newpass1 resignFirstResponder];
    }else if (textField == newpass2){
        [newpass2 resignFirstResponder];
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
