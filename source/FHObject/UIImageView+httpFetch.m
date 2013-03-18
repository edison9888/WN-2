//
//  UIImageView+httpFetch.m
//  Mee
//
//  Created by xhan on 9/23/09.
//  Copyright 2009 In-Blue. All rights reserved.
//

#import "UIImageView+httpFetch.h"
#import "DownLoadTool.h"
#import "UIImage+Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIImageView (httpFetch)

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

#pragma mark - Normal


- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable
{
    
    NSString *path = [self getCacheFile:[self MD5Value:urlstr]];
    UIImage *cacheImage = [DownLoadTool loadImageFromCacheWithFilePath:path];
    
    if(cacheImage)
    { 
         self.image = cacheImage;
        
        return;
    }
    
    [DownLoadTool addImageToLoad:urlstr imageView:self needToSave:cacheEnable imageFilePath:path Tag:self.tag delegate:nil];

}


//默认图片
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable defaultImage:(UIImage*)defaultImage
{   
    self.image = defaultImage;
    [self fetchImageFromURL:urlstr cacheEnable:cacheEnable];
}

#pragma mark - scale

//缩放大小
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable scaleSize:(CGSize)scaleSize
{
    NSString *path = [self getCacheFile:[self MD5Value:urlstr]];
    UIImage *cacheImage = [DownLoadTool loadImageFromCacheWithFilePath:path];
    
    if(cacheImage)
    { 
        //self.image = [cacheImage resizeImageTo:scaleSize];
        
        self.image = cacheImage;
        
        return; 
    }
    
    [DownLoadTool addImageToLoad:urlstr imageView:self needToSave:cacheEnable imageFilePath:path Tag:self.tag delegate:nil scaleSize:scaleSize];
    
}


//缩放大小 ＋ 默认图片
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable scaleSize:(CGSize)scaleSize defaultImage:(UIImage*)defaultImage
{   
    self.image = defaultImage;
    
    [self fetchImageFromURL:urlstr cacheEnable:cacheEnable scaleSize:scaleSize];
}

#pragma mark -
//切割大小
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable clipSize:(CGSize)clipSize
{
    NSString *path = [self getCacheFile:[self MD5Value:urlstr]];
    UIImage *cacheImage = [DownLoadTool loadImageFromCacheWithFilePath:path];
    
    if(cacheImage)
    { 
        //self.image = [cacheImage resizeImageTo:scaleSize];
        
        self.image = cacheImage;
        
        return; 
    }
    
    [DownLoadTool addImageToLoad:urlstr imageView:self needToSave:cacheEnable imageFilePath:path Tag:self.tag delegate:nil clipSize:clipSize];
    
}

//切割大小 ＋ 默认图片
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable clipSize:(CGSize)clipSize defaultImage:(UIImage*)defaultImage
{
    self.image = defaultImage;
    
    [self fetchImageFromURL:urlstr cacheEnable:cacheEnable clipSize:clipSize];
}

@end
