//
//  LoginViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/13.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "LYTBackView.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    UITextField *numtext;
    UITextField *pwtext;
}

@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"首页";
//    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 190)];

    imageview.image = [UIImage imageNamed:@"login_bg"];

    [self.view addSubview:imageview];
    
    UIView *loginview = [[UIView alloc]initWithFrame:CGRectMake(23, 130, zScreenWidth-46, 340)];
    loginview.layer.masksToBounds = NO;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:loginview.bounds];
    loginview.layer.cornerRadius = 3;
    loginview.layer.shadowOffset = CGSizeMake(0, 5);
    loginview.layer.shadowOpacity = 0.3f;
    loginview.layer.shadowPath = shadowPath.CGPath;
    loginview.layer.shadowColor = [[UIColor colorHexString:@"9BA2AF"] CGColor];
    
    loginview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:loginview];
    
    UIButton *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(23, loginview.bounds.size.height-40-44, zScreenWidth-46-46, 44)];
    [loginbtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginbtn.layer.masksToBounds = YES;
    loginbtn.layer.cornerRadius = 4;
    loginbtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    
    UIImageView *phoneimage = [[UIImageView alloc]initWithFrame:CGRectMake(31, 146, 13, 25)];
    phoneimage.image = [UIImage imageNamed:@"login_phone"];
    [phoneimage sizeToFit];
    
    UIImageView *lockimage = [[UIImageView alloc]initWithFrame:CGRectMake(31, 146+50, 13, 25)];
    lockimage.image = [UIImage imageNamed:@"login_password"];
    [lockimage sizeToFit];
    
    numtext = [[UITextField alloc]initWithFrame:CGRectMake(31+13+13, 146-8, loginview.bounds.size.width-(31+13+13+13), 35)];
    numtext.placeholder = @"请输入手机号";
    
    pwtext = [[UITextField alloc]initWithFrame:CGRectMake(31+13+13, 146-8+50, loginview.bounds.size.width-(31+13+13+13), 35)];
    pwtext.placeholder = @"请输入密码";
    
    pwtext.secureTextEntry = YES;
    
    numtext.delegate = self;
    pwtext.delegate = self;
    
    numtext.returnKeyType = UIReturnKeyDone;
    pwtext.returnKeyType = UIReturnKeyDone;
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(loginview.bounds.size.width/2-24.5, 29, 49, 49)];
    logo.image = [UIImage imageNamed:@"login_logo"];
    
    
    UIImageView *down = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-151/2, zScreenHeight-15-17, 151, 17)];
    down.image = [UIImage imageNamed:@"login_slogan"];
    down.contentMode = UIViewContentModeCenter;
    [self.view addSubview:down];
    
    [loginview addSubview:logo];
    [loginview addSubview:numtext];
    [loginview addSubview:pwtext];
    [loginview addSubview:phoneimage];
    [loginview addSubview:lockimage];
    [loginview addSubview:loginbtn];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, 480, 150, 25)];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    [registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorHexString:@"646464"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(regi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
    // Do any additional setup after loading the view.
}

- (void)confirme{
    NSLog(@"hahaha");
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(35, zScreenHeight/2-140, zScreenWidth-70, 280)];
    backview.layer.masksToBounds = YES;
    backview.backgroundColor = [UIColor whiteColor];
    backview.layer.cornerRadius = 8;
    
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backview.frame.size.width, 66)];
    imageview.contentMode = UIViewContentModeScaleToFill;
    imageview.image = [UIImage imageNamed:@"popup_not-passed"];
    [backview addSubview:imageview];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(backview.frame.size.width-20-10, 10, 20, 20)];
    [cancelBtn setImage:[UIImage imageNamed:@"popup_close-1"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelclick) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:cancelBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width/2-100, 66+20, 200, 60)];
    label.numberOfLines = 0;
    label.text = @"您的账号\n尚未审核通过！";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [backview addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width/2-100, 66+20+50+15, 200, 30)];
    label2.numberOfLines = 0;
    label2.text = @"如有问题，请联系系统管理员";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [backview addSubview:label2];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 280-45, backview.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    [backview addSubview:line];
    
    UIButton *comBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 280-44, backview.frame.size.width, 44)];
    [comBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [comBtn setTitleColor:[UIColor colorHexString:@"fdba45"] forState:UIControlStateNormal];
    [comBtn addTarget:self action:@selector(com) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:comBtn];
    
    [LYTBackView showWithView:backview];
    
    
    
    
}

- (void)cancelclick{
    [LYTBackView dissMiss];
}

- (void)com{
    [LYTBackView dissMiss];
}

- (void)regi{
    NSLog(@"regi");
   
    RegisterViewController *regivc = [[RegisterViewController alloc]init];
    
//    UINavigationController *regin = [[UINavigationController alloc]initWithRootViewController:self];
    
    [self.navigationController pushViewController:regivc animated:YES];
    
}

- (void)login{
    
    NSDictionary *dic = @{@"userPhone":numtext.text,@"password":pwtext.text};
    
    [HTTPRequest postWithURL:@"yrycapi/user/login" method:@"POST" params:dic ProgressHUD:nil controller:self response:^(id json) {
        NSLog(@"success:%@",json);
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic = [NSMutableDictionary dictionaryWithDictionary:json];
//        UserModel *newModel = [UserModel initDetailWithDict:dic];
        [ZJStoreDefaults setObject:dic forKey:@"userinfo"];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        ViewController *tab = (ViewController *)delegate.window.rootViewController;
        tab.selectedIndex = 0;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeinfo" object:nil userInfo:nil];
        
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"登陆成功");
        }];
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
    
    
    
    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    ViewController *tab = (ViewController *)delegate.window.rootViewController;
//    tab.selectedIndex = 0;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == numtext) {
        [numtext resignFirstResponder];
    }else if (textField == pwtext){
        [pwtext resignFirstResponder];
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
