//
//  PNPMessageTableViewCell.h
//  PubNubPersistence
//
//  Created by Jordan Zucker on 9/27/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

@import CoreData;
#import <UIKit/UIKit.h>

@interface PNPMessageTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellHeight;

- (void)update:(NSManagedObject *)object;

@end
