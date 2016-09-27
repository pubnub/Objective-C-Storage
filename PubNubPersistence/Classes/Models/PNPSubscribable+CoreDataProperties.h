//
//  PNPSubscribable+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPSubscribable+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPSubscribable (CoreDataProperties)

+ (NSFetchRequest<PNPSubscribable *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, retain) PNPMessage *messages;
@property (nullable, nonatomic, retain) PNPStatus *statuses;

@end

NS_ASSUME_NONNULL_END
