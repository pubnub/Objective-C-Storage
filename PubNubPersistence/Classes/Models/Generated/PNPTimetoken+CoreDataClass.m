//
//  PNPTimetoken+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPTimetoken+CoreDataClass.h"
#import "PNPMessage+CoreDataClass.h"
#import "PNPStatus+CoreDataClass.h"
@implementation PNPTimetoken

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

@end
