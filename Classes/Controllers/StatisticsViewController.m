//
//  StatisticsViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/28.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "StatisticsViewController.h"
#import "StaTableViewCell.h"

@interface StatisticsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSMutableArray *data;
    NSInteger page;
    NSDictionary *Jsondic;
    
    UILabel *firstLabel;
    UILabel *secondLabel;
}

@end

@implementation StatisticsViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *param = @{@"holderName":_holderName,@"pageNum":@0,@"pageSize":@5,@"familyNo":_FID};
    [HTTPRequest postWithURL:@"yrycapi/signinrecord/getrecords" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
        Jsondic = [NSDictionary dictionaryWithDictionary:json];
        data = [NSMutableArray arrayWithArray:[Jsondic objectForKey:@"models"]];
        NSLog(@"json%@",Jsondic);
        [tableview reloadData];
        
        firstLabel.text = [NSString stringWithFormat:@"考勤总次数 %@ 次",[Jsondic objectForKey:@"count"]];
        secondLabel.text = [NSString stringWithFormat:@"扶贫动态数 %@ 次",[Jsondic objectForKey:@"count"]];
        
        NSLog(@"first%@",json);
        
        if (data.count == 5) {
            __weak __typeof(self) weakSelf = self;
            
            tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadmoredata];
            }];
        }
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [NSMutableArray array];
    
    page = 1;
    
    self.title = @"统计";
    [self createBarLeftWithImage:@"nav_return"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    tableview.estimatedRowHeight =0;
    tableview.estimatedSectionHeaderHeight =0;
    tableview.estimatedSectionFooterHeight =0;
    
    [self.view addSubview:tableview];
    
    
    
    
    
//    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoredata)];
    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)loadmoredata{
    {
        NSDictionary *param = @{@"holderName":_holderName,@"pageNum":[NSNumber numberWithUnsignedInteger:page],@"pageSize":@5,@"familyNo":_FID};
        page++;
        [HTTPRequest postWithURL:@"yrycapi/signinrecord/getrecords" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
            NSDictionary *mdic = [NSDictionary dictionaryWithDictionary:json];
            
            for (NSDictionary *dict in [mdic objectForKey:@"models"]) {
                [data addObject:dict];
            }
            NSLog(@"final%@",data);
            [tableview reloadData];
            [tableview.footer endRefreshing];
            
            if ([[mdic objectForKey:@"models"] count] == 0) {
                [tableview.footer endRefreshingWithNoMoreData];
            }
            
            NSLog(@"second%@",json);
            
            
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 193;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 90;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(20, 10, zScreenWidth-40, 70)];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 4;
        [headerView addSubview:backview];
        
        firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, zScreenWidth-40, 20)];
        firstLabel.textAlignment = NSTextAlignmentCenter;
        firstLabel.textColor = [UIColor blackColor];
        firstLabel.font = [UIFont systemFontOfSize:16];
        [backview addSubview:firstLabel];
        
        secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10+20+10, zScreenWidth-40, 20)];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        secondLabel.textColor = [UIColor blackColor];
        secondLabel.font = [UIFont systemFontOfSize:16];
        [backview addSubview:secondLabel];
        
    }

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    StaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSLog(@"cell----%@",data);
    NSDictionary *modelDic = data[indexPath.row];
    NSLog(@"%@",modelDic);
    NSArray *arr = [modelDic objectForKey:@"pics"];
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[StaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    cell.timeLab.text = [modelDic objectForKey:@"signTime"];
    //        cell.timeLab.text = @"2017.06.03 08:33";
    cell.addLab.text = [modelDic objectForKey:@"positionAddress"];
    cell.conLab.text = [NSString stringWithFormat:@"%@ \n\n",[modelDic objectForKey:@"content"]];
    //        for (int i=0; i<arr.count; i++) {
    //            UIImageView *conImg = (UIImageView *)[cell.image viewWithTag:i];
    //            [conImg sd_setImageWithURL:[arr[i] objectForKey:@"picUrl"]];
    //        }
    
    if (arr.count == 1) {
        [cell.image1 sd_setImageWithURL:[arr[0] objectForKey:@"picUrl"]];
    }else if (arr.count == 2){
        [cell.image1 sd_setImageWithURL:[arr[0] objectForKey:@"picUrl"]];
        [cell.image2 sd_setImageWithURL:[arr[1] objectForKey:@"picUrl"]];
    }else if (arr.count == 3){
        [cell.image1 sd_setImageWithURL:[arr[0] objectForKey:@"picUrl"]];
        [cell.image2 sd_setImageWithURL:[arr[1] objectForKey:@"picUrl"]];
        [cell.image3 sd_setImageWithURL:[arr[2] objectForKey:@"picUrl"]];
    }else if (arr.count == 4){
        [cell.image1 sd_setImageWithURL:[arr[0] objectForKey:@"picUrl"]];
        [cell.image2 sd_setImageWithURL:[arr[1] objectForKey:@"picUrl"]];
        [cell.image3 sd_setImageWithURL:[arr[2] objectForKey:@"picUrl"]];
        [cell.image4 sd_setImageWithURL:[arr[3] objectForKey:@"picUrl"]];
    }
    
    
    return cell;
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
