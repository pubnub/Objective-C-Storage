//
//  PNPMessageTableViewCell.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 9/27/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/Persistence.h>
#import "PNPMessageTableViewCell.h"

@interface PNPMessageTableViewCell ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *timetokenLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *subscribablesLabel;

@end

@implementation PNPMessageTableViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

+ (CGFloat)cellHeight {
    return 150.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timetokenLabel = [self labelFactory];
        _messageLabel = [self labelFactory];
        _subscribablesLabel = [self labelFactory];
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_timetokenLabel, _messageLabel, _subscribablesLabel]];
        [self.contentView addSubview:_stackView];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.distribution = UIStackViewDistributionEqualCentering;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = @{
                                @"stackView": _stackView,
                                };
        NSArray *horizontalLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stackView]|" options:kNilOptions metrics:nil views:views];
        NSArray *verticalLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stackView]|" options:kNilOptions metrics:nil views:views];
        [NSLayoutConstraint activateConstraints:horizontalLayoutConstraints];
        [NSLayoutConstraint activateConstraints:verticalLayoutConstraints];
        [self.contentView setNeedsLayout];
    }
    return self;
}

- (UILabel *)labelFactory {
    UILabel *createdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    createdLabel.numberOfLines = 3;
    createdLabel.textAlignment = NSTextAlignmentCenter;
    createdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    return createdLabel;
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
    NSString *messageString = [message messageString];
    /*
    self.textLabel.numberOfLines = 3;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = messageString;
    self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    self.detailTextLabel.numberOfLines = 3;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@", message.subscribables.debugDescription];
     */
    self.timetokenLabel.text = [NSString stringWithFormat:@"Timetoken: %@", [message.timetoken timetokenString]];
    self.messageLabel.text = [NSString stringWithFormat:@"Message: %@", messageString];
    self.subscribablesLabel.text = [NSString stringWithFormat:@"Subscribables: %@", message.subscribablesString];
    [self.contentView setNeedsLayout];
}

@end
