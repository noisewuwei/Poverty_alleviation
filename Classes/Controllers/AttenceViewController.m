//
//  AttenceViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/13.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AttenceViewController.h"
#import "ClockViewController.h"
#import "ChargeViewController.h"
#import "AccountBookViewController.h"
#import "ListViewController.h"
#import "WWButton.h"
#import "DetectionViewController.h"
#import "CheckAndWriteInfoViewController.h"
#import "WriteInfoViewController.h"

@interface AttenceViewController (){
    
    NSDictionary *dic;
    
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *levelLabel;
    UILabel *numLabel;
    UILabel *countLabel;
    
    NSArray *array;
    
    UIImageView *imgView;
    
    UIImageView *partyimg;
    
    

}

@end

@implementation AttenceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    
    
    if ([ZJStoreDefaults getObjectForKey:@"headimg"]) {
        UIImage *image = [ZJStoreDefaults getObjectForKey:@"headimg"];
        imgView.image = image;
    }else if([[dic objectForKey:@"picUrl"] isEqualToString:@"无头像"]){
        imgView.image = [UIImage imageNamed:@"head_head"];
        NSLog(@"hhh");
    }else if([dic objectForKey:@"picUrl"]){
        [imgView sd_setImageWithURL:[dic objectForKey:@"picUrl"]];
        
    }
    
    if ([[dic objectForKey:@"isMemberOfTheParty"] isEqualToString:@"true"]) {

        partyimg.hidden = NO;

    }else{

        partyimg.hidden = YES;


    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    self.title = @"首页";
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zToolBarHeight)];
    back.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:back];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 43, zScreenWidth-30, 250)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.cornerRadius = 7;
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-34, 9, 68, 68 )];
    imgView.backgroundColor = [UIColor blackColor];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 34;
    [self.view addSubview:imgView];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-40, imgView.frame.origin.y+68+14, 80, 20)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:16];
    
    partyimg = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+80, nameLabel.frame.origin.y, 20, 20 )];
    partyimg.contentMode = UIViewContentModeCenter;
    partyimg.image = [UIImage imageNamed:@"home_Party-members"];
    [self.view addSubview:partyimg];
    
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-150, nameLabel.frame.origin.y+20+10, 300, 20)];
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    
    levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, addressLabel.frame.origin.y+30, 150, 20)];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.textColor = [UIColor colorHexString:@"888888"];
    levelLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:addressLabel];
    [self.view addSubview:levelLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(51, levelLabel.frame.origin.y+44, zScreenWidth-102, 1)];
    lineView.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:lineView];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(51, lineView.frame.origin.y+26, 10, 10)];
    UIImageView *peopleImg = [[UIImageView alloc]initWithFrame:CGRectMake(51, phoneImg.frame.origin.y+31, 10, 10)];
    phoneImg.contentMode = UIViewContentModeCenter;
    peopleImg.contentMode = UIViewContentModeCenter;
    phoneImg.image = [UIImage imageNamed:@"attendance_photo"];
    peopleImg.image = [UIImage imageNamed:@"attendance_people"];
    
    [self.view addSubview:peopleImg];
    [self.view addSubview:phoneImg];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImg.frame.origin.x+20, phoneImg.frame.origin.y-2.5, zScreenWidth/2-51-30, 15)];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = [UIColor colorHexString:@"888888"];
    phoneLabel.text = @"联系电话";
    phoneLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    
    UILabel *peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(peopleImg.frame.origin.x+20, peopleImg.frame.origin.y-2.5, zScreenWidth/2-51-30, 15)];
    peopleLabel.textAlignment = NSTextAlignmentLeft;
    peopleLabel.textColor = [UIColor colorHexString:@"888888"];
    peopleLabel.text = @"帮扶户数";
    peopleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    
    [self.view addSubview:peopleLabel];
    [self.view addSubview:phoneLabel];
    
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2, phoneLabel.frame.origin.y, zScreenWidth/2, 15)];
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    
    countLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2, peopleLabel.frame.origin.y, zScreenWidth/2, 15)];
    countLabel.textAlignment = NSTextAlignmentLeft;
    countLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    
    
    
    [self.view addSubview:numLabel];
    [self.view addSubview:countLabel];
    
