//
//  PNPMessage+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPMessage+CoreDataProperties.h"

@implementation PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Message"];
}

@dynamic payload;
@dynamic creationDate;
@dynamic timetoken;
@dynamic subscribables;

@end
