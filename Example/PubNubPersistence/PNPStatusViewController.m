//
//  PNPStatusViewController.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 9/28/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/Persistence.h>
#import "PNPStatusViewController.h"
#import "PNPAppDelegate.h"

@interface PNPStatusViewController ()
@property (nonatomic, weak) IBOutlet UILabel *currentTimetokenLabel;
@property (nonatomic, weak) IBOutlet UIButton *historyButton;
@property (nonatomic, weak) IBOutlet UIButton *unsubscribeButton;
@property (nonatomic, weak) IBOutlet UIButton *newestTimetokenButton;
@property (nonatomic, weak) IBOutlet UIButton *newestMessageForChannelButton;
@property (nonatomic, weak) IBOutlet UIButton *publishMessageButton;
@property (nonatomic, strong) PNPStatus *currentStatus;
@end

@implementation PNPStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    PubNubPersistence *client = appDelegate.client;
    
    self.currentStatus = [PNPStatus currentStatusInContext:client.viewContext];
    
    [self.historyButton addTarget:self action:@selector(historyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.unsubscribeButton addTarget:self action:@selector(unsubscribeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.newestTimetokenButton addTarget:self action:@selector(newestTimetokenButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.newestMessageForChannelButton addTarget:self action:@selector(newestMessageForChannelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.publishMessageButton addTarget:self action:@selector(publishMessageButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.currentStatus = nil;
}

#pragma mark - Actions

- (void)newestMessageForChannelButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    PubNubPersistence *client = appDelegate.client;
    PNPMessage *newestMessage = [client newestMessageForChannel:@"meta" inContext:client.viewContext];
    NSLog(@"latest message: %@", newestMessage.debugDescription);
}

- (void)newestTimetokenButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    PubNubPersistence *client = appDelegate.client;
    PNPTimetoken *newestTimetoken = [client newestMessageTimetokenInContext:client.viewContext];
    NSLog(@"latest timetoken: %@", newestTimetoken.debugDescription);
}

- (void)historyButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *start = @([[NSDate date] timeIntervalSince1970]);
    
    NSNumber *end = @([[NSDate dateWithTimeIntervalSince1970:1000] timeIntervalSince1970]);
    
    PubNubPersistence *client = appDelegate.client;
    [client persistentHistoryForChannel:@"meta" start:start end:end withCompletion:^(NSArray<NSManagedObjectID *> * _Nullable messages, NSError * _Nullable error) {
        NSLog(@"messages: %@", messages);
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (void)publishMessageButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    PubNubPersistence *client = appDelegate.client;
    [client persistentPublish:@{@"message": @"hello"} toChannel:@"meta" completion:^(PNPublishStatus * _Nonnull status) {
        NSLog(@"status: %@", status.debugDescription);
    }];
}

- (void)unsubscribeButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.client unsubscribeFromAll];
}

#pragma mark - KVO Getters

- (void)setCurrentStatus:(PNPStatus *)currentStatus {
    [_currentStatus removeObserver:self forKeyPath:@"timetoken"];
    _currentStatus = currentStatus;
    [_currentStatus addObserver:self forKeyPath:@"timetoken" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior|NSKeyValueObservingOptionOld context:nil];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"timetoken"] && [object isKindOfClass:[PNPStatus class]]) {
        self.currentTimetokenLabel.text = [self.currentStatus.timetoken timetokenString];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
