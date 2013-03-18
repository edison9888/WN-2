//
//  LocationModule.h
//  CoolFinder
//
//  Created by  falcon on 10-6-14.
//  Modify by wangyao on 11-12-17 （由于google有时无法访问，所以这里在访问失败得使用备用定位类进行定位）
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MHLocationInfo.h"
#import "MHLocationReserve.h"
#import <MapKit/MapKit.h>

@protocol MHLocationDelegate<NSObject>
@required
@optional
//获取位置信息失败
-(void)LocationModuleFailWithError:(NSError *)error;
//获得的gps信息
-(void)LocationModuleUpdateToLocation:(float)lat lng:(float)lng;
//从gps获取详细信息完成
-(void)LocationModuleInfoToLocation:(MHLocationInfo *)info;
-(void)LocationModuleUpdateHeading:(float)Heading;

-(void)AddressModuleUpdateToLocation:(float)lat lng:(float)lng;
//自定义位置获得详细信息完成
-(void)AddressModuleInfoToLocation:(MHLocationInfo *)info;
@end

@interface MHLocation : NSObject <MKMapViewDelegate,CLLocationManagerDelegate,MHLocationReserveDelegate>{
    MKMapView                          *mapView;
	//CLLocationManager                  *locationManager;
	CLLocationCoordinate2D             coordinate;
	id<MHLocationDelegate>         _delegate;
	
	
	NSURLConnection                 *_conn;
	NSMutableURLRequest             *_request;
	NSHTTPURLResponse               *_response;
	NSURLAuthenticationChallenge    *_challenge;
	NSURLCredential                 *_credential;
	NSMutableData                   *_databuf;
    
    int                             _type;
    
    //wangyao 11-12-17
    //MHLocationReserve *_locationReserveTool;
    
}
@property (nonatomic, retain) NSMutableData* _databuf;
@property (nonatomic, assign) CLLocationCoordinate2D    coordinate;

- (void)setGetCurrectLocation:(BOOL)state;
-(id)init:(id)delegate;

-(void)StartSearchGoogleByAddress:(NSString *)Address;

- (void)setDelegate:(id)dele;

-(BOOL)ParseAddressDataBuf;
-(BOOL)ParseLocationDataBuf; 

@end
