//
//  PNPSubscribable+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
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
