//
//  TrueMessViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/29.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "TrueMessViewController.h"
#import "TrueMessTableViewCell.h"

@interface TrueMessViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
}

@end

@implementation TrueMessViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"党建扶贫";
    [self createBarLeftWithImage:@"nav_return"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 229;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    TrueMessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[TrueMessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.firsttimeLab.text = @"2018.02.06 13:20";
        cell.secondtimeLab.text = @"2018.02.06 13:20";
        cell.contentLab.text = @"你看见卡上就看出撒娇阿轲三餐不继卡措手不及吃洒看巴萨采集卡";
        [cell.Btn setBackgroundColor:[UIColor colorHexString:@"274d89"]];
        
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
