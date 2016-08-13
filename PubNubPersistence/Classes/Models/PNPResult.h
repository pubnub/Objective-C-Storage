//
//  PNPResult.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class PNResult;

@interface PNPResult : RLMObject

@property NSString *identifier;
@property NSDate *creationDate;
@property NSInteger statusCode;
@property NSInteger operation;
@property BOOL TLSEnabled;
@property NSString *uuid;
@property NSString *authKey;
@property NSString *origin;

- (instancetype)initWithResult:(PNResult *)result;
+ (instancetype)resultWithResult:(PNResult *)result;

@end
