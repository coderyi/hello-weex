//
//  WXSeekBarComponent.m
//  Monkey
//
//  Created by coderyi on 2016/10/12.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXSeekBarComponent.h"
#import "WXHandlerFactory.h"
#import "WXComponent_internal.h"
#import "WXImgLoaderProtocol.h"

@interface WXSeekBarView : UISlider

@end

@implementation WXSeekBarView

@end
static dispatch_queue_t WXImageUpdateQueue;

@interface WXSeekBarComponent()
@property (nonatomic, strong)   WXSeekBarView    *seekBarView;
@property (nonatomic, assign)   float    minimumValue;
@property (nonatomic, assign)   float    maximumValue;
@property (nonatomic, assign)   float    value;
@property (nonatomic, assign)   BOOL    changeEvent;

@property(nullable, nonatomic,strong) UIColor *minimumTrackTintColor ;
@property(nullable, nonatomic,strong) UIColor *maximumTrackTintColor ;
@property(nullable, nonatomic,strong) UIColor *thumbTintColor ;
@property (nonatomic, strong) id<WXImageOperationProtocol> thumbImageOperation;
@property (nonatomic, strong) id<WXImageOperationProtocol> minimumTrackImageOperation;
@property (nonatomic, strong) id<WXImageOperationProtocol> maximumTrackImageOperation;

@property (nonatomic) BOOL imageLoadEvent;

@property (nonatomic, strong) NSString *thumbImageSrc;
@property (nonatomic, strong) NSString *minimumTrackImageSrc;
@property (nonatomic, strong) NSString *maximumTrackImageSrc;
@property (nonatomic, strong) UIImage *image;

@end

