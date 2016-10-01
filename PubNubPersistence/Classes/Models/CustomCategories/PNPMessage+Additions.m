//
//  PNPMessage+Additions.m
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPMessage+Additions.h"
#import "PNPTimetoken+Additions.h"
#import "PNPSubscribable+Additions.h"
#import "PNPMessageSource+Additions.h"

@implementation PNPMessage (Additions)

#pragma mark - Constructors

+ (instancetype)subscribedMessageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)context {
    /*
     NSString *subscriptionMatch = message.data.subscription;
     if (subscriptionMatch) {
     PNPSubscribable *
     }
     */
    return [self messageWithSource:PNPMessageSourceTypeSubscribe channel:message.data.channel timetoken:message.data.timetoken message:message.data.message inContext:context];
}

+ (instancetype)historyMessageWithFetchedChannel:(PNPSubscribable *)channel timetoken:(NSNumber *)timetoken message:(id)message inContext:(NSManagedObjectContext *)context {
    return [self messageWithSource:PNPMessageSourceTypeHistory fetchedChannel:channel timetoken:timetoken message:message inContext:context];
}

+ (instancetype)messageWithSource:(PNPMessageSourceType)source fetchedChannel:(PNPSubscribable *)channel timetoken:(NSNumber *)timetoken message:(id)message inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(channel.subscribableType == PNPSubscribableTypeChannel);
    /*
    PNPMessage *createdMessage = [[PNPMessage alloc] initWithContext:context];
    
    PNPMessageSource *messageSource = [PNPMessageSource messageSourceWithType:source inContext:context];
    [createdMessage addSourcesObject:messageSource];
     */
    
    PNPTimetoken *messageTimetoken = [PNPTimetoken createOrUpdate:timetoken inContext:context];
    return [self createOrUpdateMessage:message withFetchedChannel:channel fetchedTimetoken:messageTimetoken source:source inContext:context];
    //createdMessage.timetoken = messageTimetoken;
    /*
    id payload = message;
    NSString *messageString = nil;
    if ([payload isKindOfClass:[NSNumber class]]) {
        NSNumber *numberPayload = (NSNumber *)payload;
        messageString = [NSString stringWithFormat:@"%@", numberPayload];
    } else if ([payload isKindOfClass:[NSString class]]) {
        messageString = (NSString *)payload;
    } else if ([payload isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionaryPayload = (NSDictionary *)payload;
        messageString = dictionaryPayload.debugDescription;
    }
    if (messageString) {
        createdMessage.payload = [messageString dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    [createdMessage addSubscribablesObject:channel];
     */
    
    //return createdMessage;
}

+ (instancetype)messageWithSource:(PNPMessageSourceType)source channel:(NSString *)channel timetoken:(NSNumber *)timetoken message:(id)message inContext:(NSManagedObjectContext *)context {
    
    PNPSubscribable *fetchedChannel = [PNPSubscribable createOrUpdateChannel:channel inContext:context];
    return [self messageWithSource:source fetchedChannel:fetchedChannel timetoken:timetoken message:message inContext:context];
}

+ (instancetype)createOrUpdateMessage:(id)message withFetchedChannel:(PNPSubscribable *)channel fetchedTimetoken:(PNPTimetoken *)timetoken source:(PNPMessageSourceType)source inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(channel.subscribableType == PNPSubscribableTypeChannel);
    
    __block PNPMessage *createdOrUpdatedMessage = nil;
    [context performBlockAndWait:^{
        id payload = message;
        NSString *messageString = nil;
        if ([payload isKindOfClass:[NSNumber class]]) {
            NSNumber *numberPayload = (NSNumber *)payload;
            messageString = [NSString stringWithFormat:@"%@", numberPayload];
        } else if ([payload isKindOfClass:[NSString class]]) {
            messageString = (NSString *)payload;
        } else if ([payload isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionaryPayload = (NSDictionary *)payload;
            messageString = dictionaryPayload.debugDescription;
        }
        NSData *payloadData = nil;
        if (messageString) {
            payloadData = [messageString dataUsingEncoding:NSUTF8StringEncoding];
        }
        NSFetchRequest<PNPMessage *> *matchingFetchRequest = [self fetchRequest];
        //NSSortDescriptor *creationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:YES];
        matchingFetchRequest.predicate = [NSPredicate predicateWithFormat:@"(timetoken == %@) AND (%@ IN subscribables) AND (payload == %@)", timetoken, channel, payloadData];
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

#pragma mark - Accessors

- (NSString *)messageString {
    return [[NSString alloc] initWithData:self.payload encoding:NSUTF8StringEncoding];
}

- (NSString *)subscribablesString {
    NSMutableString *buildingString = [@"" mutableCopy];
    for (PNPSubscribable *subscribable in self.subscribables) {
        if (buildingString.length) {
            [buildingString appendString:@", "];
        }
        [buildingString appendString:subscribable.name];
    }
    return buildingString.copy;
}

@end
