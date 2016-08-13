//
//  PubNubPersistence.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <Foundation/Foundation.h>

#import "PNPConstants.h"

@class PubNub;
@class PNPPersistenceConfiguration;
@class RLMResults;
@class PNPMessage;
@class PNPStatus;

@interface PubNubPersistence : NSObject

@property (nonatomic, strong, readonly) PubNub *client;
@property (nonatomic, strong, readonly) PNPPersistenceConfiguration *configuration;

- (instancetype)initWithConfiguration:(PNPPersistenceConfiguration *)configuration;
+ (instancetype)persistenceWithConfiguration:(PNPPersistenceConfiguration *)configuration;

@property (nonatomic, assign) PNPStatusStorageOptions statusStorageOption;
@property (nonatomic, assign) PNPPresenceEventsStorageOptions presenceEventsStorageOption;

@property (nonatomic, strong, readonly) RLMResults *messages;
@property (nonatomic, strong, readonly) RLMResults *statuses;
@property (nonatomic, strong, readonly) RLMResults *presenceEvents;
@property (nonatomic, strong, readonly) PNPStatus *currentStatus;

@end

