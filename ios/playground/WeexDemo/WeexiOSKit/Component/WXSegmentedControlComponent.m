//
//  WXSegmentedControlComponent.m
//  Monkey
//
//  Created by coderyi on 2016/10/11.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXSegmentedControlComponent.h"

@interface WXSegmentedControlView : UISegmentedControl

@end

@implementation WXSegmentedControlView

@end
@interface WXSegmentedControlComponent()
@property (nonatomic, copy)   NSArray    *items;// items can be NSStrings. control is automatically sized to fit content
@property (nonatomic, strong)   WXSegmentedControlView    *segmentedControlView;
@property(nonatomic,getter=isMomentary) BOOL momentary;             // if set, then we don't keep showing selected state after tracking ends. default is NO
@property(nonatomic,copy) NSString *tintColor;
@property (nonatomic, assign)   BOOL    changeEvent;

@end


@implementation WXSegmentedControlComponent
- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        NSString *itemsString = attributes[@"items"] ? [WXConvert NSString:attributes[@"items"]] : @"";
        _momentary = [WXConvert BOOL:attributes[@"momentary"]];
        _tintColor = attributes[@"tintColor"] ? [WXConvert NSString:attributes[@"tintColor"]] : @"";

        _items = [itemsString componentsSeparatedByString:@";"];
        
    }
    return self;
}
- (UIView *)loadView
{
    return [[WXSegmentedControlView alloc] initWithItems:_items];
}
- (void)viewDidLoad
{
    _segmentedControlView = (WXSegmentedControlView *)self.view;
    _segmentedControlView.momentary = _momentary;
    _segmentedControlView.tintColor = [WXConvert UIColor:_tintColor];
    [_segmentedControlView addTarget:self action:@selector(didClickSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];

}

- (void)addEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"change"]) {
        _changeEvent = YES;
    }
}

- (void)removeEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"change"]) {
        _changeEvent = NO;
    }
}
- (void)didClickSegmentedControlAction:(UISegmentedControl *)seg{
    if (_changeEvent) {
        [self fireEvent:@"change" params:@{@"value":@(seg.selectedSegmentIndex)} domChanges:@{@"attrs": @{@"checked": @(seg.selectedSegmentIndex)}}];
    }
}


@end
