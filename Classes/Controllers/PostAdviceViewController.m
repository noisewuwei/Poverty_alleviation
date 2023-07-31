//
//  PostAdviceViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/2.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PostAdviceViewController.h"

@interface PostAdviceViewController ()<UITextViewDelegate,UITextFieldDelegate>{
    UITextView *text;
    UILabel *pleLabel;
    
    NSMutableArray *btnMutableArray;
    UIButton *Btn;
    NSString *typestr;
    
    UITextField *textfield;
}

@end

@implementation PostAdviceViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ((UIButton *)[btnMutableArray objectAtIndex:0]).selected=YES;
    
    typestr = @"市长信箱";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    [self createBarLeftWithImage:@"nav_return"];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+1, zScreenWidth, 50)];
    topview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topview];
    
    NSArray *arr = @[@"书记信箱",@"县长信箱",@"系统反馈"];
    
    btnMutableArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<3; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(20+(20+(zScreenWidth-80)/3)*i, 10, (zScreenWidth-80)/3, 32)];
        Btn.layer.masksToBounds = YES;
        Btn.layer.cornerRadius = 32/2;
        [Btn setTitle:arr[i] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [Btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [Btn setBackgroundImage:[self imageWithColor:[UIColor colorHexString:@"1a2f55"]] forState:UIControlStateSelected];        Btn.layer.borderWidth = 1;
        Btn.layer.borderColor= [[UIColor colorHexString:@"e1e1e1"]CGColor];
        
        Btn.selected = NO;
        Btn.tag = 100+i;
        
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnMutableArray addObject:Btn];
        
        [topview addSubview:Btn];
    }
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+50+10, zScreenWidth, 350)];
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

- (void)choose:(UIButton *)sender{
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    //    for (int i = 0; i < 3; i++) {
    //        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
    //        //选中当前按钮时
    //        if (sender.tag == btn.tag) {
    //            sender.selected = !sender.selected;
    //        }else{
    //            [btn setSelected:NO];
    //        }
    //
    //    }
    
    if (sender.tag == 100) {
        NSLog(@"市长信箱");
        typestr = @"市长信箱";
        textfield.text = @"";
        text.text = @"";
    }else if(sender.tag == 101){
        NSLog(@"县长信箱");
        typestr = @"县长信箱";
        textfield.text = @"";
        text.text = @"";
    }else{
        NSLog(@"系统反馈");
        typestr = @"系统反馈";
        textfield.text = @"";
        text.text = @"";
    }
    
    
}

- (void)confirme{
    NSLog(@"queding");
    
    if (textfield.text.length>0 && textfield.text.length>0) {
        NSDictionary *dict = @{@"type":typestr,@"title":textfield.text,@"content":text};
        
        [HTTPRequest postWithURL:@"yrycapi/suggest/commit" method:@"POST" params:dict ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"%@",json);
            [ZJStaticFunction alertView:self.view msg:@"提交成功"];
            [self.navigationController popViewControllerAnimated:NO];
            
        } error400Code:^(id failure) {
            
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
    }
    
    
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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

- (void)showRight:(UIButton *)sender{
    NSLog(@"tijiao");
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
