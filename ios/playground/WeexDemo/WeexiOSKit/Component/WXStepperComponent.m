//
//  WXStepperComponent.m
//  Monkey
//
//  Created by coderyi on 2016/10/12.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXStepperComponent.h"
@interface WXStepperView : UIStepper

@end

@implementation WXStepperView

@end
@interface WXStepperComponent()
@property (nonatomic, strong)   WXStepperView    *stepperView;
@property (nonatomic, assign)   float    minimumValue;
@property (nonatomic, assign)   float    maximumValue;
@property (nonatomic, assign)   float    value;
@property (nonatomic) float stepValue;                    // default 1. must be greater than 0

@property(nonatomic,copy) NSString *tintColor;
@property (nonatomic, assign)   BOOL    changeEvent;

@end


@implementation WXStepperComponent
- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        _tintColor = attributes[@"tintColor"] ? [WXConvert NSString:attributes[@"tintColor"]] : @"";
        _minimumValue = [WXConvert CGFloat:attributes[@"minimumValue"]];
        _maximumValue = [WXConvert CGFloat:attributes[@"maximumValue"]];
        _value = [WXConvert CGFloat:attributes[@"value"]];
        _stepValue = [WXConvert CGFloat:attributes[@"stepValue"]];

    }
    return self;
}

- (UIView *)loadView
{
    return [[WXStepperView alloc] init];
}
- (void)viewDidLoad
{
    _stepperView = (WXStepperView *)self.view;
    _stepperView.minimumValue = _minimumValue;
    _stepperView.maximumValue = _maximumValue;
    _stepperView.value = _value;
    _stepperView.stepValue = _stepValue;

    _stepperView.tintColor = [WXConvert UIColor:_tintColor];
    [_stepperView addTarget:self action:@selector(didClickStepperAction:) forControlEvents:UIControlEventValueChanged];
    
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
- (void)didClickStepperAction:(UIStepper *)stepper{
    if (_changeEvent) {
        [self fireEvent:@"change" params:@{@"value":@(stepper.value)} domChanges:@{@"attrs": @{@"checked": @(stepper.value)}}];
    }
}


@end
