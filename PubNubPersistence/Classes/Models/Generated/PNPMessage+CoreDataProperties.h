//
//  PNPMessage+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *payload;
@property (nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, retain) PNPTimetoken *timetoken;
@property (nullable, nonatomic, retain) NSSet<PNPSubscribable *> *subscribables;

@end

@interface PNPMessage (CoreDataGeneratedAccessors)

- (void)addSubscribablesObject:(PNPSubscribable *)value;
- (void)removeSubscribablesObject:(PNPSubscribable *)value;
- (void)addSubscribables:(NSSet<PNPSubscribable *> *)values;
- (void)removeSubscribables:(NSSet<PNPSubscribable *> *)values;

@end

NS_ASSUME_NONNULL_END
