//
//  PNPTimetoken+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPTimetoken+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPTimetoken (CoreDataProperties)

+ (NSFetchRequest<PNPTimetoken *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic) int64_t timetoken;
@property (nullable, nonatomic, retain) NSSet<PNPStatus *> *statuses;
@property (nullable, nonatomic, retain) NSSet<PNPMessage *> *messages;

@end

@interface PNPTimetoken (CoreDataGeneratedAccessors)

- (void)addStatusesObject:(PNPStatus *)value;
- (void)removeStatusesObject:(PNPStatus *)value;
- (void)addStatuses:(NSSet<PNPStatus *> *)values;
- (void)removeStatuses:(NSSet<PNPStatus *> *)values;

- (void)addMessagesObject:(PNPMessage *)value;
- (void)removeMessagesObject:(PNPMessage *)value;
- (void)addMessages:(NSSet<PNPMessage *> *)values;
- (void)removeMessages:(NSSet<PNPMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
