//
//  UIButton+HttpFetch.m
//  Mee
//
//  Created by xu xhan on 10/14/09.
//  Copyright 2009 In-Blue. All rights reserved.
//

#import "UIButton+HttpFetch.h"
#import "DownLoadTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIButton(HttpFetch)

#pragma mark - 工具方法
/**   函数名称 :MD5Value
 **   函数作用 :将字符串转成MD5
 **   函数参数 : 
 **   函数返回值:md5编码后的值
 **/
- (NSString *)MD5Value:(NSString *)str{
	if (str==nil) {
		return nil;
	}
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

//获取Caches目录下的文件
- (NSString *)getCacheFile:(NSString *)file{
	return [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(),file];
}

#pragma mark -

//UIControlStateNormal  cacheEnable:YES
- (void) fetchImageFromURL:(NSString*)urlstr
{
	[self fetchImageFromURL:urlstr forStatus:UIControlStateNormal cacheEnable:YES];
}


- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable
{
    NSString* path = [self getCacheFile:[self MD5Value:urlstr]];

    UIImage* cacheImage = [DownLoadTool loadImageFromCacheWithFilePath:path];
    
    if(cacheImage)
    { 
        
        [self setBackgroundImage:cacheImage forState:status];
        return;
    }
  
    [DownLoadTool addImageToLoad:urlstr button:self needToSave:cacheEnable imageFilePath:path Tag:self.tag forStatus:status delegate:nil];

}


//默认图片
- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable defualtImg:(UIImage*)defaultImg
{
    [self setBackgroundImage:defaultImg forState:status];
    [self fetchImageFromURL:urlstr forStatus:status cacheEnable:cacheEnable];
}

//默认图片＋切割大小
- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable defualtImg:(UIImage*)defaultImg clipSize:(CGSize) clipSize
{
    [self setBackgroundImage:defaultImg forState:status];
    
    NSString* path = [self getCacheFile:[self MD5Value:urlstr]];
    UIImage* cacheImage = [DownLoadTool loadImageFromCacheWithFilePath:path];
    
    if(cacheImage)
    { 
        
        [self setBackgroundImage:cacheImage forState:status];
        return;
    }
    
    [DownLoadTool addImageToLoad:urlstr button:self needToSave:cacheEnable imageFilePath:path Tag:self.tag forStatus:status delegate:nil clipSize:clipSize];
}


//默认图片＋切割大小＋等待框
- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable defualtImg:(UIImage*)defaultImg clipSize:(CGSize) clipSize isAnimating:(BOOL)isAnimating
{
    
    [self setBackgroundImage:defaultImg forState:status];
    
    NSString* path = [self getCacheFile:[self MD5Value:urlstr]];
    UIImage* cacheImage = [DownLoadTool loadImageFromCacheWithFilePath:path];
    
    if(cacheImage)
    { 
        
        [self setBackgroundImage:cacheImage forState:status];
        return;
    }
    
    [DownLoadTool addImageToLoad:urlstr button:self needToSave:cacheEnable imageFilePath:path Tag:self.tag forStatus:status delegate:nil clipSize:clipSize isAnimating:isAnimating];
}

@end
