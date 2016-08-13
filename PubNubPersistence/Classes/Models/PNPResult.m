//
//  PNPResult.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPResult.h"

@implementation PNPResult

- (instancetype)initWithResult:(PNResult *)result {
    NSParameterAssert(result);
    NSMutableDictionary *value = [@{
                                    @"identifier": [NSUUID UUID].UUIDString,
                                    @"uuid": result.uuid,
                                    @"origin": result.origin,
                                    @"TLSEnabled": @(result.isTLSEnabled),
                                    @"creationDate": [NSDate date],
                                    @"statusCode": @(result.statusCode),
                                    @"operation": @((NSInteger)result.operation)
                                    } mutableCopy];
#warning should this be self init?
    self = [self initWithValue:value.copy];
    return self;
}

+ (instancetype)resultWithResult:(PNResult *)result {
    return [[self alloc] initWithResult:result];
}

#pragma mark - Realm

+ (NSArray *)requiredProperties {
    return @[
             @"TLSEnabled",
             @"uuid",
             @"identifier"
             @"creationDate",
             @"statusCode",
             @"operation",
             ];
}

+ (NSString *)primaryKey {
    return @"identifier";
}

@end
