//
//  PNPPersistenceConfiguration.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPPersistenceConfiguration.h"

@interface PNPPersistenceConfiguration ()
@property (nonatomic, strong, readwrite) PubNub *client;
@end

@implementation PNPPersistenceConfiguration

- (instancetype)initWithClient:(PubNub *)client {
    NSParameterAssert(client);
    self = [super init];
    if (self) {
        _client = client;
    }
    return self;
}

+ (instancetype)persistenceConfigurationWithClient:(PubNub *)client {
    return [[self alloc] initWithClient:client];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    PNPPersistenceConfiguration *configuration = [[[self class] allocWithZone:zone] initWithClient:self.client];
    return configuration;
}

@end
