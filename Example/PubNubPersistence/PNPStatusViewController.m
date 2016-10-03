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
@property (nonatomic, strong) PNPStatus *currentStatus;
@end

@implementation PNPStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    PubNubPersistence *persistence = appDelegate.persistence;
    
    self.currentStatus = [PNPStatus currentStatusInContext:persistence.persistentContainer.viewContext];
    
    [self.historyButton addTarget:self action:@selector(historyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.unsubscribeButton addTarget:self action:@selector(unsubscribeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)historyButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *start = @([[NSDate date] timeIntervalSince1970]);
    
    NSNumber *end = @([[NSDate dateWithTimeIntervalSince1970:1000] timeIntervalSince1970]);
    
    PubNubPersistence *persistence = appDelegate.persistence;
    [persistence historyForChannel:@"a" start:start end:end withCompletion:^(NSArray<NSManagedObjectID *> * _Nullable messages, NSError * _Nullable error) {
        NSLog(@"messages: %@", messages);
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

- (void)unsubscribeButtonTapped:(UIButton *)sender {
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.persistence.client unsubscribeFromAll];
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
