//
//  CheckAndWriteInfoViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/5/29.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "CheckAndWriteInfoViewController.h"
#import "HelpTableViewCell.h"
#import "AddInfoViewController.h"

@interface CheckAndWriteInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    
    NSInteger status;
    
    UISegmentedControl *segmentedControl;
    
    UIImageView *view;
}

@end

@implementation CheckAndWriteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信息采集";
    [self createBarLeftWithImage:@"nav_return"];
    [self createRightTitle:@"录入" titleColor:[UIColor blackColor]];
    
    [self initSegmentedControl];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 15+39+zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight-49) style:UITableViewStylePlain];
    
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
    
    
    // Do any additional setup after loading the view.
}

- (void)showRight:(UIButton *)sender{
    AddInfoViewController *avc = [[AddInfoViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
//    NSDictionary *dictionary = arr[indexPath.row];
    cell.addinfoBtn.hidden = NO;
    cell.photoImage.backgroundColor = [UIColor blackColor];
    cell.nameLabel.text = @"123123";
    cell.phoneLabel.text = @"22222";
    cell.addressLabel.text = @"111111";
//    [cell.photoImage sd_setImageWithURL:[dictionary objectForKey:@"familyIcon"]];
    
    return cell;
}


- (void)initSegmentedControl
{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"贫困户",@"非贫困户",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(15, zNavigationHeight+10,zScreenWidth-30, 39);
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
            status = 0;
        {

        }
            
            
            
            
            
            
            break;
        case 1:
            NSLog(@"222222");
            status = 1;
            
            
        {
            
        }
            
            break;
        default:
            break;
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
