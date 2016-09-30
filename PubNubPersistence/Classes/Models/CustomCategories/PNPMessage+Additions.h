//
//  PNPMessage+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPMessage+CoreDataClass.h"

@class PNMessageResult;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage (Additions)

+ (instancetype)messageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)context;
+ (instancetype)messageWithChannel:(NSString *)channel timetoken:(NSNumber *)timetoken message:(nullable id)message inContext:(NSManagedObjectContext *)context;

- (NSString *)messageString;
- (NSString *)subscribablesString;

@end

NS_ASSUME_NONNULL_END
