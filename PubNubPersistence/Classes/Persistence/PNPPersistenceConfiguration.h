//
//  PNPPersistenceConfiguration.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <Foundation/Foundation.h>
#import "PNPConstants.h"

@class PubNub;

@interface PNPPersistenceConfiguration : NSObject <NSCopying>

- (instancetype)initWithClient:(PubNub *)client;
+ (instancetype)persistenceConfigurationWithClient:(PubNub *)client;

@property (nonatomic, strong) PubNub *client;

@end
