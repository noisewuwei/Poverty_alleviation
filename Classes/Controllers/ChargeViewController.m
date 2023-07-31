//
//  ChargeViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/27.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ChargeViewController.h"
#import "PGDatePickManager.h"
#import "CustomMyPickerView.h"

@interface ChargeViewController ()<UITextFieldDelegate,UITextViewDelegate,PGDatePickerDelegate>{
    UIButton *Btn;
    UITextView *tipText;
    UITextField *moneyText;
    UIButton *timeBtn;
    
    NSString *typestr;
    NSString *timestr;
    NSString *weekend;
    
    NSMutableArray *btnMutableArray;
    
    UIButton *addBtn;
    
    UIView *back1;
    UIView *back2;
    UIView *backView;
    UIButton *selectbtn;
    
    UILabel *pronamelab;
    
    UIPickerView *pickerView;
    
    NSMutableArray *dataarr;;
    
    NSString *proname;
}

@end

@implementation ChargeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ((UIButton *)[btnMutableArray objectAtIndex:0]).selected=YES;
    
    typestr = @"帮扶金额";
    
    [HTTPRequest postWithURL:@"yrycapi/chargerecord/getprojects" method:@"POST" params:@{@"familyNo":_familyNo} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        dataarr = [NSMutableArray array];
        
        for (NSDictionary *dic in json) {
            [dataarr addObject:[dic objectForKey:@"projectName"]];
        }
        
        NSLog(@"%@",dataarr);
        
    } error400Code:^(id failure) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记账";
    [self createBarLeftWithImage:@"nav_return"];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 380)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    NSArray *arr = @[@"帮扶金额",@"收入",@"支出"];
    
    btnMutableArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<3; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(20+(20+(zScreenWidth-80)/3)*i, 10, (zScreenWidth-80)/3, 32)];
        Btn.layer.masksToBounds = YES;
        Btn.layer.cornerRadius = 32/2;
        [Btn setTitle:arr[i] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [Btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [Btn setBackgroundImage:[self imageWithColor:[UIColor colorHexString:@"1a2f55"]] forState:UIControlStateSelected];
        Btn.layer.borderWidth = 1;
        Btn.layer.borderColor= [[UIColor colorHexString:@"e1e1e1"]CGColor];
        
        Btn.selected = NO;
        Btn.tag = 100+i;
        
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnMutableArray addObject:Btn];
        
        [backView addSubview:Btn];
    }
    
    addBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10+32+10, (zScreenWidth-80)/3, 32)];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.cornerRadius = 32/2;
    [addBtn setTitle:@"项目收益" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [addBtn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [addBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[self imageWithColor:[UIColor colorHexString:@"1a2f55"]] forState:UIControlStateSelected];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor= [[UIColor colorHexString:@"e1e1e1"]CGColor];
    
    addBtn.selected = NO;
    addBtn.tag = 100+3;
    
    [addBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnMutableArray addObject:addBtn];
    
    [backView addSubview:addBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 0, zScreenWidth-40, 1)];
    line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 15)];
    namelab.textAlignment = NSTextAlignmentLeft;
    namelab.textColor = [UIColor colorHexString:@"888888"];
    namelab.text = @"项目名称";
    namelab.font = [UIFont systemFontOfSize:14];
    
    pronamelab = [[UILabel alloc]initWithFrame:CGRectMake(20+60, 10, 200, 15)];
    pronamelab.textAlignment = NSTextAlignmentCenter;
    pronamelab.textColor = [UIColor colorHexString:@"121212"];
    pronamelab.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    
    selectbtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-20-80-20, namelab.frame.origin.y-2.5, 100, 20)];
    [selectbtn setTitle:@"选择项目" forState:UIControlStateNormal];
    [selectbtn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateNormal];
    selectbtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    selectbtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    [selectbtn addTarget:self action:@selector(selectpro) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100-15,2.5 , 15, 15)];
    image.contentMode = UIViewContentModeCenter;
    image.image = [UIImage imageNamed:@"attendance_arrow"];
    [selectbtn addSubview:image];
    
    
    back2 = [[UIView alloc]initWithFrame:CGRectMake(0, addBtn.frame.origin.y+32+10, zScreenWidth, 9+15+11)];
    [back2 addSubview:line];
    [back2 addSubview:namelab];
    [back2 addSubview:selectbtn];
    [back2 addSubview:pronamelab];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(20, 0, zScreenWidth-40, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    
    UILabel *date = [[UILabel alloc]initWithFrame:CGRectMake(20, line1.frame.origin.y+10, 30, 15)];
    date.textAlignment = NSTextAlignmentLeft;
    date.textColor = [UIColor colorHexString:@"888888"];
    date.text = @"日期";
    date.font = [UIFont systemFontOfSize:14];
    
    timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(date.frame.origin.x+30+10,date.frame.origin.y-2.5, zScreenWidth-(date.frame.origin.x+30+10+20), 20)];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    timeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [timeBtn setTitle:@"点击选择日期" forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor colorHexString:@"121212"] forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(time) forControlEvents:UIControlEventTouchUpInside];

    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20, date.frame.origin.y+15+10, zScreenWidth-40, 1)];
    line2.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(20, line2.frame.origin.y+10, 30, 15)];
    tip.textAlignment = NSTextAlignmentLeft;
    tip.textColor = [UIColor colorHexString:@"888888"];
    tip.text = @"备注";
    tip.font = [UIFont systemFontOfSize:14];

    
    tipText = [[UITextView alloc]initWithFrame:CGRectMake(tip.frame.origin.x+30+10, tip.frame.origin.y, zScreenWidth-70-10, 150)];
    tipText.layer.masksToBounds = YES;
    tipText.layer.cornerRadius = 4;
    tipText.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"]CGColor];
    tipText.layer.borderWidth = 1;
    tipText.delegate = self;
    tipText.returnKeyType = UIReturnKeyDone;
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(20, tipText.frame.origin.y+150+10, zScreenWidth-40, 1)];
    line3.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(20, line3.frame.origin.y+15, 30, 15)];
    money.textAlignment = NSTextAlignmentLeft;
    money.textColor = [UIColor colorHexString:@"888888"];
    money.text = @"金额";
    money.font = [UIFont systemFontOfSize:14];
    
    moneyText = [[UITextField alloc]initWithFrame:CGRectMake(money.frame.origin.x+30+10, money.frame.origin.y-7, 100, 30)];
    moneyText.layer.masksToBounds = YES;
    moneyText.layer.borderWidth = 1;
    moneyText.layer.cornerRadius = 2;
    moneyText.layer.borderColor= [[UIColor colorHexString:@"e1e1e1"]CGColor];
    
    moneyText.delegate = self;
    moneyText.returnKeyType = UIReturnKeyDone;
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(moneyText.frame.origin.x+100+5, money.frame.origin.y, 15, 15)];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.textColor = [UIColor colorHexString:@"888888"];
    moneyLabel.text = @"元";
    moneyLabel.font = [UIFont systemFontOfSize:14];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [doneBtn addTarget:self action:@selector(confirme) forControlEvents:UIControlEventTouchUpInside];
    
     
    back1 = [[UIView alloc]initWithFrame:CGRectMake(0, addBtn.frame.origin.y+32+10, zScreenWidth, 310)];

    [back1 addSubview:line1];
    [back1 addSubview:date];
    [back1 addSubview:timeBtn];
    [back1 addSubview:line2];
    [back1 addSubview:tip];
    [back1 addSubview:tipText];
    [back1 addSubview:line3];
    [back1 addSubview:money];
    [back1 addSubview:moneyText];
    [back1 addSubview:moneyLabel];
    
    [backView addSubview:back1];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    scrollView.contentSize = CGSizeMake(zScreenWidth, zScreenHeight+100);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview: scrollView];
    
    [scrollView addSubview:backView];
    [self.view addSubview:doneBtn];
    
    proname = @"";
    
    
    // Do any additional setup after loading the view.
}

