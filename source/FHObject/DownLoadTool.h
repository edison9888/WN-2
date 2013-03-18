//
//  ImageTool.h
//
//  Created by  falcon on 11-2-22.
//  Modify by fuzhifei on 11-11-25
//  Copyright 2011 imohoo. All rights reserved.
//


#import <Foundation/Foundation.h>


#pragma mark - protocol

@protocol DownLoadOperationDelegate<NSObject>
@required
@optional

//图片下载回调
//image：图片 imgPath:图片保存路径
-(void)asycImageCallBack:(UIImage *)image Tag:(NSInteger)tag;
-(void)asycFilePathCallBack:(NSString *)filePath;

-(void)DownloadClientCallBack;
-(void)DownloadClientCallBack:(id)value;
-(void)DownloadClientState:(double)size fullSize:(double)fsize;
-(void)DownloadClientError:(NSError *)error;
@end


#pragma mark - DownLoadImageTool
//下载图片
@interface DownLoadImageTool : NSOperation {
	
	NSString	*_strImageURL;		//图片url
	NSString	*_imageFilePath;	//保存到本地文件夹中的图片地址
	UIImageView *_imgvToShow;		//UIImageView
	
	id<DownLoadOperationDelegate> _delegate;
    
    UIButton *_button;
    UIControlState _state;
    
    NSURLConnection *_con;
    NSMutableData *_buf;
    BOOL _finished;
    
    BOOL isAnimating;
    UIActivityIndicatorView *activityView;
    
}
//裁剪大小
@property(nonatomic,assign) CGSize clipSize;
//缩放大小
@property(nonatomic,assign) CGSize scaleSize;
//是否保存图片
@property(nonatomic,assign) BOOL needToSave;
//标签值
@property(nonatomic,assign) NSInteger tag;
//是否自动设置UIImageView或者UIButton
//@property(nonatomic,assign) BOOL shouldAutoSet;
@property(nonatomic,assign) BOOL isAnimating;
@property(nonatomic,assign) BOOL finished;
@property(nonatomic,readonly) NSString *imageUrl;


//普通下载，不设置ImageView和Button
-(id) initWithURL:(NSString*)url 
    toSavePicture:(BOOL)shouldSave
	imageFilePath:(NSString*)imageFilePath		 //图片存储路径
              Tag:(NSInteger)tag
		 delegate:(id)delegate;

//imageView下载,设置imageView图片
-(id) initWithURL:(NSString *)url
		imageView:(UIImageView *)imageView 
    toSavePicture:(BOOL)shouldSave
	imageFilePath:(NSString *)imageFilePath		 //图片存储路径
              Tag:(NSInteger)tag
		 delegate:(id)delegate;

//button
-(id) initWithURL:(NSString*)url
           button:(UIButton*)button
    toSavePicture:(BOOL)shouldSave
	imageFilePath:(NSString*)imageFilePath 
              Tag:(NSInteger)tag
            state:(UIControlState)state
         delegate:(id)delegate;

@end

#pragma mark - DownLoadFileTool
//下载文件
@interface DownLoadFileTool : NSOperation {
	
	NSString	*_strFileURL;		//图片url
	NSString	*_FilePath;	//保存到本地文件夹中的图片地址
	
	id<DownLoadOperationDelegate> _delegate;
}


-(id) initWithURL:(NSString*)url
		 FilePath:(NSString*)FilePath		 //本地图片路径
		 delegate:(id<NSObject>)delegate;
@end



//下载工具

#pragma mark - DownLoadTool

@interface DownLoadTool:NSObject
{
	
}

#pragma mark - UIImageView
/*
 *作用：队列下载图片到UIImageView
 *参数：
     url:图片网络地址
     imageView：需要设置的ImageView
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
			 imageView:(UIImageView*)imageView 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate;

/*
 *作用：队列下载图片到UIImageView 非等比例缩放图片（重绘）
 *参数：
     url:图片网络地址
     imageView：需要设置的ImageView
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
     scaleSize:重绘后的大小
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
			 imageView:(UIImageView*)imageView 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate
             scaleSize:(CGSize)scaleSize;


/*
 *作用：队列下载图片到UIImageView 切割
 *参数：
     url:图片网络地址
     imageView：需要设置的ImageView
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
     clipSize:从左上角开始切割clipSize大小的图片
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
			 imageView:(UIImageView*)imageView 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate
              clipSize:(CGSize)clipSize;


#pragma mark - UIButton
/*
 *作用：队列下载图片到UIButton 
 *参数：
     url:图片网络地址
     imageView：需要设置的Button
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     status：Button状态
     delegate：委托对象
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate;

/*
 *作用：队列下载图片到UIButton 非等比例缩放图片缩放（重绘）
 *参数：
     url:图片网络地址
     button：需要设置的Button
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
     scaleSize:重绘大小
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
             scaleSize:(CGSize)scaleSize;

/*
 *作用：队列下载图片到UIButton 切割
 *参数：
     url:图片网络地址
     imageView：需要设置的Button
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
     clipSize:从左上角开始切割clipSize大小的图片
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
              clipSize:(CGSize)clipSize;

/*
 *作用：队列下载图片到UIButton 切割
 *参数：
     url:图片网络地址
     imageView：需要设置的Button
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
     clipSize:从左上角开始切割clipSize大小的图片
     isAnimating:是否有等待框
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
              clipSize:(CGSize)clipSize
           isAnimating:(BOOL)isAnimating;


#pragma mark - NO UIImageView NO UIButton
/*
 *作用：队列下载图片 
 *参数：
     url:图片网络地址
     toSave：是否将图片保存到本地
     imageFilePath：图片保存地址
     tag：标签值
     delegate：委托对象
 *返回值：
 */
+(void) addImageToLoad:(NSString*)url 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate;


#pragma mark - loadCacheImage

/*
 *作用：根据路径 读取本地缓存的图片 
 *参数：
     path:图片路径
 *返回值：
 */
+(UIImage *)loadImageFromCacheWithFilePath:(NSString*)path;


/*
 *作用：根据图片url 读取本地缓存的图片 
 *参数：
     url:图片网络地址
 *返回值：
 */
+(UIImage *)loadImageFromCacheWithUrl:(NSString*)url;



#pragma mark - cancel and pause

/*
 *作用：取消队列里的所有操作 
 *参数：
 *返回值：
 */
+(void) cancelQueueDownload;


/*
 *作用：停止队列中的下载地址为url的操作
 *参数：
     url:图片网络地址
 *返回值：
 */
+(void)pauseDownloadWithUrl:(NSString*)url;



@end
