//
//  PNPPresenceEvent.m
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPPresenceEvent.h"

@implementation PNPPresenceEvent

- (instancetype)initWithPresenceEvent:(PNPresenceEventResult *)event {
    NSParameterAssert(event);
    NSMutableDictionary *value = [@{
                                    @"identifier": [NSUUID UUID].UUIDString,
                                    @"presenceEvent": event.data.presenceEvent,
                                    @"occupancy": event.data.presence.occupancy,
                                    @"presenceTimetoken": event.data.presence.timetoken,
                                    @"subscribedChannel": event.data.subscribedChannel,
                                    @"statusCode": @(event.statusCode),
                                    } mutableCopy];
    if (event.data.actualChannel) {
        value[@"actualChannel"] = event.data.actualChannel;
    }
    self = [self initWithValue:value.copy];
    return self;
}

+ (instancetype)presenceEventWithPresenceEvent:(PNPresenceEventResult *)event {
    return [[self alloc] initWithPresenceEvent:event];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"identifier",
             @"presenceEvent",
             @"occupancy",
             @"presenceTimetoken",
             @"subscribedChannel",
             @"statusCode",
             ];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

@end
