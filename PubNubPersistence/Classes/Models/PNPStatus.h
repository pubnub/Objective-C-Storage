//
//  PNPStatus.h
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class PNStatus;
@class PNPResult;

@interface PNPStatus : RLMObject

@property NSInteger category;
@property BOOL error;
@property PNPResult *result;
@property NSString *identifier;


- (instancetype)initWithStatus:(PNStatus *)status;
+ (instancetype)statusWithStatus:(PNStatus *)status;

@end
