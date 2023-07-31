//
//  MethodViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/14.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MethodViewController.h"
#import "DeatailAndMethodTableViewCell.h"
#import "JXButton.h"
#import "MethodBigTableViewCell.h"

@interface MethodViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    UIImageView *headimg;
    UILabel *organization;
    UILabel *typelab;
    UILabel *titlab;
    
    UILabel *peolab;
    UILabel *pholab;
    
    UIButton *Btn;
    
    NSMutableArray *btnMutableArray;
    
    NSDictionary *memberdetaildic;
    NSDictionary *trainingCourcedic;
    NSDictionary *helpMapdic;
    NSDictionary *MedicalHelpdic;
    NSDictionary *EducationHelpdic;
    NSDictionary *skillTrainingdic;
    NSArray *dataArray;
    NSArray *arr;
    
    UILabel *first1;
    UILabel *first2;
    UILabel *first3;
    UILabel *first4;
    UILabel *first5;
    UILabel *first6;
    UILabel *first7;
    UILabel *first8;
    UILabel *first9;
    
    NSString *modestr;
    
    NSString *ifEducationHelp;
    NSString *ifIndustyHelp;
    NSString *ifJobHelp;
    NSString *ifMedicalHelp;
    
    CGFloat y;
    
    UIImageView *view;
}

@end

@implementation MethodViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"yrycapi/familyinfo/getpolicy" method:@"POST" params:@{@"cardNo":_cardno} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"method:%@",json);
        
//        dataArray = @[@"教育帮扶"];
        
        dataArray = [json objectForKey:@"dataArray"];
        memberdetaildic = [json objectForKey:@"memberDetail"];
        trainingCourcedic = [json objectForKey:@"trainingCource"];
        helpMapdic = [json objectForKey:@"helpMap"];
        skillTrainingdic = [json objectForKey:@"skillTraining"];
        if ([helpMapdic objectForKey:@"EducationHelp"]) {
            EducationHelpdic = [helpMapdic objectForKey:@"EducationHelp"];
        }
        
        if ([helpMapdic objectForKey:@"MedicalHelp"]) {
            MedicalHelpdic = [helpMapdic objectForKey:@"MedicalHelp"];
        }
        
        if ([helpMapdic objectForKey:@"IndustyHelp"]) {
            arr = [helpMapdic objectForKey:@"IndustyHelp"];
        }
        
        ifEducationHelp = [NSString stringWithFormat:@"%@",[json objectForKey:@"ifEducationHelp"]];
        ifIndustyHelp = [NSString stringWithFormat:@"%@",[json objectForKey:@"ifIndustyHelp"]];
        ifJobHelp = [NSString stringWithFormat:@"%@",[json objectForKey:@"ifJobHelp"]];
        ifMedicalHelp = [NSString stringWithFormat:@"%@",[json objectForKey:@"ifMedicalHelp"]];
        
        NSLog(@"%@,%@,%@,%@",ifEducationHelp,ifIndustyHelp,ifJobHelp,ifMedicalHelp);
        
