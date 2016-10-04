//
//  PNPSubscribable+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPSubscribable+CoreDataProperties.h"

@implementation PNPSubscribable (CoreDataProperties)

+ (NSFetchRequest<PNPSubscribable *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Subscribable"];
}

@dynamic creationDate;
@dynamic name;
@dynamic type;
@dynamic messages;
@dynamic statuses;

@end
