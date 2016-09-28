//
//  PNPStatus+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPStatus+CoreDataProperties.h"

@implementation PNPStatus (CoreDataProperties)

+ (NSFetchRequest<PNPStatus *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Status"];
}

@dynamic lastStatusCode;
@dynamic currentUUID;
@dynamic timetoken;
@dynamic subscribables;

@end
