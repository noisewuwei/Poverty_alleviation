//
//  WriteInfoViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/5/31.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "WriteInfoViewController.h"
#import "LYTBackView.h"


@interface WriteInfoViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    UITextField *nametext;//姓名
    UIButton *birthtext;//出身日期
    UIButton *studyext;//最高学历
    UITextField *idnumtext;//身份证号
    UIButton *numbertext;//帮扶户数
    UITextField *companytext;//行政单位
    UITextField *jobtext;//职务
    UITextField *expritext;//帮扶经历及成效
    UIButton *leveltext;//具体的乡镇
    
    UIButton *Btn;
    UIButton *Btn1;
    UIButton *Btn2;
    
    
    UIView *hiddenview;
    
    UITextView *expriText;
    
    UILabel *pleLabel;
    
    UIView *moveview;
    
    UITextField *leadernametext;//领导姓名
    UITextField *mobilenumtext;//联系电话
    UITextField *aparttext;//所属部门
    
    UIView *whiteview;
    NSMutableArray *mutablearr;
}

@end

@implementation WriteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mutablearr = [NSMutableArray array];
    
    self.title = @"填写基本信息";
    
    [self createBarLeftWithImage:@"nav_return"];
    
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight-49)];
    scrollView.contentSize = CGSizeMake(zScreenWidth, zScreenHeight*1.7);
    scrollView.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [doneBtn addTarget:self action:@selector(confirme) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 6, zScreenWidth, zScreenHeight*1.7-6)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:whiteview];
    
    NSArray *arr = @[@"姓名",@"性别",@"出身日期",@"最高学历",@"身份证号",@"帮扶户数",@"所属级",@"",@"行政单位",@"职务",@"是否党员"];
    
    for (int i=0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+(31+10)*i, 110, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = arr[i];
        
        
        [whiteview addSubview:label];
    }
    
    
    hiddenview = [[UIView alloc]initWithFrame:CGRectMake(0, 10+(31+10)*11-10, zScreenWidth, 330)];
    [whiteview addSubview:hiddenview];
    
    UILabel *hiddenlabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 10, 110, 31)];
    hiddenlabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    hiddenlabel.textAlignment = NSTextAlignmentLeft;
    hiddenlabel.textColor = [UIColor colorHexString:@"888888"];
    hiddenlabel.backgroundColor = [UIColor whiteColor];
    hiddenlabel.text = @"可提供帮扶";

    [hiddenview addSubview:hiddenlabel];
    
    
    QCheckBox *check1 = [[QCheckBox alloc] initWithDelegate:self];
    check1.frame = CGRectMake(28+110, 10, 100, 31);
    [check1 setTitle:@"政策宣传" forState:UIControlStateNormal];
    [check1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [check1.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [hiddenview addSubview:check1];

    QCheckBox *check2 = [[QCheckBox alloc] initWithDelegate:self];
    check2.frame = CGRectMake(28+110+100, 10, 100, 31);
    [check2 setTitle:@"教育辅导" forState:UIControlStateNormal];
    [check2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [check2.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [hiddenview addSubview:check2];

    QCheckBox *check3 = [[QCheckBox alloc] initWithDelegate:self];
    check3.frame = CGRectMake(28+110, 10+(31+10), 100, 31);
    [check3 setTitle:@"医疗帮扶" forState:UIControlStateNormal];
    [check3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [check3.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [hiddenview addSubview:check3];

    QCheckBox *check4 = [[QCheckBox alloc] initWithDelegate:self];
    check4.frame = CGRectMake(28+110+100, 10+(31+10), 100, 31);
    [check4 setTitle:@"就业指导" forState:UIControlStateNormal];
    [check4 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [check4.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [hiddenview addSubview:check4];

    QCheckBox *check5 = [[QCheckBox alloc] initWithDelegate:self];
    check5.frame = CGRectMake(28+110, 10+(31+10)*2, 100, 31);
    [check5 setTitle:@"资金帮扶" forState:UIControlStateNormal];
    [check5 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [check5.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [hiddenview addSubview:check5];

    QCheckBox *check6 = [[QCheckBox alloc] initWithDelegate:self];
    check6.frame = CGRectMake(28+110+100, 10+(31+10)*2, 100, 31);
    [check6 setTitle:@"产业指导" forState:UIControlStateNormal];
    [check6 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [check6.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [hiddenview addSubview:check6];
    
    UILabel *exprilabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+(31+10)*3, 110, 31)];
    exprilabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    exprilabel.textAlignment = NSTextAlignmentLeft;
    exprilabel.textColor = [UIColor colorHexString:@"888888"];
    exprilabel.backgroundColor = [UIColor whiteColor];
    exprilabel.text = @"帮扶经历及成效";
    [hiddenview addSubview:exprilabel];
    
    expriText = [[UITextView alloc]initWithFrame:CGRectMake(28, 10+(31+10)*4, zScreenWidth-56, 150)];
    expriText.backgroundColor = [UIColor whiteColor];
    expriText.delegate = self;
    expriText.returnKeyType = UIReturnKeyDone;
    
    expriText.layer.masksToBounds = YES;
    expriText.layer.cornerRadius = 4;
    expriText.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"]CGColor];
    expriText.layer.borderWidth = 1;
    
    
    [hiddenview addSubview:expriText];
    
    pleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 250, 20)];
    pleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    pleLabel.text = @"请填写具体帮扶经历及成效...";
    pleLabel.textColor = [UIColor colorHexString:@"888888"];
    pleLabel.textAlignment = NSTextAlignmentLeft;;
    [expriText addSubview:pleLabel];

    
    
    
    nametext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10, zScreenWidth-28-110-28, 31)];
    nametext.layer.borderWidth = 0.5;
    nametext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    nametext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    nametext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    nametext.placeholder = @" 请输入姓名";
    nametext.returnKeyType = UIReturnKeyDone;
    nametext.delegate = self;
    [whiteview addSubview:nametext];
    
    NSArray *sexarr = @[@" 男",@" 女"];
    
    for (int i = 0; i<2; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*1, 100, 31)];
        [Btn setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn setTitle:sexarr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn.selected = NO;
        Btn.tag = 100+i;
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn];
    }
    
    NSArray *addressarr = @[@"县级别",@"乡镇级",@"村级"];
    
    for (int i = 0; i<3; i++) {
        Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(28+100+80*i, 10+(31+10)*6, 80, 31)];
        [Btn1 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn1 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn1 setTitle:addressarr[i] forState:UIControlStateNormal];
        [Btn1 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn1.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn1.selected = NO;
        Btn1.tag = 150+i;
        [Btn1 addTarget:self action:@selector(choose1:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn1];
    }
    
    NSArray *isarr = @[@" 是",@" 否"];
    
    for (int i = 0; i<2; i++) {
        Btn2 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*10, 100, 31)];
        [Btn2 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn2 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn2 setTitle:isarr[i] forState:UIControlStateNormal];
        [Btn2 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn2.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn2.selected = NO;
        Btn2.tag = 200+i;
        [Btn2 addTarget:self action:@selector(choose2:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn2];
    }
    
    
    
    idnumtext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*4, zScreenWidth-28-110-28, 31)];
    idnumtext.layer.borderWidth = 0.5;
    idnumtext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    idnumtext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    idnumtext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    idnumtext.placeholder = @" 请输入身份证号码";
    idnumtext.returnKeyType = UIReturnKeyDone;
    idnumtext.delegate = self;
    [whiteview addSubview:idnumtext];
    
    companytext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*8, zScreenWidth-28-110-28, 31)];
    companytext.layer.borderWidth = 0.5;
    companytext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    companytext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    companytext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    companytext.placeholder = @" 请输入行政单位";
    companytext.returnKeyType = UIReturnKeyDone;
    companytext.delegate = self;
    [whiteview addSubview:companytext];
    
    jobtext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*9, zScreenWidth-28-110-28, 31)];
    jobtext.layer.borderWidth = 0.5;
    jobtext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    jobtext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    jobtext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    jobtext.placeholder = @" 请输入具体职务";
    jobtext.returnKeyType = UIReturnKeyDone;
    jobtext.delegate = self;
    [whiteview addSubview:jobtext];
    
    birthtext = [[UIButton alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*2, zScreenWidth-28-110-28, 31)];
    birthtext.layer.borderWidth = 0.5;
    [birthtext setTitle:@"请选择出生日期" forState:UIControlStateNormal];
    [birthtext setTitleColor:[UIColor colorHexString:@"a6a6a6"] forState:UIControlStateNormal];
    birthtext.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    birthtext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    birthtext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    [birthtext addTarget:self action:@selector(selectbirth) forControlEvents:UIControlEventTouchUpInside];
    [whiteview addSubview:birthtext];
    
    studyext = [[UIButton alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*3, zScreenWidth-28-110-28, 31)];
    studyext.layer.borderWidth = 0.5;
    [studyext setTitle:@"请选择最高学历" forState:UIControlStateNormal];
    [studyext setTitleColor:[UIColor colorHexString:@"a6a6a6"] forState:UIControlStateNormal];
    studyext.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    studyext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    studyext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    [studyext addTarget:self action:@selector(selectstudy) forControlEvents:UIControlEventTouchUpInside];
    [whiteview addSubview:studyext];
    
    numbertext = [[UIButton alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*5, zScreenWidth-28-110-28, 31)];
    numbertext.layer.borderWidth = 0.5;
    [numbertext setTitle:@"请选择帮扶户数" forState:UIControlStateNormal];
    [numbertext setTitleColor:[UIColor colorHexString:@"a6a6a6"] forState:UIControlStateNormal];
    numbertext.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    numbertext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    numbertext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    [numbertext addTarget:self action:@selector(selectnumber) forControlEvents:UIControlEventTouchUpInside];
    [whiteview addSubview:numbertext];
    
    
    leveltext = [[UIButton alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*7, zScreenWidth-28-110-28, 31)];
    leveltext.layer.borderWidth = 0.5;
    [leveltext setTitle:@"请选择所属级" forState:UIControlStateNormal];
    [leveltext setTitleColor:[UIColor colorHexString:@"a6a6a6"] forState:UIControlStateNormal];
    leveltext.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    leveltext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    leveltext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    [leveltext addTarget:self action:@selector(selectlevel) forControlEvents:UIControlEventTouchUpInside];
    [whiteview addSubview:leveltext];
    
    
    moveview = [[UIView alloc]initWithFrame:CGRectMake(0, hiddenview.frame.origin.y+330, zScreenWidth, 300)];
    moveview.backgroundColor = [UIColor colorHexString:@"efefef"];
    [scrollView addSubview:moveview];
    
    UIView *backwhiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 10, zScreenWidth, 290)];
    backwhiteview.backgroundColor = [UIColor whiteColor];
    [moveview addSubview:backwhiteview];
    
    UILabel *tiplab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 31)];
    tiplab.textAlignment = NSTextAlignmentLeft;
    tiplab.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    tiplab.textColor = [UIColor colorHexString:@"c5c5c5"];
    tiplab.text = @"所在单位扶贫挂帮分管领导";
    [backwhiteview addSubview:tiplab];
    
    NSArray *array = @[@"领导姓名",@"联系电话",@"所属部门"];
    
    for (int i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+(31+10)+(31+10)*i, 110, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = array[i];
        
        
        [backwhiteview addSubview:label];
    }
    
    leadernametext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*1, zScreenWidth-28-110-28, 31)];
    leadernametext.layer.borderWidth = 0.5;
    leadernametext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    leadernametext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    leadernametext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    leadernametext.placeholder = @" 请填写你的领导姓名";
    leadernametext.returnKeyType = UIReturnKeyDone;
    leadernametext.delegate = self;
    [backwhiteview addSubview:leadernametext];
    
    mobilenumtext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*2, zScreenWidth-28-110-28, 31)];
    mobilenumtext.layer.borderWidth = 0.5;
    mobilenumtext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    mobilenumtext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    mobilenumtext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    mobilenumtext.placeholder = @" 请填写你的联系电话";
    mobilenumtext.returnKeyType = UIReturnKeyDone;
    mobilenumtext.delegate = self;
    [backwhiteview addSubview:mobilenumtext];
    
    aparttext = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*3, zScreenWidth-28-110-28, 31)];
    aparttext.layer.borderWidth = 0.5;
    aparttext.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    aparttext.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    aparttext.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    aparttext.placeholder = @" 请填写你的所属部门";
    aparttext.returnKeyType = UIReturnKeyDone;
    aparttext.delegate = self;
    [backwhiteview addSubview:aparttext];
    
