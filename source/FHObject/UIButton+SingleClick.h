//
//  UIButton+SingleClick.h
//  SingleClick
//
//  Created by L imohoo on 11-7-29.
//  Copyright 2011年 imohoo. All rights reserved.
//
/*
 * 注意 当前类 并不支持 buttonWithType: 方法
 */

#import <Foundation/Foundation.h>

//总锁 和 子锁 状态
typedef enum SIGNMANAGER_TYPE{
    SIGNMANAGER_TYPE_INIT=0,
    SIGNMANAGER_TYPE_LOCK,
    SIGNMANAGER_TYPE_UNLOCK,
}SIGNMANAGER_TYPE;

@interface UIButton_SingleClick : UIButton{
    //子锁
    SIGNMANAGER_TYPE    btnState;
}

//子锁
@property (assign, nonatomic) SIGNMANAGER_TYPE    btnState;

+ (SIGNMANAGER_TYPE) sharedSignManager;

@end
