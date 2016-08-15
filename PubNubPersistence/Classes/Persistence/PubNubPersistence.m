//
//  PubNubPersistence.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPPersistenceConfiguration.h"
#import "PubNubPersistence.h"
#import "PNPMessage.h"

@interface PubNubPersistence () <PNObjectEventListener>
@property (nonatomic, strong, readwrite) PNPPersistenceConfiguration *configuration;

@property (nonatomic, strong) dispatch_queue_t networkQueue;

@end

@implementation PubNubPersistence

- (instancetype)initWithConfiguration:(PNPPersistenceConfiguration *)configuration {
    NSParameterAssert(configuration);
    self = [super init];
    if (self) {
        _networkQueue = dispatch_queue_create("com.PubNubPersistence.NetworkingQueue", DISPATCH_QUEUE_CONCURRENT);
        _configuration = configuration.copy;
        // this should never be nil
        [_configuration.client addListener:self];
    }
    return self;
}

+ (instancetype)persistenceWithConfiguration:(PNPPersistenceConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

#pragma mark - Getters

- (PubNub *)client {
    return self.configuration.client;
}

#pragma mark - Methods

- (RLMResults *)messages {
    return [PNPMessage allObjects];
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    dispatch_async(self.networkQueue, ^{
        RLMRealm *defaultRealm = [RLMRealm defaultRealm];
        [defaultRealm beginWriteTransaction];
        PNPMessage *realmMessage = [PNPMessage messageWithMessage:message];
        [defaultRealm addOrUpdateObject:realmMessage];
        [defaultRealm commitWriteTransaction];
    });
}

@end
