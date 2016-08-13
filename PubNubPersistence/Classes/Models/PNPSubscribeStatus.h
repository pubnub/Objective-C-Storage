//
//  PNPSubscribeStatus.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <Foundation/Foundation.h>

@class PNSubscribeStatus;

@interface PNPSubscribeStatus : RLMObject

@property NSString *subscribedChannel;
@property NSString *actualChannel;
@property long long timetoken;
@property long long currentTimetoken;
@property long long lastTimetoken;
@property NSString *identifier;

@property PNPStatus *status;

- (instancetype)initWithSubscribeStatus:(PNSubscribeStatus *)status;
+ (instancetype)subscribeStatusWithSubscribeStatus:(PNSubscribeStatus *)status;

@end
