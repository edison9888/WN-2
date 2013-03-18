//
//  AnimationTool.h
//  AnimationTool
//
//  Created by fuzhifei on 11-11-1.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//



//add QuartzCore.framework
//动画工具类
 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MHAnimationTool : NSObject

#pragma mark - move

/**   函数名称 :animationView:OriginMoveTo:time:selector:delegate:
 **   函数作用 :根据view的起始点做动画
 **   函数参数 : view：需要做动画的view toPoint：原点默认地址 time：动画时间
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/


+ (void)animationView:(UIView *)view 
         OriginMoveTo:(CGPoint)destPoint 
                 time:(float)time 
          repeatCount:(NSInteger)count
             selector:(SEL)selector 
             delegate:(id)delegate;


/**   函数名称 :animationView:CenterMoveTo:time:selector:delegate:
 **   函数作用 :根据view的起始点做动画
 **   函数参数 : view：需要做动画的view toPoint：原点默认地址 time：动画时间
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/
+ (void)animationView:(UIView *)view 
         CenterMoveTo:(CGPoint)destPoint 
                 time:(float)time
          repeatCount:(NSInteger)count
             selector:(SEL)selector 
             delegate:(id)delegate;


/**   函数名称 :animationView:FrameMoveTo:time:selector:delegate:
 **   函数作用 :根据view的起始点做动画
 **   函数参数 : view：需要做动画的view toPoint：原点默认地址 time：动画时间
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/
+ (void)animationView:(UIView *)view 
          FrameMoveTo:(CGRect)destFrame 
                 time:(float)time
          repeatCount:(NSInteger)count
             selector:(SEL)selector 
             delegate:(id)delegate;


#pragma mark - rotation

/**   函数名称 :animationView:time:rotationAngle:selector:delegate:
 **   函数作用 :界面旋转
 **   函数参数 : view：需要做动画的view time：动画时间 angle:旋转角度
            selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/


+ (void)animationView:(UIView *)view 
                 time:(float)time 
        rotationAngle:(CGFloat)angle 
             selector:(SEL)selector 
             delegate:(id)delegate;


#pragma mark - alpha

/**   函数名称 :animationAlphaFadeInOutView:time:resAlpha:destAlpha:selector:delegate:
 **   函数作用 :渐隐渐现动画
 **   函数参数 : view：需要做动画的view time：动画时间 resAlpha:起始透明度
                destAlpha：目的透明度 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationAlphaFadeInOutView:(UIView *)view 
                               time:(float)time 
                           resAlpha:(float)resAlpha
                          destAlpha:(float)destAlpha
                           selector:(SEL)selector 
                           delegate:(id)delegate;

#pragma mark - push pop present dismiss

/**   函数名称 :animationPushView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view           
 **   函数返回值:
 **/

+ (void)animationPushView:(UIView *)viewApplyTtansition 
                     time:(float)time 
            viewExChange1:(UIView *)view1 
            viewExChange2:(UIView *)view2;



/**   函数名称 :animationPopView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view          
 **   函数返回值:
 **/

+ (void)animationPopView:(UIView *)viewApplyTtansition 
                    time:(float)time 
           viewExChange1:(UIView *)view1 
           viewExChange2:(UIView *)view2;


/**   函数名称 :animationPresentView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view         
 **   函数返回值:
 **/

+ (void)animationPresentView:(UIView *)viewApplyTtansition 
                        time:(float)time 
               viewExChange1:(UIView *)view1 
               viewExChange2:(UIView *)view2;

/**   函数名称 :animationDismissView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view          
 **   函数返回值:
 **/

+ (void)animationDismissView:(UIView *)viewApplyTtansition 
                        time:(float)time 
               viewExChange1:(UIView *)view1 
               viewExChange2:(UIView *)view2;


#pragma mark - Flip and Curl

/**   函数名称 :animationFlipFromLeftView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :左翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationFlipFromLeftView:(UIView *)viewApplyTtansition 
                             time:(float)time 
                    viewExChange1:(UIView *)view1 
                    viewExChange2:(UIView *)view2
                         selector:(SEL)selector 
                         delegate:(id)delegate;


/**   函数名称 :animationFlipFromRightView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :右翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationFlipFromRightView:(UIView *)viewApplyTtansition 
                              time:(float)time 
                     viewExChange1:(UIView *)view1 
                     viewExChange2:(UIView *)view2
                          selector:(SEL)selector 
                          delegate:(id)delegate;


/**   函数名称 :animationCurlUpView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationCurlUpView:(UIView *)viewApplyTtansition 
                       time:(float)time 
              viewExChange1:(UIView *)view1 
              viewExChange2:(UIView *)view2
                   selector:(SEL)selector 
                   delegate:(id)delegate;


/**   函数名称 :animationCurlDownView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationCurlDownView:(UIView *)viewApplyTtansition 
                         time:(float)time 
                viewExChange1:(UIView *)view1 
                viewExChange2:(UIView *)view2
                     selector:(SEL)selector 
                     delegate:(id)delegate;


#pragma mark - change Frame and Bounds

/**   函数名称 :animationChangeBoundsView:time:DestBounds:selector:delegate:
 **   函数作用 :改变view的Bounds 动画
 **   函数参数 : view：需要改变bounds的view time：动画时间 destBounds:view的最终bounds大小
                selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationChangeBoundsView:(UIView *)view 
                             time:(float)time 
                       DestBounds:(CGRect)destBounds 
                         selector:(SEL)selector 
                         delegate:(id)delegate;



/**   函数名称 :animationChangeFrameView:time:DestBounds:selector:delegate:
 **   函数作用 :改变view的Bounds 动画
 **   函数参数 : view：需要改变bounds的view time：动画时间 destBounds:view的最终bounds大小
                    selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationChangeFrameView:(UIView *)view 
                            time:(float)time 
                       DestFrame:(CGRect)destFrame 
                        selector:(SEL)selector 
                        delegate:(id)delegate;

/**   函数名称 :ViewZoom
 **   函数作用 :view缩放
 **   函数参数 : 
 **           
 **   函数返回值:
 **/
+(void)animationScaleView:(UIView *)view 
                     time:(float)time 
               startScale:(float)startScale
                 endScale:(float)endScale 
                 selector:(SEL)selector 
                 delegate:(id)delegate;

/**   函数名称 :ViewMove
 **   函数作用 :view移动
 **   函数参数 : 
 **           
 **   函数返回值:
 **/
+(void)animationMoveView:(UIView *)view 
                    time:(float)time 
                  center:(CGPoint)center
                selector:(SEL)selector 
                delegate:(id)delegate;
/**   函数名称 :ViewMove
 **   函数作用 :view移动
 **   函数参数 : 
 **           
 **   函数返回值:
 **/
+(void)animationMoveView:(UIView *)view 
                    time:(float)time 
                    rect:(CGRect)rect
                selector:(SEL)selector 
                delegate:(id)delegate;

@end
