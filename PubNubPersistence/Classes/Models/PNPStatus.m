//
//  PNPStatus.m
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPResult.h"
#import "PNPStatus.h"
#import "PNPSubscribeStatus.h"

//@property long long currentTimetoken;
//@property long long lastTimetoken;
//@property NSInteger category;
//@property BOOL error;

@implementation PNPStatus

- (instancetype)initWithStatus:(PNStatus *)status {
//    NSParameterAssert(status);
//    NSMutableDictionary *value = [@{
//                                    @"currentTimetoken": status.currentTimetoken,
//                                    @"lastTimetoken": status.lastTimeToken,
//                                    @"statusCode": @(status.statusCode),
//                                    } mutableCopy];
//    self = [self initWithValue:value.copy];
//    return self;
//    self = [self initWithResult:status];
//    if (self) {
//        _category = (NSInteger)status.category;
//        _error = status.isError;
//    }
//    return self;
    NSLog(@"category: %d", status.category);
    NSMutableDictionary *value = [@{
                                    @"result": [PNPResult resultWithResult:(PNResult *)status],
                                    @"identifier": [NSUUID UUID].UUIDString,
                                    @"category": @((NSInteger)status.category),
                                    @"error": @(status.isError),
                                    } mutableCopy];
#warning should this be self init?
    self = [self initWithValue:value.copy];
    return self;
}

+ (instancetype)statusWithStatus:(PNStatus *)status {
    return [[self alloc] initWithStatus:status];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"identifier",
             @"category",
             @"error",
             ];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"subscribeStatus": [RLMPropertyDescriptor descriptorWithClass:PNPSubscribeStatus.class propertyName:@"status"],
             };
}

@end
