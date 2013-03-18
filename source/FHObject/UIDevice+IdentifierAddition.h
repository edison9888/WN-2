//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by fuzhifei on 11-11-28.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIDevice (IdentifierAddition)

/*
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */

/*
 *某个设备上某个程序的唯一标志符:设备地址＋程序签名
 */
- (NSString *) uniqueDeviceIdentifier;


/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */


/*
 *设备唯一标志符
 */
- (NSString *) uniqueGlobalDeviceIdentifier;

@end
