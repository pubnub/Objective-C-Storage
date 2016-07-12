//
//  PNPDebugViewController.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/11/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNub/PubNub.h>
#import "PNPDebugViewController.h"

@interface PNPDebugViewController () <
                                        PNObjectEventListener
                                        >
@property (nonatomic, weak) IBOutlet UIButton *subscriptionButton;
@property (nonatomic, strong) NSArray *channels;
@end

@implementation PNPDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.client addListener:self];
    [self.subscriptionButton addTarget:self action:@selector(subscriptionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.subscriptionButton setTitle:@"Subscribe" forState:UIControlStateNormal];
    [self.subscriptionButton setTitle:@"Unsubscribe" forState:UIControlStateSelected];
    self.channels = @[
                      @"a"
                      ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _updateSubscriptionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIActions

- (void)subscriptionButtonTapped:(UIButton *)sender {
    if (sender.selected) {
        // subscribed
        NSLog(@"selected");
        [self.client unsubscribeFromAll];
    } else {
        NSLog(@"unselected");
        [self.client subscribeToChannels:self.channels withPresence:YES];
    }
}

#pragma mark - Subscription Button

- (void)_updateSubscriptionButton {
#warning there should be a shortcut for this
    // if YES then we are subscribing
    if (
        self.client.channels.count ||
        self.client.channelGroups.count
        ) {
        NSLog(@"%s: we are subscribing", __PRETTY_FUNCTION__);
        self.subscriptionButton.selected = YES;
    } else {
        // if NO then we are not subscribing
        NSLog(@"%s: we are not subscribing", __PRETTY_FUNCTION__);
        self.subscriptionButton.selected = NO;
    }
    [self.subscriptionButton sizeToFit];
    [self.subscriptionButton setNeedsLayout];
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    [self _updateSubscriptionButton];
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, status.debugDescription);
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, message.debugDescription);
}

- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, event.debugDescription);
}

@end
