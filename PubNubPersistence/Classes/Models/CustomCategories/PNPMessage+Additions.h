//
//  PNPMessage+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPMessage+CoreDataClass.h"
#import "PNPConstants.h"

@class PNMessageResult;
@class PNPTimetoken;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage (Additions)

+ (instancetype)subscribedMessageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)context;
+ (instancetype)historyMessageWithFetchedChannel:(PNPSubscribable *)channel timetoken:(NSNumber *)timetoken message:(nullable id)message inContext:(NSManagedObjectContext *)context;
+ (instancetype)messageWithSource:(PNPMessageSourceType)source channel:(NSString *)channel timetoken:(NSNumber *)timetoken message:(nullable id)message inContext:(NSManagedObjectContext *)context;
+ (instancetype)messageWithSource:(PNPMessageSourceType)source fetchedChannel:(PNPSubscribable *)channel timetoken:(NSNumber *)timetoken message:(nullable id)message inContext:(NSManagedObjectContext *)context;

- (NSString *)messageString;
- (NSString *)subscribablesString;

@end

NS_ASSUME_NONNULL_END
