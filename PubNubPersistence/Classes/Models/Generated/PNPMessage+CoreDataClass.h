//
//  PNPMessage+CoreDataClass.h
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PNPMessageSource, PNPPayload, PNPSubscribable, PNPTimetoken;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "PNPMessage+CoreDataProperties.h"
