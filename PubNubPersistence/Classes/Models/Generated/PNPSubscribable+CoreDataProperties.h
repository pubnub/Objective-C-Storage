//
//  PNPSubscribable+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPSubscribable+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPSubscribable (CoreDataProperties)

+ (NSFetchRequest<PNPSubscribable *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, retain) NSSet<PNPMessage *> *messages;
@property (nullable, nonatomic, retain) NSSet<PNPStatus *> *statuses;

@end

@interface PNPSubscribable (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(PNPMessage *)value;
- (void)removeMessagesObject:(PNPMessage *)value;
- (void)addMessages:(NSSet<PNPMessage *> *)values;
- (void)removeMessages:(NSSet<PNPMessage *> *)values;

- (void)addStatusesObject:(PNPStatus *)value;
- (void)removeStatusesObject:(PNPStatus *)value;
- (void)addStatuses:(NSSet<PNPStatus *> *)values;
- (void)removeStatuses:(NSSet<PNPStatus *> *)values;

@end

NS_ASSUME_NONNULL_END
