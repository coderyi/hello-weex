//
//  WXSearchBarComponent.m
//  Monkey
//
//  Created by coderyi on 2016/10/12.
//  Copyright © 2016年 www.coderyi.com. All rights reserved.
//

#import "WXSearchBarComponent.h"

@interface WXSearchBarView : UISearchBar

@end

@implementation WXSearchBarView

@end
@interface WXSearchBarComponent()<UISearchBarDelegate>
@property (nonatomic, strong)   WXSearchBarView    *searchBarView;
@property(nonatomic,copy) NSString *tintColor;
@property (nonatomic) BOOL clickEvent;

@end
@implementation WXSearchBarComponent
- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        _tintColor = attributes[@"tintColor"] ? [WXConvert NSString:attributes[@"tintColor"]] : @"";

    }
    return self;
}
- (UIView *)loadView
{
    return [[WXSearchBarView alloc] init];
}
- (void)viewDidLoad
{
    _searchBarView = (WXSearchBarView *)self.view;
    _searchBarView.tintColor = [WXConvert UIColor:_tintColor];
    _searchBarView.delegate = self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self didClickSearchBarAction:searchBar];
    [_searchBarView endEditing:YES];
}
- (void)addEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"click"]) {
        _clickEvent = YES;
    }
}

- (void)removeEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:@"click"]) {
        _clickEvent = NO;
    }
}
- (void)didClickSearchBarAction:(UISearchBar *)searchBar{
    if (_clickEvent) {
        [self fireEvent:@"click" params:@{@"value":searchBar.text} domChanges:@{@"attrs": @{@"checked": searchBar.text}}];
    }
}

@end
