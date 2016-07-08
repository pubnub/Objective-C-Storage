//
//  PNPViewController.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 07/07/2016.
//  Copyright (c) 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/PubNubPersistence.h>
#import "PNPAppDelegate.h"
#import "PNPViewController.h"
#import "PNPMessageTableViewCell.h"

@interface PNPViewController () <
                                    UITableViewDelegate,
                                    UITableViewDataSource
                                >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong, readwrite) PNPPersistenceLayer *persistenceLayer;
@property (nonatomic, strong) RLMNotificationToken *updateNotificationToken;

@end

@implementation PNPViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
        _persistenceLayer = appDelegate.persistenceLayer;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
        _persistenceLayer = appDelegate.persistenceLayer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[PNPMessageTableViewCell class] forCellReuseIdentifier:[PNPMessageTableViewCell reuseIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    PNPWeakify(self);
    self.updateNotificationToken = [self.dataSourceResults addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to open realm on background worker: %@", error);
            return;
        }
        PNPStrongify(self);
        UITableView *currentTableView = self.tableView;
        
        // Initial run of the query will pass nil for the change information
        if (!change) {
            [currentTableView reloadData];
            return;
        }
        
        // Query results have changed, so apply them to the UITableView
        [currentTableView beginUpdates];
        [currentTableView deleteRowsAtIndexPaths:[change deletionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [currentTableView insertRowsAtIndexPaths:[change insertionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [currentTableView reloadRowsAtIndexPaths:[change modificationsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [currentTableView endUpdates];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.updateNotificationToken stop];
}

- (RLMResults *)dataSourceResults {
    return nil;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PNPMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PNPMessageTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self configureCell:(UITableViewCell *)cell forIndexPath:indexPath];
    
//    PNPMessage *message = [self.persistenceLayer.messages objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", message.message];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(message.timetoken)];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
}

@end
