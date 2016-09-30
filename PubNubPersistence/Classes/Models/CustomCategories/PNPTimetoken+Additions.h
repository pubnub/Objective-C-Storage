//
//  PNPTimetoken+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPTimetoken+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PNPTimetoken (Additions)

+ (instancetype)createOrUpdate:(NSNumber *)timetoken inContext:(NSManagedObjectContext *)context;

- (NSString *)timetokenString;

@end

NS_ASSUME_NONNULL_END
