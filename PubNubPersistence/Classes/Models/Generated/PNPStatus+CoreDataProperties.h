//
//  PNPStatus+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPStatus+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPStatus (CoreDataProperties)

+ (NSFetchRequest<PNPStatus *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic) int16_t lastStatusCode;
@property (nullable, nonatomic, copy) NSString *currentUUID;
@property (nullable, nonatomic, retain) PNPTimetoken *timetoken;
@property (nullable, nonatomic, retain) PNPSubscribable *subscribables;

@end

NS_ASSUME_NONNULL_END
