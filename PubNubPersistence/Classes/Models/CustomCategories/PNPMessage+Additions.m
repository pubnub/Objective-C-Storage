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
    PNPMessage *createdMessage = [[PNPMessage alloc] initWithContext:context];
    
    PNPMessageSource *messageSource = [PNPMessageSource messageSourceWithType:source inContext:context];
    [createdMessage addSourcesObject:messageSource];
    
    PNPTimetoken *messageTimetoken = [PNPTimetoken createOrUpdate:timetoken inContext:context];
    createdMessage.timetoken = messageTimetoken;
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
    
    return createdMessage;
}

+ (instancetype)messageWithSource:(PNPMessageSourceType)source channel:(NSString *)channel timetoken:(NSNumber *)timetoken message:(id)message inContext:(NSManagedObjectContext *)context {
    
    PNPSubscribable *fetchedChannel = [PNPSubscribable createOrUpdateChannel:channel inContext:context];
    return [self messageWithSource:source fetchedChannel:fetchedChannel timetoken:timetoken message:message inContext:context];
}

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
