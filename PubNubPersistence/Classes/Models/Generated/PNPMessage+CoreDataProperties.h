//
//  PNPMessage+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPMessage+CoreDataClass.h"

@class PNPMessageSource;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage (CoreDataProperties)

+ (NSFetchRequest<PNPMessage *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, retain) NSData *payload;
@property (nonatomic, retain) NSSet<PNPSubscribable *> *subscribables;
@property (nonatomic, retain) PNPTimetoken *timetoken;
@property (nonatomic, retain) NSOrderedSet<PNPMessageSource *> *sources;

@end

@interface PNPMessage (CoreDataGeneratedAccessors)

- (void)addSubscribablesObject:(PNPSubscribable *)value;
- (void)removeSubscribablesObject:(PNPSubscribable *)value;
- (void)addSubscribables:(NSSet<PNPSubscribable *> *)values;
- (void)removeSubscribables:(NSSet<PNPSubscribable *> *)values;

- (void)insertObject:(PNPMessageSource *)value inSourcesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSourcesAtIndex:(NSUInteger)idx;
- (void)insertSources:(NSArray<PNPMessageSource *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSourcesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSourcesAtIndex:(NSUInteger)idx withObject:(PNPMessageSource *)value;
- (void)replaceSourcesAtIndexes:(NSIndexSet *)indexes withSources:(NSArray<PNPMessageSource *> *)values;
- (void)addSourcesObject:(PNPMessageSource *)value;
- (void)removeSourcesObject:(PNPMessageSource *)value;
- (void)addSources:(NSOrderedSet<PNPMessageSource *> *)values;
- (void)removeSources:(NSOrderedSet<PNPMessageSource *> *)values;

@end

NS_ASSUME_NONNULL_END
