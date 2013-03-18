//
//  UIImageView+httpFetch.h
//  Mee
//
//  Created by xhan on 9/23/09.
//  Copyright 2009 In-Blue. All rights reserved.
//


/*
 *图片保存在Cache文件夹里
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
@protocol COHCimageViewDelegate < NSObject >

@optional

- (void)imageViewHttpClientFailed:(UIImageView*)sender;

@end
*/


@interface UIImageView (httpFetch) 

//- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable;

#pragma mark - Normal

/*
 *作用：根据url获取图片并加到UIImageView中
 *参数：
    urlstr，图片url 
    cacheEnable,是否将图片保存到本地
 *返回值：
 */
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable;


/*
 *作用：根据url获取图片并加到UIImageView中，并添加默认图片
 *参数：
    urlstr，图片url 
    cacheEnable,是否将图片保存到本地
    defaultImage，默认图片
 *返回值：
 */
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable defaultImage:(UIImage*)defaultImage;


#pragma mark - scale(重绘)

//重绘大小
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable scaleSize:(CGSize)scaleSize;

//重绘大小 ＋ 默认图片
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable scaleSize:(CGSize)scaleSize defaultImage:(UIImage*)defaultImage;

#pragma mark - clip(切割)
//切割大小
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable clipSize:(CGSize)clipSize;

//切割大小 ＋ 默认图片
- (void) fetchImageFromURL:(NSString*)urlstr cacheEnable:(BOOL)cacheEnable clipSize:(CGSize)clipSize defaultImage:(UIImage*)defaultImage;

@end
