//
//  PovertyDetailViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/14.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PovertyDetailViewController.h"
#import "DeatailAndMethodTableViewCell.h"
#import "FamilyMemberTableViewCell.h"

@interface PovertyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    
    UILabel *nameLabel;
    UILabel *relaLabel;
    UILabel *addressLabel;
    UILabel *numLabel;
    

}

@end

@implementation PovertyDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贫困户详情";
    [self createBarLeftWithImage:@"nav_return"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 9;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1){
        return 54;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    static NSString *ID1 = @"cell1";
    
    if (indexPath.section == 0) {
        
        DeatailAndMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            
            cell = [[DeatailAndMethodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            
            
        }
        
        NSArray *arr1 = @[@"证件号码",@"家庭成员",@"贫困户属性",@"识别标准",@"致贫原因",@"人均收入"];
        cell.firstLabel.text = arr1[indexPath.row];
        
        
        if (indexPath.row == 0) {
            cell.secondLabel.text = [_dic objectForKey:@"masterCardNo"];
        }else if(indexPath.row == 1){
            cell.secondLabel.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"memberAmount"]];
        }else if(indexPath.row == 2){
            cell.secondLabel.text = [_dic objectForKey:@"poorFamilyAttr"];
        }else if(indexPath.row == 3){
            cell.secondLabel.text = @"国家标准";
        }else if(indexPath.row == 4){
            cell.secondLabel.text = [_dic objectForKey:@"povertyReason"];
        }else if(indexPath.row == 5){
            cell.secondLabel.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"perManIncome"]];
        }
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        FamilyMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        if (!cell) {
            
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[FamilyMemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            
        }
        
        cell.nameLabel.text = @"simon";
        cell.sexLabel.text = @"nan";
        cell.numLabel.text = @"123";
        cell.relaLabel.text = @"2222222";
        
        return cell;
        
        
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 230;
    }else {
        return 0;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 427;
    }else {
        return 0;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    UIImageView *headImg;
    UIImageView *locaImg;
    UIImageView *phoneImg;
    UIView *backView;
    
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];

        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 229)];
        backView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:backView];

        headImg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-34.5, 11, 69, 69)];
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, headImg.frame.origin.y+69+12, zScreenWidth, 20)];
        relaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nameLabel.frame.origin.y+20+7, zScreenWidth, 20)];
        addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-110, relaLabel.frame.origin.y+20+18, 220, 20)];
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-110,addressLabel.frame.origin.y+20+14, 220, 20)];

        headImg.backgroundColor = [UIColor blackColor];

        locaImg = [[UIImageView alloc]initWithFrame:CGRectMake(addressLabel.frame.origin.x-33, addressLabel.frame.origin.y, 20, 20)];
        locaImg.contentMode = UIViewContentModeCenter;
        locaImg.image = [UIImage imageNamed:@"details_adress"];

        phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(numLabel.frame.origin.x-33, numLabel.frame.origin.y, 20, 20)];
        phoneImg.contentMode = UIViewContentModeCenter;
        phoneImg.image = [UIImage imageNamed:@"details_telephone"];


        nameLabel.textColor = [UIColor colorHexString:@"121212"];
        relaLabel.textColor = [UIColor colorHexString:@"888888"];
        addressLabel.textColor = [UIColor colorHexString:@"121212"];
        numLabel.textColor = [UIColor colorHexString:@"121212"];

        relaLabel.font = [UIFont systemFontOfSize:10];
        addressLabel.font = [UIFont systemFontOfSize:13];

        nameLabel.textAlignment = NSTextAlignmentCenter;
        relaLabel.textAlignment = NSTextAlignmentCenter;

        addressLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textAlignment = NSTextAlignmentCenter;

        nameLabel.text = [_dic objectForKey:@"familyMaster"];
        relaLabel.text = @"户主";
        addressLabel.text = [_dic objectForKey:@"address"];
        numLabel.text = [_dic objectForKey:@"masterPhone"];
        [headImg sd_setImageWithURL:[_dic objectForKey:@"familyIcon"]];

        [headerView addSubview:headImg];
        [headerView addSubview:nameLabel];
        [headerView addSubview:relaLabel];
        [headerView addSubview:addressLabel];
        [headerView addSubview:numLabel];
        [headerView addSubview:locaImg];
        [headerView addSubview:phoneImg];

    }
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *footerSectionID = @"footerSectionID";
    UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerSectionID];
    
    UIView *back;
    UILabel *nameLabel;
    UILabel *sexLabel;
    UILabel *numLabel;
    UILabel *relaLabel;
    
    back = [[UIView alloc]initWithFrame:CGRectMake(0, 6, zScreenWidth, 330)];
    back.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:back];
    
    UILabel *titlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
    titlabel.textAlignment = NSTextAlignmentLeft;
    titlabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    titlabel.textColor = [UIColor colorHexString:@"c5c5c5"];
    titlabel.text = @"生产生活条件";
    [back addSubview:titlabel];
    
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, titlabel.frame.origin.y+20+10, 140, 74)];
    image1.backgroundColor = [UIColor blackColor];
    image1.contentMode = UIViewContentModeCenter;
    [back addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, image1.frame.origin.y+74+26, 140, 74)];
    image2.backgroundColor = [UIColor blackColor];
    image2.contentMode = UIViewContentModeCenter;
    [back addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, image2.frame.origin.y+74+26, 140, 74)];
    image3.backgroundColor = [UIColor blackColor];
    image3.contentMode = UIViewContentModeCenter;
    [back addSubview:image3];
    
    
    UIImageView *small1 = [[UIImageView alloc]initWithFrame:CGRectMake(15+140+14, image1.frame.origin.y+27, 20, 20)];
    small1.contentMode = UIViewContentModeCenter;
    small1.image = [UIImage imageNamed:@"details_icon1"];
    [back addSubview:small1];
    
    UIImageView *small2 = [[UIImageView alloc]initWithFrame:CGRectMake(15+140+14, image2.frame.origin.y+8.5, 20, 20)];
    small2.contentMode = UIViewContentModeCenter;
    small2.image = [UIImage imageNamed:@"details_icon2"];
    [back addSubview:small2];
    
    UIImageView *small3 = [[UIImageView alloc]initWithFrame:CGRectMake(15+140+14, image2.frame.origin.y+37+8.5, 20, 20)];
    small3.contentMode = UIViewContentModeCenter;
    small3.image = [UIImage imageNamed:@"details_icon3"];
    [back addSubview:small3];
    
    UIImageView *small4 = [[UIImageView alloc]initWithFrame:CGRectMake(15+140+14, image3.frame.origin.y+2.3, 20, 20)];
    small4.contentMode = UIViewContentModeCenter;
    small4.image = [UIImage imageNamed:@"details_icon4"];
    [back addSubview:small4];
    
    UIImageView *small5 = [[UIImageView alloc]initWithFrame:CGRectMake(15+140+14, image3.frame.origin.y+24.6+2.3, 20, 20)];
    small5.contentMode = UIViewContentModeCenter;
    small5.image = [UIImage imageNamed:@"details_icon6"];
    [back addSubview:small5];
    
    UIImageView *small6 = [[UIImageView alloc]initWithFrame:CGRectMake(15+140+14, image3.frame.origin.y+24.6*2+2.3, 20, 20)];
    small6.contentMode = UIViewContentModeCenter;
    small6.image = [UIImage imageNamed:@"details_icon5"];
    [back addSubview:small6];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15+140+14+20+8, small1.frame.origin.y, 150, 20)];
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab1.textColor = [UIColor colorHexString:@"888888"];
    lab1.text = @"危房户";
    [back addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15+140+14+20+8, small2.frame.origin.y, 150, 20)];
    lab2.textAlignment = NSTextAlignmentLeft;
    lab2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab2.textColor = [UIColor colorHexString:@"888888"];
    lab2.text = @"饮水困难";
    [back addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15+140+14+20+8, small3.frame.origin.y, 150, 20)];
    lab3.textAlignment = NSTextAlignmentLeft;
    lab3.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab3.textColor = [UIColor colorHexString:@"888888"];
    lab3.text = @"饮水安全";
    [back addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(15+140+14+20+8, small4.frame.origin.y, 150, 20)];
    lab4.textAlignment = NSTextAlignmentLeft;
    lab4.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab4.textColor = [UIColor colorHexString:@"888888"];
    lab4.text = @"耕地面积";
    [back addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(15+140+14+20+8, small5.frame.origin.y, 150, 20)];
    lab5.textAlignment = NSTextAlignmentLeft;
    lab5.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab5.textColor = [UIColor colorHexString:@"888888"];
    lab5.text = @"有效灌溉面积";
    [back addSubview:lab5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(15+140+14+20+8, small6.frame.origin.y, 150, 20)];
    lab6.textAlignment = NSTextAlignmentLeft;
    lab6.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab6.textColor = [UIColor colorHexString:@"888888"];
    lab6.text = @"林地面积";
    [back addSubview:lab6];
    
    UILabel *slab1 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-33-50, small1.frame.origin.y, 50, 20)];
    slab1.textAlignment = NSTextAlignmentRight;
    slab1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slab1.textColor = [UIColor colorHexString:@"121212"];
    slab1.text = @"是";
    [back addSubview:slab1];
    
    UILabel *slab2 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-33-50, small2.frame.origin.y, 50, 20)];
    slab2.textAlignment = NSTextAlignmentRight;
    slab2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slab2.textColor = [UIColor colorHexString:@"121212"];
    slab2.text = @"是";
    [back addSubview:slab2];
    
    UILabel *slab3 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-33-50, small3.frame.origin.y, 50, 20)];
    slab3.textAlignment = NSTextAlignmentRight;
    slab3.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slab3.textColor = [UIColor colorHexString:@"121212"];
    slab3.text = @"是";
    [back addSubview:slab3];
    
    UILabel *slab4 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-33-50, small4.frame.origin.y, 50, 20)];
    slab4.textAlignment = NSTextAlignmentRight;
    slab4.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slab4.textColor = [UIColor colorHexString:@"121212"];
    slab4.text = @"2亩";
    [back addSubview:slab4];
    
    UILabel *slab5 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-33-50, small5.frame.origin.y, 50, 20)];
    slab5.textAlignment = NSTextAlignmentRight;
    slab5.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slab5.textColor = [UIColor colorHexString:@"121212"];
    slab5.text = @"2亩";
    [back addSubview:slab5];
    
    UILabel *slab6 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-33-50, small6.frame.origin.y, 50, 20)];
    slab6.textAlignment = NSTextAlignmentRight;
    slab6.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slab6.textColor = [UIColor colorHexString:@"121212"];
    slab6.text = @"2亩";
    [back addSubview:slab6];
    
    
    
    for (int i=0; i<2; i++) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, image1.frame.origin.y+74+13+(74+26)*i, zScreenWidth-15, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        
        
        [back addSubview:line];
    }
    
    UIView *back2 = [[UIView alloc]initWithFrame:CGRectMake(0, 6+330+10, zScreenWidth, 40)];
    back2.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:back2];
    
    UILabel *memlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
    memlabel.textAlignment = NSTextAlignmentLeft;
    memlabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    memlabel.textColor = [UIColor colorHexString:@"c5c5c5"];
    memlabel.text = @"家庭成员";
    [back2 addSubview:memlabel];
    
    
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, back2.frame.origin.y+40+10, (zScreenWidth-26)/4-20, 20)];
    sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4-20, back2.frame.origin.y+40+10, (zScreenWidth-26)/4+20, 20)];
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4*2, back2.frame.origin.y+40+10, (zScreenWidth-26)/4, 20)];
    relaLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4*3,back2.frame.origin.y+40+10, (zScreenWidth-26)/4, 20)];
    
    nameLabel.text = @"姓名";
    sexLabel.text = @"民族";
    numLabel.text = @"证件号码";
    relaLabel.text = @"关系";
    
    nameLabel.font = [UIFont systemFontOfSize:14];
    sexLabel.font = [UIFont systemFontOfSize:14];
    numLabel.font = [UIFont systemFontOfSize:14];
    relaLabel.font = [UIFont systemFontOfSize:14];
    
    
    nameLabel.textColor = [UIColor colorHexString:@"888888"];
    sexLabel.textColor = [UIColor colorHexString:@"888888"];
    numLabel.textColor = [UIColor colorHexString:@"888888"];
    relaLabel.textColor = [UIColor colorHexString:@"888888"];
    
    relaLabel.textAlignment = NSTextAlignmentRight;
    
    [footerView addSubview:nameLabel];
    [footerView addSubview:sexLabel];
    [footerView addSubview:numLabel];
    [footerView addSubview:relaLabel];
    
    
    return footerView;
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
