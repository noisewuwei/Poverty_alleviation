//
//  ClockViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ClockViewController.h"
#import "LYTBackView.h"
#import "HelpDynamicViewController.h"
#import "StatisticsViewController.h"
#import "PhotosController.h"
#import "PhotoCollectionViewCell.h"
#import "DetectionViewController.h"

@interface ClockViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PhotosControllerDelegate,UITextViewDelegate>{
    UILabel *second;
    NSTimer *timeNow;
    
    NSString *firstStr;
    NSString *secondStr;
    
    NSString *longi;
    NSString *lati;
    
    UIView *hiddenview;
    UIButton *writeBtn;
    UIView *hiddenView2;
    
    UIView *backview;
    UIButton *clockBtn;
    
    UIView *hiddenView3;
    
    UITextView *text;
    UILabel *pleLabel;
    UICollectionView *collview;
    NSMutableArray *arr;
    
    UILabel *timeLabel;
    UILabel *locaLbael;
    
    UILabel *helpLabel;
    
    UIImageView *Img1;
    UIImageView *Img2;
    UIImageView *Img3;
    UIImageView *Img4;
    
    NSMutableArray *ImgArr;
    NSMutableArray *dataImgArr;
    
    NSString *timeStr;
    NSString *addStr;
    NSString *conStr;
    
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UILabel *houseLabel;
    UIImageView *headImg;
    
    
}

@end

@implementation ClockViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    nameLabel.text = [NSString stringWithFormat:@"户主:%@",[_dict objectForKey:@"holderName"]];
    phoneLabel.text = [NSString stringWithFormat:@"联系方式:%@",[_dict objectForKey:@"masterPhone"]];
    houseLabel.text = [NSString stringWithFormat:@"家庭住址:%@",[_dict objectForKey:@"address"]];
    [headImg sd_setImageWithURL:[_dict objectForKey:@"familyIcon"]];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSArray *imgarr = @[[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"],[UIImage imageNamed:@"dynamic_add+"]];
    
    arr = [NSMutableArray arrayWithArray:imgarr];
    
    
    self.title = @"考勤打卡";
    [self createBarLeftWithImage:@"nav_return"];
    [self createRightTitle:@"统计" titleColor:[UIColor blackColor]];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    scrollView.contentSize = CGSizeMake(zScreenWidth, zScreenHeight*2-300);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview: scrollView];
    
    headImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 80, 80)];
    headImg.contentMode = UIViewContentModeScaleAspectFit;
    headImg.backgroundColor = [UIColor blackColor];
    
    [scrollView addSubview:headImg];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImg.frame.origin.x+109+10, 20, zScreenWidth-130, 20)];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:nameLabel];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y+20+10, 10, 10)];
    phoneImg.contentMode = UIViewContentModeCenter;
    phoneImg.image = [UIImage imageNamed:@"list_photo"];
    [scrollView addSubview:phoneImg];
    
    UIImageView *houseImg = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, phoneImg.frame.origin.y+20, 10, 10)];
    houseImg.contentMode = UIViewContentModeCenter;
    houseImg.image = [UIImage imageNamed:@"list_adress"];
    [scrollView addSubview:houseImg];
    
    phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImg.frame.origin.x+15, phoneImg.frame.origin.y-2.5, zScreenWidth-150, 15)];
    phoneLabel.font = [UIFont systemFontOfSize:12];
    phoneLabel.textColor = [UIColor colorHexString:@"888888"];
    [scrollView addSubview:phoneLabel];
    
    houseLabel = [[UILabel alloc]initWithFrame:CGRectMake(houseImg.frame.origin.x+15, houseImg.frame.origin.y-2.5, zScreenWidth-150, 15)];
    houseLabel.font = [UIFont systemFontOfSize:10];
    houseLabel.textColor = [UIColor colorHexString:@"888888"];
    [scrollView addSubview:houseLabel];
    
