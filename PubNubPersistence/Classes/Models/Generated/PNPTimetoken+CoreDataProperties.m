//
//  PNPTimetoken+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPTimetoken+CoreDataProperties.h"

@implementation PNPTimetoken (CoreDataProperties)

+ (NSFetchRequest<PNPTimetoken *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Timetoken"];
}

@dynamic creationDate;
@dynamic timetoken;
@dynamic messages;
@dynamic statuses;

@end
