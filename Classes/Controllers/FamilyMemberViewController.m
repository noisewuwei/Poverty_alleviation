//
//  FamilyMemberViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/14.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FamilyMemberViewController.h"
#import "FamilyMemberTableViewCell.h"
#import "PovertyDetailViewController.h"
#import "MethodViewController.h"
#import "FamilyMemberTableViewCell.h"

@interface FamilyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSArray *arr;
}

@end

@implementation FamilyMemberViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HTTPRequest postWithURL:@"yrycapi/familyinfo/getmembers" method:@"POST" params:@{@"holderName":_holderName,@"familyNo":_ID} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"lalalalasuccess:%@",json);
        arr = [NSArray arrayWithArray:json];
        
        [tableview reloadData];
        
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭成员";
    [self createRightTitle:@"详情" titleColor:[UIColor blackColor]];
    [self createBarLeftWithImage:@"nav_return"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    
    
    [self.view addSubview:tableview];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FamilyMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        NSLog(@"123456%@",arr);
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FamilyMemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        
    }
    
    NSDictionary *dic = arr[indexPath.row];
    cell.nameLabel.text = [dic objectForKey:@"name"];
    cell.sexLabel.text = [dic objectForKey:@"nation"];
    cell.numLabel.text = [dic objectForKey:@"cardNo"];
    cell.relaLabel.text = [dic objectForKey:@"relation"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = arr[indexPath.row];
    MethodViewController *vc = [[MethodViewController alloc]init];
    vc.cardno = [dic objectForKey:@"cardNo"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    UILabel *nameLabel;
    UILabel *sexLabel;
    UILabel *numLabel;
    UILabel *relaLabel;
    
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 7, (zScreenWidth-26)/4-20, 20)];
        sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4-20, 7, (zScreenWidth-26)/4+20, 20)];
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4*2, 7, (zScreenWidth-26)/4, 20)];
        relaLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4*3,7, (zScreenWidth-26)/4, 20)];
        
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
        
        [headerView addSubview:nameLabel];
        [headerView addSubview:sexLabel];
        [headerView addSubview:numLabel];
        [headerView addSubview:relaLabel];
        
    }
    
    return headerView;
}


-(void)showRight:(UIButton *)sender{
    
    [HTTPRequest postWithURL:@"yrycapi/familyinfo/familydetails" method:@"POST" params:@{@"holderName":_holderName,@"familyNo":_ID} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"showright:%@",json);
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:json];
        
        PovertyDetailViewController *pvc = [[PovertyDetailViewController alloc] init];
        pvc.dic = dict;
        [self.navigationController pushViewController:pvc animated:YES];
        
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
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
