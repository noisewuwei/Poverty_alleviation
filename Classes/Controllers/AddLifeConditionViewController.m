//
//  AddLifeConditionViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/6/1.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddLifeConditionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotosController.h"

@interface AddLifeConditionViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PhotosControllerDelegate>{
    UIView *whiteview;
    UITextField *text;
    UIButton *Btn;
    UIButton *Btn2;
    UIButton *Btn3;
    UIButton *Btn4;
    UIButton *Btn5;
    UIButton *Btn6;
    UIButton *Btn7;
    
    NSMutableArray *arr;
    NSMutableArray *ImgArr;
    NSMutableArray *dataImgArr;
    
    UICollectionView *collview;
}

@end

@implementation AddLifeConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *imgarr = @[[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"]];
    
    arr = [NSMutableArray arrayWithArray:imgarr];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor redColor];
    [self.view addSubview:back];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-49-6)];
    scrollView.contentSize = CGSizeMake(zScreenWidth, zScreenHeight*1.7);
    scrollView.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-zNavigationHeight-6-34-49, zScreenWidth, 49)];
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [doneBtn addTarget:self action:@selector(confirme:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 6, zScreenWidth, zScreenHeight*1.7-6)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:whiteview];
    
    
    NSArray *arr = @[@"耕地面积",@"有效灌溉面积",@"林地面积",@"退耕还林面积",@"林果面积",@"牧草地面积",@"水面面积",@"通生产用电",@"与村主干路距离",@"入户路类型",@"通生活用电",@"饮水困难",@"饮水安全",@"主要燃料类型",@"加入农村合作社",@"有无卫生厕所",@"住房面积",@"房屋结构",@"危房户",@"危房级别"];
    
    for (int i=0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+(31+10)*i, 110, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = arr[i];
        
        
        [whiteview addSubview:label];
    }
    
    for (int i = 0; i<7; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28-30, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 500+i;
        [whiteview addSubview:text];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-28-30, 10+(31+10)*i, 30, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"亩";
        
        
        [whiteview addSubview:label];
        
        
    }
    
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-28-30, 10+(31+10)*8, 30, 31)];
    alabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    alabel.textAlignment = NSTextAlignmentRight;
    alabel.textColor = [UIColor colorHexString:@"888888"];
    alabel.backgroundColor = [UIColor whiteColor];
    alabel.text = @"公里";
    
    [whiteview addSubview:alabel];
    
    
    UILabel *blabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-28-30, 10+(31+10)*16, 30, 31)];
    blabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    blabel.textAlignment = NSTextAlignmentRight;
    blabel.textColor = [UIColor colorHexString:@"888888"];
    blabel.backgroundColor = [UIColor whiteColor];
    blabel.text = @"m²";
    
    [whiteview addSubview:blabel];
    
    
    
    for (int i = 8; i<10; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28-30, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 550+i;
        [whiteview addSubview:text];
    }
    
    for (int i = 13; i<14; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28-30, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 600+i;
        [whiteview addSubview:text];
    }
    
    for (int i = 16; i<18; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28-30, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 650+i;
        [whiteview addSubview:text];
    }
    
    for (int i = 19; i<20; i++) {
        text = [[UITextField alloc]initWithFrame:CGRectMake(28+110, 10+(31+10)*i, zScreenWidth-28-110-28-30, 31)];
        text.layer.borderWidth = 0.5;
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
        text.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        //        text.placeholder = @" 请输入具体职务";
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 700+i;
        [whiteview addSubview:text];
    }
    
    NSArray *buttonarr = @[@" 是",@" 否"];
    
    for (int i = 0; i<2; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*7, 100, 31)];
        [Btn setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn.selected = NO;
        Btn.tag = 100+i;
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn];
    }
    
    for (int i = 0; i<2; i++) {
        Btn2 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*10, 100, 31)];
        [Btn2 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn2 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn2 setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn2 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn2.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn2.selected = NO;
        Btn2.tag = 110+i;
        [Btn2 addTarget:self action:@selector(choose2:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn2];
    }
    
    for (int i = 0; i<2; i++) {
        Btn3 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*11, 100, 31)];
        [Btn3 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn3 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn3 setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn3 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn3.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn3.selected = NO;
        Btn3.tag = 120+i;
        [Btn3 addTarget:self action:@selector(choose3:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn3];
    }
    
    for (int i = 0; i<2; i++) {
        Btn4 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*12, 100, 31)];
        [Btn4 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn4 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn4 setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn4 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn4.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn4.selected = NO;
        Btn4.tag = 130+i;
        [Btn4 addTarget:self action:@selector(choose4:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn4];
    }
    
    for (int i = 0; i<2; i++) {
        Btn5 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*14, 100, 31)];
        [Btn5 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn5 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn5 setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn5 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn5.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn5.selected = NO;
        Btn5.tag = 140+i;
        [Btn5 addTarget:self action:@selector(choose5:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn5];
    }
    
    for (int i = 0; i<2; i++) {
        Btn6 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*15, 100, 31)];
        [Btn6 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn6 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn6 setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn6 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn6.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn6.selected = NO;
        Btn6.tag = 150+i;
        [Btn6 addTarget:self action:@selector(choose6:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn6];
    }
    
    for (int i = 0; i<2; i++) {
        Btn7 = [[UIButton alloc]initWithFrame:CGRectMake(28+110+100*i, 10+(31+10)*18, 100, 31)];
        [Btn7 setImage:[UIImage imageNamed:@"information_unselected"] forState:UIControlStateNormal];
        [Btn7 setImage:[UIImage imageNamed:@"information_selected"] forState:UIControlStateSelected];
        
        [Btn7 setTitle:buttonarr[i] forState:UIControlStateNormal];
        [Btn7 setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        Btn7.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        Btn7.selected = NO;
        Btn7.tag = 160+i;
        [Btn7 addTarget:self action:@selector(choose7:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:Btn7];
    }
    
    UIView *secondview = [[UIView alloc]initWithFrame:CGRectMake(0, 10+(31+10)*20 , zScreenWidth, zScreenHeight*1.7-(10+(31+10)*20-10+31+10))];
    [whiteview addSubview:secondview];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 10)];
    lineview.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [secondview addSubview:lineview];
    
//    UILabel *downlabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, 10+27+49+16, 150, 31)];
//    downlabel.textAlignment = NSTextAlignmentCenter;
//    downlabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
//    downlabel.textColor = [UIColor colorHexString:@"fdba45"];
//    downlabel.text = @"添加家庭成员";
//    [secondview addSubview:downlabel];
    
    
    UILabel *photolabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 10+10, 100, 31)];
    photolabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    photolabel.textAlignment = NSTextAlignmentLeft;
    photolabel.textColor = [UIColor colorHexString:@"888888"];
    photolabel.backgroundColor = [UIColor whiteColor];
    photolabel.text = @"上传图片";
    [secondview addSubview:photolabel];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置行间距
    layout.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake((zScreenWidth-50)/4,(zScreenWidth-50)/4);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10+10+31+10, zScreenWidth-10, (zScreenWidth-50)/4+10) collectionViewLayout:layout];
    collview.backgroundColor = [UIColor clearColor];
    collview.dataSource = self;
    collview.delegate = self;
    [collview registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [secondview addSubview:collview];
    
    NSArray *lalalaarr = @[@"家庭合照",@"水源照片",@"房屋照片",@"土地照片"];
    for (int i=0; i<lalalaarr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+((zScreenWidth-50)/4+10)*i, 10+10+31+10+(zScreenWidth-50)/4+10, 80, 31)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorHexString:@"888888"];
        label.backgroundColor = [UIColor whiteColor];
        label.text = lalalaarr[i];


        [secondview addSubview:label];
    }
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.imageview.image = arr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath; {
    PhotosController *vc = [[PhotosController alloc] init];
    //    vc.title = @"相册";
    vc.delegate          = self;
    vc.row = [NSString stringWithFormat:@"%ld",indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray indexrow:(NSString *)rowstr {
    NSLog(@"图片：%ld",imagesArray.count);
    if (imagesArray.count>1) {
        [ZJStaticFunction alertView:self.view msg:@"一次只能选一张图片"];
    }else if(imagesArray.count==1){
        [arr replaceObjectAtIndex:[rowstr intValue] withObject:imagesArray[0]];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请选择图片"];
    }
    
    [collview reloadData];
    
}

- (void)confirme:(UIButton *)sender{
    
    NSArray *temparr = [NSArray arrayWithArray:arr];
    ImgArr = [NSMutableArray arrayWithArray:arr];
    dataImgArr = [NSMutableArray array];
    for (id image in temparr) {
        if ([image isEqual:[UIImage imageNamed:@"dynamic_add+"]]) {
            [ImgArr removeObject:image];
            
        }
    }
    
    if (ImgArr.count== 0) {
        [ZJStaticFunction alertView:self.view msg:@"请先选择图片"];
    }
    
}


- (void)choose:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 100) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (void)choose2:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:110 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 110) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (void)choose3:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:120 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 120) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (void)choose4:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:130 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 130) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (void)choose5:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:140 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 140) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (void)choose6:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:150 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 150) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}

- (void)choose7:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:160 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 160) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
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
