//
//  PNPStatus.m
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPStatus.h"

@implementation PNPStatus

- (instancetype)initWithStatus:(PNSubscribeStatus *)status {
    NSParameterAssert(status);
    NSMutableDictionary *value = [@{
                                    @"identifier": [NSUUID UUID].UUIDString,
                                    @"stringifiedCategory": status.stringifiedCategory,
                                    @"currentTimetoken": status.currentTimetoken,
                                    @"lastTimetoken": status.lastTimeToken,
                                    @"statusCode": @(status.statusCode),
                                    } mutableCopy];
    self = [self initWithValue:value.copy];
    return self;
}

+ (instancetype)statusWithStatus:(PNSubscribeStatus *)status {
    return [[self alloc] initWithStatus:status];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"identifier",
             @"stringifiedCategory",
             @"currentTimetoken",
             @"lastTimetoken",
             @"statusCode",
             ];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

@end
