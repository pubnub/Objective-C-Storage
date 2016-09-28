//
//  PNPTimetoken+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPTimetoken+CoreDataClass.h"

@interface PNPTimetoken (Additions)

+ (instancetype)createOrUpdate:(NSNumber *)timetoken inContext:(NSManagedObjectContext *)context;

- (NSString *)timetokenString;

@end
