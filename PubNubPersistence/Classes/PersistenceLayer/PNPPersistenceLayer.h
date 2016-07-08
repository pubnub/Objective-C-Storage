//
//  PNPPersistenceLayer.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>

@class PubNub;
@class PNPPersistenceLayerConfiguration;
@class RLMResults;
@class PNPMessage;

@interface PNPPersistenceLayer : NSObject

@property (nonatomic, strong, readonly) PubNub *client;
@property (nonatomic, strong, readonly) PNPPersistenceLayerConfiguration *configuration;

- (instancetype)initWithConfiguration:(PNPPersistenceLayerConfiguration *)configuration;
+ (instancetype)persistenceLayerWithConfiguration:(PNPPersistenceLayerConfiguration *)configuration;

@property (nonatomic, strong, readonly) RLMResults *messages;

@end
