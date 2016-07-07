//
//  PNPMessage.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
//#import "RLMObject.h"

@class PNMessageResult;

@interface PNPMessage : RLMObject

@property NSString *message;
@property NSString *subscribedChannel;
@property NSString *actualChannel;
@property long long timetoken;
@property NSString *messageIdentifier;

- (instancetype)initWithMessage:(PNMessageResult *)message;
+ (instancetype)messageWithMessage:(PNMessageResult *)message;


@end
