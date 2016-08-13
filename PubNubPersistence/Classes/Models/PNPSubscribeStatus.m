//
//  PNPSubscribeStatus.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPStatus.h"
#import "PNPSubscribeStatus.h"

//@property NSString *subscribedChannel;
//@property NSString *actualChannel;
//@property long long timetoken;
//@property long long currentTimetoken;
//@property long long lastTimetoken;

@implementation PNPSubscribeStatus

- (instancetype)initWithSubscribeStatus:(PNSubscribeStatus *)status {
//    self = [super initWithStatus:status];
//    if (self) {
//        _subscribedChannel = status.data.subscribedChannel;
//        _actualChannel = status.data.actualChannel;
//        _timetoken = status.data.timetoken;
//        _currentTimetoken = status.currentTimetoken;
//        _lastTimetoken = status.lastTimeToken;
//    }
    NSMutableDictionary *value = [@{
                                    @"status": [PNPStatus statusWithStatus:(PNStatus *)status],
                                    @"identifier": [NSUUID UUID].UUIDString,
                                    @"timetoken": status.data.timetoken,
                                    @"currentTimetoken": status.currentTimetoken,
                                    @"lastTimetoken": status.lastTimeToken,
//                                    @"subscribedChannel": status.data.subscribedChannel,
//                                    @"actualChannel": status.data.actualChannel,
                                    } mutableCopy];
    if (status.data.subscribedChannel) {
        value[@"subscribedChannel"] = status.data.subscribedChannel;
    }
    if (status.data.actualChannel) {
        value[@"actualChannel"] = status.data.actualChannel;
    }
#warning should this be self init?
    self = [self initWithValue:value.copy];
    return self;
}

+ (instancetype)subscribeStatusWithSubscribeStatus:(PNSubscribeStatus *)status {
    return [[self alloc] initWithSubscribeStatus:status];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"identifier",
             @"timetoken",
             @"currentTimetoken",
             @"lastTimetoken",
             ];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

@end
