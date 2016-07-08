//
//  PNPPersistenceLayerConfiguration.m
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPPersistenceLayerConfiguration.h"

@implementation PNPPersistenceLayerConfiguration

- (instancetype)initWithClient:(PubNub *)client {
    NSParameterAssert(client);
    self = [super init];
    if (self) {
        _client = client;
        _statusStorageOption = kPNPDefaultStatusStorageOption;
        _presenceEventsStorageOption = kPNPDefaultPresenceEventsStorageOption;
    }
    return self;
}

+ (instancetype)persistenceLayerConfigurationWithClient:(PubNub *)client {
    return [[self alloc] initWithClient:client];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    PNPPersistenceLayerConfiguration *configuration = [[[self class] allocWithZone:zone] initWithClient:self.client];
    configuration.statusStorageOption = self.statusStorageOption;
    configuration.presenceEventsStorageOption = self.presenceEventsStorageOption;
    return configuration;
}

@end
