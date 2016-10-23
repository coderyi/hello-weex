//
//  WXConvert+Addition.m
//  WeexDemo
//
//  Created by coderyi on 2016/10/18.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "WXConvert+Addition.h"
#import <objc/message.h>
@implementation WXConvert (Addition)
#define WX_JSON_CONVERTER(type)           \
+ (type *)type:(id)json                    \
{                                          \
if ([json isKindOfClass:[type class]]) { \
return json;                           \
}                                     \
return nil;                              \
}
/**
 * This macro is used for creating converter functions for typed arrays.
 */
#define WX_ARRAY_CONVERTER(type)                      \
+ (NSArray<id> *)type##Array:(id)json                      \
{                                                      \
return WXConvertArrayValue(@selector(type:), json); \
}


WX_JSON_CONVERTER(NSArray)
WX_ARRAY_CONVERTER(NSString)
WX_ARRAY_CONVERTER(NSArray)
WX_ARRAY_CONVERTER(NSStringArray)

NSArray *WXConvertArrayValue(SEL type, id json)
{
    __block BOOL copy = NO;
    __block NSArray *values = json = [WXConvert NSArray:json];
    [json enumerateObjectsUsingBlock:^(id jsonValue, NSUInteger idx, __unused BOOL *stop) {
        id value = ((id(*)(Class, SEL, id))objc_msgSend)([WXConvert class], type, jsonValue);
        if (copy) {
            if (value) {
                [(NSMutableArray *)values addObject:value];
            }
        } else if (value != jsonValue) {
            // Converted value is different, so we'll need to copy the array
            values = [[NSMutableArray alloc] initWithCapacity:values.count];
            for (NSUInteger i = 0; i < idx; i++) {
                [(NSMutableArray *)values addObject:json[i]];
            }
            if (value) {
                [(NSMutableArray *)values addObject:value];
            }
            copy = YES;
        }
    }];
    return values;
}


+ (NSURL *)NSURL:(id)json
{
    NSString *path = [self NSString:json];
    if (!path) {
        return nil;
    }
    
    @try { // NSURL has a history of crashing with bad input, so let's be safe
        
        NSURL *URL = [NSURL URLWithString:path];
        if (URL.scheme) { // Was a well-formed absolute URL
            return URL;
        }
        
        // Check if it has a scheme
        if ([path rangeOfString:@":"].location != NSNotFound) {
            path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            URL = [NSURL URLWithString:path];
            if (URL) {
                return URL;
            }
        }
        
        // Assume that it's a local path
        path = path.stringByRemovingPercentEncoding;
        if ([path hasPrefix:@"~"]) {
            // Path is inside user directory
            path = path.stringByExpandingTildeInPath;
        } else if (!path.absolutePath) {
            // Assume it's a resource path
            path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:path];
        }
        if (!(URL = [NSURL fileURLWithPath:path])) {
            return nil;//a valid URL
        }
        return URL;
    }
    @catch (__unused NSException *e) {
        return nil;//a valid URL
    }
}

@end
