//
//  PNPMessage+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPMessage+CoreDataClass.h"

@class PNMessageResult;

@interface PNPMessage (Additions)

+ (instancetype)messageWithMessage:(PNMessageResult *)message inContext:(NSManagedObjectContext *)context;

- (NSString *)messageString;

@end
