//
//  MHCode.h
//  comic
//
//  Created by shenzhen on 12-7-3.
//  Copyright (c) 2012年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import "DES.h" 

@interface MHCode : NSObject

/**   函数名称 :encodeBase64
 **   函数作用 :Base64加密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)encodeBase64:(NSData *)data;

/**   函数名称 :encodeBase64
 **   函数作用 :Base64解密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)decodeBase64:(NSData *)data;

/**   函数名称 :decodeString
 **   函数作用 :Base64解密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)decodeBase64String:(NSString *)string;

/**   函数名称 :encodeDES
 **   函数作用 :des加密
 **   函数参数 :        
 **   函数返回值:
 **/
+ (NSString *)encodeDES:(NSString *)string;

/**   函数名称 :decodeDES
 **   函数作用 :des解密
 **   函数参数 :        
 **   函数返回值:
 **/
+ (NSString *)decodeDES:(NSString *)string; 

@end