//        if (trainingCourcedic.count==0 && skillTrainingdic.count==0) {
//            [tableview addSubview:view];
//            tableview.scrollEnabled = NO;
//        }
        
        if (trainingCourcedic.count!=0 || skillTrainingdic.count!=0) {
            modestr = @"1";
        }else if (EducationHelpdic.count!=0) {
            
            modestr = @"2";
        }else if (MedicalHelpdic.count!=0) {
            
            modestr = @"3";
        }else if (arr.count!=0) {
            
             modestr = @"4";
        }else{
            [tableview addSubview:view];
        }
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一人一策";
    [self createBarLeftWithImage:@"nav_return"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    
    y = 70;
    
    [self.view addSubview:tableview];
//
//    modestr = @"1";
    
    view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, tableview.frame.size.height)];
    view.contentMode = UIViewContentModeCenter;
    view.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    view.image = [UIImage imageNamed:@"none"];
    // Do any additional setup after loading the view.
}
//表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 39, zScreenWidth, 250-39)];
    backview.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backview];
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 39)];
    back.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    [headerView addSubview:back];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(17, 9.5, 200, 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorHexString:@"888888"];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"一对一帮扶指导";
    [headerView addSubview:label];
    
    
    btnMutableArray = [[NSMutableArray alloc]init];
    
    if (dataArray.count == 1) {
        Btn = [[JXButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-((zScreenWidth/4)/2), 0, zScreenWidth/4, 72)];
        [Btn setTitle:dataArray[0] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateSelected];
        [Btn setImage:[UIImage imageNamed:dataArray[0]] forState:UIControlStateNormal];
//        [Btn setImage:arr1[i] forState:UIControlStateSelected];
//        Btn.tag = 101;
//        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [btnMutableArray addObject:Btn];
        [backview addSubview:Btn];
    }else if (dataArray.count == 2){
        for (int i = 0; i<2; i++) {
            Btn = [[JXButton alloc]initWithFrame:CGRectMake(zScreenWidth/2/2-zScreenWidth/4/2+(zScreenWidth/2)*i, 0, zScreenWidth/4, 72)];
            [Btn setTitle:dataArray[i] forState:UIControlStateNormal];
            Btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [Btn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateSelected];
            [Btn setImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateNormal];
            Btn.selected = NO;
            Btn.tag = 100+i;
            [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [btnMutableArray addObject:Btn];
            [backview addSubview:Btn];
        }
    }else if (dataArray.count == 3){
        for (int i = 0; i<3; i++) {
            Btn = [[JXButton alloc]initWithFrame:CGRectMake(zScreenWidth/3/2-zScreenWidth/4/2+(zScreenWidth/3)*i, 0, zScreenWidth/4, 72)];
            [Btn setTitle:dataArray[i] forState:UIControlStateNormal];
            Btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [Btn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateSelected];
            [Btn setImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateNormal];
            Btn.selected = NO;
            Btn.tag = 100+i;
            [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [btnMutableArray addObject:Btn];
            [backview addSubview:Btn];
        }
    }else if (dataArray.count == 4){
        for (int i = 0; i<4; i++) {
            Btn = [[JXButton alloc]initWithFrame:CGRectMake(20+(20+(zScreenWidth-100)/4)*i, 0, (zScreenWidth-100)/4, 72)];
            [Btn setTitle:dataArray[i] forState:UIControlStateNormal];
            Btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [Btn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateSelected];
            [Btn setImage:[UIImage imageNamed:dataArray[i]] forState:UIControlStateNormal];
            Btn.selected = NO;
            Btn.tag = 100+i;
            [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [btnMutableArray addObject:Btn];
            [backview addSubview:Btn];
        }
    }
    
//    if (btnMutableArray.count > 0) {
//        ((UIButton *)[btnMutableArray objectAtIndex:0]).selected=YES;
//    }
    
    headimg = [[UIImageView alloc] initWithFrame:CGRectMake(17, 73, zScreenWidth-34, 70)];
    headimg.layer.masksToBounds = YES;
    headimg.layer.cornerRadius = 4;
    headimg.image = [UIImage imageNamed:@"assist_banner1"];
    [backview addSubview:headimg];
    
    organization = [[UILabel alloc] initWithFrame:CGRectMake(headimg.frame.size.width-54, 23, 66, 24)];
    organization.backgroundColor = [UIColor colorHexString:@"ef7024"];
    organization.layer.masksToBounds = YES;
    organization.layer.cornerRadius = 12;
    organization.textColor = [UIColor whiteColor];
    organization.textAlignment = NSTextAlignmentCenter;
    organization.font = [UIFont systemFontOfSize:12];
    [headimg addSubview:organization];
    
    typelab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, 73+70+10, 150, 20)];
    typelab.textColor = [UIColor colorHexString:@"fdba44"];
    typelab.textAlignment = NSTextAlignmentCenter;
    typelab.font = [UIFont systemFontOfSize:15];
    [backview addSubview:typelab];
    
    titlab = [[UILabel alloc]initWithFrame:CGRectMake(0, typelab.frame.origin.y+20+10, zScreenWidth, 20)];
    titlab.textColor = [UIColor blackColor];
    titlab.textAlignment = NSTextAlignmentCenter;
    titlab.font = [UIFont systemFontOfSize:13];
    [backview addSubview:titlab];
    
    if ([modestr isEqualToString:@"1"]) {
        headimg.image = [UIImage imageNamed:@"assist_banner1"];
        typelab.text = @"就业指导";
        titlab.hidden = NO;
        
        if (skillTrainingdic.count>0) {
            organization.text = [skillTrainingdic objectForKey:@"organization"];
            titlab.text = [NSString stringWithFormat:@"%@-%@ (%@天)",[skillTrainingdic objectForKey:@"trainingType"],[skillTrainingdic objectForKey:@"trainingDays"],[skillTrainingdic objectForKey:@"trainingPeriod"]];
        }else if(trainingCourcedic.count>0){
            organization.text = [trainingCourcedic objectForKey:@"organization"];
            titlab.text = [NSString stringWithFormat:@"%@ (%@天)",[trainingCourcedic objectForKey:@"type"],[trainingCourcedic objectForKey:@"period"]];
        }
        
    }else if([modestr isEqualToString:@"2"]){
        headimg.image = [UIImage imageNamed:@"assist_banner2"];
        typelab.text = @"教育";
        titlab.hidden = YES;
        
        if (EducationHelpdic.count>0) {
            organization.text = [EducationHelpdic objectForKey:@"organization"];
        }
        
    }else if([modestr isEqualToString:@"3"]){
        headimg.image = [UIImage imageNamed:@"assist_banner3"];
        typelab.text = @"医疗";
        titlab.hidden = YES;
        
        if (MedicalHelpdic.count>0) {
            organization.text = [MedicalHelpdic objectForKey:@"organization"];
        }
        
    }else if([modestr isEqualToString:@"4"]){
        headimg.image = [UIImage imageNamed:@"assist_banner4"];
        typelab.text = @"产业帮扶";
        titlab.hidden = YES;
        organization.hidden = YES;
        
    }
//
    
    return headerView;
}
//按钮
- (void)choose:(UIButton *)sender{

//    for (int i = 0; i < 4; i++) {
//        JXButton *btn = (JXButton *)[[sender superview]viewWithTag:100 + i];
//        [btn setSelected:NO];
//    }
//    JXButton *button = (JXButton *)sender;
    [sender setSelected:YES];
    
    if ([sender.titleLabel.text isEqualToString:@"就业指导"]) {

        modestr = @"1";
        [tableview reloadData];
        
        
    }else if([sender.titleLabel.text isEqualToString:@"教育帮扶"]){

        modestr = @"2";
        [tableview reloadData];
        
        
    }else if([sender.titleLabel.text isEqualToString:@"医疗帮扶"]){

        modestr = @"3";
        [tableview reloadData];
        
    }else if([sender.titleLabel.text isEqualToString:@"产业帮扶"]){

        modestr = @"4";
        [tableview reloadData];
        
    }
}

