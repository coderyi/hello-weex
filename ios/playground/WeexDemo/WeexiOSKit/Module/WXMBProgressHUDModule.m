//
//  WXMBProgressHUDModule.m
//  Monkey
//
//  Created by coderyi on 2016/10/12.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXMBProgressHUDModule.h"
#import "WXUtility.h"
#import "WXMBProgressHUD.h"
#import <WeexSDK/WeexSDK.h>

@interface WXMBProgressHUDModule () 
@property (nonatomic,copy) WXModuleCallback moduleCallback;
@property (nonatomic,strong) MBProgressHUD *hud;

@end


@implementation WXMBProgressHUDModule
@synthesize weexInstance;
WX_EXPORT_METHOD(@selector(showHUD:))
WX_EXPORT_METHOD(@selector(hideHUD))

- (void)showHUD:(NSDictionary *)param
{
    UIView *superView =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    if (!superView) {
        superView =  self.weexInstance.rootView;
    }
    NSString *title = [self stringValue:param[@"title"]];
    NSString *detail = [self stringValue:param[@"detail"]];
    NSString *mode = [self stringValue:param[@"mode"]];
    NSString *cancelTitle = [self stringValue:param[@"cancelTitle"]];
    NSString *contentColor = [self stringValue:param[@"contentColor"]];

    MBProgressHUDMode hudMode = MBProgressHUDModeIndeterminate;
    if ([mode isEqualToString:@"indicator"]) {
        hudMode  = MBProgressHUDModeIndeterminate;
    }else  if ([mode isEqualToString:@"text"]) {
        hudMode  = MBProgressHUDModeText;
    }

    WXPerformBlockOnMainThread(^{
        _hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
        _hud.label.text=title;
        _hud.mode = hudMode;
        _hud.detailsLabel.text=detail;
        _hud.contentColor = [WXConvert UIColor:contentColor];
        if (cancelTitle.length>0) {
            [_hud.button setTitle:cancelTitle forState:UIControlStateNormal];
            [_hud.button addTarget:self action:@selector(cancelWork) forControlEvents:UIControlEventTouchUpInside];
        }
    });
}

- (void)cancelWork
{
    [self hideHUD];
}

- (void)hideHUD
{
    WXPerformBlockOnMainThread(^{
        [_hud hideAnimated:YES];
    });
}

- (NSString*)stringValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

@end
