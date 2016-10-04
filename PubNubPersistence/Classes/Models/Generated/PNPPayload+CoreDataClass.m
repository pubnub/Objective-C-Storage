//
//  PNPPayload+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import "PNPPayload+CoreDataClass.h"
#import "PNPMessage+CoreDataClass.h"
@implementation PNPPayload

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

@end
