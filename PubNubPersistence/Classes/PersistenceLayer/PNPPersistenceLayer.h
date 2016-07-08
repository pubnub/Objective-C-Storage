//
//  PNPPersistenceLayer.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>
#import "PNPConstants.h"

@class PubNub;
@class PNPPersistenceLayerConfiguration;
@class RLMResults;
@class PNPMessage;
@class PNPStatus;

@interface PNPPersistenceLayer : NSObject

@property (nonatomic, strong, readonly) PubNub *client;
@property (nonatomic, strong, readonly) PNPPersistenceLayerConfiguration *configuration;

- (instancetype)initWithConfiguration:(PNPPersistenceLayerConfiguration *)configuration;
+ (instancetype)persistenceLayerWithConfiguration:(PNPPersistenceLayerConfiguration *)configuration;

@property (nonatomic, assign) PNPStatusStorageOptions statusStorageOption;
@property (nonatomic, assign) PNPPresenceEventsStorageOptions presenceEventsStorageOption;

@property (nonatomic, strong, readonly) RLMResults *messages;
@property (nonatomic, strong, readonly) RLMResults *statuses;
@property (nonatomic, strong, readonly) RLMResults *presenceEvents;
@property (nonatomic, strong, readonly) PNPStatus *currentStatus;

@end
