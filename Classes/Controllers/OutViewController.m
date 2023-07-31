//
//  OutViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "OutViewController.h"
#import "OutTableViewCell.h"

@interface OutViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    UILabel *titleLab;
    UILabel *timeLab;
    UILabel *conLab;
    
    NSDictionary *dic;
    NSArray *arr;
}

@end

@implementation OutViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HTTPRequest postWithURL:@"yrycapi/task/publishTaskDetail" method:@"POST" params:@{@"taskId":_Id} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"12121212%@",json);
        
        
        dic = [NSDictionary dictionaryWithDictionary:json];
        
        arr = [NSArray arrayWithArray:[dic objectForKey:@"handleStatusModels"]];
        
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我发布的任务";
    [self createBarLeftWithImage:@"nav_return"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-39-zNavigationHeight) style:UITableViewStyleGrouped];
    
    tableview.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    OutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[OutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        
    }
    
    NSDictionary *dic = arr[indexPath.row];
    
    cell.nameLab.text = [dic objectForKey:@"name"];
    cell.statusLab.text = [dic objectForKey:@"status"];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(15, 15, zScreenWidth-30, 149)];
    backview.layer.masksToBounds = YES;
    backview.layer.cornerRadius = 4;
    backview.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backview];
    
    UIImageView *littleImg = [[UIImageView alloc]initWithFrame:CGRectMake(17, 22, 15, 15)];
    littleImg.contentMode = UIViewContentModeCenter;
    littleImg.image = [UIImage imageNamed:@"task_icon2"];
    [backview addSubview:littleImg];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(littleImg.frame.origin.x+15+10, 22, 200, 15)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:14];
    [backview addSubview:titleLab];
    
    
    timeLab = [[UILabel alloc]initWithFrame:CGRectMake(littleImg.frame.origin.x+15+10, 22+15+5, 200, 15)];
    timeLab.textColor = [UIColor colorHexString:@"a6a6a6"];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textAlignment = NSTextAlignmentLeft;
    [backview addSubview:timeLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(17, timeLab.frame.origin.y+15+10, zScreenWidth-30-34, 1)];
    line.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [backview addSubview:line];
    
    conLab = [[UILabel alloc]initWithFrame:CGRectMake(17, line.frame.origin.y, line.frame.size.width, 60)];
    conLab.textAlignment = NSTextAlignmentLeft;
    conLab.textColor = [UIColor colorHexString:@"888888"];
    conLab.numberOfLines = 0;
    conLab.font = [UIFont systemFontOfSize:14];
    [backview addSubview:conLab];

    titleLab.text = [dic objectForKey:@"taskName"];
    timeLab.text = [NSString stringWithFormat:@"完成时间:%@-%@",[dic objectForKey:@"startDate"],[dic objectForKey:@"endDate"]];
    conLab.text = [dic objectForKey:@"taskContent"];
    
    UILabel *setlab = [[UILabel alloc]initWithFrame:CGRectMake(15, backview.frame.origin.y+149+12, 100, 15)];
    setlab.textColor = [UIColor colorHexString:@"888888"];
    setlab.textAlignment = NSTextAlignmentLeft;
    setlab.font = [UIFont systemFontOfSize:14];
    setlab.text = @"完成情况";
    [headerView addSubview:setlab];
    
    
    return headerView;
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
