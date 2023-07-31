//
//  MineViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/13.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "MineTableViewCell.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "PhotosController.h"
#import "TrueMessViewController.h"
#import "WriteLeaderViewController.h"
#import "LeaderInfoViewController.h"
#import "ChangePasswordViewController.h"
#import "PostAdviceViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,PhotosControllerDelegate>{
    UITableView *tableview;
    UIButton *headBtn;
    UILabel *nameLabel;
    UIImageView *headImg;
}

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
//
//    if ([dic objectForKey:@"picUrl"]) {
//        [headBtn sd_setImageWithURL:[dic objectForKey:@"picUrl"] forState:UIControlStateNormal];
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    self.title = @"我";
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStyleGrouped];
//    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    
    [self.view addSubview:tableview];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, zScreenHeight-zNavigationHeight-zToolBarHeight-60, zScreenWidth, 60)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    label.textColor = [UIColor colorHexString:@"cccccc"];
    label.text = @"Copyright© 2018 \n 遵义院士工作中心 中科有数 中科禹贡 \n版权所有";
    [tableview addSubview:label];
    
    
    // Do any additional setup after loading the view.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 83+7;
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    NSArray *arr2 = @[@"系统使用说明",@"所在单位扶贫挂帮分管领导",@"修改密码"];
    
    NSArray *arr2 = @[@"所在单位扶贫挂帮分管领导",@"修改密码",@"意见反馈"];
    
    NSArray *imgArr2 = @[@"myself_icon1",@"myself_leader",@"myself_icon2"];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            cell.firstLabel.text = arr2[indexPath.row];
            cell.firstImg.image = [UIImage imageNamed:imgArr2[indexPath.row]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
//             UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 54)];
//
//            label.textAlignment = NSTextAlignmentCenter;
//            label.textColor = [UIColor colorHexString:@"ff5443"];
//            label.text = @"退出登录";
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 54)];
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorHexString:@"ff5443"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
            [btn addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            
            
            
//            [btn setTitle:@"推出登录" forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor colorHexString:@"ff5443"] forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(loginout:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn];
        }

        
        
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    MethodViewController *vc = [[MethodViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            LeaderInfoViewController *lvc = [[LeaderInfoViewController alloc]init];
            lvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lvc animated:YES];
        }else if (indexPath.row == 1){
            ChangePasswordViewController *cvc = [[ChangePasswordViewController alloc]init];
            cvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cvc animated:YES];
        }else if (indexPath.row == 2){
            PostAdviceViewController *pvc = [[PostAdviceViewController alloc]init];
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pvc animated:YES];
        }
        
    }else{
        

    }
    
}

- (void)loginout{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"确认退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *lgvc = [[LoginViewController alloc] init];
        [self presentViewController:lgvc animated:YES completion:nil];
        
        [ZJStoreDefaults removeObjectForKey:@"userinfo"];
        [ZJStoreDefaults removeObjectForKey:@"headimg"];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel");
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:^{
        NSLog(@"alert");
    }];
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    UIImageView *headImg;
    UIView *backView;
    
    if (headerView == nil) {
        
        if (section == 0) {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
            
            backView = [[UIView alloc]initWithFrame:CGRectMake(0, 7, zScreenWidth, 82)];
            backView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:backView];
            
//            headImg = [[UIImageView alloc]initWithFrame:CGRectMake(23, 9, 65, 65)];
//            headImg.backgroundColor = [UIColor blackColor];
//            [backView addSubview:headImg];
            
            nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.origin.x+65+30, 26.5, 100, 30)];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.textColor = [UIColor colorHexString:@"6d6d6d"];
            
            
            headBtn = [[UIButton alloc]initWithFrame:CGRectMake(23, 9, 65, 65)];
            headBtn.backgroundColor = [UIColor blackColor];
            [backView addSubview:headBtn];
            headBtn.layer.masksToBounds = YES;
            headBtn.layer.cornerRadius = 32.5;
            [headBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
            
            
            [backView addSubview:nameLabel];
            
            [self load];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
            
            
        }
        
    }
    
    return headerView;
}