//    nameLabel.text = [NSString stringWithFormat:@"户主:%@",[_dict objectForKey:@"holderName"]];
//    phoneLabel.text = [NSString stringWithFormat:@"联系方式:%@",[_dict objectForKey:@"masterPhone"]];
//    houseLabel.text = [NSString stringWithFormat:@"家庭住址:%@",[_dict objectForKey:@"address"]];
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 104, zScreenWidth, 252)];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.clipsToBounds = YES;
    
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    
    [self.localManager startUpdatingLocation];
    
    [scrollView addSubview:self.mapView];
    
    backview = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-65, 252/2-65, 130, 130)];
    backview.layer.masksToBounds = YES;
    backview.layer.cornerRadius = 65;
    backview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.mapView addSubview:backview];
    
    clockBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-57.5, 252/2-57.5, 115, 115)];
    clockBtn.layer.masksToBounds = YES;
    clockBtn.layer.cornerRadius = 57.5;
    clockBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.mapView addSubview:clockBtn];
    
    UILabel *first = [[UILabel alloc]initWithFrame:CGRectMake(5, 57.5-15, 115-10, 15)];
    first.textAlignment = NSTextAlignmentCenter;
    first.textColor = [UIColor whiteColor];
    first.font = [UIFont systemFontOfSize:12];
    first.text = @"考勤定位打卡";
    [clockBtn addSubview:first];
    
    second = [[UILabel alloc]initWithFrame:CGRectMake(5, 57.5, 115-10, 15)];
    second.textAlignment = NSTextAlignmentCenter;
    second.textColor = [UIColor whiteColor];
    second.font = [UIFont systemFontOfSize:12];
    timeNow = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeUpdate) userInfo:nil repeats:YES];
    [clockBtn addSubview:second];
    
    [clockBtn addTarget:self action:@selector(clock) forControlEvents:UIControlEventTouchUpInside];
    
    hiddenview = [[UIView alloc]initWithFrame:CGRectMake(0, self.mapView.frame.origin.y+252, zScreenWidth, 50)];
    hiddenview.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:hiddenview];
    
    hiddenview.hidden = YES;
    
    UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 15, 15)];
    timeImg.contentMode = UIViewContentModeCenter;
    timeImg.image = [UIImage imageNamed:@"count_times"];
    [hiddenview addSubview:timeImg];
    
    UIImageView *locaImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, timeImg.frame.origin.y+15+5, 15, 15)];
    locaImg.contentMode = UIViewContentModeCenter;
    locaImg.image = [UIImage imageNamed:@"count_Location2"];
    [hiddenview addSubview:locaImg];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeImg.frame.origin.x+15+5, timeImg.frame.origin.y, zScreenWidth-50, 15)];
    timeLabel.textColor = [UIColor colorHexString:@"888888"];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [hiddenview addSubview:timeLabel];
    
//    timeLabel.text = @"打开时间：2017.08.02 14.01.06";
    
    locaLbael = [[UILabel alloc]initWithFrame:CGRectMake(locaImg.frame.origin.x+15+5, locaImg.frame.origin.y, zScreenWidth-50, 15)];
    locaLbael.textColor = [UIColor colorHexString:@"888888"];
    locaLbael.textAlignment = NSTextAlignmentLeft;
    locaLbael.font = [UIFont systemFontOfSize:12];
    [hiddenview addSubview:locaLbael];
    
//    locaLbael.text = @"定位地点：汇川区芝麻镇芝麻村长虹路";
    
