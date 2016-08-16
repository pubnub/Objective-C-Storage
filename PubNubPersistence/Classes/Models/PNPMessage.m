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
                                    @"rawMessage": [[self class] dataForMessage:message.data.message],
                                    @"subscribedChannel": message.data.subscribedChannel,
                                    @"timetoken": message.data.timetoken,
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

#pragma mark - Additional properties

- (id)message {
    return [[self class] messageForData:self.rawMessage];
}

#pragma mark - Helpers

+ (NSData *)dataForMessage:(id)message {
    NSParameterAssert(message);
    return [NSKeyedArchiver archivedDataWithRootObject:message];
}

+ (id)messageForData:(NSData *)data {
    NSParameterAssert(data);
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"rawMessage",
             @"subscribedChannel",
             @"timetoken",
             @"identifier",
             @"creationDate",
             ];
}

+ (NSDictionary *)defaultPropertyValues {
    return @{
             @"creationDate": [NSDate date],
             @"identifier": [NSUUID UUID].UUIDString,
             };
}

+ (NSArray *)ignoredProperties {
    return @[
             @"message",
             ];
}

+ (NSArray *)indexedProperties {
    return @[
             @"creationDate",
             ];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

@end
