//
//  PNPSubscribeStatus.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPSubscribeStatus.h"

//@property NSString *subscribedChannel;
//@property NSString *actualChannel;
//@property long long timetoken;
//@property long long currentTimetoken;
//@property long long lastTimetoken;

@implementation PNPSubscribeStatus

- (instancetype)initWithSubscribeStatus:(PNSubscribeStatus *)status {
    self = [super initWithStatus:status];
    if (self) {
        _subscribedChannel = status.data.subscribedChannel;
        _actualChannel = status.data.actualChannel;
        _timetoken = status.data.timetoken;
        _currentTimetoken = status.currentTimetoken;
        _lastTimetoken = status.lastTimeToken;
    }
}

+ (instancetype)subscribeStatusWithSubscribeStatus:(PNSubscribeStatus *)status {
    return [[self alloc] initWithSubscribeStatus:status];
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