@implementation WXSeekBarComponent
- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        _minimumValue = [WXConvert CGFloat:attributes[@"minimumValue"]];
        _maximumValue = [WXConvert CGFloat:attributes[@"maximumValue"]];
        _value = [WXConvert CGFloat:attributes[@"value"]];
        if (attributes[@"minimumTrackTintColor"]) {
            _minimumTrackTintColor = [WXConvert UIColor:attributes[@"minimumTrackTintColor"]];
        }
        
        if (attributes[@"maximumTrackTintColor"]) {
            _maximumTrackTintColor = [WXConvert UIColor:attributes[@"maximumTrackTintColor"]];
        }
        if (attributes[@"thumbTintColor"]) {
            _thumbTintColor = [WXConvert UIColor:attributes[@"thumbTintColor"]];
        }
        _thumbImageSrc = [WXConvert NSString:attributes[@"thumbImageSrc"]];
        _minimumTrackImageSrc = [WXConvert NSString:attributes[@"minimumTrackImageSrc"]];
        _maximumTrackImageSrc = [WXConvert NSString:attributes[@"maximumTrackImageSrc"]];

        if (!WXImageUpdateQueue) {
            WXImageUpdateQueue = dispatch_queue_create("com.taobao.weex.ImageUpdateQueue", DISPATCH_QUEUE_SERIAL);
        }

    }
    return self;
}
- (UIView *)loadView
{
    return [[WXSeekBarView alloc] init];
}
- (void)viewDidLoad
{
    _seekBarView = (WXSeekBarView *)self.view;
    _seekBarView.minimumValue = _minimumValue;
    _seekBarView.maximumValue = _maximumValue;
    _seekBarView.value = _value;
    _seekBarView.minimumTrackTintColor = _minimumTrackTintColor;
    _seekBarView.maximumTrackTintColor = _maximumTrackTintColor;
    _seekBarView.thumbTintColor = _thumbTintColor;

    [_seekBarView addTarget:self action:@selector(didClickSeekBarAction:) forControlEvents:UIControlEventValueChanged];
    [self updateImage];
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
- (void)didClickSeekBarAction:(UISlider *)slider{
    if (_changeEvent) {
        [self fireEvent:@"change" params:@{@"value":@(slider.value)} domChanges:@{@"attrs": @{@"checked": @(slider.value)}}];
    }
}


- (void)updateImage
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(WXImageUpdateQueue, ^{
        [self cancelImage];
        
        if (CGRectEqualToRect(self.calculatedFrame, CGRectZero)) {
            return;
        }
        
        void(^downloadFailed)(NSString *, NSError *) = ^void(NSString *url, NSError *error){
            WXLogError(@"Error downloading image:%@, detail:%@", url, [error localizedDescription]);
        };
        
        NSString *thumbImageSrc = weakSelf.thumbImageSrc;
        NSString *minimumTrackImageSrc = weakSelf.minimumTrackImageSrc;
        NSString *maximumTrackImageSrc = weakSelf.maximumTrackImageSrc;

        if (weakSelf.minimumTrackImageSrc) {
            weakSelf.minimumTrackImageOperation = [[weakSelf imageLoader] downloadImageWithURL:minimumTrackImageSrc imageFrame:CGRectMake(0, 0, 0, 0) userInfo:nil completed:^(UIImage *image, NSError *error, BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    
                    if (weakSelf.imageLoadEvent) {
                        [strongSelf fireEvent:@"load" params:@{ @"success": error? @"false" : @"true"}];
                    }
                    if (error) {
                        downloadFailed(minimumTrackImageSrc, error);
                        return ;
                    }
                    
                    if (![minimumTrackImageSrc isEqualToString:strongSelf.minimumTrackImageSrc]) {
                        return ;
                    }
                    
                    if ([strongSelf isViewLoaded]) {
                        [strongSelf.seekBarView setMinimumTrackImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forState:UIControlStateNormal];
                        [strongSelf.seekBarView setMinimumTrackImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forState:UIControlStateHighlighted];
                        
                    }

                });
            }];
        }
        if (weakSelf.maximumTrackImageSrc) {
            weakSelf.maximumTrackImageOperation = [[weakSelf imageLoader] downloadImageWithURL:maximumTrackImageSrc imageFrame:CGRectMake(0, 0, 0, 0) userInfo:nil completed:^(UIImage *image, NSError *error, BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    
                    if (weakSelf.imageLoadEvent) {
                        [strongSelf fireEvent:@"load" params:@{ @"success": error? @"false" : @"true"}];
                    }
                    if (error) {
                        downloadFailed(maximumTrackImageSrc, error);
                        return ;
                    }
                    
                    if (![maximumTrackImageSrc isEqualToString:strongSelf.maximumTrackImageSrc]) {
                        return ;
                    }
                    
                    if ([strongSelf isViewLoaded]) {
                        [strongSelf.seekBarView setMaximumTrackImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forState:UIControlStateNormal];
                        [strongSelf.seekBarView setMaximumTrackImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forState:UIControlStateHighlighted];
                        
                    }

                });
            }];
        }

        if (weakSelf.thumbImageSrc) {
            
            weakSelf.thumbImageOperation = [[weakSelf imageLoader] downloadImageWithURL:thumbImageSrc imageFrame:CGRectMake(0, 0, 0, 0) userInfo:nil completed:^(UIImage *image, NSError *error, BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    
                    if (weakSelf.imageLoadEvent) {
                        [strongSelf fireEvent:@"load" params:@{ @"success": error? @"false" : @"true"}];
                    }
                    if (error) {
                        downloadFailed(thumbImageSrc, error);
                        return ;
                    }
                    
                    if (![thumbImageSrc isEqualToString:strongSelf.thumbImageSrc]) {
                        return ;
                    }
                    
                    if ([strongSelf isViewLoaded]) {
                        [strongSelf.seekBarView setThumbImage:image forState:UIControlStateNormal];
                        [strongSelf.seekBarView setThumbImage:image forState:UIControlStateHighlighted];

                    }
                });
            }];
        }

    });
}

- (void)cancelImage
{
    [_thumbImageOperation cancel];
    _thumbImageOperation = nil;
    [_maximumTrackImageOperation cancel];
    _maximumTrackImageOperation = nil;
    [_minimumTrackImageOperation cancel];
    _minimumTrackImageOperation = nil;
}

- (id<WXImgLoaderProtocol>)imageLoader
{
    static id<WXImgLoaderProtocol> imageLoader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageLoader = [WXHandlerFactory handlerForProtocol:@protocol(WXImgLoaderProtocol)];
    });
    return imageLoader;
}

@end
