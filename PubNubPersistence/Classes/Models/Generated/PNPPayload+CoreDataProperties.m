//
//  PNPPayload+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPPayload+CoreDataProperties.h"

@implementation PNPPayload (CoreDataProperties)

+ (NSFetchRequest<PNPPayload *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Payload"];
}

@dynamic uuid;
@dynamic creationDate;
@dynamic data;
@dynamic messages;

@end
