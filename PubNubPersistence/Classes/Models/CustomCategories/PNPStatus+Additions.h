//
//  PNPStatus+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPStatus+CoreDataClass.h"

@class PNStatus;

NS_ASSUME_NONNULL_BEGIN

@interface PNPStatus (Additions)

+ (instancetype)currentStatusInContext:(NSManagedObjectContext *)context;

+ (instancetype)createOrUpdate:(PNStatus *)status inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
