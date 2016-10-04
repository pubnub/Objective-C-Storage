//
//  PNPStatus+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPStatus+CoreDataClass.h"
#import "PNPSubscribable+CoreDataClass.h"
#import "PNPTimetoken+CoreDataClass.h"
@implementation PNPStatus

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

@end
