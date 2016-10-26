//
//  WXActionSheetModule.m
//  Monkey
//
//  Created by coderyi on 2016/10/12.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXActionSheetModule.h"
#import "WXUtility.h"
#import "WXConvert+Addition.h"
@interface WXActionSheetModule () <UIActionSheetDelegate>
@property (nonatomic,copy) WXModuleCallback moduleCallback;
@end

@implementation WXActionSheetModule
@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(actionSheetShow:callback:))

- (void)actionSheetShow:(NSDictionary *)param callback:(WXModuleCallback)callback
{
    NSString *cancelButtonTitle = [self stringValue:param[@"cancelButtonTitle"]];
    NSString *destructiveButtonTitle = [self stringValue:param[@"destructiveButtonTitle"]];

    NSArray *otherButtonTitlesString = param[@"otherButtonTitles"];
    _moduleCallback = callback;

    WXPerformBlockOnMainThread(^{
        
        UIActionSheet * sheet = [[UIActionSheet alloc] init];
        sheet.delegate = self;
        [sheet addButtonWithTitle:cancelButtonTitle];
        [sheet addButtonWithTitle:destructiveButtonTitle];
        for (NSString *option in otherButtonTitlesString) {
            if ([option isKindOfClass:[NSString class]]) {
                [sheet addButtonWithTitle:option];
            }
        }
        sheet.destructiveButtonIndex = 1;
        sheet.cancelButtonIndex = 0;

        UIView *superView =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        if (!superView) {
            superView =  self.weexInstance.rootView;
        }
        [sheet showInView:superView];
    });
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!_moduleCallback) return;

    _moduleCallback(@{@"buttonIndex":@(buttonIndex)});
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
