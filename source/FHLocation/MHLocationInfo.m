//
//  ParseLocationdata.m
//  iFound
//
//  Created by falcon on 3/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MHLocationInfo.h"
#import "JSON.h"

@implementation MHLocationInfo

@synthesize ZipCode = _zipcode;
@synthesize Country = _country;
@synthesize CountryCode=_countrycode;
@synthesize Area = _area;
@synthesize Address = _address;
@synthesize Locality= _locality;
@synthesize Thoroughfare=_thoroughfare;
@synthesize lat=_lat;
@synthesize lng=_lng;
@synthesize havelocation=_havelocation;

- init
{
	if ((self = [super init])) {
		_zipcode=nil;
		_country=nil;
		_area=nil;
		_address=nil;
		_locality=nil;
		_thoroughfare=nil;
		_countrycode=nil;
	}
	return self;
}

- (void) dealloc {
	[_zipcode release];
	[_country release];
	[_area release];
	[_address release];
	[_locality release];
	[_thoroughfare release];
	[_countrycode release];
	[super dealloc];
}

-(void)SetCoordinate2D:(float)lat lng:(float)lng{
	_lat=lat;
	_lng=lng;
}


-(BOOL)ParseData:(NSString *)buf{
	if(!buf) return NO;
    
    NSDictionary *AllData=[buf JSONValue];
	NSArray *Placemarkarray=[AllData objectForKey:@"Placemark"];
	if(Placemarkarray){
		NSDictionary *palcedict=[Placemarkarray objectAtIndex:0];
		NSDictionary *addressdetail=[palcedict objectForKey:@"AddressDetails"];
		NSDictionary *country=[addressdetail objectForKey:@"Country"];
		NSDictionary *areadict=[country objectForKey:@"AdministrativeArea"];
		
		NSString *code=[country objectForKey:@"CountryNameCode"];
		if(code){
			self.CountryCode=code;
		}
		
		NSString *countryname=[country objectForKey:@"CountryName"];
		if(countryname){
			self.Country=countryname;
		}
		
		if(areadict){
			NSString *areaname=[areadict objectForKey:@"AdministrativeAreaName"];
			NSDictionary *subareadict=[areadict objectForKey:@"SubAdministrativeArea"];
			NSDictionary *Locality=[subareadict objectForKey:@"Locality"];
			if(!Locality)
				Locality=[areadict objectForKey:@"Locality"];
			NSString *LocalityName=[Locality objectForKey:@"LocalityName"];
			NSDictionary *PostalCode=[Locality objectForKey:@"PostalCode"];
			NSString *PostalCodeNumber=[PostalCode objectForKey:@"PostalCodeNumber"];
			NSDictionary *Thoroughfare=[Locality objectForKey:@"Thoroughfare"];
			NSString *ThoroughfareName=[Thoroughfare objectForKey:@"ThoroughfareName"];
			
			if(PostalCodeNumber){
				self.ZipCode=PostalCodeNumber;
			}
			
			if(areaname){
				self.Area=areaname;
			}
			
			
			NSString *AllAddress=[NSString stringWithFormat:@""];
			if(ThoroughfareName){
				AllAddress=[NSString stringWithFormat:@"%@",ThoroughfareName];
				self.Thoroughfare=ThoroughfareName;
			}
			if(LocalityName){
				if(AllAddress.length>0){
					AllAddress=[NSString stringWithFormat:@"%@,%@",AllAddress,LocalityName];
				}else{
					AllAddress=[NSString stringWithFormat:@"%@",LocalityName];
				}
				
				self.Locality=LocalityName;
			}
			
			if(areaname){
				if(AllAddress.length>0){
					AllAddress=[NSString stringWithFormat:@"%@,%@",AllAddress,areaname];
				}else{
					AllAddress=[NSString stringWithFormat:@"%@",areaname];
				}
				
			}
			
			if(PostalCodeNumber){
				if(AllAddress.length>0){
					AllAddress=[NSString stringWithFormat:@"%@,%@",AllAddress,PostalCodeNumber];
				}else{
					AllAddress=[NSString stringWithFormat:@"%@",PostalCodeNumber];
				}
				
			}
			
			
			//if(_address)
			//	[_address release];
			//_address=[AllAddress retain];
			self.Address=[palcedict objectForKey:@"address"];
		}else{
			return NO;
		}
		
	}
	
    return YES;
}

