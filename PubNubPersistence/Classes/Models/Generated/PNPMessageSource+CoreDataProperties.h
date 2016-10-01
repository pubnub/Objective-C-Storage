//
//  PNPMessageSource+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPMessageSource+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPMessageSource (CoreDataProperties)

+ (NSFetchRequest<PNPMessageSource *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic) int16_t type;
@property (nonatomic, retain) PNPMessage *message;

@end

NS_ASSUME_NONNULL_END
