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
@property (nonatomic, strong) PNPPersistenceLayer *persistenceLayer;
@property (nonatomic, strong) RLMNotificationToken *messageNotificationToken;

@end

@implementation PNPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    self.persistenceLayer = appDelegate.persistenceLayer;
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[PNPMessageTableViewCell class] forCellReuseIdentifier:[PNPMessageTableViewCell reuseIdentifier]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    PNPWeakify(self);
    self.messageNotificationToken = [self.persistenceLayer.messages addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
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

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persistenceLayer.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PNPMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PNPMessageTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    PNPMessage *message = [self.persistenceLayer.messages objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", message.message];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(message.timetoken)];
    return cell;
}

@end
