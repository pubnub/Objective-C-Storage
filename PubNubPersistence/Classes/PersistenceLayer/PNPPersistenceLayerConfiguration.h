//
//  PNPPersistenceLayerConfiguration.h
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <Foundation/Foundation.h>

@class PubNub;

@interface PNPPersistenceLayerConfiguration : NSObject <NSCopying>

- (instancetype)initWithClient:(PubNub *)client;
+ (instancetype)persistenceLayerConfigurationWithClient:(PubNub *)client;

@property (nonatomic, strong) PubNub *client;

@end
