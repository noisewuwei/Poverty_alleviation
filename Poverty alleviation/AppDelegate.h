//
//  AppDelegate.h
//  Poverty alleviation
//
//  Created by 吴畏 on 2017/12/26.
//  Copyright © 2017年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic) CLLocationManager *locationManager;


@end

