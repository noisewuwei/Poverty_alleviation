//
//  MessageViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/13.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MessageViewController.h"
#import "DJFPTableViewCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSArray *arr;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"党建扶贫";
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self load];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
    
    
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
}


- (void)load{
    [HTTPRequest postWithURL:@"yrycapi/cadreservice/getcadreservice" method:@"GET" params:nil ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"success:%@",json);
        
        arr = [NSArray arrayWithArray:json];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"errorlalalala:%@",failure);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    static NSString *ID = @"cell";
//    DJFPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//
//    cell.contentlab.text = [arr[indexPath.row] objectForKey:@"workDetails"];
//    CGSize size = [cell.contentlab sizeThatFits:CGSizeMake(zScreenWidth-28-38-10, MAXFLOAT)];
//    cell.contentlab.frame = CGRectMake(31, 40, size.width, size.height);
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:14 weight:UIFontWeightThin]};
    NSString *contentStr= [arr[indexPath.row] objectForKey:@"workDetails"];
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(zScreenWidth-28-38-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return 40+size.height+20;

//    UITableViewCell *cell = [self tableView:tableview cellForRowAtIndexPath:indexPath];
////    [self tableView:tableview cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
//    return 92+10+20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 130+10+24+10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 130+10+24+10)];
        view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
        [headerView addSubview:view];
        
        UIImageView *backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 123)];
        backimage.contentMode = UIViewContentModeCenter;
        backimage.image = [UIImage imageNamed:@"information_empty-1"];
        [headerView addSubview:backimage];
        
        UIImageView *labelimg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 123+10, 100, 24)];
        labelimg.contentMode = UIViewContentModeCenter;
        labelimg.image = [UIImage imageNamed:@"未-1"];
        [headerView addSubview:labelimg];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 24)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"可帮扶党员推荐";
        [labelimg addSubview:label];
        
    }
    
    return headerView;
}

//WithFrame:CGRectMake(14, 0, zScreenWidth-28, 110)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    DJFPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[DJFPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.namelab.text = [arr[indexPath.row] objectForKey:@"userName"];
    cell.numlab.text = [arr[indexPath.row] objectForKey:@"userPhone"];
    cell.skilllab.text = [arr[indexPath.row] objectForKey:@"type"];
    
    
    
    cell.contentlab.text = [arr[indexPath.row] objectForKey:@"workDetails"];
    CGSize size = [cell.contentlab sizeThatFits:CGSizeMake(zScreenWidth-28-38-10, MAXFLOAT)];
    cell.contentlab.frame = CGRectMake(31, 40, size.width, size.height);
    
    cell.backview.frame = CGRectMake(14, 2, zScreenWidth-28, 38+size.height+10);
    [cell addSubview:cell.backview];
    
    [cell.backview addSubview:cell.contentlab];
    
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)call:(UIButton *)sender{
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", [arr[sender.tag] objectForKey:@"userPhone"]];
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
