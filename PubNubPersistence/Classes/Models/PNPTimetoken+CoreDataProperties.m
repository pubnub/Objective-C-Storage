//
//  PNPTimetoken+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPTimetoken+CoreDataProperties.h"

@implementation PNPTimetoken (CoreDataProperties)

+ (NSFetchRequest<PNPTimetoken *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Timetoken"];
}

@dynamic creationDate;
@dynamic timetoken;
@dynamic statuses;
@dynamic messages;

@end
