//
//  PNPSubscribable+Additions.m
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPSubscribable+Additions.h"

@implementation PNPSubscribable (Additions)

+ (instancetype)createOrUpdateSubscribable:(NSString *)subscribable type:(PNPSubscribableType)type inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(subscribable);
    //NSParameterAssert(type);
    NSParameterAssert(context);
    __block PNPSubscribable *createdOrUpdatedSubscribable = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPSubscribable *> *matchingFetchRequest = [self fetchRequest];
        //NSSortDescriptor *creationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:YES];
        matchingFetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == %@", subscribable];
        NSError *matchError;
        NSArray<PNPSubscribable *> *matchedSubscribables = [matchingFetchRequest execute:&matchError];
        NSAssert(!matchError, @"Shouldn't have a matchError: %@", matchError.localizedDescription);
        if (matchedSubscribables.count) {
            createdOrUpdatedSubscribable = matchedSubscribables.firstObject;
        } else {
            createdOrUpdatedSubscribable = [[PNPSubscribable alloc] initWithContext:context];
            createdOrUpdatedSubscribable.name = subscribable;
            createdOrUpdatedSubscribable.type = type;
        }
    }];
    return createdOrUpdatedSubscribable;
}

+ (instancetype)createOrUpdateChannel:(NSString *)name inContext:(NSManagedObjectContext *)context {
    return [self createOrUpdateSubscribable:name type:PNPSubscribableTypeChannel inContext:context];
}

- (PNPSubscribableType)subscribableType {
    return (PNPSubscribableType)self.type;
}

@end
