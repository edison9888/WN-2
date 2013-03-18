//
//  ImageTool.m
//  SexPicture
//
//  Created by  falcon on 11-2-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define MAX_COUNT 2

#import "DownLoadTool.h"
#import "UIImage+Addition.h"
#import <CommonCrypto/CommonDigest.h>

static NSOperationQueue* operateQueue;



#pragma mark - DownLoadFileTool
#pragma mark 

@implementation DownLoadFileTool


#pragma mark -

-(id) initWithURL:(NSString*)url
		 FilePath:(NSString*)FilePath		 //本地图片路径
		 delegate:(id)delegate{
	if (!(self = [super init]))
		return nil;
	if (url) {
		_strFileURL = [[NSString alloc] initWithString:url];
	}
	
	if (FilePath) {
		_FilePath  = [[NSString alloc] initWithString:FilePath];
	}
	
	if (delegate) {
		_delegate = delegate;
	}
	
    return self;
}

-(void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (![self isCancelled])
    {
		if (_strFileURL && _strFileURL.length>0){
            
			NSString *strURL = [[NSString alloc] initWithString:[_strFileURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
			NSURL *url = [[NSURL alloc] initWithString:strURL];
			[strURL release];
            
			NSData *data = [[NSData alloc] initWithContentsOfURL:url];
			[url release];
			
            //存入本地
			[data writeToFile:_FilePath atomically:YES];
			[data release];
			
			[self performSelectorOnMainThread:@selector(DoneDownLoad:) withObject:_FilePath waitUntilDone:YES];
		}
    }
	
	[pool release];
}

-(void)DoneDownLoad:(NSString *)filePath{
	 
    
	if (_delegate && [_delegate respondsToSelector:@selector(asycImageCallBack:)])
	{
		[_delegate asycFilePathCallBack:filePath];
	}
}

- (void)dealloc {
    
   
	if (_strFileURL) {
		[_strFileURL release];
		_strFileURL = nil;
	}

    if (_FilePath) {
		[_FilePath release];
		_FilePath = nil;
	}
	
    _delegate = nil;
	
	[super dealloc];
}


@end

#pragma mark - DownLoadImageTool

@interface DownLoadImageTool()

//-(void)setDuplicateUrlImage:(UIImage*)image;
//-(void)setImageView:(UIImage *)image;
@end

@implementation DownLoadImageTool

@synthesize finished=_finished;
@synthesize clipSize=_clipSize;
@synthesize scaleSize=_scaleSize;
@synthesize needToSave=_needToSave;
@synthesize tag = _tag;
//@synthesize shouldAutoSet=_shouldAutoSet;
@synthesize imageUrl = _strImageURL;
@synthesize isAnimating;

//普通下载
-(id) initWithURL:(NSString*)url 
    toSavePicture:(BOOL)shouldSave
	imageFilePath:(NSString*)imageFilePath		 //本地图片路径
              Tag:(NSInteger)tag
		 delegate:(id)delegate
{
	if (!(self = [super init]))
		return nil;
    
	if (url) 
    {
		_strImageURL = [[NSString alloc] initWithString:url];
	}
        
    if (operateQueue == nil) 
    {
        operateQueue=[[NSOperationQueue alloc] init];
        [operateQueue setMaxConcurrentOperationCount:MAX_COUNT];
    }
        
    _needToSave = shouldSave;

	if (imageFilePath) 
    {
		_imageFilePath  = [[NSString alloc] initWithString:imageFilePath];
	}
	
	if (delegate) 
    {
		_delegate = delegate ;
	}
	
    _tag = tag;
    
    _clipSize = CGSizeZero;
    _scaleSize = CGSizeZero;
    
    _imgvToShow = nil;
    _button = nil;
    
    return self;
}

//imageView下载,设置imageView图片
-(id) initWithURL:(NSString *)url
		imageView:(UIImageView *)imageView 
    toSavePicture:(BOOL)shouldSave
	imageFilePath:(NSString *)imageFilePath		 //本地图片路径
              Tag:(NSInteger)tag
		 delegate:(id)delegate
{
	if (!(self = [super init]))
		return nil;
    
	if (url) 
    {
		_strImageURL = [[NSString alloc] initWithString:url];
	}
	if (imageView) 
    {
		_imgvToShow = [imageView retain];
    }

    if (operateQueue == nil) 
    {
        operateQueue=[[NSOperationQueue alloc] init];
        [operateQueue setMaxConcurrentOperationCount:MAX_COUNT];
    }

    _needToSave = shouldSave;
    
	if (imageFilePath) {
		_imageFilePath  = [[NSString alloc] initWithString:imageFilePath];
	}
	
	if (delegate) {
		_delegate = delegate ;
	}
	
    _tag = tag;
    
    _clipSize = CGSizeZero;
    _scaleSize = CGSizeZero;
    
    _button = nil;
    
    return self;
}

//button
-(id) initWithURL:(NSString*)url
           button:(UIButton*)button
    toSavePicture:(BOOL)shouldSave
	imageFilePath:(NSString*)imageFilePath 
              Tag:(NSInteger)tag
            state:(UIControlState)state
         delegate:(id)delegate
{
    
	if (!(self = [super init]))
		return nil;
    
	if (url) 
    {
		_strImageURL = [[NSString alloc] initWithString:url];
	}
	
    
    _button = [button retain];
    
    _needToSave = shouldSave;
    
	if (imageFilePath)
    {
		_imageFilePath  = [[NSString alloc] initWithString:imageFilePath];
	}
	
    
    if (operateQueue == nil) 
    {
        operateQueue=[[NSOperationQueue alloc] init];
        [operateQueue setMaxConcurrentOperationCount:MAX_COUNT];
    } 
    
    if (delegate) {
		_delegate = delegate ;
	}
    
    _tag = tag;
    
    _state  = state;
	
	_clipSize = CGSizeZero;
    _scaleSize = CGSizeZero;
    
    _imgvToShow = nil;
    
    return self;

}

-(void)main
{  
    
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (![self isCancelled])
    {
        _finished = NO;
		//先看本地有没有图片，没有则下载
		//UIImage *image=[[UIImage alloc] initWithContentsOfFile:_imageFilePath];
//		if (image) {
//			[self performSelectorOnMainThread:@selector(setImageView:) withObject:image waitUntilDone:YES];
//			[image release];
//		}else {
			//没有本地图片，开始下载
			if (_strImageURL && _strImageURL.length>0){
         
				NSString *strURL = [[NSString alloc] initWithString:[_strImageURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
				NSURL *url = [[NSURL alloc] initWithString:strURL];
				[strURL release];
                
                if (_con)
                {
                    [_con cancel];
                    [_con release];
                    _con = nil;
                
                }
                
                //等待框
                if (isAnimating)
                {
                    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                    
                    UIView* view = nil;
                    if (_imgvToShow)
                    {
                        view =  _imgvToShow;           
                    }
                    else
                    {
                        view = _button;
                    }
                    activityView.frame = CGRectMake((view.frame.size.width -activityView.frame.size.width )/2 , (view.frame.size.height -activityView.frame.size.height )/2, activityView.frame.size.width, activityView.frame.size.height);
                    [view addSubview:activityView];
                    [activityView startAnimating];
                    
                }
                
                NSURLRequest* request = [NSURLRequest requestWithURL:url];
                [url release];
                 _buf = [[NSMutableData alloc] init];
                _con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                

                while(_finished==NO) 
                {
                    
                    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                    
                }
                 
                [_con cancel];
                [_con release];
                _con = nil;
			}
    }
	
	[pool release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_buf setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_buf appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     _finished = YES;
    
    UIImage *image = [[UIImage alloc] initWithData:_buf];
    
    [self performSelectorOnMainThread:@selector(didGetImage:) withObject:image waitUntilDone:YES];
    
    /*
    //如果从网路下载成功，并且要求保存到临时目录
    if (image) 
    {   
        UIImage *storImage = image;
        
        if (!CGSizeEqualToSize(CGSizeZero,_clipSize))
        {
            //存在切割
            storImage = [[[image imageClippingForSize:_clipSize] retain] autorelease];
        }
        
        if (!CGSizeEqualToSize(CGSizeZero,_scaleSize))
        {
            //存在缩放
            //storImage = [[[image scaleImageToNewSize:_scaleSize] retain] autorelease];
        }
        
        if (storImage && _imageFilePath && _savePicture) {
            
            //保存图片
            [UIImagePNGRepresentation(storImage) writeToFile:_imageFilePath atomically:YES];
            
        }
        
        //
        [self performSelectorOnMainThread:@selector(didGetImage:) withObject:storImage waitUntilDone:YES];
        
    }
     */
    
    if(_buf)
    {
        [_buf release];
        _buf = nil;
    }
    
    [image release];
    
    if(activityView)
    {
        [activityView stopAnimating];
        [activityView removeFromSuperview];
        [activityView release];
        activityView = nil;
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _finished = YES;
    
    if(_buf)
    {
        [_buf release];
        _buf = nil;
    }
    
    if(activityView)
    {
        [activityView stopAnimating];
        [activityView removeFromSuperview];
        [activityView release];
        activityView = nil;
    }
     
}

- (void)didGetImage:(UIImage *)image
//-(void)setImageView:(UIImage *)image
{

    if (!CGSizeEqualToSize(CGSizeZero,_scaleSize))
    {
        //存在缩放
        image = [image resizeImageTo:_scaleSize];
        //image = [image scaleImageToNewSize:_scaleSize];
    }
    else if (!CGSizeEqualToSize(CGSizeZero,_clipSize))
    {
        //存在切割
        //image = [image imageClippingForSize:_clipSize];
        image = [image resizeImageTo:_clipSize];
    }
    
    //保存图片 保存的是修改后的图片
    if (image && _imageFilePath && _needToSave) 
    {        
        [UIImagePNGRepresentation(image) writeToFile:_imageFilePath atomically:YES];        
    }
    
    //显示
    if(_imgvToShow)
    {
        _imgvToShow.image  = image;
    }
    else if(_button)
    {
        [_button setBackgroundImage:image forState:_state];
    }
    
    /*
    //...................................................................
    //保存图片  保存的是原图片
    if (image && _imageFilePath && _needToSave) 
    {        
        [UIImagePNGRepresentation(image) writeToFile:_imageFilePath atomically:YES];        
    }
     
    
    //设置图片
    if (_imgvToShow)
    {
        //设置UIImageView
        if (!CGSizeEqualToSize(CGSizeZero,_scaleSize))
        {
            //存在缩放
            _imgvToShow.image = [image scaleImageToNewSize:_scaleSize];
        }
        else if (!CGSizeEqualToSize(CGSizeZero,_clipSize))
        {
            //存在切割
            _imgvToShow.image = [image imageClippingForSize:_clipSize];
        }
        else
        {
            _imgvToShow.image=image;
        }
    }
    else if(_button)
    {
        //设置UIImageView
        if (!CGSizeEqualToSize(CGSizeZero,_scaleSize))
        {
            //存在缩放
            [_button setBackgroundImage:[image scaleImageToNewSize:_scaleSize] forState:_state];
        }
        else if (!CGSizeEqualToSize(CGSizeZero,_clipSize))
        {
            //存在切割
            [_button setBackgroundImage:[image imageClippingForSize:_clipSize] forState:_state];
        }
        else
        {
            [_button setBackgroundImage:image forState:_state];
        }
        
    }
	//...................................................................
     */
     
    
	if (_delegate && [_delegate respondsToSelector:@selector(asycImageCallBack:Tag:)])
	{
		[_delegate asycImageCallBack:image Tag:_tag];
	}
}

- (void)dealloc {
    
    
    //DLog(@"DownLoadImageTool  dealloc");
    if(_con)
    {
        [_con cancel];
        [_con release];
        _con = nil;
    }
    
    if(_buf)
    {
        [_buf release];
        _buf = nil;
    }
    
    if(_button)
    {
        [_button release];
        _button = nil;
    }
    
	if (_strImageURL) 
    {
		[_strImageURL release];
		_strImageURL = nil;
	}
    
    if (_imageFilePath)
    {
		[_imageFilePath release];
		_imageFilePath = nil;
	}
    
    if (_imgvToShow) 
    {
		[_imgvToShow release];
		_imgvToShow = nil;	
	}
    
    if(activityView)
    {
        [activityView release];
        activityView = nil;
    }
    
    _delegate = nil;
	
	[super dealloc];
}
@end


#pragma mark - DownLoadTool


@interface DownLoadTool () 
//+(void)filterDuplicateUrl:(DownLoadImageTool*)imageTool;

@end

@implementation DownLoadTool

#pragma mark - 工具方法
//获取Caches目录下的文件
+ (NSString *)getCacheFile:(NSString *)file{
	return [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(),file];
}

//将字符串转成MD5
+ (NSString *)MD5Value:(NSString *)str{
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

//+(void)filterDuplicateUrl:(DownLoadImageTool*)imageTool
//{
//    DownLoadImageTool* _imageTool = nil;
//    for (id  tool in app.operateQueue.operations)
//    {  
//        if ([tool isKindOfClass:[DownLoadImageTool class]])
//        {
//            _imageTool = tool;
//            
//            if ([_imageTool.imageUrl isEqualToString:imageTool.imageUrl])
//            {
//                [duplicateUrlArray addObject:imageTool];
//                
//                return;
//                
//            }
//        }
//    } 
//    
//}


#pragma mark - UIImageView
//下载图片到UIImageView
+(void) addImageToLoad:(NSString*)url
			 imageView:(UIImageView*)imageView 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate
{   
    
    DownLoadImageTool *op = [[DownLoadImageTool alloc] initWithURL:url imageView:imageView toSavePicture:toSave imageFilePath:imageFilePath Tag:tag delegate:delegate];
    
    //[DownLoadTool filterDuplicateUrl:op];   
   
	[operateQueue addOperation:op];
    
	[op release];
}

//下载图片到UIImageView 等比例缩放图片
+(void) addImageToLoad:(NSString*)url
			 imageView:(UIImageView*)imageView 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate
             scaleSize:(CGSize)scaleSize
{   
    
    DownLoadImageTool *op = [[DownLoadImageTool alloc] initWithURL:url imageView:imageView toSavePicture:toSave imageFilePath:imageFilePath Tag:tag delegate:delegate];
    
    op.scaleSize = scaleSize; 
    
	[operateQueue addOperation:op];
    
	[op release];
}

//下载图片到UIImageView 切割图片
+(void) addImageToLoad:(NSString*)url
			 imageView:(UIImageView*)imageView 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate
             clipSize:(CGSize)clipSize
{   
    
    DownLoadImageTool *op = [[DownLoadImageTool alloc] initWithURL:url imageView:imageView toSavePicture:toSave imageFilePath:imageFilePath Tag:tag delegate:delegate];
    
    op.clipSize = clipSize; 
    
	[operateQueue addOperation:op];
    
	[op release];
}

#pragma mark - UIButton
//下载图片的UIButton
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
{
    
    DownLoadImageTool *op =[[DownLoadImageTool alloc] initWithURL:url button:button toSavePicture:toSave imageFilePath:imageFilePath Tag:tag state:status delegate:delegate];
 
	[operateQueue addOperation:op];
    
	[op release];
}

//下载图片的UIButton 缩放图片
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
              scaleSize:(CGSize)scaleSize
{
    DownLoadImageTool *op =[[DownLoadImageTool alloc] initWithURL:url button:button toSavePicture:toSave imageFilePath:imageFilePath Tag:tag state:status delegate:delegate];
    
    op.scaleSize = scaleSize;
    
	[operateQueue addOperation:op];
    
	[op release];
}

//下载图片的UIButton 切割图片
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
              clipSize:(CGSize)clipSize
{
    DownLoadImageTool *op =[[DownLoadImageTool alloc] initWithURL:url button:button toSavePicture:toSave imageFilePath:imageFilePath Tag:tag state:status delegate:delegate];
    
    op.clipSize = clipSize;
    
	[operateQueue addOperation:op];
    
	[op release];
}


//下载图片的UIButton 切割图片+等待框
+(void) addImageToLoad:(NSString*)url
                button:(UIButton*)button 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath	
                   Tag:(NSInteger)tag
             forStatus:(UIControlState)status
			  delegate:(id<NSObject>)delegate
              clipSize:(CGSize)clipSize
           isAnimating:(BOOL)isAnimating
{
    
    DownLoadImageTool *op =[[DownLoadImageTool alloc] initWithURL:url button:button toSavePicture:toSave imageFilePath:imageFilePath Tag:tag state:status delegate:delegate];
    
    op.clipSize = clipSize;
    op.isAnimating = isAnimating; 
    
	[operateQueue addOperation:op];
    
	[op release];
}

#pragma mark - NO UIImageView NO UIButton
//队列下载图片
+(void) addImageToLoad:(NSString*)url 
            needToSave:(BOOL)toSave
		 imageFilePath:(NSString*)imageFilePath		 //本地图片路径
                   Tag:(NSInteger)tag
			  delegate:(id<NSObject>)delegate
{   
    DownLoadImageTool *op =[[DownLoadImageTool alloc] initWithURL:url toSavePicture:toSave imageFilePath:imageFilePath Tag:tag delegate:delegate];  
    
	[operateQueue addOperation:op];
	[op release];
}

#pragma mark - loadCacheImage

//根据路径 读取本地缓存的图片
+(UIImage*) loadImageFromCacheWithFilePath:(NSString*)path
{
    return [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
}

//根据图片url 读取本地缓存的图片
+(UIImage*) loadImageFromCacheWithUrl:(NSString*)url
{
    NSString* path = [self getCacheFile:[self MD5Value:url]];
    return [self loadImageFromCacheWithFilePath:path];
}

#pragma mark - cancel and pause

//取消所有下载队列
+(void) cancelQueueDownload
{
	if (operateQueue) {
		[operateQueue cancelAllOperations];
	}
}


//停止某个队列中的操作(下载图片)
+(void)pauseDownloadWithUrl:(NSString*)url
{
    NSArray* operations = [operateQueue operations];
    
    for (NSObject* tool in operations) 
    {
        if ([tool isKindOfClass:[DownLoadImageTool class]])
        {   
            
            DownLoadImageTool* fileTool = (DownLoadImageTool*)tool;
            
            if ([fileTool.imageUrl isEqualToString:url]) 
            {
                fileTool.finished = YES;
                [fileTool cancel];
                
                break;
                
            }
        }
        
    }
    
}

@end
