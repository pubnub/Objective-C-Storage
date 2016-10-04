//
//  PNPStatus+CoreDataProperties.h
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPStatus+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PNPStatus (CoreDataProperties)

+ (NSFetchRequest<PNPStatus *> *)fetchRequest;

@property (nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, copy) NSString *currentUUID;
@property (nonatomic) int16_t lastStatusCode;
@property (nullable, nonatomic, retain) PNPSubscribable *subscribables;
@property (nullable, nonatomic, retain) PNPTimetoken *timetoken;

@end

NS_ASSUME_NONNULL_END
