//
//  PNPMessageSource+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPConstants.h"
#import "PNPMessageSource+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessageSource (Additions)

- (PNPMessageSourceType)sourceType;

+ (instancetype)messageSourceWithType:(PNPMessageSourceType)source inContext:(NSManagedObjectContext *)context;
+ (instancetype)subscribeMessageSourceInContext:(NSManagedObjectContext *)context;
+ (instancetype)historyMessageSourceInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
