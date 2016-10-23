//
//  WXConvert+Addition.h
//  WeexDemo
//
//  Created by coderyi on 2016/10/18.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <WeexSDK/WeexSDK.h>

@interface WXConvert (Addition)
+ (NSArray *)NSArray:(id)value;
+ (NSArray<NSString *> *)NSStringArray:(id)value;
+ (NSArray<NSArray *> *)NSArrayArray:(id)json;
+ (NSArray<NSArray<NSString *> *> *)NSStringArrayArray:(id)json;

+ (NSURL *)NSURL:(id)json;

@end
