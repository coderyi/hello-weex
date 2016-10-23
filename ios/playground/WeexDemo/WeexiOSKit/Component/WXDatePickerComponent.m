//
//  WXDatePickerComponent.m
//  Monkey
//
//  Created by coderyi on 2016/10/12.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXDatePickerComponent.h"
@interface WXDatePickerView : UIDatePicker

@end

@implementation WXDatePickerView

@end
@interface WXDatePickerComponent()
@property (nonatomic, strong)   WXDatePickerView    *datePickerView;
@property (nonatomic, assign)   BOOL    changeEvent;

@end

@implementation WXDatePickerComponent
- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        
    }
    return self;
}

- (UIView *)loadView
{
    return [[WXDatePickerView alloc] init];
}

- (void)viewDidLoad
{
    _datePickerView = (WXDatePickerView *)self.view;
    _datePickerView.backgroundColor =[UIColor whiteColor];
    [_datePickerView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [_datePickerView setTimeZone:[NSTimeZone localTimeZone]];
    [_datePickerView setDate:[NSDate date] animated:YES];
    [_datePickerView setMaximumDate:[NSDate date]];
    [_datePickerView setDatePickerMode:UIDatePickerModeDate];
    [_datePickerView addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];

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
- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    if (_changeEvent) {
        [self fireEvent:@"change" params:@{@"value":datePicker.date} domChanges:@{@"attrs": @{@"checked": datePicker.date}}];
    }
}


@end
