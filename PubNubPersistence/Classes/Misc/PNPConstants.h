//
//  PNPConstants.h
//  Pods
//
//  Created by Jordan Zucker on 7/7/16.
//
//

#import <Foundation/Foundation.h>

#ifndef PNPConstants_h
#define PNPConstants_h

#define PNPWeakify(__var) \
__weak __typeof__(__var) __var ## _weak_ = (__var)

#define PNPStrongify(__var) \
_Pragma("clang diagnostic push"); \
_Pragma("clang diagnostic ignored  \"-Wshadow\""); \
__strong __typeof__(__var) __var = __var ## _weak_; \
_Pragma("clang diagnostic pop") \

typedef NS_ENUM(NSInteger, PNPStatusStorageOptions) {
    PNPStatusStorageOptionsCurrentStatus = 0,
    PNPStatusStorageOptionsAll,
    PNPStatusStorageOptionsNone
};

typedef NS_ENUM(NSInteger, PNPPresenceEventsStorageOptions) {
    PNPPresenceEventsStorageOptionsAll = 0,
    PNPPresenceEventsStorageOptionsNone
};

static PNPStatusStorageOptions const kPNPDefaultStatusStorageOption = PNPStatusStorageOptionsCurrentStatus;
static PNPPresenceEventsStorageOptions const kPNPDefaultPresenceEventsStorageOption = PNPPresenceEventsStorageOptionsAll;


#endif /* PNPConstants_h */
