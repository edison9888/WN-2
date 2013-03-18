//
//  UIImage+Addition.h
//  ToolLibrary
//
//  Created by fuzhifei on 11-11-28.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

/*
 *作用：从左上角开始切割size大小的图片,若图片原始的宽和高小于size的宽，高则使用原图片的宽或高
 *参数：size，需要切割的大小
 *返回值：新图片
 */
- (UIImage *)clipImageFromOriginToNewSize:(CGSize)size;

/*
 *作用：将图片重绘为size大小
 *参数：size，需要重绘的大小
 *返回值：新图片
 */
- (UIImage *)resizeImageTo:(CGSize)size;

/*
 *作用：在CGSize(w_max,h_max)范围内等比例缩小图片
 *参数：w_max,宽  h_max,高
 *返回值：新图片（若源图片的宽和高都比w_max，h_max小，则返回原图片）
 */
- (UIImage *)zoomOutImageInMaxWidth:(float)w_max MaxHeight:(float)h_max;

/*
 *作用：将图片的宽或高至少一边放大到w_min，h_min
 *参数：w_min,宽  h_min,高
 *返回值：新图片，（若源图片的宽和高都比w_min，h_min大，则返回原图片）
 */
- (UIImage *)zoomInImageBaseOn:(float)w_min DestHeight:(float)h_min;
@end
