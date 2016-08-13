//
//  PNPSubscribeStatus.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <Foundation/Foundation.h>
#import "PNPStatus.h"

@class PNSubscribeStatus;

@interface PNPSubscribeStatus : PNPStatus

@property NSString *subscribedChannel;
@property NSString *actualChannel;
@property long long timetoken;
@property long long currentTimetoken;
@property long long lastTimetoken;

- (instancetype)initWithSubscribeStatus:(PNSubscribeStatus *)status;
+ (instancetype)subscribeStatusWithSubscribeStatus:(PNSubscribeStatus *)status;

@end
