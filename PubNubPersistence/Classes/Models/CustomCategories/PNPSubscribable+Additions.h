//
//  PNPSubscribable+Additions.h
//  Pods
//
//  Created by Jordan Zucker on 9/28/16.
//
//

#import "PNPSubscribable+CoreDataClass.h"

typedef NS_ENUM(NSInteger, PNPSubscribableType) {
    PNPSubscribableTypeUnknown = -1,
    PNPSubscribableTypeChannel = 0,
    PNPSubscribableTypeChannelGroup,
};

NS_ASSUME_NONNULL_BEGIN

@interface PNPSubscribable (Additions)

+ (instancetype)createOrUpdateSubscribable:(NSString *)subscribable type:(NSInteger)type inContext:(NSManagedObjectContext *)context;

- (PNPSubscribableType)subscribableType;

@end

NS_ASSUME_NONNULL_END