//    writeBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-98, hiddenview.frame.origin.y+50+30, 196, 49)];
//    writeBtn.layer.masksToBounds = YES;
//    writeBtn.layer.cornerRadius = 4;
//    writeBtn.layer.borderColor = [[UIColor colorHexString:@"fdba44"]CGColor];
//    writeBtn.layer.borderWidth = 1;
//    writeBtn.backgroundColor = [UIColor whiteColor];
//    [writeBtn setTitle:@"填写帮扶动态" forState:UIControlStateNormal];
//    [writeBtn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateNormal];
//    [writeBtn addTarget:self action:@selector(writesomething) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:writeBtn];
    
    writeBtn.hidden = YES;
    
    hiddenView2 = [[UIView alloc]initWithFrame:CGRectMake(0, hiddenview.frame.origin.y+50, zScreenWidth, 130)];
    hiddenView2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:hiddenView2];
    
    hiddenView2.hidden = YES;
    
    UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 15, 15)];
    helpImg.contentMode = UIViewContentModeCenter;
    helpImg.image = [UIImage imageNamed:@"count_dynamic"];
    [hiddenView2 addSubview:helpImg];
    
    helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(helpImg.frame.origin.x+15+5, helpImg.frame.origin.y, zScreenWidth-50, 30)];
    helpLabel.numberOfLines = 0;
    helpLabel.textColor = [UIColor colorHexString:@"888888"];
//    helpLabel.textAlignment = NSTextAlignmentLeft;
    helpLabel.textAlignment = NSTextAlignmentNatural;
    helpLabel.font = [UIFont systemFontOfSize:12];
//    [helpLabel sizeToFit];
    [hiddenView2 addSubview:helpLabel];
    
//    helpLabel.text = @"帮扶动态：赠送生活物资和小鸡仔30只，了解疾病状况会啊UI啊白金卡比较卡即可别喝酒啊比较好";
    
//    for (int i=0; i<4; i++) {
//        Img = [[UIImageView alloc]initWithFrame:CGRectMake(10+((zScreenWidth-50)/4+10)*i, 5+40, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
//        Img.layer.masksToBounds = YES;
//        Img.layer.cornerRadius = 4;
//        Img.tag = i;
//        Img.backgroundColor = [UIColor blackColor];
//        [hiddenView2 addSubview:Img];
//    }
    
    Img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5+40, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
    Img1.layer.masksToBounds = YES;
    Img1.layer.cornerRadius = 4;
    Img1.backgroundColor = [UIColor clearColor];
    [hiddenView2 addSubview:Img1];

    Img2 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4+10, 5+40, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
    Img2.layer.masksToBounds = YES;
    Img2.layer.cornerRadius = 4;
    Img2.backgroundColor = [UIColor clearColor];
    [hiddenView2 addSubview:Img2];

    Img3 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*2+10*2, 5+40, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
    Img3.layer.masksToBounds = YES;
    Img3.layer.cornerRadius = 4;
    Img3.backgroundColor = [UIColor clearColor];
    [hiddenView2 addSubview:Img3];

    Img4 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*3+10*3, 5+40, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
    Img4.layer.masksToBounds = YES;
    Img4.layer.cornerRadius = 4;
    Img4.backgroundColor = [UIColor clearColor];
    [hiddenView2 addSubview:Img4];
    
    hiddenView3 = [[UIView alloc]initWithFrame:CGRectMake(0, hiddenView2.frame.origin.y, zScreenWidth, 420)];
    hiddenView3.backgroundColor = [UIColor whiteColor];
    
    [scrollView addSubview:hiddenView3];
    
    hiddenView3.hidden = YES;
    
    text = [[UITextView alloc]initWithFrame:CGRectMake(20,10, zScreenWidth-40, 150)];
    text.backgroundColor = [UIColor whiteColor];
    text.layer.masksToBounds = YES;
    text.layer.cornerRadius = 4;
    text.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    text.layer.borderWidth = 0.5;
    text.delegate = self;
    text.returnKeyType = UIReturnKeyDone;
    [hiddenView3 addSubview:text];
    
    pleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
    
    pleLabel.text = @"说点什么吧......";
    pleLabel.textColor = [UIColor colorHexString:@"888888"];
    pleLabel.textAlignment = NSTextAlignmentLeft;;
    [text addSubview:pleLabel];
    
    UILabel *photeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, text.frame.origin.y+150+13, 200, 20)];
    photeLabel.textAlignment = NSTextAlignmentLeft;
    photeLabel.textColor = [UIColor colorHexString:@"888888"];
    photeLabel.text = @"上传照片（最多4张）";
    [hiddenView3 addSubview:photeLabel];
    
    UILabel *tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(20, photeLabel.frame.origin.y+20+13, zScreenWidth-40, 40)];
    tiplabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    tiplabel.backgroundColor = [UIColor colorHexString:@"f5f5f5"];
    tiplabel.layer.masksToBounds = YES;
    tiplabel.layer.cornerRadius = 3;
    tiplabel.layer.borderWidth = 0.5;
    tiplabel.layer.borderColor = [[UIColor colorHexString:@"e1e1e1"] CGColor];
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.textColor = [UIColor colorHexString:@"585858"];
    tiplabel.text = @" 提醒：请上传标准的考核图片，如贫困户确认签字表等。";
    [hiddenView3 addSubview:tiplabel];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置行间距
    layout.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake((zScreenWidth-50)/4,(zScreenWidth-50)/4);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, text.frame.origin.y+150+50+13+40, zScreenWidth-10, (zScreenWidth-50)/4+10) collectionViewLayout:layout];
    collview.backgroundColor = [UIColor clearColor];
    collview.dataSource = self;
    collview.delegate = self;
    [collview registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [hiddenView3 addSubview:collview];
    
    UIButton *comBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, text.frame.origin.y+150+150+60, zScreenWidth-40, 44)];
    comBtn.layer.masksToBounds = YES;
    comBtn.layer.cornerRadius = 4;
    comBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [comBtn setTitle:@"上传" forState:UIControlStateNormal];
    [comBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hiddenView3 addSubview:comBtn];
    [comBtn addTarget:self action:@selector(com) forControlEvents:UIControlEventTouchUpInside];
    
    _clockbtn = clockBtn;
    _clockview = backview;
    
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

