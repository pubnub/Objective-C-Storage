//
//  PNPPersistenceLayer.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>

@class PubNub;
@class RLMResults;
@class PNPMessage;

@interface PNPPersistenceLayer : NSObject

@property (nonatomic, strong, readonly) PubNub *client;

- (instancetype)initWithClient:(PubNub *)client;
+ (instancetype)persistenceLayerWithClient:(PubNub *)client;

@property (nonatomic, strong, readonly) RLMResults *messages;

@end
