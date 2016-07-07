//
//  PNPPersistenceLayer.m
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPConstants.h"
#import "PNPPersistenceLayer.h"
#import "PNPMessage.h"

@interface PNPPersistenceLayer () <PNObjectEventListener>
@property (nonatomic, strong, readwrite) PubNub *client;
@property (nonatomic, strong) dispatch_queue_t networkQueue;

@end

@implementation PNPPersistenceLayer

- (instancetype)initWithClient:(PubNub *)client {
    NSParameterAssert(client);
    self = [super init];
    if (self) {
        _networkQueue = dispatch_queue_create("com.PubNubPersistence.NetworkingQueue", DISPATCH_QUEUE_CONCURRENT);
        _client = client;
        [_client addListener:self];
    }
    return self;
}

+ (instancetype)persistenceLayerWithClient:(PubNub *)client {
    return [[self alloc] initWithClient:client];
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
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
}

@end
