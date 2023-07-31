//
//  ClockViewController.h
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ClockViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *localManager;
@property (nonatomic,strong) NSString *familyNo;
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSString *holderName;
@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) UIButton *clockbtn;
@property (nonatomic,strong) UIView *clockview;


@end
