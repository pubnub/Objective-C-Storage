//
//  PNPMessageTableViewCell.h
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/7/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PNPMessage;

@interface PNPMessageTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

- (instancetype)initWithMessage:(PNPMessage *)message;
+ (instancetype)cellWithMessage:(PNPMessage *)message;

@end
