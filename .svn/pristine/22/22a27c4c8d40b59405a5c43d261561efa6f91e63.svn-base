//
//  HelpDynamicViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/27.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "HelpDynamicViewController.h"
#import "PhotosController.h"
#import "PhotoCollectionViewCell.h"

@interface HelpDynamicViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PhotosControllerDelegate>{
    UITextView *text;
    UILabel *pleLabel;
    UICollectionView *collview;
    NSMutableArray *arr;
}

@end

@implementation HelpDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮扶动态";
    [self createBarLeftWithImage:@"nav_return"];
    
    NSArray *imgarr = @[[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"]];
    
    arr = [NSMutableArray arrayWithArray:imgarr];
    
    self.view.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    
    text = [[UITextView alloc]initWithFrame:CGRectMake(0, zNavigationHeight+10, zScreenWidth, 150)];
    text.backgroundColor = [UIColor whiteColor];
    text.delegate = self;
    text.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:text];
    
    pleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
    
    pleLabel.text = @"说点什么吧......";
    pleLabel.textColor = [UIColor colorHexString:@"88888888"];
    pleLabel.textAlignment = NSTextAlignmentLeft;;
    [text addSubview:pleLabel];
    
    UILabel *photeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, text.frame.origin.y+150+13, 200, 20)];
    photeLabel.textAlignment = NSTextAlignmentLeft;
    photeLabel.textColor = [UIColor colorHexString:@"888888"];
    photeLabel.text = @"上传照片（最多4张）";
    [self.view addSubview:photeLabel];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置行间距
    layout.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake((zScreenWidth-50)/4,(zScreenWidth-50)/4);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, text.frame.origin.y+150+50, zScreenWidth-10, (zScreenWidth-50)/4+10) collectionViewLayout:layout];
    collview.backgroundColor = [UIColor clearColor];
    collview.dataSource = self;
    collview.delegate = self;
    [collview registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self.view addSubview:collview];
    
    UIButton *comBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, text.frame.origin.y+150+150, zScreenWidth-40, 44)];
    comBtn.layer.masksToBounds = YES;
    comBtn.layer.cornerRadius = 4;
    comBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [comBtn setTitle:@"上传" forState:UIControlStateNormal];
    [comBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comBtn addTarget:self action:@selector(com) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:comBtn];
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


- (void)pick:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
}

- (void)com{
    NSLog(@"com");
    NSArray *temparr = [NSArray arrayWithArray:arr];
    NSMutableArray *temparr2 = [NSMutableArray arrayWithArray:arr];
    for (id image in temparr) {
        if ([image isEqual:[UIImage imageNamed:@"dynamic_add+"]]) {
            [temparr2 removeObject:image];
        }
    }
    
    if (temparr2.count== 0) {
        [ZJStaticFunction alertView:self.view msg:@"请先选择图片"];
    }
    
    NSLog(@"%ld",temparr2.count);
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        pleLabel.alpha = 1;
    } else {
        pleLabel.alpha = 0;
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
