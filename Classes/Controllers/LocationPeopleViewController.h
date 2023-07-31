//
//  LocationPeopleViewController.h
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/5/31.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationPeopleViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *localManager;

@end
