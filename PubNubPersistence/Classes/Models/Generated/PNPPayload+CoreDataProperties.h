//
//  PNPPayload+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPPayload+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPPayload (CoreDataProperties)

+ (NSFetchRequest<PNPPayload *> *)fetchRequest;

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSSet<PNPMessage *> *messages;

@end

@interface PNPPayload (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(PNPMessage *)value;
- (void)removeMessagesObject:(PNPMessage *)value;
- (void)addMessages:(NSSet<PNPMessage *> *)values;
- (void)removeMessages:(NSSet<PNPMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