- (void)load{
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    nameLabel.text = [dic objectForKey:@"userName"];
    NSLog(@"%@",[dic objectForKey:@"picUrl"]);
    
    if ([ZJStoreDefaults getObjectForKey:@"headimg"]) {
        UIImage *image = [ZJStoreDefaults getObjectForKey:@"headimg"];
        [headBtn setImage:image forState:UIControlStateNormal];
    }else if([[dic objectForKey:@"picUrl"] isEqualToString:@"无头像"]){
        [headBtn setImage:[UIImage imageNamed:@"head_head"] forState:UIControlStateNormal];
        NSLog(@"hhh");
        
    }else if([dic objectForKey:@"picUrl"]){
        [headBtn sd_setImageWithURL:[dic objectForKey:@"picUrl"] forState:UIControlStateNormal];
    }
    
}


- (void)change{
    NSLog(@"change");
    PhotosController *vc = [[PhotosController alloc] init];
    vc.title = @"相册";
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray indexrow:(NSString *)rowstr {
    NSLog(@"图片：%ld",imagesArray.count);
    if (imagesArray.count>1) {
        [ZJStaticFunction alertView:self.view msg:@"只能选一张图片"];
    }else if(imagesArray.count==1){
        
        UIImage *image = [self getSubImage:imagesArray[0] mCGRect:CGRectMake(0, 0, imagesArray[0].size.width, imagesArray[0].size.width) centerBool:YES];
        
        NSMutableArray *arr = [NSMutableArray arrayWithObject:image];
        
        
        [HTTPRequest postWithURL:@"yrycapi/user/changeicon" method:@"POST" params:nil filePathAndKey:@{@"files":arr} ProgressHUD:nil controller:self response:^(id json) {
            NSLog(@"%@",json);
            [headBtn setImage:image forState:UIControlStateNormal];
            [ZJStoreDefaults setObject:image forKey:@"headimg"];
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请选择图片"];
    }
    
}

- (UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect
             centerBool:(BOOL)centerBool{
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgWidth = image.size.width;
    float imgHeight = image.size.height;
    float viewWidth = mCGRect.size.width;
    float viewHidth = mCGRect.size.height;
    CGRect rect;
    if(centerBool){
        rect = CGRectMake((imgWidth-viewWidth)/2,(imgHeight-viewHidth)/2,viewWidth,viewHidth);
    }else{
        if(viewHidth < viewWidth){
            if(imgWidth <= imgHeight){
                rect = CGRectMake(0, 0, imgWidth, imgWidth*imgHeight/viewWidth);
            }else{
                float width = viewWidth*imgHeight/viewHidth;
                float x = (imgWidth - width)/2;
                if(x > 0){
                    rect = CGRectMake(x, 0, width, imgHeight);
                }else{
                    rect = CGRectMake(0, 0, imgWidth, imgWidth*viewHidth/viewWidth);
                }
            }
        }else{
            if(imgWidth <= imgHeight){
                float height = viewHidth*imgWidth/viewWidth;
                if(height < imgHeight){
                    rect = CGRectMake(0,0, imgWidth, height);
                }else{
                    rect = CGRectMake(0,0, viewWidth*imgHeight/viewHidth,imgHeight);
                }
            }else{
                float width = viewWidth * imgHeight / viewHidth;
                if(width < imgWidth){
                    float x = (imgWidth - width)/2;
                    rect = CGRectMake(x,0,width, imgHeight);
                }else{
                    rect = CGRectMake(0,0,imgWidth, imgHeight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0,0,CGImageGetWidth(subImageRef),CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (void)showRight:(UIButton *)sender{
    TrueMessViewController *tvc = [TrueMessViewController alloc];
    tvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tvc animated:YES];
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
