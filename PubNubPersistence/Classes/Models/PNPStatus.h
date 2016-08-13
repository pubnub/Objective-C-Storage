//
//  PNPStatus.h
//  Pods
//
//  Created by Jordan Zucker on 7/8/16.
//
//

#import <Foundation/Foundation.h>
#import "PNPResult.h"

@class PNStatus;

@interface PNPStatus : PNPResult

@property NSInteger category;
@property BOOL error;


- (instancetype)initWithStatus:(PNStatus *)status;
+ (instancetype)statusWithStatus:(PNStatus *)status;

@end
