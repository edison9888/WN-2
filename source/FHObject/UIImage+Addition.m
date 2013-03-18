//
//  UIImage+Addition.m
//  ToolLibrary
//
//  Created by fuzhife on 11-11-28.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

//从左上角切割图片
- (UIImage *)clipImageFromOriginToNewSize:(CGSize)size
{
    float x = 0;
    float y = 0;
    
    float w = size.width;
    float h = size.height;
    
    if(self.size.width < w)
    {
        w = self.size.width;
    }
    
    if(self.size.height < h)
    {
        h = self.size.height;
    }
    
    CGRect rect = CGRectMake(x, y, w, h);
    
    CGImageRef sourceImageRef = [self CGImage];  
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);   
    UIImage *newImage = [[[UIImage alloc] initWithCGImage:newImageRef] autorelease];  
    CGImageRelease(newImageRef);  
    return newImage;     
}


//改变图片大小（重绘）
- (UIImage *)resizeImageTo:(CGSize)size
{
    
    // 创建一个bitmap的context  
    // 并把它设置成为当前正在使用的context  
    // UIGraphicsBeginImageContext(size);  
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    // 绘制改变大小的图片  
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];  
    // 从当前context中创建一个改变大小后的图片  
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
    // 使当前的context出堆栈  
    UIGraphicsEndImageContext();  
    // 返回新的改变大小后的图片  
    return scaledImage; 
}


//根据设置的最大宽度和最大高度等比例缩小图片
- (UIImage *)zoomOutImageInMaxWidth:(float)w_max MaxHeight:(float)h_max
{
    float scale = 1.0;
    float w = self.size.width;
    float h = self.size.height;
    
    UIImage *newImg = self;
    
    if(w > w_max && h > h_max)
    {
        //x,y都要缩放
        float x_scale = w_max/w;
        float y_scale = h_max/h;
        scale = (x_scale < y_scale) ? x_scale : y_scale;
        
        //缩放图片
        newImg = [self resizeImageTo:CGSizeMake(w*scale, h*scale)];
        
    }else if(w > w_max)
    {
        //只有宽缩放
        //缩放图片
        newImg = [self resizeImageTo:CGSizeMake(w_max, h*(w_max/w))];
    }else if(h > h_max)
    {
        //只有高缩放
        newImg = [self resizeImageTo:CGSizeMake(w*(h_max/h), h_max)];
    }
    
    return newImg;
}

/*
 放大图片，将图片的宽高，至少有一边放大到目的值(等比例缩放)
 */
- (UIImage *)zoomInImageBaseOn:(float)w_min DestHeight:(float)h_min
{
    UIImage *retImg = self;
    
    float w_img = self.size.width;
    float h_img = self.size.height;
    
    float w_scale = w_min/w_img;
    float h_scale = h_min/h_img;
    
    if(w_scale > 1 && h_scale >1)
    {
        //图片的宽高都比目的宽高大
        if(w_scale >= h_scale)
        {
            retImg = [self resizeImageTo:CGSizeMake(w_img*w_scale, h_img*w_scale)];
        }
        else
        {
            retImg = [self resizeImageTo:CGSizeMake(w_img*h_scale, h_img*h_scale)];
        }
        
    }
    else if(w_scale > 1)
    {
        //图片的宽比目的宽大
        retImg = [self resizeImageTo:CGSizeMake(w_img*w_scale, h_img*w_scale)];
    }
    else if(h_scale > 1)
    {
        //图片的高比目的高大
        retImg = [self resizeImageTo:CGSizeMake(w_img*h_scale, h_img*h_scale)];
    }
    
    
    return retImg;
}

@end
