//
//  UIButton+HttpFetch.h
//  Mee
//
//  Created by xu xhan on 10/14/09.
//  Copyright 2009 In-Blue. All rights reserved.
//


/*
 *图片保存在Cache文件夹里
 */

#import <UIKit/UIKit.h>


@interface UIButton (HttpFetch)


/*!
    @method     fetchImageFromURL:
    @abstract   a simple method to fetch image with cacheEnable and forStatus Normal
    @discussion 
    @param      urlstr a url string that specify the image url
*/


#pragma mark - Normal
//UIControlStateNormal  cacheEnable:YES
- (void) fetchImageFromURL:(NSString*)urlstr;

- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable;

//默认图片
- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable defualtImg:(UIImage*)defaultImg;

#pragma mark - clip

//默认图片＋切割大小
- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable defualtImg:(UIImage*)defaultImg clipSize:(CGSize) clipSize;

//默认图片＋切割大小＋等待框
- (void) fetchImageFromURL:(NSString*)urlstr forStatus:(UIControlState)status cacheEnable:(BOOL)cacheEnable defualtImg:(UIImage*)defaultImg clipSize:(CGSize) clipSize isAnimating:(BOOL)isAnimating;


#pragma mark - scale
//缩放图片
//...........................

@end
