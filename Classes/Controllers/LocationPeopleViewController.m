//
//  LocationPeopleViewController.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/5/31.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "LocationPeopleViewController.h"

@interface LocationPeopleViewController (){
    NSString *longi;
    NSString *lati;
    UILabel *label2;
}

@end

@implementation LocationPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"定位";
    
    [self createBarLeftWithImage:@"nav_return"];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
    [self.view addSubview:back];
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 39)];
    backview.backgroundColor = [UIColor colorHexString:@"fbefbe"];
    [back addSubview:backview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-100, 9.5, 200, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorHexString:@"2a2a2a"];
    label.text = @"请到该户家中采集坐标";
    [backview addSubview:label];
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 39, zScreenWidth, 388)];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.clipsToBounds = YES;
    
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    
    [self.localManager startUpdatingLocation];
    
    [self.view addSubview:self.mapView];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(16, 39+388+20, 20, 20)];
    image.image = [UIImage imageNamed:@"count_Location2"];
    image.contentMode = UIViewContentModeCenter;
    [self.view addSubview:image];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(16+20+10, 39+388+20, 100, 20)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = [UIColor colorHexString:@"888888"];
    label1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label.text = @"当前定位";
    [self.view addSubview:label1];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(16+20+10+100, 39+388+20, 200, 20)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.textColor = [UIColor colorHexString:@"888888"];
    label2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
//    label2.text = @"当前定位";
    [self.view addSubview:label2];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorHexString:@"1a2f55"];
    [doneBtn addTarget:self action:@selector(confirme) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

- (void)confirme{
    NSLog(@"confirm");
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
    
    label2.text = [NSString stringWithFormat:@"经度%f  纬度%f",loc.longitude,loc.latitude];
    
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
        
        
    }];
    
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