//    UIButton *attenceBtn = [[UIButton alloc]initWithFrame:CGRectMake(51, whiteView.frame.origin.y+230+20+100, zScreenWidth-102, 44)];
//    attenceBtn.backgroundColor = [UIColor colorHexString:@"fdba44"];
//    [attenceBtn setTitle:@"考勤打卡" forState:UIControlStateNormal];
//    [attenceBtn addTarget:self action:@selector(attence) forControlEvents:UIControlEventTouchUpInside];
//    attenceBtn.layer.masksToBounds = YES;
//    attenceBtn.layer.cornerRadius = 4;
//    [self.view addSubview:attenceBtn];
//
//    UIButton *chargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(51, attenceBtn.frame.origin.y+60, zScreenWidth-102, 44)];
//    chargeBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
//    [chargeBtn setTitle:@"记账" forState:UIControlStateNormal];
//    [chargeBtn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
//    chargeBtn.layer.masksToBounds = YES;
//    chargeBtn.layer.cornerRadius = 4;
//    [self.view addSubview:chargeBtn];
    
    
    [self load];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
    
    UIView *whiteView2 = [[UIView alloc]initWithFrame:CGRectMake(15, 43+230+20+20, zScreenWidth-30, 135+60)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    whiteView2.layer.masksToBounds = YES;
    whiteView2.layer.cornerRadius = 7;
    
    UIButton *Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, (whiteView2.frame.size.width)/2, 72)];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake((whiteView2.frame.size.width)/2/2-25, 6, 50, 50)];
    image1.image = [UIImage imageNamed:@"home_icon1"];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 56+4, (whiteView2.frame.size.width)/2, 20)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    label1.text = @"考勤打卡";
    
    [Btn1 addSubview:image1];
    [Btn1 addSubview:label1];
    
    [Btn1 addTarget:self action:@selector(attence) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:Btn1];
    
    UIButton *Btn2 = [[UIButton alloc]initWithFrame:CGRectMake((whiteView2.frame.size.width)/2, 15, (whiteView2.frame.size.width)/2, 72)];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake((whiteView2.frame.size.width)/2/2-25, 6, 50, 50)];
    image2.image = [UIImage imageNamed:@"home_icon2"];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 56+4, (whiteView2.frame.size.width)/2, 20)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    label2.text = @"记账";
    
    [Btn2 addSubview:image2];
    [Btn2 addSubview:label2];

    [Btn2 addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:Btn2];
    
    UIButton *Btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 15+72+20, (whiteView2.frame.size.width)/2, 72)];
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake((whiteView2.frame.size.width)/2/2-25, 6, 50, 50)];
    image3.image = [UIImage imageNamed:@"home_icon3"];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 56+4, (whiteView2.frame.size.width)/2, 20)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    label3.text = @"贫困户需求";
    
    [Btn3 addSubview:image3];
    [Btn3 addSubview:label3];

    [Btn3 addTarget:self action:@selector(require) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:Btn3];
    
    UIButton *Btn4 = [[UIButton alloc]initWithFrame:CGRectMake((whiteView2.frame.size.width)/2, 15+72+20, (whiteView2.frame.size.width)/2, 72)];
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake((whiteView2.frame.size.width)/2/2-25, 6, 50, 50)];
    image4.image = [UIImage imageNamed:@"home_icon4"];
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 56+4, (whiteView2.frame.size.width)/2, 20)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    label4.text = @"信息采集";
    
    [Btn4 addSubview:image4];
    [Btn4 addSubview:label4];

    [Btn4 addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:Btn4];
    
    
    // Do any additional setup after loading the view.
}

- (void)load{
    [HTTPRequest postWithURL:@"yrycapi/signinrecord/getuserinfo" method:@"GET" params:nil ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"lalalalasuccess:%@",json);
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:json];
        
        addressLabel.text = [dict objectForKey:@"development"];
        levelLabel.text = [dict objectForKey:@"business"];
        
        numLabel.text = [dict objectForKey:@"userPhone"];
        countLabel.text = [NSString stringWithFormat:@"%@ 户",[dict objectForKey:@"familyNum"]];
        
        nameLabel.text = [dict objectForKey:@"userName"];
        
        
        array = [NSArray arrayWithArray:[dict objectForKey:@"familyListModels"]];

        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
}




- (void)attence{
    NSLog(@"考勤打卡");
    
    ListViewController *lvc = [[ListViewController alloc] init];
    lvc.hidesBottomBarWhenPushed = YES;
    lvc.str = @"考勤";
    [self.navigationController pushViewController:lvc animated:YES];
}


- (void)charge{
    NSLog(@"记账");
    
    WriteInfoViewController *lvc = [[WriteInfoViewController alloc] init];
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];
    
//    ListViewController *lvc = [[ListViewController alloc] init];
//    lvc.hidesBottomBarWhenPushed = YES;
//    lvc.str = @"记账";
//    [self.navigationController pushViewController:lvc animated:YES];
    
}

- (void)require{
    ListViewController *lvc = [[ListViewController alloc] init];
    lvc.hidesBottomBarWhenPushed = YES;
    lvc.str = @"需求";
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)info{
    CheckAndWriteInfoViewController *cvc = [[CheckAndWriteInfoViewController alloc] init];
    cvc.hidesBottomBarWhenPushed = YES;
//    cvc.str = @"需求";
    [self.navigationController pushViewController:cvc animated:YES];
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