- (void)selectpro{
    NSLog(@"select");
    
    CustomMyPickerView *customVC =[[CustomMyPickerView alloc] initWithComponentDataArray:dataarr titleDataArray:nil];
    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        NSLog(@"%@",compoentString);
        pronamelab.text = compoentString;
        proname = compoentString;
    };
    
    [self.view addSubview:customVC];
    
}

- (void)time{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGPickerViewType1;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    [timeBtn setTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",dateComponents.year,dateComponents.month,dateComponents.day] forState:UIControlStateNormal];
    NSLog(@"date  %ld,%ld,%ld", dateComponents.year,dateComponents.month,dateComponents.day);
    
    timestr = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-mm-dd"];
    
    NSDate *dateTime = [formatter dateFromString:timestr];
    
    weekend = [self weekdayStringFromDate:dateTime];
    
    NSLog(@"weekend%@",weekend);
    
    
}

- (void)choose:(UIButton *)sender{
    
    for (int i = 0; i < 4; i++) {
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
        NSLog(@"帮扶金额");
        typestr = @"帮扶金额";
        [back2 removeFromSuperview];
        back1.frame = CGRectMake(0, addBtn.frame.origin.y+32+10, zScreenWidth, 440);
        [backView addSubview:back1];
        pronamelab.text = @"";
        proname = @"";
    }else if(sender.tag == 101){
        NSLog(@"收入");
        typestr = @"收入";
        [back2 removeFromSuperview];
        back1.frame = CGRectMake(0, addBtn.frame.origin.y+32+10, zScreenWidth, 440);
        [backView addSubview:back1];
        pronamelab.text = @"";
        proname = @"";
    }else if(sender.tag == 102){
        NSLog(@"支出");
        typestr = @"支出";
        [back2 removeFromSuperview];
        back1.frame = CGRectMake(0, addBtn.frame.origin.y+32+10, zScreenWidth, 440);
        [backView addSubview:back1];
        pronamelab.text = @"";
        proname = @"";
    }else{
        NSLog(@"project");
        typestr = @"项目收益";
        [backView addSubview:back2];
        back1.frame = CGRectMake(0, addBtn.frame.origin.y+32+10+35, zScreenWidth, 440);
        [backView addSubview:back1];
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

- (void)confirme{
    NSLog(@"queding");
    
    if ([typestr isEqualToString:@"项目收益"]) {
        if (typestr.length>0 && timestr.length>0 && tipText.text.length>0 && moneyText.text.length>0 && weekend.length>0 && proname.length>0) {
            
            
            NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"type":typestr,@"chargeDate":timestr,@"content":tipText.text,@"capital":moneyText.text,@"wekend":weekend,@"projectName":proname};
            
            NSLog(@"%@",dic);
            
            [HTTPRequest postWithURL:@"yrycapi/chargerecord/charge" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"222222%@",json);
                [self.navigationController popViewControllerAnimated:NO];
            } error400Code:^(id failure) {
                NSLog(@"11111%@",failure);
            }];
            
        }else{
            [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
        }
    }else{
        if (typestr.length>0 && timestr.length>0 && tipText.text.length>0 && moneyText.text.length>0 && weekend.length>0) {
            
            
            NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"type":typestr,@"chargeDate":timestr,@"content":tipText.text,@"capital":moneyText.text,@"wekend":weekend,@"projectName":proname};
            
            NSLog(@"%@",dic);
            
            [HTTPRequest postWithURL:@"yrycapi/chargerecord/charge" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"222222%@",json);
                [self.navigationController popViewControllerAnimated:NO];
            } error400Code:^(id failure) {
                NSLog(@"11111%@",failure);
            }];
            
        }else{
            [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
        }
    }
    
    
    
}

-(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/BeiJing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
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
