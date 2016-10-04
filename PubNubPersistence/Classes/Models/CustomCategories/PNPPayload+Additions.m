//
//  PNPPayload+Additions.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPPayload+Additions.h"

@implementation PNPPayload (Additions)

+ (instancetype)createOrUpdatePayloadWithIdentifier:(NSString *)identifier message:(nonnull id)messagePayload inContext:(nonnull NSManagedObjectContext *)context {
    NSParameterAssert(context);
    
    __block PNPPayload *createdOrUpdatedPayload = nil;
    [context performBlockAndWait:^{
        NSString *messageString = nil;
        if ([messagePayload isKindOfClass:[NSNumber class]]) {
            NSNumber *numberPayload = (NSNumber *)messagePayload;
            messageString = [NSString stringWithFormat:@"%@", numberPayload];
        } else if ([messagePayload isKindOfClass:[NSString class]]) {
            messageString = (NSString *)messagePayload;
        } else if ([messagePayload isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionaryPayload = (NSDictionary *)messagePayload;
            messageString = dictionaryPayload.debugDescription;
        }
        NSData *payloadData = nil;
        if (messageString) {
            payloadData = [messageString dataUsingEncoding:NSUTF8StringEncoding];
        }
        NSFetchRequest<PNPPayload *> *matchingFetchRequest = [self fetchRequest];
        //NSSortDescriptor *creationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:YES];
        matchingFetchRequest.predicate = [NSPredicate predicateWithFormat:@"(data == %@)", timetoken, channel, payloadData];
        NSError *matchError;
        NSArray<PNPMessage *> *matchedMessages = [matchingFetchRequest execute:&matchError];
        NSAssert(!matchError, @"Shouldn't have a matchError: %@", matchError.localizedDescription);
        if (matchedMessages.count) {
            createdOrUpdatedMessage = matchedMessages.firstObject;
        } else {
            createdOrUpdatedMessage = [[PNPMessage alloc] initWithContext:context];
            createdOrUpdatedMessage.payload = payloadData;
            createdOrUpdatedMessage.timetoken = timetoken;
            [createdOrUpdatedMessage addSubscribablesObject:channel];
        }
        PNPMessageSource *messageSource = [PNPMessageSource messageSourceWithType:source inContext:context];
        [createdOrUpdatedMessage addSourcesObject:messageSource];
    }];
    return createdOrUpdatedMessage;
}

@end
