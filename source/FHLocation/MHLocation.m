//
//  LocationModule.m
//  CoolFinder
//
//  Created by  falcon on 10-6-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MHLocation.h" 


@implementation MHLocation

@synthesize _databuf,coordinate;

#define DEFAULT_LOCATION_LAT @"DEFAULT_LOCATION_LAT"
#define DEFAULT_LOCATION_LNG @"DEFAULT_LOCATION_LNG"
#define DEFAULT_LOCATION_LOCATIONINFO @"DEFAULT_LOCATION_LOCATIONINFO_NEWDATA"
#define DEFAULT_TYPE @"DEFAULT_TYPE"

#define SEARCH_LOCATION_URL @"http://maps.google.com/maps/geo?key=ABQIAAAAqqvstZmd8aKTTLOtVS9sUhTiLANGJNleVuWGeDgMZurWT5cGfhSbp6IHrvqX27yZUNscFcGW8rI1Lg&output=json&q="
//ABQIAAAAqqvstZmd8aKTTLOtVS9sUhTiLANGJNleVuWGeDgMZurWT5cGfhSbp6IHrvqX27yZUNscFcGW8rI1Lg
//old:   ABQIAAAAssu_ToMPKRqd-IDkNjwQ9BRsNm_uiy2cFMCJTLVVeZGs_HXOrBTNp-a75WV-iTmrHB7iANhNWC7p-A
-(id)init:(id)delegate{
	if ((self = [super init])) {
        
		_delegate=delegate;
        
        _request=[[NSMutableURLRequest alloc] init];
        [_request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [_request setTimeoutInterval:30];
        
        _databuf=[[NSMutableData alloc] init];
        
        //获取初始值
        float lat = [[[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_LOCATION_LAT] floatValue];
        float lng = [[[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_LOCATION_LNG] floatValue];
        NSData  *info = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_LOCATION_LOCATIONINFO];
        int   lastType = [[[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_TYPE] intValue]; 
        //初始值存在 先传递初始值
        if (info){
            
            coordinate.latitude = lat;
            coordinate.longitude = lng;
            
            [_databuf setLength:0];
            [_databuf appendData:info];
            
            if (lastType==1) {
                [self ParseLocationDataBuf];
            }else if(lastType==2){
                [self ParseAddressDataBuf];
            } 
        }
        
        mapView=[[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        mapView.delegate=self;
        mapView.showsUserLocation=YES;
	}
	return self;
}

- (void)setDelegate:(id)dele{
    _delegate = dele;
}

//设置最新的位置信息到沙箱
- (void)setLastLocationInfo:(float)lat lng:(float)lng info:(NSData *)str type:(int)type{
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:lat] forKey:DEFAULT_LOCATION_LAT];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:lng] forKey:DEFAULT_LOCATION_LNG];
//    [[NSUserDefaults standardUserDefaults] setObject:str forKey:DEFAULT_LOCATION_LOCATIONINFO];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:type] forKey:DEFAULT_TYPE];
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(LocationModuleUpdateToLocation:lng:)]) {
        [_delegate LocationModuleUpdateToLocation:lat lng:lng];
    }
}

