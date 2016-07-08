//
//  PNPStatusViewController.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/8/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/PubNubPersistence.h>
#import "PNPStatusViewController.h"

@interface PNPStatusViewController ()

@end

@implementation PNPStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RLMResults *)dataSourceResults {
    return self.persistenceLayer.statuses;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    PNPStatus *status = [self.persistenceLayer.statuses objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", status.currentTimetoken];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", status.stringifiedCategory];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