- (void)com{
    
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
    
    if (text.text.length>0 && ImgArr.count>0 ) {
        NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"longitude":longi,@"latitude":lati,@"positionAddress":[NSString stringWithFormat:@"%@%@",firstStr,secondStr],@"content":text.text};
        NSLog(@"应该做网络请求");
        [HTTPRequest postWithURL:@"yrycapi/signinrecord/signin" method:@"POST" params:dic filePathAndKey:@{@"files":ImgArr} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"%@",json);
            helpLabel.text = [NSString stringWithFormat:@"帮扶动态:%@ \n",text.text];
            hiddenView2.hidden = NO;
            hiddenView3.hidden = YES;
            
            backview.hidden = YES;
            clockBtn.hidden = YES;

            if (ImgArr.count == 1) {
                Img1.image = ImgArr[0];
            }else if (ImgArr.count == 2){
                Img1.image = ImgArr[0];
                Img2.image = ImgArr[1];
            }else if (ImgArr.count == 3){
                Img1.image = ImgArr[0];
                Img2.image = ImgArr[1];
                Img3.image = ImgArr[2];
            }else{
                Img1.image = ImgArr[0];
                Img2.image = ImgArr[1];
                Img3.image = ImgArr[2];
                Img4.image = ImgArr[3];
            }
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
    }
    
    NSLog(@"%ld",ImgArr.count);
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

