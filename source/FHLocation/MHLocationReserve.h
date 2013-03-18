//
//  LocationReserveTool.h
//  GPSDemo
//
//  Created by 尧 王 on 11-12-17.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHLocationInfo.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@protocol MHLocationReserveDelegate <NSObject>

/**
 ** 备用定位成功
 ** @param LocationInfo 定位对象
 ** 
 **/
- (void)locationReserveToolSuccess:(MHLocationInfo *)locationInfo;

/**
 ** 备用定位失败
 ** 
 **/
- (void)locationReservetoolFailed;

@end

@interface MHLocationReserve : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLLocationCoordinate2D _coordinate;
    
    //5.0及以上版本解析GPS位置
    CLGeocoder *_geoCoder;
    
    id<MHLocationReserveDelegate> _delegate;
    
    MHLocationInfo *_locationInfo;
}

@property (nonatomic, retain) CLGeocoder *geoCoder;
@property (nonatomic, retain) MHLocationInfo *locationInfo;
@property (nonatomic, assign) id<MHLocationReserveDelegate> delegate;


@end
