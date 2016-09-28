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

+ (instancetype)createOrUpdate:(NSNumber *)timetoken inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(timetoken);
    NSParameterAssert(context);
    __block PNPTimetoken *createdOrUpdatedTimetoken = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPTimetoken *> *matchingFetchRequest = [self fetchRequest];
        //NSSortDescriptor *creationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:YES];
        matchingFetchRequest.predicate = [NSPredicate predicateWithFormat:@"timetoken == %@", timetoken];
        NSError *matchError;
        NSArray<PNPTimetoken *> *matchedTimetokens = [matchingFetchRequest execute:&matchError];
        NSAssert(!matchError, @"Shouldn't have a matchError: %@", matchError.localizedDescription);
        if (matchedTimetokens.count) {
            createdOrUpdatedTimetoken = matchedTimetokens.firstObject;
        } else {
            createdOrUpdatedTimetoken = [[PNPTimetoken alloc] initWithContext:context];
            createdOrUpdatedTimetoken.timetoken = timetoken.unsignedLongLongValue;
        }
    }];
    return createdOrUpdatedTimetoken;
}

@dynamic creationDate;
@dynamic timetoken;
@dynamic statuses;
@dynamic messages;

@end
