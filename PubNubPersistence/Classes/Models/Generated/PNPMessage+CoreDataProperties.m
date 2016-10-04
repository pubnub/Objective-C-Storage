//
//  PNPMessage+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPMessage+CoreDataProperties.h"

@implementation PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Message"];
}

@dynamic creationDate;
@dynamic sources;
@dynamic subscribables;
@dynamic timetoken;
@dynamic payload;

@end
