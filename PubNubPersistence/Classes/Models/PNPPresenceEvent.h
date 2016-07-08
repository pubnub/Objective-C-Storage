//
//  PNPPresenceEvent.h
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class PNPresenceEventResult;

@interface PNPPresenceEvent : RLMObject

@property NSString *identifier;
@property NSString *presenceEvent;
@property NSInteger occupancy;
@property long long presenceTimetoken;
@property NSString *subscribedChannel;
@property NSString *actualChannel;
@property NSInteger statusCode;

- (instancetype)initWithPresenceEvent:(PNPresenceEventResult *)event;
+ (instancetype)presenceEventWithPresenceEvent:(PNPresenceEventResult *)event;

@end
