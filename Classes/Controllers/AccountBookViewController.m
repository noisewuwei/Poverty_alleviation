//
//  AccountBookViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/28.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AccountBookViewController.h"
#import "AccBookTableViewCell.h"
#import "PGDatePickManager.h"
#import "ChargeViewController.h"

@interface AccountBookViewController ()<UITableViewDelegate,UITableViewDataSource,PGDatePickerDelegate>{
    UITableView *tableview;
    UIButton *startTime;
    UIButton *endTime;
    
    NSString *startstr;
    NSString *endstr;
    
    NSDictionary *totalDic;
    
    UILabel *totalmoneylabel;
    UILabel *incomemoneylabel;
    UILabel *paymoneylabel;
    UILabel *helpmoneylabel;
    UILabel *promoneylabel;
    
    UILabel *timeLabel;
    
    
}

@end

@implementation AccountBookViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo};
    
    NSLog(@"lalalala%@",dic);
    
    [HTTPRequest postWithURL:@"yrycapi/chargerecord/getcharges" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"chenggongle%@",json);
        
        totalDic = [NSDictionary dictionaryWithDictionary:json];
        
        if ([totalDic objectForKey:@"total"]) {
            totalmoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"total"]];
            incomemoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"income"]];
            paymoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"payout"]];
            helpmoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"helpmoney"]];
            promoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"projectIncome"]];
        }else{
            totalmoneylabel.text = @"0";
            incomemoneylabel.text = @"0";
            paymoneylabel.text = @"0";
            helpmoneylabel.text = @"0";
            promoneylabel.text = @"0";
        }
        
        
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贫困户账本";
    [self createBarLeftWithImage:@"nav_return"];
    
    startstr = @"";
    endstr = @"";
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+60+88, zScreenWidth, zScreenHeight-zNavigationHeight-88-49-40) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    startTime = [[UIButton alloc]initWithFrame:CGRectMake(20,zNavigationHeight+10, zScreenWidth/2-20-30, 40)];
    startTime.titleLabel.textAlignment = NSTextAlignmentRight;
    startTime.titleLabel.font = [UIFont systemFontOfSize:14];
    [startTime setTitle:@"选择起始日期" forState:UIControlStateNormal];
    [startTime setTitleColor:[UIColor colorHexString:@"121212"] forState:UIControlStateNormal];
    [startTime addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startTime];
    
    endTime = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+30, zNavigationHeight+10, zScreenWidth/2-20-30, 40)];
    endTime.titleLabel.textAlignment = NSTextAlignmentLeft;
    endTime.titleLabel.font = [UIFont systemFontOfSize:14];
    [endTime setTitle:@"选择结束日期" forState:UIControlStateNormal];
    [endTime setTitleColor:[UIColor colorHexString:@"121212"] forState:UIControlStateNormal];
    [endTime addTarget:self action:@selector(end:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endTime];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+59, zScreenWidth, 1)];
    lineview.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    [self.view addSubview:lineview];
    
    UIButton *Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    Btn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn setTitle:@"记账" forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:Btn];
    [Btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    
    [self setview];


    
    // Do any additional setup after loading the view.
}

- (void)setview{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+60, zScreenWidth, 88)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10, 0, zScreenWidth-20, 74)];
    backview.backgroundColor = [UIColor colorHexString:@"fdba44"];
    backview.layer.masksToBounds = YES;
    backview.layer.cornerRadius = 4;
    [view addSubview:backview];
    
    for (int i=1; i<5; i++) {
        UIView *white = [[UIView alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*i, 27.5, 1, 19)];
        white.backgroundColor = [UIColor whiteColor];
        [backview addSubview:white];
    }
    
    NSArray *arr = @[@"总计",@"收入",@"支出",@"帮扶金额",@"项目收益"];
    
    for (int i=0; i<5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*i, 15, (zScreenWidth-20)/5-1, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        label.text = arr[i];
        [backview addSubview:label];
    }
    
    totalmoneylabel = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*0, 15+20, (zScreenWidth-20)/5-1, 20)];
    totalmoneylabel.textAlignment = NSTextAlignmentCenter;
    totalmoneylabel.font = [UIFont systemFontOfSize:12];
    totalmoneylabel.textColor = [UIColor whiteColor];
    [backview addSubview:totalmoneylabel];
    
    incomemoneylabel = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*1, 15+20, (zScreenWidth-20)/5-1, 20)];
    incomemoneylabel.textAlignment = NSTextAlignmentCenter;
    incomemoneylabel.font = [UIFont systemFontOfSize:12];
    incomemoneylabel.textColor = [UIColor whiteColor];
    [backview addSubview:incomemoneylabel];
    
    paymoneylabel = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*2, 15+20, (zScreenWidth-20)/5-1, 20)];
    paymoneylabel.textAlignment = NSTextAlignmentCenter;
    paymoneylabel.font = [UIFont systemFontOfSize:12];
    paymoneylabel.textColor = [UIColor whiteColor];
    [backview addSubview:paymoneylabel];
    
    helpmoneylabel = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*3, 15+20, (zScreenWidth-20)/5-1, 20)];
    helpmoneylabel.textAlignment = NSTextAlignmentCenter;
    helpmoneylabel.font = [UIFont systemFontOfSize:12];
    helpmoneylabel.textColor = [UIColor whiteColor];
    [backview addSubview:helpmoneylabel];
    
    promoneylabel = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/5*4, 15+20, (zScreenWidth-20)/5-1, 20)];
    promoneylabel.textAlignment = NSTextAlignmentCenter;
    promoneylabel.font = [UIFont systemFontOfSize:12];
    promoneylabel.textColor = [UIColor whiteColor];
    [backview addSubview:promoneylabel];
    
}

