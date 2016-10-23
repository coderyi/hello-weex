//
//  WXLocationModule.m
//  WeexDemo
//
//  Created by coderyi on 2016/10/18.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "WXLocationModule.h"
#import <WeexSDK/WeexSDK.h>
#import "WXUtility.h"
#import "WXConvert+Addition.h"
#import <CoreLocation/CLError.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


@interface WXLocationModule ()<CLLocationManagerDelegate>
@property (nonatomic,copy) WXModuleCallback successCallback;
@property (nonatomic,copy) WXModuleCallback errorCallback;
@property (nonatomic,strong)   CLLocationManager *locationManager;

@end
@implementation WXLocationModule
WX_EXPORT_METHOD(@selector(getCurrentPosition:success:error:))


- (void)getCurrentPosition:(NSDictionary *)param success:(WXModuleCallback)success error:(WXModuleCallback)error
{
    

    CLLocationAccuracy accuracy = [WXConvert CGFloat:param[@"accuracy"]];
    if (accuracy<=0) {
        accuracy =1000;
    }
    double distanceFilter = [WXConvert CGFloat:param[@"distanceFilter"]];

    if (distanceFilter<=0) {
        distanceFilter = kCLLocationAccuracyBest;
    }
    if (!([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] ||
          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"])) {
        //Either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription key must be present in Info.plist to use geolocation.
    }
    if (![CLLocationManager locationServicesEnabled]) {
        if (error) {
            error(@{@"error": @"Location services disabled."});
            return;
        }
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        if (error) {

            error(@{@"error": @"PositionErrorDenied"});

            return;
        }
    }
    _successCallback = success;
    _errorCallback = error;

    [self beginLocationUpdatesWithDesiredAccuracy:accuracy distanceFilter:distanceFilter];

}


#pragma mark - Private API


- (void)beginLocationUpdatesWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy distanceFilter:(CLLocationDistance)distanceFilter
{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
    }
    
    // Request location access permission
    if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] &&
        [_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    } else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] &&
               [_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    _locationManager.distanceFilter  = distanceFilter;
    _locationManager.desiredAccuracy = desiredAccuracy;
    // Start observing location
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // Create event
    CLLocation *location = locations.lastObject;
    if (_successCallback) {
        _successCallback(@{
                           @"coords": @{
                                   @"latitude": @(location.coordinate.latitude),
                                   @"longitude": @(location.coordinate.longitude),
                                   @"altitude": @(location.altitude),
                                   @"accuracy": @(location.horizontalAccuracy),
                                   @"altitudeAccuracy": @(location.verticalAccuracy),
                                   @"heading": @(location.course),
                                   @"speed": @(location.speed),
                                   },
                           @"timestamp": @([location.timestamp timeIntervalSince1970] * 1000) // in ms
                           });

    }
    [_locationManager stopUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // Check error type
    NSDictionary<NSString *, id> *jsError = nil;
    switch (error.code) {
        case kCLErrorDenied:
            jsError = @{@"error":@"PositionErrorDenied"};
            break;
        case kCLErrorNetwork:
            
            jsError = @{@"error":@"Unable to retrieve location due to a network failure"};
        
            break;
        case kCLErrorLocationUnknown:
        default:
            jsError = @{@"error":@"PositionErrorUnavailable"};

            break;
    }
    if (_errorCallback) {
        _errorCallback(jsError);
    }
    
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