//表尾
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *footerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerSectionID];
    
//    if (footerView == nil) {
//        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerSectionID];
//
//    }
    
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 70+39+230)];
    white.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:white];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(17, 0, zScreenWidth-34, 1)];
    line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    [footerView addSubview:line];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(17, 10, 15, 15)];
    img.contentMode = UIViewContentModeCenter;
    img.image = [UIImage imageNamed:@"assist_icon5"];
    [footerView addSubview:img];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(17, 10+15+10, 15, 15)];
    img1.contentMode = UIViewContentModeCenter;
    img1.image = [UIImage imageNamed:@"assist_icon6"];
    [footerView addSubview:img1];
    
    peolab = [[UILabel alloc]initWithFrame:CGRectMake(50, img.frame.origin.y, zScreenWidth-50-17, 15)];
    peolab.textAlignment = NSTextAlignmentRight;
    peolab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    [footerView addSubview:peolab];
    
    pholab = [[UILabel alloc]initWithFrame:CGRectMake(50, img1.frame.origin.y, zScreenWidth-50-17, 15)];
    pholab.textAlignment = NSTextAlignmentRight;
    pholab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    [footerView addSubview:pholab];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, img1.frame.origin.y-2.5, zScreenWidth-50-17, 20)];
    [btn addTarget:self action:@selector(call4) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    
    if (skillTrainingdic.count>0) {
        peolab.text = [skillTrainingdic objectForKey:@"poliyContact"];
        pholab.text = [skillTrainingdic objectForKey:@"policyTelephone"];
    }else if(trainingCourcedic.count>0){
        
        peolab.text = [trainingCourcedic objectForKey:@"poliyContact"];
        pholab.text = [trainingCourcedic objectForKey:@"policyTelephone"];

    }
    
    if ([modestr isEqualToString:@"1"]) {
        img.hidden = NO;
        img1.hidden = NO;
        peolab.hidden = NO;
        pholab.hidden = NO;
        y = 70;
    }else{
        img.hidden = YES;
        img1.hidden = YES;
        peolab.hidden = YES;
        pholab.hidden = YES;
        y = 0;
    }
    
    
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, y, zScreenWidth, 39)];
    backview.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    [footerView addSubview:backview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(17, 9.5, 200, 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorHexString:@"888888"];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"帮扶对象基本情况介绍";
    [backview addSubview:label];
    
    NSArray *arr1 = @[@"帮扶对象",@"地址",@"证件号码",@"民族",@"文化程度",@"健康状况",@"劳动力",@"家庭成员",@"在校生状况"];
    
    for (int i = 0; i<9; i++) {
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(17, y+39+30*i, 100, 30)];
        namelab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
        
        namelab.textAlignment = NSTextAlignmentLeft;
        
        namelab.textColor = [UIColor colorHexString:@"888888"];
        
        namelab.text = arr1[i];
        
        [footerView addSubview:namelab];
    }
    
    first1 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*0, zScreenWidth-17-100-17, 20)];
    first1.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first1.textAlignment = NSTextAlignmentRight;
    first1.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first1];
    
    first2 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*1, zScreenWidth-17-100-17, 20)];
    first2.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first2.textAlignment = NSTextAlignmentRight;
    first2.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first2];
    
    first3 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*2, zScreenWidth-17-100-17, 20)];
    first3.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first3.textAlignment = NSTextAlignmentRight;
    first3.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first3];
    
    first4 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*3, zScreenWidth-17-100-17, 20)];
    first4.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first4.textAlignment = NSTextAlignmentRight;
    first4.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first4];
    
    first5 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*4, zScreenWidth-17-100-17, 20)];
    first5.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first5.textAlignment = NSTextAlignmentRight;
    first5.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first5];
    
    first6 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*5, zScreenWidth-17-100-17, 20)];
    first6.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first6.textAlignment = NSTextAlignmentRight;
    first6.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first6];
    
    first7 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*6, zScreenWidth-17-100-17, 20)];
    first7.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first7.textAlignment = NSTextAlignmentRight;
    first7.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first7];
    
    first8 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*7, zScreenWidth-17-100-17, 20)];
    first8.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first8.textAlignment = NSTextAlignmentRight;
    first8.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first8];
    
    first9 = [[UILabel alloc]initWithFrame:CGRectMake(17+100, y+39+30*8, zScreenWidth-17-100-17, 20)];
    first9.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    first9.textAlignment = NSTextAlignmentRight;
    first9.textColor = [UIColor colorHexString:@"121212"];
    [footerView addSubview:first9];
    
    first1.text = [memberdetaildic objectForKey:@"name"];
    first2.text = [memberdetaildic objectForKey:@"address"];
    first3.text = [memberdetaildic objectForKey:@"cardNo"];
    first4.text = [memberdetaildic objectForKey:@"nation"];
    first5.text = [memberdetaildic objectForKey:@"education"];
    first6.text = [memberdetaildic objectForKey:@"healthyStatus"];
    first7.text = [memberdetaildic objectForKey:@"labourSkill"];
    first8.text = [NSString stringWithFormat:@"%@",[memberdetaildic objectForKey:@"memberAmount"]];
    first9.text = [memberdetaildic objectForKey:@"studentStatus"];
    
    return footerView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 250;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70+39+230+50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([modestr isEqualToString:@"1"]) {
        return 30;
    }else{
       return 240;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [helpMapdic objectForKey:@"IndustyHelp"];
    if ([modestr isEqualToString:@"1"]) {
        return 6;
    }else if([modestr isEqualToString:@"2"]){
        return 1;
    }else if([modestr isEqualToString:@"3"]){
        return 1;
    }
    return arr.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([modestr isEqualToString:@"1"]) {
        static NSString *ID = @"cell1";
        DeatailAndMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[DeatailAndMethodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        NSArray *arr2 = @[@"证书类型",@"培训机构",@"培训组织部门",@"培训后就业创业",@"就业创业单位名称",@"月均收入"];
        NSArray *arr3 = @[@"培训工种",@"培训等级",@"培训方式",@"培训联系人",@"培训电话",@"培训地点"];
        
        if (skillTrainingdic.count>0) {
            
            cell.firstLabel.text = arr2[indexPath.row];
            if (indexPath.row ==0) {
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"certificate"];
            }else if (indexPath.row == 1){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"trainingAgency"];
            }else if (indexPath.row == 2){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"trainingDep"];
            }else if (indexPath.row == 3){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"isGetJob"];
            }else if (indexPath.row == 4){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"companyName"];
            }else if (indexPath.row == 5){
                cell.secondLabel.text = [NSString stringWithFormat:@"%@",[trainingCourcedic objectForKey:@"monthlyProfit"]];
            }
            
        }else if(trainingCourcedic.count>0){
            
            cell.firstLabel.text = arr3[indexPath.row];

            if (indexPath.row ==0) {
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"work"];
            }else if (indexPath.row == 1){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"level"];
            }else if (indexPath.row == 2){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"mode"];
            }else if (indexPath.row == 3){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"contact"];
            }else if (indexPath.row == 4){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"telephone"];
            }else if (indexPath.row == 5){
                cell.secondLabel.text = [trainingCourcedic objectForKey:@"address"];
            }
            
        }
        
        
        
        
        return cell;
    }else if([modestr isEqualToString:@"2"]){
        static NSString *ID2 = @"cell2";
        MethodBigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[MethodBigTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        
        if (EducationHelpdic.count>0) {
            cell.titleLab.text = [EducationHelpdic objectForKey:@"title"];
            cell.contentLab.text = [EducationHelpdic objectForKey:@"content"];            
            cell.peolab.text = [EducationHelpdic objectForKey:@"contact"];
            cell.pholab.text = [EducationHelpdic objectForKey:@"telephone"];
            cell.callbtn.tag = indexPath.row;
            [cell.callbtn addTarget:self action:@selector(call1:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        
        
        return cell;
    }else if([modestr isEqualToString:@"3"]){
        static NSString *ID3 = @"cell3";
        MethodBigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID3];
        if (!cell) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[MethodBigTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID3];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        
        if (memberdetaildic.count>0) {
            cell.titleLab.text = [MedicalHelpdic objectForKey:@"title"];
            cell.contentLab.text = [MedicalHelpdic objectForKey:@"content"];
            cell.peolab.text = [MedicalHelpdic objectForKey:@"contact"];
            cell.pholab.text = [MedicalHelpdic objectForKey:@"telephone"];
            cell.callbtn.tag = indexPath.row;
            [cell.callbtn addTarget:self action:@selector(call2:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        
        
        return cell;
    }else if([modestr isEqualToString:@"4"]){
        static NSString *ID4 = @"cell4";
        MethodBigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID4];
        if (!cell) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[MethodBigTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID4];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        
        arr = [helpMapdic objectForKey:@"IndustyHelp"];
        

        cell.titleLab.text = [arr[indexPath.row] objectForKey:@"title"];
        cell.contentLab.text = [arr[indexPath.row] objectForKey:@"content"];
        cell.peolab.text = [arr[indexPath.row] objectForKey:@"contact"];
        cell.pholab.text = [arr[indexPath.row] objectForKey:@"telephone"];
        cell.callbtn.tag = indexPath.row;
        [cell.callbtn addTarget:self action:@selector(call3:) forControlEvents:UIControlEventTouchUpInside];
        
//        if (indexPath.row ==0) {
//            cell.titleLab.text = [arr[0] objectForKey:@"title"];
//            cell.contentLab.text = [arr[0] objectForKey:@"content"];
//        }else if (indexPath.row == 1){
//            cell.titleLab.text = [arr[1] objectForKey:@"title"];
//            cell.contentLab.text = [arr[1] objectForKey:@"content"];
//        }else if (indexPath.row == 2){
//            cell.titleLab.text = [arr[2] objectForKey:@"title"];
//            cell.contentLab.text = [arr[2] objectForKey:@"content"];
//        }
        
        return cell;
    }
    
    
    return nil;
}

- (void)call4{
    
    NSString *str = [NSString alloc];
    
    if (skillTrainingdic.count>0) {
        str = [NSString stringWithFormat:@"telprompt://%@", [skillTrainingdic objectForKey:@"policyTelephone"]];
    }else if(trainingCourcedic.count>0){
        str = [NSString stringWithFormat:@"telprompt://%@", [trainingCourcedic objectForKey:@"policyTelephone"]];
    }
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}

- (void)call1:(UIButton *)sender{
    NSLog(@"da call");
    NSLog(@"%@",[EducationHelpdic objectForKey:@"telephone"]);
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", [EducationHelpdic objectForKey:@"telephone"]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}
- (void)call2:(UIButton *)sender{
    NSLog(@"da call");
    NSLog(@"%@",[MedicalHelpdic objectForKey:@"telephone"]);
    
    NSString *string = [MedicalHelpdic objectForKey:@"telephone"];
    
    NSArray *array = [string componentsSeparatedByString:@","];
    
    NSLog(@"%@",array);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"选择拨打号码" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:array[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", array[0]];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }];
    UIAlertAction *save = [UIAlertAction actionWithTitle:array[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", array[1]];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:delete];
    [alert addAction:save];
    [self presentViewController:alert animated:YES completion:^{
        nil;
    }];
    
    
}
- (void)call3:(UIButton *)sender{
    arr = [helpMapdic objectForKey:@"IndustyHelp"];
    NSLog(@"da call");
    NSLog(@"%@",[arr[sender.tag] objectForKey:@"telephone"]);
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", [arr[sender.tag] objectForKey:@"telephone"]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
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
