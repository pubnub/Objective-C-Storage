//
//  PNPMessage.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class PNMessageResult;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage : RLMObject

@property NSData *rawMessage;
@property (readonly) id message;
@property NSString *subscribedChannel;
@property NSString *actualChannel;
@property long long timetoken;
@property NSString *identifier;
@property NSDate *creationDate;

- (instancetype)initWithMessage:(PNMessageResult *)message;
+ (instancetype)messageWithMessage:(PNMessageResult *)message;

@end

NS_ASSUME_NONNULL_END
