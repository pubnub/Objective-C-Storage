//
//  PNPStatus.h
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class PNStatus;
@class PNSubscribeStatus;

@interface PNPStatus : RLMObject

@property NSString *identifier;
@property NSString *stringifiedCategory;
@property long long currentTimetoken;
@property long long lastTimetoken;
@property NSInteger statusCode;

- (instancetype)initWithStatus:(PNSubscribeStatus *)status;
+ (instancetype)statusWithStatus:(PNSubscribeStatus *)status;

@end
