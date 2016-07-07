//
//  PNPMessage.m
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPMessage.h"

@implementation PNPMessage

#pragma mark - Constructors

- (instancetype)initWithMessage:(PNMessageResult *)message {
    NSParameterAssert(message);
    NSMutableDictionary *value = [@{
                                    @"message": message.data.message,
                                    @"subscribedChannel": message.data.subscribedChannel,
                                    @"timetoken": message.data.timetoken,
                                    @"messageIdentifier": [NSUUID UUID].UUIDString,
                                    } mutableCopy];
    if (message.data.actualChannel) {
        value[@"actualChannel"] = message.data.actualChannel;
    }
    self = [self initWithValue:value.copy];
    return self;
}

+ (instancetype)messageWithMessage:(PNMessageResult *)message {
    return [[self alloc] initWithMessage:message];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"message",
             @"subscribedChannel",
             @"timetoken",
             @"messageIdentifier",
             ];
}

+ (NSString *)primaryKey {
    return @"messageIdentifier";
}

@end