-(BOOL)ParseAddressData:(NSString *)buf{
	if(!buf) return NO;
    
    NSDictionary *AllData=[buf JSONValue];
	NSArray *Placemarkarray=[AllData objectForKey:@"Placemark"];
	if(Placemarkarray){
		NSDictionary *palcedict=[Placemarkarray objectAtIndex:0];
		NSDictionary *addressdetail=[palcedict objectForKey:@"AddressDetails"];
		NSDictionary *country=[addressdetail objectForKey:@"Country"];
		NSDictionary *areadict=[country objectForKey:@"AdministrativeArea"];
		
		NSString *code=[country objectForKey:@"CountryNameCode"];
		if(code){
			self.CountryCode=code;
		}
		
        NSDictionary *PointDict=[palcedict objectForKey:@"Point"];
        if(PointDict){
            NSArray *array=[PointDict objectForKey:@"coordinates"];
            if (array.count>=2) {
                self.lng=[[array objectAtIndex:0] floatValue];
                self.lat=[[array objectAtIndex:1] floatValue];
            }
        }
        
		
        
        NSString *countryname=[country objectForKey:@"CountryName"];
		if(countryname){
			self.Country=countryname;
		}
		
		if(areadict){
			NSString *areaname=[areadict objectForKey:@"AdministrativeAreaName"];
			NSDictionary *subareadict=[areadict objectForKey:@"SubAdministrativeArea"];
			NSDictionary *Locality=[subareadict objectForKey:@"Locality"];
			if(!Locality)
				Locality=[areadict objectForKey:@"Locality"];
			NSString *LocalityName=[Locality objectForKey:@"LocalityName"];
			NSDictionary *PostalCode=[Locality objectForKey:@"PostalCode"];
			NSString *PostalCodeNumber=[PostalCode objectForKey:@"PostalCodeNumber"];
			NSDictionary *Thoroughfare=[Locality objectForKey:@"Thoroughfare"];
			NSString *ThoroughfareName=[Thoroughfare objectForKey:@"ThoroughfareName"];
			
			if(PostalCodeNumber){
				self.ZipCode=PostalCodeNumber;
			}
			
			if(areaname){
				self.Area=areaname;
			}
			
			
			NSString *AllAddress=[NSString stringWithFormat:@""];
			if(ThoroughfareName){
				AllAddress=[NSString stringWithFormat:@"%@",ThoroughfareName];
				self.Thoroughfare=ThoroughfareName;
			}
			if(LocalityName){
				if(AllAddress.length>0){
					AllAddress=[NSString stringWithFormat:@"%@,%@",AllAddress,LocalityName];
				}else{
					AllAddress=[NSString stringWithFormat:@"%@",LocalityName];
				}
				
				self.Locality=LocalityName;
			}
			
			if(areaname){
				if(AllAddress.length>0){
					AllAddress=[NSString stringWithFormat:@"%@,%@",AllAddress,areaname];
				}else{
					AllAddress=[NSString stringWithFormat:@"%@",areaname];
				}
				
			}
			
			if(PostalCodeNumber){
				if(AllAddress.length>0){
					AllAddress=[NSString stringWithFormat:@"%@,%@",AllAddress,PostalCodeNumber];
				}else{
					AllAddress=[NSString stringWithFormat:@"%@",PostalCodeNumber];
				}
				
			}
			
			
			if(_address)
				[_address release];
			_address=[AllAddress retain];
			self.Address=[palcedict objectForKey:@"address"];
            
            return YES;
		}else{
			return NO;
		}
		
	}
	
    return NO;
}

@end
