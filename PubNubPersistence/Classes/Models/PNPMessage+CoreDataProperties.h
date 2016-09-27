//
//  PNPMessage+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPMessage+CoreDataClass.h"

@class PNMessageResult;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest;
+ (instancetype)messageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)moc;

@property (nullable, nonatomic, retain) NSData *payload;
@property (nonatomic, retain) PNPTimetoken *timetoken;
@property (nullable, nonatomic, retain) PNPSubscribable *subscribables;

@end

NS_ASSUME_NONNULL_END
