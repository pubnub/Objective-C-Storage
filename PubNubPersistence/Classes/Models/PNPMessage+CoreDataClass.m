//
//  PNPMessage+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPMessage+CoreDataClass.h"
#import "PNPSubscribable+CoreDataClass.h"
#import "PNPTimetoken+CoreDataClass.h"

@implementation PNPMessage

+ (instancetype)messageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)context {
    PNPMessage *createdMessage = [[PNPMessage alloc] initWithContext:context];
    
    PNPTimetoken *messageTimetoken = [PNPTimetoken createOrUpdate:message.data.timetoken inContext:context];
    createdMessage.timetoken = messageTimetoken;
    id payload = message.data.message;
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
    return createdMessage;
}

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

@end