- (CLLocationManager *)localManager
{
    if (_localManager == nil)
    {
        _localManager = [[CLLocationManager alloc]init];
        
        //设置定位的精度
        [_localManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //位置信息更新最小距离
        _localManager.distanceFilter = 10;
        _localManager.activityType = CLActivityTypeFitness;
        
        //设置代理
        _localManager.delegate = self;
        
        //        //因为 requestAlwaysAuthorization 是 iOS8 后提出的,需要添加一个是否能响应的条件判断,防止崩溃
        //        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined && [_localManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        //            [_localManager requestAlwaysAuthorization];
        //        }
    }
    return _localManager;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    
//    NSLog(@"%@",[NSString stringWithFormat:@"%f",loc.longitude]);
//    NSLog(@"%@",[NSString stringWithFormat:@"%f",loc.latitude]);
    
    longi = [NSString stringWithFormat:@"%f",loc.longitude];
    lati = [NSString stringWithFormat:@"%f",loc.latitude];
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //反地理编码
    
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //获取地标
        CLPlacemark *placemark=[placemarks firstObject];
        //设置标题
        userLocation.title=placemark.locality;
        //设置子标题
        userLocation.subtitle=placemark.name;
        
        firstStr = placemark.locality;
        secondStr = placemark.name;

        
    }];
    
}

- (void)timeUpdate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *string = [dateFormatter stringFromDate:[NSDate date]];
    
    second.text = string;
}

- (void)clock{
    
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    
    if ([[dic objectForKey:@"openFaceecognition"] isEqualToString: @"true"]) {
        __weak typeof(self) weakSelf = self;
        DetectionViewController* dvc = [[DetectionViewController alloc] init];
        dvc.completion = ^(NSDictionary* images, UIImage* originImage){
            if (images[@"bestImage"] != nil && [images[@"bestImage"] count] != 0) {
                NSData* data = [[NSData alloc] initWithBase64EncodedString:[images[@"bestImage"] lastObject] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                UIImage* bestImage = [UIImage imageWithData:data];
                NSLog(@"bestImage = %@",bestImage);
                
                NSArray *imgarr = @[bestImage];
                
                [HTTPRequest postWithURL:@"yrycapi/signinrecord/checkfaceid" method:@"POST" params:nil filePathAndKey:@{@"files":imgarr} ProgressHUD:nil controller:self response:^(id json) {
                    [weakSelf success];
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                    
                }];
                
                NSString* bestImageStr = [[images[@"bestImage"] lastObject] copy];
                
                
                
            }
        };
        [self presentViewController:dvc animated:YES completion:nil];
    }else{
        [self success];
    }
    
    
    
    
    
}

- (void)success{
    NSLog(@"%@",[NSString stringWithFormat:@"%@,%@",firstStr,secondStr]);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(35, zScreenHeight/2-230, zScreenWidth-70, 460)];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 7;
    backView.backgroundColor = [UIColor colorHexString:@"272534"];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-70-12-24, 12, 24, 24)];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"popup_close"] forState:(UIControlState)UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/2-34, 19, 68, 68)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 34;
    
    
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    
    
    if ([ZJStoreDefaults getObjectForKey:@"headimg"]) {
        UIImage *image = [ZJStoreDefaults getObjectForKey:@"headimg"];
        headImg.image = image;
    }else if([[dic objectForKey:@"picUrl"] isEqualToString:@"无头像"]){
        headImg.image = [UIImage imageNamed:@"head_head"];
    }else if([dic objectForKey:@"picUrl"]){
        [headImg sd_setImageWithURL:[dic objectForKey:@"picUrl"]];
        
    }
    [backView addSubview:headImg];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(backView.frame.size.width/2-50, headImg.frame.origin.y+68+10, 100, 15)];
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.textColor = [UIColor whiteColor];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.text = @"定位地点";
    [backView addSubview:addressLabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, addressLabel.frame.origin.y+15+5, backView.frame.size.width, 50)];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.text = [NSString stringWithFormat:@"%@,%@",firstStr,secondStr];
    contentLabel.numberOfLines = 0;
    [backView addSubview:contentLabel];
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 177, backView.frame.size.width, backView.frame.size.height-177-49)];
    backImg.contentMode = UIViewContentModeCenter;
    backImg.image = [UIImage imageNamed:@"popup_map"];
    [backView addSubview:backImg];
    
    UIButton *reBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, backView.frame.size.height-49, backView.frame.size.width/2-0.5, 49)];
    reBtn.backgroundColor = [UIColor colorHexString:@"fdba44"];
    [reBtn setTitle:@"重新定位" forState:UIControlStateNormal];
    [reBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reBtn addTarget:self action:@selector(reLocation) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:reBtn];
    reBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIButton *conBtn = [[UIButton alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+0.5, backView.frame.size.height-49, backView.frame.size.width/2-0.5, 49)];
    conBtn.backgroundColor = [UIColor colorHexString:@"fdba44"];
    [conBtn setTitle:@"确定打卡" forState:UIControlStateNormal];
    [conBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [conBtn addTarget:self action:@selector(comLocation) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:conBtn];
    conBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [LYTBackView showWithView:backView];
}