- (void)jump{
    ChargeViewController *cvc = [[ChargeViewController alloc]init];
    cvc.familyNo = _familyNo;
    cvc.holderName = _holderName;
    [self.navigationController pushViewController:cvc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *bigarr = [totalDic objectForKey:@"chargeDateModels"];
    NSArray *arr = [bigarr[section] objectForKey:@"details"];
    
    return arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *arr = [totalDic objectForKey:@"chargeDateModels"];
    NSLog(@"%@",arr);
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    UILabel *timeLabel;
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 1, zScreenWidth, 40)];
    backview.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backview];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150, 20)];
    timeLabel.textColor = [UIColor colorHexString:@"888888"];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:14];
    
    [backview addSubview:timeLabel];
    
    NSArray *bigarr = [totalDic objectForKey:@"chargeDateModels"];
    NSString *date = [bigarr[section] objectForKey:@"date"];
    NSString *weekend = [bigarr[section] objectForKey:@"wekend"];
    
    timeLabel.text = [NSString stringWithFormat:@"%@ %@",date,weekend];
    
    
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    AccBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[AccBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    NSArray *bigarr = [totalDic objectForKey:@"chargeDateModels"];
    NSArray *arr = [bigarr[indexPath.section] objectForKey:@"details"];
    
    NSDictionary *detaildic = arr[indexPath.row];
    
    cell.titleLab.text = [detaildic objectForKey:@"type"];
    cell.contLab.text = [detaildic objectForKey:@"content"];
    cell.moneyLab.text = [NSString stringWithFormat:@"%@",[detaildic objectForKey:@"capital"]];
    
    return cell;
}

- (void)start:(UIButton *)sender{
    NSLog(@"start");
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.tag = 1;
    datePicker.delegate = self;
    datePicker.datePickerType = PGPickerViewType1;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
}

- (void)end:(UIButton *)sender{
    NSLog(@"end");
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.tag = 2;
    datePicker.delegate = self;
    datePicker.datePickerType = PGPickerViewType1;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
    
   
    
}


- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    if (datePicker.tag == 1) {
        [startTime setTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",dateComponents.year,dateComponents.month,dateComponents.day] forState:UIControlStateNormal];
        NSLog(@"start  %ld,%ld,%ld", dateComponents.year,dateComponents.month,dateComponents.day);
        startstr = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
        
        
        NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"startDate":startstr,@"endDate":endstr};
        
        NSLog(@"lalalala%@",dic);
        
        [HTTPRequest postWithURL:@"yrycapi/chargerecord/getcharges" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"chenggongle%@",json);
            
            totalDic = [NSDictionary dictionaryWithDictionary:json];
            
            if ([totalDic objectForKey:@"total"]) {
                totalmoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"total"]];
                incomemoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"income"]];
                paymoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"payout"]];
                helpmoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"helpmoney"]];
                promoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"projectIncome"]];
            }else{
                totalmoneylabel.text = @"0";
                incomemoneylabel.text = @"0";
                paymoneylabel.text = @"0";
                helpmoneylabel.text = @"0";
                promoneylabel.text = @"0";
            }
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else{
        [endTime setTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",dateComponents.year,dateComponents.month,dateComponents.day] forState:UIControlStateNormal];
        endstr = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
        NSLog(@"end  %ld,%ld,%ld", dateComponents.year,dateComponents.month,dateComponents.day);
        
        
        NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"startDate":startstr,@"endDate":endstr};
        
        NSLog(@"lalalala%@",dic);
        
        [HTTPRequest postWithURL:@"yrycapi/chargerecord/getcharges" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"chenggongle%@",json);
            
            totalDic = [NSDictionary dictionaryWithDictionary:json];
            
            if ([totalDic objectForKey:@"total"]) {
                totalmoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"total"]];
                incomemoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"income"]];
                paymoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"payout"]];
                helpmoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"helpmoney"]];
                promoneylabel.text = [NSString stringWithFormat:@"%@",[totalDic objectForKey:@"projectIncome"]];
            }else{
                totalmoneylabel.text = @"0";
                incomemoneylabel.text = @"0";
                paymoneylabel.text = @"0";
                helpmoneylabel.text = @"0";
                promoneylabel.text = @"0";
            }
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
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
