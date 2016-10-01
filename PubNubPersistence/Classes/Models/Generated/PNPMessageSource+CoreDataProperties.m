//
//  PNPMessageSource+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPMessageSource+CoreDataProperties.h"

@implementation PNPMessageSource (CoreDataProperties)

+ (NSFetchRequest<PNPMessageSource *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MessageSource"];
}

@dynamic creationDate;
@dynamic type;
@dynamic message;

@end
