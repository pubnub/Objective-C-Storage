//
//  PNPMessageTableViewCell.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 9/27/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/Persistence.h>
#import "PNPMessageTableViewCell.h"

@implementation PNPMessageTableViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

+ (CGFloat)cellHeight {
    return 75.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)update:(NSManagedObject *)object {
    NSParameterAssert([object isKindOfClass:[PNPMessage class]]);
    PNPMessage *message = (PNPMessage *)object;
    NSString *messageString = [[NSString alloc] initWithData:message.payload encoding:NSUTF8StringEncoding];
    self.textLabel.numberOfLines = 3;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = messageString;
    [self setNeedsLayout];
}

@end
