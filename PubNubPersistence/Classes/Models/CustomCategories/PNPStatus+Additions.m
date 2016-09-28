//
//  PNPStatus+Additions.m
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPStatus+Additions.h"
#import "PNPTimetoken+Additions.h"

@implementation PNPStatus (Additions)

+ (instancetype)currentStatusInContext:(NSManagedObjectContext *)context {
    NSParameterAssert(context);
    __block PNPStatus *createdOrUpdatedStatus = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPStatus *> *matchingFetchRequest = [self fetchRequest];
        //NSSortDescriptor *creationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:YES];
        NSError *matchError;
        NSArray<PNPStatus *> *matchedStatuses = [matchingFetchRequest execute:&matchError];
        NSAssert(!matchError, @"Shouldn't have a matchError: %@", matchError.localizedDescription);
        NSAssert(matchedStatuses.count < 2, @"There should only ever be 0 or 1 status objects");
        if (matchedStatuses.count) {
            createdOrUpdatedStatus = matchedStatuses.firstObject;
        } else {
            createdOrUpdatedStatus = [[PNPStatus alloc] initWithContext:context];
        }
    }];
    return createdOrUpdatedStatus;
}

+ (instancetype)createOrUpdate:(PNStatus *)status inContext:(NSManagedObjectContext *)context; {
    NSParameterAssert(status);
    NSParameterAssert(context);
    __block PNPStatus *createdOrUpdatedStatus = nil;
    [context performBlockAndWait:^{
        createdOrUpdatedStatus = [self currentStatusInContext:context];
        if ([status isKindOfClass:[PNSubscribeStatus class]]) {
            PNSubscribeStatus *subscribeStatus = (PNSubscribeStatus *)status;
            createdOrUpdatedStatus.timetoken = [PNPTimetoken createOrUpdate:subscribeStatus.currentTimetoken inContext:context];
        }
    }];
    return createdOrUpdatedStatus;
}

@end
