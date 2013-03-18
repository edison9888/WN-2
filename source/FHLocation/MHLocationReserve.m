//
//  LocationReserveTool.m
//  GPSDemo
//
//  Created by 尧 王 on 11-12-17.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import "MHLocationReserve.h"

@implementation MHLocationReserve
@synthesize geoCoder = _geoCoder;
@synthesize locationInfo = _locationInfo;
@synthesize delegate = _delegate;

- (void)dealloc
{
    self.geoCoder = nil;
    self.delegate = nil;
    self.locationInfo = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        if (_locationManager) {
            _locationManager.delegate = nil;
            [_locationManager release];
            _locationManager = nil;
        }
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        _locationManager.distanceFilter = 1000;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
    return self;
}

#pragma mark - 获取城市名称
//  IOS 5.0 及以上版本使用此方法
- (void)locationAddressWithLocation:(CLLocation *)locationGps
{
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    self.geoCoder = clGeoCoder;
    [clGeoCoder release];
    
    [self.geoCoder reverseGeocodeLocation:locationGps completionHandler:^(NSArray *placemarks, NSError *error) 
     {
         NSLog(@"error %@ placemarks count %d",error.localizedDescription,placemarks.count);
         for (CLPlacemark *placeMark in placemarks) 
         {
             NSString *thoroughfare = placeMark.thoroughfare; // street address, eg. 1 Infinite Loop
             NSString *locality = placeMark.locality; // city, eg. Cupertino
             NSString *subLocality = placeMark.subLocality; // neighborhood, common name, eg. Mission District
             NSString *administrativeArea = placeMark.administrativeArea; // state, eg. CA
             NSString *postalCode = placeMark.postalCode; // zip code, eg. 95014
             NSString *ISOcountryCode = placeMark.ISOcountryCode; // eg. US
             NSString *country = placeMark.country; // eg. United States
             
             _locationInfo.ZipCode = postalCode;
             _locationInfo.Country = country;
             _locationInfo.CountryCode = ISOcountryCode;
             _locationInfo.Area = administrativeArea;
             _locationInfo.Address = [NSString stringWithFormat:@"%@%@%@%@",administrativeArea,locality,subLocality,thoroughfare];
             _locationInfo.Locality = locality;
             _locationInfo.Thoroughfare = thoroughfare;
             _locationInfo.lat = _coordinate.latitude;
             _locationInfo.lng = _coordinate.longitude;
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(locationReserveToolSuccess:)]) {
                 [self.delegate locationReserveToolSuccess:self.locationInfo];
             }
         }
     }];
}


#pragma mark - location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位出错");
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationReservetoolFailed)]) {
        [self.delegate locationReservetoolFailed];
    }
}

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    if (!newLocation) {
        [self locationManager:manager didFailWithError:(NSError *)NULL];
        return;
    }
    
    if (signbit(newLocation.horizontalAccuracy)) {
		[self locationManager:manager didFailWithError:(NSError *)NULL];
		return;
	}
    
    //[manager stopUpdatingLocation];
    
    if (_locationInfo) {
        [_locationInfo release];
        _locationInfo=nil;
    }
    _locationInfo = [[MHLocationInfo alloc] init];
    
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    _coordinate.latitude = newLocation.coordinate.latitude;
    _coordinate.longitude = newLocation.coordinate.longitude;
    
    //解析并获取当前坐标对应得地址信息
    [self locationAddressWithLocation:newLocation];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//        
//    }else {
//        [self startedReverseGeoderWithLatitude:newLocation.coordinate.latitude 
//                                     longitude:newLocation.coordinate.longitude];
//    }
}

@end
