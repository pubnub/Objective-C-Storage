//
//  PNPPersistenceLayer.m
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPPersistenceLayer.h"
#import "PNPPersistenceLayerConfiguration.h"
#import "PNPMessage.h"
#import "PNPPresenceEvent.h"
#import "PNPStatus.h"

@interface PNPPersistenceLayer () <PNObjectEventListener>
@property (nonatomic, strong, readwrite) PNPPersistenceLayerConfiguration *configuration;

@property (nonatomic, strong) dispatch_queue_t networkQueue;

@end

@implementation PNPPersistenceLayer

@synthesize statusStorageOption = _statusStorageOption;
@synthesize presenceEventsStorageOption = _presenceEventsStorageOption;

- (instancetype)initWithConfiguration:(PNPPersistenceLayerConfiguration *)configuration {
    NSParameterAssert(configuration);
    self = [super init];
    if (self) {
        _networkQueue = dispatch_queue_create("com.PubNubPersistence.NetworkingQueue", DISPATCH_QUEUE_CONCURRENT);
        _configuration = configuration.copy;
        // this should never be nil
        [_configuration.client addListener:self];
        _statusStorageOption = configuration.statusStorageOption;
        _presenceEventsStorageOption = configuration.presenceEventsStorageOption;
    }
    return self;
}

+ (instancetype)persistenceLayerWithConfiguration:(PNPPersistenceLayerConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

#pragma mark - Getters

- (PubNub *)client {
    return self.configuration.client;
}

- (void)setStatusStorageOption:(PNPStatusStorageOptions)statusStorageOption {
    PNPWeakify(self);
    dispatch_barrier_async(self.networkQueue, ^{
        PNPStrongify(self);
        self->_statusStorageOption = statusStorageOption;
    });
}

- (PNPStatusStorageOptions)statusStorageOption {
    __block PNPStatusStorageOptions currentStatusStorageOption;
    PNPWeakify(self);
    dispatch_sync(self.networkQueue, ^{
        PNPStrongify(self);
        currentStatusStorageOption = self->_statusStorageOption;
    });
    return currentStatusStorageOption;
}

- (void)setPresenceEventsStorageOption:(PNPPresenceEventsStorageOptions)presenceEventsStorageOption {
    PNPWeakify(self);
    dispatch_barrier_async(self.networkQueue, ^{
        PNPStrongify(self);
        self->_presenceEventsStorageOption = presenceEventsStorageOption;
    });
}

- (PNPPresenceEventsStorageOptions)presenceEventsStorageOption {
    __block PNPPresenceEventsStorageOptions currentPresenceEventsStorageOption;
    PNPWeakify(self);
    dispatch_sync(self.networkQueue, ^{
        PNPStrongify(self);
        currentPresenceEventsStorageOption = self->_presenceEventsStorageOption;
    });
    return currentPresenceEventsStorageOption;
}

#pragma mark - Methods

- (RLMResults *)messages {
    return [PNPMessage allObjects];
}

- (RLMResults *)statuses {
    return [PNPStatus allObjects];
}

- (RLMResults *)presenceEvents {
    return [PNPPresenceEvent allObjects];
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // handle heartbeat at some point!
    PNSubscribeStatus *subscribeStatus = (PNSubscribeStatus *)status;
    PNPWeakify(self);
    dispatch_async(self.networkQueue, ^{
        PNPStrongify(self);
        // need to figure out the different options and implement all of them
        switch (self->_statusStorageOption) {
            case PNPStatusStorageOptionsCurrentStatus:
            {
                
            }
//                break; // uncomment this at some point
            case PNPStatusStorageOptionsAll:
            {
                RLMRealm *defaultRealm = [RLMRealm defaultRealm];
                [defaultRealm beginWriteTransaction];
                PNPStatus *realmStatus = [PNPStatus statusWithStatus:subscribeStatus];
                [defaultRealm addOrUpdateObject:realmStatus];
                [defaultRealm commitWriteTransaction];
            }
                break;
            case PNPStatusStorageOptionsNone:
                break;
        }
    });
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    dispatch_async(self.networkQueue, ^{
        @autoreleasepool {
            RLMRealm *defaultRealm = [RLMRealm defaultRealm];
            [defaultRealm beginWriteTransaction];
            PNPMessage *realmMessage = [PNPMessage messageWithMessage:message];
            [defaultRealm addOrUpdateObject:realmMessage];
            [defaultRealm commitWriteTransaction];
        }
    });
}

- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    PNPWeakify(self);
    dispatch_async(self.networkQueue, ^{
        PNPStrongify(self);
        // need to figure out the different options and implement all of them
        switch (self->_presenceEventsStorageOption) {
            case PNPPresenceEventsStorageOptionsAll:
            {
                RLMRealm *defaultRealm = [RLMRealm defaultRealm];
                [defaultRealm beginWriteTransaction];
                PNPPresenceEvent *realmPresenceEvent = [PNPPresenceEvent presenceEventWithPresenceEvent:event];
                [defaultRealm addOrUpdateObject:realmPresenceEvent];
                [defaultRealm commitWriteTransaction];
            }
                break;
            case PNPPresenceEventsStorageOptionsNone:
            {
                // do nothing
            }
                break;
        }
    });
}

@end
