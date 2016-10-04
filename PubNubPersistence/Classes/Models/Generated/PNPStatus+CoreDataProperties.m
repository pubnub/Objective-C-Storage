//
//  PNPStatus+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPStatus+CoreDataProperties.h"

@implementation PNPStatus (CoreDataProperties)

+ (NSFetchRequest<PNPStatus *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Status"];
}

@dynamic creationDate;
@dynamic currentUUID;
@dynamic lastStatusCode;
@dynamic subscribables;
@dynamic timetoken;

@end
