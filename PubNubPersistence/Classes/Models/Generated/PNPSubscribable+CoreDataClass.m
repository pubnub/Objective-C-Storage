//
//  PNPSubscribable+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPSubscribable+CoreDataClass.h"
#import "PNPMessage+CoreDataClass.h"
#import "PNPStatus+CoreDataClass.h"
@implementation PNPSubscribable

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

@end
