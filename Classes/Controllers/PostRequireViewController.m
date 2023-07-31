//
//  PostRequireViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/24.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PostRequireViewController.h"

@interface PostRequireViewController ()<UITextViewDelegate,UITextFieldDelegate>{
    UITextView *text;
    UILabel *pleLabel;
    
    UITextField *textfield;
}

@end

@implementation PostRequireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    self.title = @"发布新需求";
    [self createBarLeftWithImage:@"nav_return"];
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+10, zScreenWidth, 350)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 50, 20)];
    label.textColor = [UIColor colorHexString:@"888888"];
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    label.text = @"标题";
    [backview addSubview:label];
    
    textfield = [[UITextField alloc]initWithFrame:CGRectMake(15+50, 15, 250, 30)];
    textfield.textColor = [UIColor colorHexString:@"888888"];
//    textfield.layer.masksToBounds = YES;
//    textfield.layer.cornerRadius = 2;
//    textfield.layer.borderWidth = 0.5;
//    textfield.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    textfield.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    textfield.placeholder = @"请输入标题";
    textfield.delegate = self;
    textfield.returnKeyType = UIReturnKeyDone;
    [backview addSubview:textfield];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 20+20+20, zScreenWidth-30, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    [backview addSubview:line1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 20+20+40, 50, 20)];
    label1.textColor = [UIColor colorHexString:@"888888"];
    label1.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    label1.text = @"内容";
    [backview addSubview:label1];
    
    
    
    
    text = [[UITextView alloc]initWithFrame:CGRectMake(15, 20+20+40+20+20, zScreenWidth-30, 200)];
    text.backgroundColor = [UIColor whiteColor];
    text.delegate = self;
    text.returnKeyType = UIReturnKeyDone;
    
    text.layer.masksToBounds = YES;
    text.layer.cornerRadius = 4;
    text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"]CGColor];
    text.layer.borderWidth = 1;
    
    
    [backview addSubview:text];
    
    pleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 20)];
    
    pleLabel.text = @"请输入具体内容";
    pleLabel.textColor = [UIColor colorHexString:@"88888888"];
    pleLabel.textAlignment = NSTextAlignmentLeft;;
    [text addSubview:pleLabel];
    
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [doneBtn addTarget:self action:@selector(confirme) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    // Do any additional setup after loading the view.
}

- (void)confirme{
    NSLog(@"hahaha");
    
    NSDictionary *dict = @{@"holderName":_holderName,@"familyNo":_familyNo,@"title":textfield.text,@"content":text.text};
    
    if (textfield.text.length>0 && text.text.length>0) {
        [HTTPRequest postWithURL:@"yrycapi/familyinfo/publishdemand" method:@"POST" params:dict ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"success%@",json);
            
            self.callBackBlock(@"back");
            
            [ZJStaticFunction alertView:self.view msg:@"提交成功"];
            [self.navigationController popViewControllerAnimated:NO];
            
        } error400Code:^(id failure) {
            
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        pleLabel.alpha = 1;
    } else {
        pleLabel.alpha = 0;
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
