//
//  PNPPersistenceLayer.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>

@class PubNub;

@interface PNPPersistenceLayer : NSObject

@property (nonatomic, strong, readonly) PubNub *client;

- (instancetype)initWithClient:(PubNub *)client;
+ (instancetype)persistenceLayerWithClient:(PubNub *)client;

@end
