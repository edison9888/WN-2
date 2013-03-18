//
//  ParseLocationdata.h
//  iFound
//
//  Created by falcon on 3/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHLocationInfo : NSObject {
	NSString        *_zipcode;
	NSString        *_country;
	NSString        *_countrycode;
	NSString        *_area;
	NSString        *_address;
	NSString        *_locality;
	NSString        *_thoroughfare;
	
	float           _lat;
	float           _lng;
	
	BOOL            _havelocation;
}

@property (retain, nonatomic) NSString        *ZipCode;
@property (nonatomic, retain) NSString        *Country;
@property (nonatomic, retain) NSString        *CountryCode;
@property (nonatomic, retain) NSString        *Area;
@property (nonatomic, retain) NSString        *Address;
@property (nonatomic, retain) NSString        *Locality;
@property (nonatomic, retain) NSString        *Thoroughfare;
@property (nonatomic, assign) float           lat;
@property (nonatomic, assign) float           lng;
@property (nonatomic, assign) BOOL            havelocation;

-(void)SetCoordinate2D:(float)lat lng:(float)lng;
-(BOOL)ParseData:(NSString *)buf;
-(BOOL)ParseAddressData:(NSString *)buf;
@end