- (void)cancel{
    [LYTBackView dissMiss];
}

- (void)reLocation{
    [LYTBackView dissMiss];
}

- (void)comLocation{
    
    [LYTBackView dissMiss];
    
    NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"longitude":longi,@"latitude":lati};
    NSLog(@"%@",dic);
    
//    NSDictionary *dic = @{@"holderName":_holderName,@"familyNo":_familyNo,@"longitude":@"120.941268",@"latitude":@"32.002524"};
    
    [HTTPRequest postWithURL:@"yrycapi/signinrecord/isinthescope" method:@"POST" params:dic ProgressHUD:nil controller:self response:^(id json) {
        NSLog(@"successhhhhh:%@",json);
        
        if ([[json objectForKey:@"isFirstSign"] intValue] == 1) {
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"确定已在正确位置打卡，定位地点审核通过后，后续打卡会以首次定位地点为标准" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if ([[json objectForKey:@"isInTheScope"] intValue] == 1) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *string = [dateFormatter stringFromDate:[NSDate date]];
                    timeLabel.text = [NSString stringWithFormat:@"打卡时间:%@",string];
                    locaLbael.text = [NSString stringWithFormat:@"定位地点:%@%@",firstStr,secondStr];
                    
                    backview.hidden = YES;
                    clockBtn.hidden = YES;

                    hiddenview.hidden = NO;
                    //    writeBtn.hidden = NO;
                    hiddenView3.hidden = NO;
                    //    hiddenView2.hidden = NO;
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"很抱歉，您不在有效打卡范围内，无法打卡" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:^{
                        NSLog(@"alert");
                    }];
                    
                }

            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"Cancel");
            }];

            [alert addAction:cancelAction];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:^{
                NSLog(@"alert");
            }];
            
        }else{
            
            if ([[json objectForKey:@"isInTheScope"] intValue] == 1) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *string = [dateFormatter stringFromDate:[NSDate date]];
                timeLabel.text = [NSString stringWithFormat:@"打卡时间:%@",string];
                locaLbael.text = [NSString stringWithFormat:@"定位地点:%@%@",firstStr,secondStr];
                
                backview.hidden = YES;
                clockBtn.hidden = YES;
                
                hiddenview.hidden = NO;
                //    writeBtn.hidden = NO;
                hiddenView3.hidden = NO;
                //    hiddenView2.hidden = NO;
            }else{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"很抱歉，您不在有效打卡范围内，无法打卡" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:^{
                    NSLog(@"alert");
                }];
                
            }
            
        }
        
        
        
        
    } error400Code:^(id failure) {
        NSLog(@"error:%@",failure);
    }];
    
    
    
}

- (void)writesomething{
    HelpDynamicViewController *hvc = [[HelpDynamicViewController alloc]init];
    [self.navigationController pushViewController:hvc animated:YES];
}


-(void)showRight:(UIButton *)sender{
    StatisticsViewController *svc = [[StatisticsViewController alloc] init];
    svc.FID = _familyNo;
    svc.holderName = _holderName;
    [self.navigationController pushViewController:svc animated:YES];
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
