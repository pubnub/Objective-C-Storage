//
//  PNPMessageSource+Additions.m
//  Pods
//
//  Created by Jordan Zucker on 10/1/16.
//
//

#import "PNPMessageSource+Additions.h"

@implementation PNPMessageSource (Additions)

+ (instancetype)messageSourceWithType:(PNPMessageSourceType)source inContext:(nonnull NSManagedObjectContext *)context {
    PNPMessageSource *messageSource = [[PNPMessageSource alloc] initWithContext:context];
    messageSource.type = source;
    return messageSource;
}

+ (instancetype)subscribeMessageSourceInContext:(NSManagedObjectContext *)context {
    return [self messageSourceWithType:PNPMessageSourceTypeSubscribe inContext:context];
}

+ (instancetype)historyMessageSourceInContext:(NSManagedObjectContext *)context {
    return [self messageSourceWithType:PNPMessageSourceTypeHistory inContext:context];
}

- (PNPMessageSourceType)sourceType {
    return (PNPMessageSourceType)self.type;
}

@end
