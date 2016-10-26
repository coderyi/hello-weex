//
//  WXVibrationModule.m
//  WeexDemo
//
//  Created by coderyi on 2016/10/20.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "WXVibrationModule.h"
#import "WXUtility.h"
#import <WeexSDK/WeexSDK.h>

#import <AudioToolbox/AudioToolbox.h>


@implementation WXVibrationModule
WX_EXPORT_METHOD(@selector(vibrate))

- (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
@end