#pragma mark -
#pragma mark === Get positon ===
#pragma mark -
-(void)StartSearchGoogleByAddress:(NSString *)Address{
    if(_conn){
        [_conn cancel];
        [_conn release];
        _conn = nil;
    }
    
	[_databuf setLength:0];
    
    Address=[Address stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	NSString *url=[NSString stringWithFormat:@"%@%@",SEARCH_LOCATION_URL,Address];
    [_request setURL:[NSURL URLWithString:url]];
    NSLog(@"用户自定义位置搜索 url:%@",url);
    
    _conn = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
    _type=2;
}

-(void)GetCurrentLocationInfo:(float)lat lng:(float)lng{
    
    if(_conn){
        [_conn cancel];
        [_conn release];
        _conn = nil;
    }
    
	[_databuf setLength:0];
    
	NSString *url=[NSString stringWithFormat:@"%@%f,%f",SEARCH_LOCATION_URL,lat,lng];
    [_request setURL:[NSURL URLWithString:url]];
    NSLog(@"gps %@", url);
    _conn = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
    
    _type=1;
}

-(BOOL)ParseLocationDataBuf{
	NSMutableData *data=nil;
	
	if(self._databuf && self._databuf.length>0){
		data=[[NSMutableData alloc] initWithData:self._databuf];
		
        //尝试三种编码来获取下载到的地址信息
		NSString *returnString = [[NSString alloc] initWithData:data 
                                                       encoding:CFStringConvertEncodingToNSStringEncoding( kCFStringEncodingGB_18030_2000)];
		if(!returnString){
			returnString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
			if(!returnString)
				returnString = [[NSString alloc] initWithData:data
                                                     encoding:NSASCIIStringEncoding];
		}
		
        //数据转码失败
        if (returnString == nil){
            [returnString release];
            [data release];
            return NO;
        }
        
        
		MHLocationInfo  *infolocation=[[MHLocationInfo alloc]init];
		[infolocation ParseData:returnString];
		[infolocation SetCoordinate2D:coordinate.latitude lng:coordinate.longitude];
		
		NSLog(@"ZipCode:%@",infolocation.ZipCode);
		NSLog(@"Country:%@",infolocation.Country);
		NSLog(@"CountryCode:%@",infolocation.CountryCode);
		NSLog(@"Area:%@",infolocation.Area);
		NSLog(@"Address:%@",infolocation.Address);
		NSLog(@"Locality:%@",infolocation.Locality);
		NSLog(@"Thoroughfare:%@",infolocation.Thoroughfare);
		NSLog(@"latitude:%f",infolocation.lat);
		NSLog(@"longitude:%f",infolocation.lng);
        
        //tr4work gps有一定几率获得0.0, 0.0的数据
        if (infolocation.Address == nil) {
            
            [infolocation release];
            [data release];
            [returnString release];
            return NO;
        }
        
        //存储最新信息
        [self setLastLocationInfo:infolocation.lat lng:infolocation.lng info:self._databuf type:1];
        
		if(_delegate != nil && [_delegate respondsToSelector:@selector(LocationModuleInfoToLocation:)]) {
			[_delegate LocationModuleInfoToLocation:infolocation];
		}
        [infolocation release];
        [data release];
        [returnString release];
        
        return YES;
	}
    return NO;
}


-(BOOL)ParseAddressDataBuf{
    NSMutableData *data=nil;
	
	if(self._databuf && self._databuf.length>0){
		data=[[NSMutableData alloc] initWithData:self._databuf];
		
		NSString *returnString = [[NSString alloc] initWithData:data
                                                       encoding:CFStringConvertEncodingToNSStringEncoding( kCFStringEncodingGB_18030_2000)];
		if(!returnString){
			returnString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
			if(!returnString)
				returnString = [[NSString alloc] initWithData:data
                                                     encoding:NSASCIIStringEncoding];
		}
		
		MHLocationInfo  *infolocation=[[MHLocationInfo alloc]init];
		BOOL b=[infolocation ParseAddressData:returnString];
        if (b==YES) {
            [infolocation SetCoordinate2D:infolocation.lat lng:infolocation.lng];
            
            if(_delegate != nil && [_delegate respondsToSelector:@selector(AddressModuleInfoToLocation:)]) {
                [_delegate AddressModuleInfoToLocation:infolocation];
            }
             
            //tr4work gps有一定几率获得0.0, 0.0的数据
            if (infolocation.Address){
                
                //存储最新信息
                [self setLastLocationInfo:infolocation.lat lng:infolocation.lng info:self._databuf type:2];
            }
            
        }else{
            if(_delegate != nil && [_delegate respondsToSelector:@selector(LocationModuleFailWithError:)]) {
                [_delegate LocationModuleFailWithError:nil];
            }
        }
        
		if(returnString)
            [returnString release];
		
		NSLog(@"ZipCode:%@",infolocation.ZipCode);
		NSLog(@"Country:%@",infolocation.Country);
		NSLog(@"CountryCode:%@",infolocation.CountryCode);
		NSLog(@"Area:%@",infolocation.Area);
		NSLog(@"Address:%@",infolocation.Address);
		NSLog(@"Locality:%@",infolocation.Locality);
		NSLog(@"Thoroughfare:%@",infolocation.Thoroughfare);
		NSLog(@"latitude:%f",infolocation.lat);
		NSLog(@"longitude:%f",infolocation.lng);
        
        if(infolocation)
            [infolocation release];
        if(data)
            [data release];
        
        return b;
	}
    return NO;
}

#pragma mark -
#pragma mark === connect delegate ===
#pragma mark -
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
	//下载位置信息失败 进入失败回调
//    if(_delegate != nil && [_delegate respondsToSelector:@selector(LocationModuleFailWithError:)]) {
//        [_delegate LocationModuleFailWithError:error];
//    }
    
    //使用苹果自己得定位
//    if (_locationReserveTool) {
//        [_locationReserveTool setDelegate:nil];
//        [_locationReserveTool release];
//        _locationReserveTool = nil;
//    }
//    _locationReserveTool = [[MHLocationReserve alloc] init];
//    [_locationReserveTool setDelegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self._databuf appendData:data];
    NSLog(@"add");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"done");
    //下载数据完成 分类进行解析
	if (_type==1) {
        if ([self ParseLocationDataBuf]){
            //获取位置信息成功 关闭gps
            //[mapView setShowsUserLocation:NO];
        }
        
    }else if(_type==2){
        if ([self ParseAddressDataBuf]) {
            //获取位置信息成功 关闭gps
            //[mapView setShowsUserLocation:NO];
        }
    } 
}

