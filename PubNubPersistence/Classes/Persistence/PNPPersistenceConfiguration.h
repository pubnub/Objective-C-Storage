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

NS_ASSUME_NONNULL_BEGIN

@interface PNPPersistenceConfiguration : NSObject <NSCopying>

- (instancetype)initWithClient:(PubNub *)client;
+ (instancetype)persistenceConfigurationWithClient:(PubNub *)client;

@property (nonatomic, strong, readonly) PubNub *client;

@end

NS_ASSUME_NONNULL_END
