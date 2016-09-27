//
//  PNPMessage+CoreDataProperties.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPMessage+CoreDataProperties.h"
#import "PNPTimetoken+CoreDataProperties.h"

@implementation PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Message"];
}

+ (instancetype)messageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)moc {
    //PNPMessage *createdMessage = [[self alloc] initWithContext:moc];
    PNPMessage *createdMessage = [[self alloc] initWithEntity:[PNPMessage entity] insertIntoManagedObjectContext:moc];
    createdMessage.payload = [message.data.message dataUsingEncoding:NSUTF8StringEncoding];
    PNPTimetoken *timetoken = [[PNPTimetoken alloc] initWithContext:moc];
    timetoken.timetoken = message.data.timetoken.unsignedLongLongValue;
    createdMessage.timetoken = timetoken;
    return timetoken;
}

@dynamic payload;
@dynamic timetoken;
@dynamic subscribables;

@end
