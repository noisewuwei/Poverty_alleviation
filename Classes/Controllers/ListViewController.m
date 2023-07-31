//
//  ListViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/29.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ListViewController.h"
#import "HelpTableViewCell.h"
#import "ClockViewController.h"
#import "AccountBookViewController.h"
#import "LYTBackView.h"
#import "RequireViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    UITableView *tableview;
    
    UILabel *label;
    
    CGFloat y;
    
    UILabel *plelab;
    UITextView *text;
    
    NSString *userstr;
}

@end

@implementation ListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
    
    if ([_str isEqualToString:@"考勤"]) {
        label.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBarLeftWithImage:@"nav_return"];
    self.title = @"贫困户列表";
    NSLog(@"listview list arr %@",self.listArr);
    
    
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, zScreenHeight-20, zScreenWidth, 20)];
    label.backgroundColor = [UIColor colorHexString:@"f5f5f5"];
    label.text = @"温馨提示：左滑可设置家中是否有人";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorHexString:@"585858"];
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    label.hidden = YES;
    [self.view addSubview:label];
    
    
    [self load];
    
    // Do any additional setup after loading the view.
}

- (void)load{
    [HTTPRequest postWithURL:@"yrycapi/signinrecord/getuserinfo" method:@"GET" params:nil ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"lalalalasuccess:%@",json);
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:json];
        userstr = [dict objectForKey:@"openFaceecognition"];
        _listArr = [NSArray arrayWithArray:[dict objectForKey:@"familyListModels"]];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"listarr count %lu",(unsigned long)self.listArr.count);
    return self.listArr.count;
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
    
    cell.photoImage.backgroundColor = [UIColor blackColor];
    NSDictionary *dict = self.listArr[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"户主:%@",[dict objectForKey:@"holderName"]];
    cell.phoneLabel.text = [NSString stringWithFormat:@"联系方式:%@",[dict objectForKey:@"masterPhone"]];
    cell.addressLabel.text = [NSString stringWithFormat:@"家庭住址:%@",[dict objectForKey:@"address"]];
    [cell.photoImage sd_setImageWithURL:[dict objectForKey:@"familyIcon"]];
    
    
    if ([[dict objectForKey:@"stayOut"] isEqualToString:@"1"]) {
        cell.statusLabel.hidden = NO;
    }else{
        cell.statusLabel.hidden = YES;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_str isEqualToString:@"记账"]) {
        NSDictionary *dict = self.listArr[indexPath.row];
        AccountBookViewController *cvc = [[AccountBookViewController alloc]init];
        cvc.familyNo = [dict objectForKey:@"familyNo"];
        cvc.holderName = [dict objectForKey:@"holderName"];
        cvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cvc animated:YES];
    }else if ([_str isEqualToString:@"考勤"]){
        
        NSDictionary *dict = self.listArr[indexPath.row];
        
        if ([[dict objectForKey:@"stayOut"] isEqualToString:@"0"]) {
            ClockViewController *vc = [[ClockViewController alloc] init];
            vc.familyNo = [dict objectForKey:@"familyNo"];
            vc.dict = dict;
            vc.status = @"0";
            vc.holderName = [dict objectForKey:@"holderName"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ClockViewController *vc = [[ClockViewController alloc] init];
            vc.familyNo = [dict objectForKey:@"familyNo"];
            vc.dict = dict;
            vc.status = @"1";
            vc.clockbtn.hidden = YES;
            vc.clockview.hidden = YES;
            vc.holderName = [dict objectForKey:@"holderName"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
    }else{
        NSDictionary *dict = self.listArr[indexPath.row];
        RequireViewController *rvc = [[RequireViewController alloc]init];
        rvc.familyNo = [dict objectForKey:@"familyNo"];
        rvc.holderName = [dict objectForKey:@"holderName"];
        rvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rvc animated:YES];
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_str isEqualToString:@"考勤"]){
        return YES;
    }
    return NO;
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除
    UITableViewRowAction *haveRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"设为家中无人" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(30, (zScreenHeight/2)-150, zScreenWidth-60, 300)];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 7;
        backview.backgroundColor = [UIColor whiteColor];
        
        text = [[UITextView alloc]initWithFrame:CGRectMake(10,20, zScreenWidth-60-20, 300-20-49)];
        text.backgroundColor = [UIColor whiteColor];
        text.delegate = self;
        text.returnKeyType = UIReturnKeyDone;
        [backview addSubview:text];
        
        plelab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 20)];
        
        plelab.text = @"请输入家中无人原因...";
        plelab.textColor = [UIColor colorHexString:@"888888"];
        plelab.textAlignment = NSTextAlignmentLeft;;
        [text addSubview:plelab];
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-60-35, 10, 25, 25)];
        [cancel setImage:[UIImage imageNamed:@"popup_close-1"] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        [backview addSubview:cancel];
        
        UIButton *com = [[UIButton alloc]initWithFrame:CGRectMake(0, 300-49, zScreenWidth-60, 49)];
        [com setTitle:@"确定" forState:UIControlStateNormal];
        [com setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [com setBackgroundColor:[UIColor colorHexString:@"fdba44"]];
        com.tag = indexPath.row;
        [com addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [backview addSubview:com];
        
        [LYTBackView showWithView:backview];

        
        NSLog(@"设为家中无人 %ld",(long)indexPath.row);
    }];
    haveRowAction.backgroundColor = [UIColor colorHexString:@"ff9d11"];
    
    //标记为已读
    UITableViewRowAction *noRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消家中无人" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSDictionary *dict = self.listArr[indexPath.row];
        
        NSDictionary *dic = @{@"holderName":[dict objectForKey:@"holderName"],@"familyNo":[dict objectForKey:@"familyNo"]};
        
        [HTTPRequest postWithURL:@"yrycapi/familyinfo/setathome" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"success%@",json);
            [ZJStaticFunction alertView:self.view msg:@"提交成功"];
            [LYTBackView dissMiss];
            [self load];
            
        } error400Code:^(id failure) {
            
        }];
        NSLog(@"取消家中无人 %ld",(long)indexPath.row);
    }];
    noRowAction.backgroundColor = [UIColor colorHexString:@"c7c7c7"];
    
    
    NSDictionary *dict = self.listArr[indexPath.row];
    
    if ([[dict objectForKey:@"stayOut"] isEqualToString:@"0"]) {
        return @[haveRowAction];
    }else if ([[dict objectForKey:@"stayOut"] isEqualToString:@"1"]){
        return @[noRowAction];
    }
    
    
    
    return nil;
    
    

}

- (void)diss{
    [LYTBackView dissMiss];
}

- (void)click:(UIButton *)sender{
    
    NSLog(@"%ld",(long)sender.tag);
    
    NSDictionary *dict = self.listArr[sender.tag];
    
    NSDictionary *dic = @{@"holderName":[dict objectForKey:@"holderName"],@"familyNo":[dict objectForKey:@"familyNo"],@"content":text.text};
    
    if (text.text.length>0) {
        [HTTPRequest postWithURL:@"yrycapi/familyinfo/setstayout" method:@"POST" params:dic ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"success%@",json);
            [ZJStaticFunction alertView:self.view msg:@"提交成功"];
            [LYTBackView dissMiss];
            [self load];
            
        } error400Code:^(id failure) {
            
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
    }
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        
        plelab.alpha = 1;
    } else {
        plelab.alpha = 0;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
