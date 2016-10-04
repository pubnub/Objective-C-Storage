//
//  PNPMessageSource+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPMessageSource+CoreDataClass.h"
#import "PNPMessage+CoreDataClass.h"
@implementation PNPMessageSource

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

@end
