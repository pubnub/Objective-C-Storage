//
//  PNPPayload+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPPayload+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PNPPayload (Additions)

+ (instancetype)createOrUpdatePayloadWithIdentifier:(NSString *)identifier message:(id)messagePayload inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
