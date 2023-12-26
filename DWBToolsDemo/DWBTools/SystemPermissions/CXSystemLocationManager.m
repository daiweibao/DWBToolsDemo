//
//  CXSystemLocationManager.m
//  aaa
//
//  Created by 季文斌 on 2023/12/26.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//原文链接：https://blog.csdn.net/m0_55124878/article/details/123112088

#import "CXSystemLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "CXAuthorityManager.h"

//首先要Info里添加两个键值对，向用户请求位置服务时会显示在这里设置的值的内容。
//
//<key>NSLocationWhenInUseUsageDescription</key>
//<value>使用程序的时候获取本机位置</value>
//
//<key>NSLocationAlwaysUsageDescription</key>
//<value>总是获取本机位置</value>


@interface CXSystemLocationManager()<CLLocationManagerDelegate>

//设置一个定位管理者：CLLocationManager实例必须是全局的变量，否则授权提示弹框会一闪而过，不会一直显示。
@property (nonatomic, strong) CLLocationManager *locationManager;

//如果你只想获取当前经纬度坐标的话定义一个这个就足够了，若是你还想获取当前位置的更多信息那么你还需要再设置一个下面这个属性：
//存储推算出当前位置的地理信息
//这个属性用于获取通过当前位置坐标推算出来的更多的位置信息，比如市、区、名字等等。
@property (nonatomic, strong) CLGeocoder *geoCoder;


@end

@implementation CXSystemLocationManager

+(instancetype)shareManager{
    static CXSystemLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CXSystemLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.longitudeString = @"";
        self.latitudeString = @"";
    }
    return self;
}

//开始定位
- (void)startLocation {
    [CXAuthorityManager requestLocationManagerWithResult:^(BOOL granted) {
        if (granted==YES) {
            //有定位权限
            [self loadataLocationData];
        }
    }];
}

//定位管理者
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        //精确度获取到米
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return _locationManager;
}

//地理信息
-(CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder =[[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

//请求化定位数据
- (void)loadataLocationData{
    //开始获取定位
    [self.locationManager startUpdatingLocation];
}


/*
CLLocationManager其相关的属性：

desiredAccuracy位置的精度属性，取值有如下几种：

kCLLocationAccuracyBest    精确度最佳
kCLLocationAccuracynearestTenMeters    精确度10m以内
kCLLocationAccuracyHundredMeters    精确度100m以内
kCLLocationAccuracyKilometer    精确度1000m以内
kCLLocationAccuracyThreeKilometers    精确度3000m以内
*/


//设置获取位置信息的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation * myLocation = locations.lastObject;//获取最后一个定位位置数据
    NSLog(@"系统定位成功：经度：%f 纬度：%f", myLocation.coordinate.longitude, myLocation.coordinate.latitude);
    //经度记录
    self.longitudeString = [NSString stringWithFormat:@"%f",myLocation.coordinate.longitude];
    //纬度记录
    self.latitudeString = [NSString stringWithFormat:@"%f",myLocation.coordinate.latitude];
    
    //通过坐标来推算该位置的相关信息
    [self.geoCoder reverseGeocodeLocation:myLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%@", placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            // 位置名
            NSLog(@"name, %@", placemark.name);
            // 街道
            NSLog(@"thoroughfare, %@", placemark.thoroughfare);
            // 子街道
            NSLog(@"subThoroughfare, %@", placemark.subThoroughfare);
            // 市
            NSLog(@"locality, %@", placemark.locality);
            // 区
            NSLog(@"subLocality, %@", placemark.subLocality);
            // 国家
            NSLog(@"country, %@", placemark.country);
        } else if (error == nil && [placemarks count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //不用的时候关闭更新位置服务，不关闭的话这个 delegate 隔一定的时间间隔就会有回调
    [self.locationManager stopUpdatingLocation];
}

//问题函数
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"系统定位出错：error:%ld", (long)error.code);
    }
}



@end
