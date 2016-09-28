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
@property (nonatomic, strong) PNPStatus *currentStatus;
@end

@implementation PNPStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    PubNubPersistence *persistence = appDelegate.persistence;
    
    self.currentStatus = [PNPStatus currentStatusInContext:persistence.persistentContainer.viewContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.currentStatus = nil;
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
