//
//  HelpViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/13.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewCell.h"
#import "FamilyMemberViewController.h"
#import "LoginViewController.h"
#import "PovertyDetailViewController.h"

@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSArray *arr;
    
    UIImageView *image;
    UIImageView *view;
    
}

@end

@implementation HelpViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"帮扶指导";
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, tableview.frame.size.height)];
    image.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    image.contentMode = UIViewContentModeCenter;
    image.image = [UIImage imageNamed:@"empty_network"];
    
    
    view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, tableview.frame.size.height)];
    view.contentMode = UIViewContentModeCenter;
    view.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    view.image = [UIImage imageNamed:@"none"];
    
    [self load];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)load{
    [HTTPRequest postWithURL:@"yrycapi/signinrecord/getuserinfo" method:@"GET" params:nil ProgressHUD:self.Hud controller:self response:^(id json) {
        
        NSLog(@"lalalalasuccess:%@",json);
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:json];
        
        [view removeFromSuperview];
        [image removeFromSuperview];
        
        arr = [dict objectForKey:@"familyListModels"];
        
        
        
        if (arr.count>0) {
            [tableview reloadData];
        }else{
            [tableview addSubview:view];
        }
        
        
        
        
        
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
        if ([[failure objectForKey:@"code"] isEqualToString:@"902"]) {
            LoginViewController *lgvc = [[LoginViewController alloc] init];
            [self presentViewController:lgvc animated:YES completion:nil];
        }else {
            
            [tableview addSubview:image];
            
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    HelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[HelpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary *dictionary = arr[indexPath.row];
    
    cell.photoImage.backgroundColor = [UIColor blackColor];
    cell.nameLabel.text = [NSString stringWithFormat:@"户主:%@",[dictionary objectForKey:@"holderName"]];
    cell.phoneLabel.text = [NSString stringWithFormat:@"联系方式:%@",[dictionary objectForKey:@"masterPhone"]];
    cell.addressLabel.text = [NSString stringWithFormat:@"家庭住址:%@",[dictionary objectForKey:@"address"]];
    [cell.photoImage sd_setImageWithURL:[dictionary objectForKey:@"familyIcon"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictionary = arr[indexPath.row];
    
    [HTTPRequest postWithURL:@"yrycapi/familyinfo/familydetails" method:@"POST" params:@{@"holderName":[dictionary objectForKey:@"holderName"],@"familyNo":[dictionary objectForKey:@"familyNo"]} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"showright:%@",json);
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:json];
        
        PovertyDetailViewController *pvc = [[PovertyDetailViewController alloc] init];
        pvc.dic = dict;
        [self.navigationController pushViewController:pvc animated:YES];
        
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
}



-(void)showRight:(UIButton *)sender{
    
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
