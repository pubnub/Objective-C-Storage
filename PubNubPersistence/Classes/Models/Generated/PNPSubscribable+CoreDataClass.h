//
//  PNPSubscribable+CoreDataClass.h
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PNPMessage, PNPStatus;

NS_ASSUME_NONNULL_BEGIN

@interface PNPSubscribable : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "PNPSubscribable+CoreDataProperties.h"
