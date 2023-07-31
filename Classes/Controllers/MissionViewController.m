//
//  MissionViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MissionViewController.h"
#import "MissonTableViewCell.h"
#import "PushMissionViewController.h"
#import "OutViewController.h"
#import "InViewController.h"

@interface MissionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *Btn;
    UITableView *tableview;
    
    NSMutableArray *data;
    NSMutableArray *data2;
    NSInteger page;
    NSInteger page2;
    NSDictionary *Jsondic;
    
    NSInteger status;
    
    NSString *statusstr;
    
    UISegmentedControl *segmentedControl;
    
    UIImageView *view;
}

@end

@implementation MissionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRightTitle:@"发布任务" titleColor:[UIColor blackColor]];
    
    data = [NSMutableArray array];
    
    status = 0;
    
    page = 1;
    page2 = 1;
    
    self.title = @"扶贫任务";
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    [self initSegmentedControl];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 15+39, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight-49) style:UITableViewStylePlain];
    
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    tableview.estimatedRowHeight =0;
    tableview.estimatedSectionHeaderHeight =0;
    tableview.estimatedSectionFooterHeight =0;
    
    tableview.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15+39, tableview.frame.size.width, tableview.frame.size.height)];
    view.contentMode = UIViewContentModeCenter;
    view.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    view.image = [UIImage imageNamed:@"none"];
    
//    __weak __typeof(self) weakSelf = self;
//
//    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadmoredata];
//    }];

    [self load];
    
    // Do any additional setup after loading the view.
}

- (void)load{
    
    [view removeFromSuperview];
    
    segmentedControl.selectedSegmentIndex = 0;
    
    status = 0;
    
    NSDictionary *param = @{@"pageNum":@0,@"pageSize":@5};
    [HTTPRequest postWithURL:@"yrycapi/task/getReceivetasks" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
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
    if (status == 0) {
        NSDictionary *param = @{@"pageNum":[NSNumber numberWithUnsignedInteger:page],@"pageSize":@5};
        page++;
        [HTTPRequest postWithURL:@"yrycapi/task/getReceivetasks" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
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
    }else if(status == 1){
        NSDictionary *param = @{@"pageNum":[NSNumber numberWithUnsignedInteger:page2],@"pageSize":@5};
        page2++;
        [HTTPRequest postWithURL:@"yrycapi/task/getpublishtasks" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
            NSArray *arr = [NSArray arrayWithArray:json];
            
            [data2 addObjectsFromArray:arr];
            
            NSLog(@"final%@",data2);
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (status == 0) {
        return data.count;
    }else if(status == 1){
        return data2.count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 159;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    MissonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[MissonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    if (status == 0) {
        NSDictionary *dic = data[indexPath.row];
        
        cell.rightLab.text = [dic objectForKey:@"status"];
        
        cell.titleLab.text = [dic objectForKey:@"taskName"];
        cell.timeLab.text = [NSString stringWithFormat:@"完成时间:%@-%@",[dic objectForKey:@"startDate"],[dic objectForKey:@"endDate"]];
        cell.conLab.text = [dic objectForKey:@"taskContent"];
    }else if(status == 1){
        NSDictionary *dic = data2[indexPath.row];
        
        cell.rightLab.text = [dic objectForKey:@"status"];
        
        cell.titleLab.text = [dic objectForKey:@"taskName"];
        cell.timeLab.text = [NSString stringWithFormat:@"完成时间:%@-%@",[dic objectForKey:@"startDate"],[dic objectForKey:@"endDate"]];
        cell.conLab.text = [dic objectForKey:@"taskContent"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (status == 1) {
        
        NSDictionary *dic = data2[indexPath.row];
        
        OutViewController *ovc = [[OutViewController alloc]init];
        
        ovc.Id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"taskId"]];
        
        [self.navigationController pushViewController:ovc animated:YES];
        
    }else if (status == 0){
        
        NSDictionary *dic = data[indexPath.row];
        
        InViewController *ivc = [[InViewController alloc]init];
        
        ivc.callBackBlock = ^(NSString *text){
            
            [self load];
            page = 1;
            
        };
        
        ivc.Id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"taskId"]];
        ivc.townId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"townTaskId"]];
        
        [self.navigationController pushViewController:ivc animated:YES];
        
    }
    
}


- (void)initSegmentedControl
{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"我收到的任务",@"我发布的任务",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(15, 10,zScreenWidth-30, 39);
    segmentedControl.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    /*
     这个是设置按下按钮时的颜色
     */
    segmentedControl.tintColor = [UIColor colorHexString:@"193055"];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    
    
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIColor colorHexString:@"888888"] forKey:NSForegroundColorAttributeName];
    
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index)
    {
        case 0:
            NSLog(@"111111");
            page = 1;
            status = 0;
        {
            NSDictionary *param = @{@"pageNum":@0,@"pageSize":@5};
            [HTTPRequest postWithURL:@"yrycapi/task/getReceivetasks" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
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
            
    
            
            
            
            
            break;
        case 1:
            NSLog(@"222222");
            page2 = 1;
            status = 1;
            
            
        {
            NSDictionary *param = @{@"pageNum":@0,@"pageSize":@5};
            [HTTPRequest postWithURL:@"yrycapi/task/getpublishtasks" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"12121212%@",json);
                
                [view removeFromSuperview];
                
                data2 = [NSMutableArray arrayWithArray:json];
                
                if (data2.count > 0) {
                    [tableview reloadData];
                }else{
                    [self.view addSubview:view];
                }
                
                if (data2.count == 5) {
                    __weak __typeof(self) weakSelf = self;
                    
                    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        [weakSelf loadmoredata];
                    }];
                }
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }
            
            break;
        default:
            break;
    }
}

- (void)backload{
    segmentedControl.selectedSegmentIndex = 1;
    
    status = 1;
    
    NSDictionary *param = @{@"pageNum":@0,@"pageSize":@5};
    [HTTPRequest postWithURL:@"yrycapi/task/getpublishtasks" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"12121212%@",json);
        
        data2 = [NSMutableArray arrayWithArray:json];
        [tableview reloadData];
        
        if (data2.count == 5) {
            __weak __typeof(self) weakSelf = self;
            
            tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadmoredata];
            }];
        }
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

-(void)showRight:(UIButton *)sender{
    NSLog(@"发布任务");
    
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    if ([[dic objectForKey:@"isHaveSubordinates"] isEqualToString:@"有下属"]) {
        PushMissionViewController *pvc = [[PushMissionViewController alloc]init];
        pvc.callBackBlock = ^(NSString *text){
            
            [self backload];
            page2 = 1;
            
        };
        pvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pvc animated:YES];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"暂无权限"];
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
