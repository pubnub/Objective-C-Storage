//
//  PNPStatus.m
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPStatus.h"

//@property long long currentTimetoken;
//@property long long lastTimetoken;
//@property NSInteger category;
//@property BOOL error;

@implementation PNPStatus

- (instancetype)initWithStatus:(PNStatus *)status {
    NSParameterAssert(status);
//    NSMutableDictionary *value = [@{
//                                    @"currentTimetoken": status.currentTimetoken,
//                                    @"lastTimetoken": status.lastTimeToken,
//                                    @"statusCode": @(status.statusCode),
//                                    } mutableCopy];
//    self = [self initWithValue:value.copy];
//    return self;
    self = [self initWithResult:status];
    if (self) {
        _category = (NSInteger)status.category;
        _error = status.isError;
    }
    return self;
}

+ (instancetype)statusWithStatus:(PNStatus *)status {
    return [[self alloc] initWithStatus:status];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"category",
             @"error",
             ];
}

+ (NSString *)primaryKey {
    return [super primaryKey];
}

@end
