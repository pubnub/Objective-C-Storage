//
//  PNPMessage+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPMessage+CoreDataProperties.h"

@implementation PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Message"];
}

@dynamic creationDate;
@dynamic payload;
@dynamic subscribables;
@dynamic timetoken;
@dynamic sources;

@end
