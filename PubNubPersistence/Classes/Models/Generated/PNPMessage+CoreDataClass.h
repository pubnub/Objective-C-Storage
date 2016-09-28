//
//  PNPMessage+CoreDataClass.h
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PNPSubscribable, PNPTimetoken;

NS_ASSUME_NONNULL_BEGIN

@interface PNPMessage : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "PNPMessage+CoreDataProperties.h"
