//
//  AddBasicInfoViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/6/1.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddBasicInfoViewController.h"
#import "LocationPeopleViewController.h"

@interface AddBasicInfoViewController ()<UITextFieldDelegate>{
    UIView *whiteview;
    UIButton *Btn;
    UIButton *Btn2;
    UITextField *text;
    
    UILabel *addresslabel;
}

@end

@implementation AddBasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight)];
//    back.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:back];
    
    
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
    
    NSArray *arr = @[@"类型",@"户主",@"地址",@"户口性质",@"识别标准",@"贫困户属性",@"是否军烈属",@"主要致贫原因",@"联系电话",@"计划脱贫",@"计划脱贫时间",@"家庭人数",@"开户银行",@"银行卡号"];
    
    for (int i=0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+(31+10)*i, 110, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = arr[i];
        
        
        [whiteview addSubview:label];
    }
    

    NSArray *buttonarr = @[@" 贫困户",@" 非贫困户"];
    
    for (int i = 0; i<2; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*0, 100, 31)];
        [Btn setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn.selected = NO;
        Btn.tag = 100+i;
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn];
    }
    
    NSArray *buttonarr2 = @[@" 是",@" 否"];
    
    for (int i = 0; i<2; i++) {
        Btn2 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*9, 100, 31)];
        [Btn2 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn2 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn2 setTitle:buttonarr2[i] forState:UIControlStateNormal];
        [Btn2 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn2.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn2.selected = NO;
        Btn2.tag = 50+i;
        [Btn2 addTarget:self action:@selector(choose2:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn2];
    }
    
    for (int i = 1; i<9; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
//        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 500+i;
        [whiteview addSubview:text];
    }
    
    for (int i = 1; i<5; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*(9+i), zScreenWidth-28-110-28, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 550+i;
        [whiteview addSubview:text];
    }
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(28, 10+(31+10)*(9+5), 15, 31)];
    image.contentMode = UIViewContentModeLeft;
    image.image = [UIImage imageNamed:@"count_Location2"];
    [whiteview addSubview:image];
    
    UILabel *tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(28+15+5, image.frame.origin.y, 60, 31)];
    tiplabel.textAlignment = NSTextAlignmentLeft;
    tiplabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    tiplabel.textColor = [UIColor colorHexString:@"888888"];
    tiplabel.text = @"户坐标：";
    [whiteview addSubview:tiplabel];
    
    addresslabel = [[UILabel alloc]initWithFrame:CGRectMake(28+15+5+60, image.frame.origin.y, 150, 31)];
    addresslabel.textAlignment = NSTextAlignmentLeft;
    addresslabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    addresslabel.textColor = [UIColor colorHexString:@"121212"];
    addresslabel.text = @"经度：123.6 纬度：56";
    [whiteview addSubview:addresslabel];
    
    
    UIButton *locaBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-28-80, image.frame.origin.y, 80, 31)];
    [locaBtn setTitle:@"重新定位" forState:UIControlStateNormal];
    [locaBtn setTitleColor:[UIColor colorHexString:@"fdba45"] forState:UIControlStateNormal];
    locaBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [locaBtn addTarget:self action:@selector(loca) forControlEvents:UIControlEventTouchUpInside];
    [whiteview addSubview:locaBtn];
    
    
    UIView *secondview = [[UIView alloc]initWithFrame:CGRectMake(0, image.frame.origin.y+31+10, zScreenWidth, zScreenHeight*1.7-(image.frame.origin.y+31+10))];
    [whiteview addSubview:secondview];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 10)];
    lineview.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [secondview addSubview:lineview];
    
    UIButton *addpeople = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-24.5, 10+27, 49, 49)];
    [addpeople setBackgroundImage:[UIImage imageNamed:@"add_add"] forState:UIControlStateNormal];
    [addpeople addTarget:self action:@selector(addpeople) forControlEvents:UIControlEventTouchUpInside];
    [secondview addSubview:addpeople];
    
    UILabel *downlabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, 10+27+49+16, 150, 31)];
    downlabel.textAlignment = NSTextAlignmentCenter;
    downlabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    downlabel.textColor = [UIColor colorHexString:@"fdba45"];
    downlabel.text = @"添加家庭成员";
    [secondview addSubview:downlabel];
    
    
    // Do any additional setup after loading the view.
}

- (void)addpeople{
    NSLog(@"people");
}

- (void)loca{
    LocationPeopleViewController *lvc = [[LocationPeopleViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES];
    NSLog(@"location");
}



- (void)choose:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 100) {
        NSLog(@"贫困户");
    }else{
        NSLog(@"非贫困户");
    }
    
    
}

- (void)choose2:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:50 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 50) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)confirme:(UIButton *)sender{
    UITextField *textfield1 = (UITextField *)[[sender superview]viewWithTag:500+1];
    UITextField *textfield2 = (UITextField *)[[sender superview]viewWithTag:500+2];
    UITextField *textfield3 = (UITextField *)[[sender superview]viewWithTag:500+3];
    UITextField *textfield4 = (UITextField *)[[sender superview]viewWithTag:500+4];
    UITextField *textfield5 = (UITextField *)[[sender superview]viewWithTag:500+5];
    UITextField *textfield6 = (UITextField *)[[sender superview]viewWithTag:500+6];
    UITextField *textfield7 = (UITextField *)[[sender superview]viewWithTag:500+7];
    UITextField *textfield8 = (UITextField *)[[sender superview]viewWithTag:500+8];
    NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@",textfield1.text,textfield2.text,textfield3.text,textfield4.text,textfield5.text,textfield6.text,textfield7.text,textfield8.text);
    
    
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
