//
//  UIButton+SingleClick.m
//  SingleClick
//
//  Created by L imohoo on 11-7-29.
//  Copyright 2011年 imohoo. All rights reserved.
//

#import "UIButton+SingleClick.h"

@implementation UIButton_SingleClick
@synthesize btnState = _btnState;

static  SIGNMANAGER_TYPE     signManager;

+  (SIGNMANAGER_TYPE) sharedSignManager
{
    @synchronized(self)
    {
        if  (signManager == SIGNMANAGER_TYPE_INIT)
        {
            signManager = SIGNMANAGER_TYPE_UNLOCK;
        }
    }
    
    return  signManager;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self addTarget:self action:@selector(lockState) forControlEvents:UIControlEventTouchDown];
        _btnState = YES;
    }
    
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self addTarget:self action:@selector(lockState) forControlEvents:UIControlEventTouchDown];
        _btnState = YES;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code here.
        [self addTarget:self action:@selector(lockState) forControlEvents:UIControlEventTouchDown];
        _btnState = YES;
    }
    
    return self;
}

//解锁 总锁
- (void)unlockState{ 
    signManager = SIGNMANAGER_TYPE_UNLOCK; 
}

//释放 总锁
- (void)lockState{  
    signManager = SIGNMANAGER_TYPE_LOCK;  
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    @synchronized(self){
        NSString *actionStr = NSStringFromSelector(action);
        //手指按下状态 开始锁定  不允许其他触摸
        if([actionStr isEqualToString:@"lockState"]){
            if(SIGNMANAGER_TYPE_UNLOCK == [UIButton_SingleClick sharedSignManager]){ 
                [super sendAction:action to:target forEvent:event]; 
                _btnState = SIGNMANAGER_TYPE_UNLOCK;
            } else {
                _btnState = SIGNMANAGER_TYPE_LOCK; 
            }
        } else {
            //处理 touch upinside
            if(SIGNMANAGER_TYPE_UNLOCK == _btnState){
                if(SIGNMANAGER_TYPE_UNLOCK != [UIButton_SingleClick sharedSignManager]) { 
                    //允许事件处理
                    _btnState = SIGNMANAGER_TYPE_UNLOCK;
                    [super sendAction:action to:target forEvent:event]; 
                    //处理总锁状态 
                    [self unlockState];
                }
            } else {
                _btnState = SIGNMANAGER_TYPE_UNLOCK;
                [self unlockState];
                return;
            }  
        } 
    }
}

@end
