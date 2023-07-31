//
//  RequireViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/24.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "RequireViewController.h"
#import "RequireTableViewCell.h"
#import "PostRequireViewController.h"
#import "RequireDetailViewController.h"

@interface RequireViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSInteger page;
    NSMutableArray *data;
    UIImageView *view;
}

@end

@implementation RequireViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self load];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    self.title = @"贫困户需求";
    [self createBarLeftWithImage:@"nav_return"];
    [self createRightTitle:@"发布新需求" titleColor:[UIColor blackColor]];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    tableview.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    tableview.estimatedRowHeight =0;
    tableview.estimatedSectionHeaderHeight =0;
    tableview.estimatedSectionFooterHeight =0;
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, tableview.frame.size.height)];
    view.contentMode = UIViewContentModeCenter;
    view.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    view.image = [UIImage imageNamed:@"empty_no-demand"];
    
    page = 1;
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)load{
    
    [view removeFromSuperview];

    NSDictionary *param = @{@"holderName":_holderName,@"familyNo":_familyNo,@"pageNum":@0,@"pageSize":@5};
    [HTTPRequest postWithURL:@"yrycapi/familyinfo/getdemands" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"12121212%@",json);
        
        [view removeFromSuperview];
        
        data = [NSMutableArray arrayWithArray:json];
        
        
        
        if (data.count > 0) {
            [tableview reloadData];
        }else{
            [self.view addSubview:view];
        }
        
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

- (void)loadmoredata{
    
    NSDictionary *param = @{@"holderName":_holderName,@"familyNo":_familyNo,@"pageNum":[NSNumber numberWithUnsignedInteger:page],@"pageSize":@5};
    page++;
    [HTTPRequest postWithURL:@"yrycapi/familyinfo/getdemands" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
        NSArray *arr = [NSArray arrayWithArray:json];
        
        [data addObjectsFromArray:arr];
        
        NSLog(@"final%@",data);
        [tableview reloadData];
        [tableview.footer endRefreshing];
        
        if (arr.count == 0) {
            [tableview.footer endRefreshingWithNoMoreData];
        }
        
        NSLog(@"second%@",json);
        
        
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    RequireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[RequireTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dic = data[indexPath.row];
    
    cell.title.text = [dic objectForKey:@"title"];
    cell.status.text = [dic objectForKey:@"status"];
    cell.content.text = [dic objectForKey:@"content"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = data[indexPath.row];

    RequireDetailViewController *rvc = [[RequireDetailViewController alloc]init];
    
    rvc.dict = dic;
    
    [self.navigationController pushViewController:rvc animated:YES];
    
}

- (void)showRight:(UIButton *)sender{
    PostRequireViewController *rvc = [[PostRequireViewController alloc]init];
    rvc.familyNo = _familyNo;
    rvc.holderName = _holderName;
    rvc.callBackBlock = ^(NSString *text){
        
        [self load];
        page = 1;
        
    };
    
    [self.navigationController pushViewController:rvc animated:YES];
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
