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

NS_ASSUME_NONNULL_BEGIN

@interface PubNubPersistence : NSObject

@property (nonatomic, strong, readonly) PubNub *client;
@property (nonatomic, strong, readonly) PNPPersistenceConfiguration *configuration;

- (instancetype)initWithConfiguration:(PNPPersistenceConfiguration *)configuration;
+ (instancetype)persistenceWithConfiguration:(PNPPersistenceConfiguration *)configuration;

@property (nonatomic, strong, readonly) RLMResults *messages;

@end

NS_ASSUME_NONNULL_END