//    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(28, 290-49, zScreenWidth-56, 49)];
//    doneBtn.layer.masksToBounds = YES;
//    doneBtn.layer.cornerRadius = 4;
//    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
//    [doneBtn addTarget:self action:@selector(confirme) forControlEvents:UIControlEventTouchUpInside];
//    [backwhiteview addSubview:doneBtn];
    
    
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
    imageview.image = [UIImage imageNamed:@"popup_examine"];
    [backview addSubview:imageview];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(backview.frame.size.width-20-10, 10, 20, 20)];
    [cancelBtn setImage:[UIImage imageNamed:@"popup_close-1"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelclick) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:cancelBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width/2-100, 66+20, 200, 35)];
    label.text = @"提交成功！";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [backview addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(backview.frame.size.width/2-100, 66+20+35+15, 200, 50)];
    label2.numberOfLines = 0;
    label2.text = @"等待管理员审核\n审核通过后即可登录系统";
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

- (void)choose2:(UIButton *)sender{
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:200 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 200) {
        hiddenview.hidden = NO;
        moveview.frame = CGRectMake(0, hiddenview.frame.origin.y+330, zScreenWidth, 300);
        [whiteview addSubview:moveview];
    }else{
        hiddenview.hidden = YES;
        moveview.frame = CGRectMake(0, hiddenview.frame.origin.y, zScreenWidth, 300);
        [whiteview addSubview:moveview];
    }
    
    
}

- (void)choose1:(UIButton *)sender{
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:150 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 150) {
        NSLog(@"县");
    }else if(sender.tag == 151){
        NSLog(@"乡镇");
    }else{
        NSLog(@"村");
    }
    
    
}


- (void)choose:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 100) {
        NSLog(@"男");
    }else{
        NSLog(@"女");
    }
    
    
}


- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    
    if (checked ==1) {
        if (![mutablearr containsObject:checkbox.titleLabel.text]) {
            [mutablearr addObject:checkbox.titleLabel.text];
        }
    }if (checked == 0) {
        if ([mutablearr containsObject:checkbox.titleLabel.text]) {
            [mutablearr removeObject:checkbox.titleLabel.text];
        }
    }
    NSLog(@"%@",mutablearr);
    
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
}

- (void)selectlevel{
    
}


- (void)selectbirth{
    
}

- (void)selectstudy{
    
}

- (void)selectnumber{
    
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
