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

@implementation PNPMessage (Additions)

+ (instancetype)messageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)context {
    /*
     NSString *subscriptionMatch = message.data.subscription;
     if (subscriptionMatch) {
     PNPSubscribable *
     }
     */
    return [self messageWithChannel:message.data.channel timetoken:message.data.timetoken message:message.data.message inContext:context];
}

+ (instancetype)messageWithFetchedChannel:(PNPSubscribable *)channel timetoken:(NSNumber *)timetoken message:(id)message inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(channel.subscribableType == PNPSubscribableTypeChannel);
    PNPMessage *createdMessage = [[PNPMessage alloc] initWithContext:context];
    
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

+ (instancetype)messageWithChannel:(NSString *)channel timetoken:(NSNumber *)timetoken message:(id)message inContext:(NSManagedObjectContext *)context {
    PNPMessage *createdMessage = [[PNPMessage alloc] initWithContext:context];
    
    PNPSubscribable *fetchedChannel = [PNPSubscribable createOrUpdateChannel:channel inContext:context];
    return [self messageWithFetchedChannel:fetchedChannel timetoken:timetoken message:message inContext:context];
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
