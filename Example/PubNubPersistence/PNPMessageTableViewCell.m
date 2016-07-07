//
//  PNPMessageTableViewCell.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/7/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/PubNubPersistence.h>
#import "PNPMessageTableViewCell.h"

@implementation PNPMessageTableViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

- (instancetype)initWithMessage:(PNPMessage *)message {
    NSParameterAssert(message);
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[self class] reuseIdentifier]];
    if (self) {
        self.textLabel.text = [NSString stringWithFormat:@"%@", message.message];
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(message.timetoken)];
    }
    return self;
}

+ (instancetype)cellWithMessage:(PNPMessage *)message {
    return [[self alloc] initWithMessage:message];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
