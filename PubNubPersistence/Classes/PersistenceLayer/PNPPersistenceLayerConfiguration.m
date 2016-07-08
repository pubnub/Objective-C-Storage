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
    }
    return self;
}

+ (instancetype)persistenceLayerConfigurationWithClient:(PubNub *)client {
    return [[self alloc] initWithClient:client];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    PNPPersistenceLayerConfiguration *configuration = [[[self class] allocWithZone:zone] initWithClient:self.client];
    return configuration;
}

@end