//#pragma mark -
//#pragma mark === Get GPS ===
//#pragma mark -
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation,%@,%@",userLocation.title,userLocation.subtitle);
    NSLog(@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

    CLLocationCoordinate2D oldcoo;
    oldcoo=coordinate;
    
    coordinate.latitude=userLocation.location.coordinate.latitude;
    coordinate.longitude=userLocation.location.coordinate.longitude;
    
    CLLocation *oC=[[[CLLocation alloc] initWithLatitude:oldcoo.latitude longitude:oldcoo.longitude]autorelease];
    CLLocation *nC=[[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude]autorelease];
    if ([oC distanceFromLocation:(const CLLocation *)nC]<1000) return;
    
    //获取本地详细信息
    if ((int)coordinate.latitude == 0 && (int)coordinate.longitude == 0) {
//        if (!_locationReserveTool) {
//            //使用苹果自己得定位
//            _locationReserveTool = [[MHLocationReserve alloc] init];
//            [_locationReserveTool setDelegate:self];
//        }
    }
    else
    {
        [self GetCurrentLocationInfo:coordinate.latitude lng:coordinate.longitude];
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading { 
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(LocationModuleUpdateHeading:)]) {
        [_delegate LocationModuleUpdateHeading:newHeading.trueHeading];
    }
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {  
    return YES;  
}

- (void) dealloc {
	//[locationManager release];
    if (_conn) {
        [_conn cancel];
        [_conn release];
        _conn=nil;
    }
    
    if (_request) {
        [_request release];
        _request=nil;
    }
	
	if(_databuf){
		[_databuf release];
        _databuf=nil;
    }
    
    if(mapView){
        [mapView release];
        mapView = nil;
    }
    
//    if (_locationReserveTool) {
//        [_locationReserveTool setDelegate:nil];
//        [_locationReserveTool release];
//        _locationReserveTool = nil;
//    }
    
	[super dealloc];
}

- (void)setGetCurrectLocation:(BOOL)state{
    //[mapView setShowsUserLocation:NO];
    //[mapView setShowsUserLocation:state];
}


#pragma LocationReserveToolDelegate Methods
- (void)locationReserveToolSuccess:(MHLocationInfo *)locationInfo
{
    [self setLastLocationInfo:locationInfo.lat lng:locationInfo.lng info:self._databuf type:1];
    if (_delegate && [_delegate respondsToSelector:@selector(LocationModuleInfoToLocation:)]) {
        [_delegate LocationModuleInfoToLocation:locationInfo];
    }
}

- (void)locationReservetoolFailed
{
    if (_delegate && [_delegate respondsToSelector:@selector(LocationModuleFailWithError:)]) {
        [_delegate LocationModuleFailWithError:nil];
    }
}

@end
