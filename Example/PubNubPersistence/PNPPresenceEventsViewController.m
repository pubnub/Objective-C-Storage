//
//  PNPPresenceEventsViewController.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/8/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNubPersistence/Persistence.h>
#import "PNPPresenceEventsViewController.h"

@interface PNPPresenceEventsViewController ()

@end

@implementation PNPPresenceEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (RLMResults *)dataSourceResults {
//    return self.persistence.presenceEvents;
//}

//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    PNPPresenceEvent *presenceEvent = [self.persistence.presenceEvents objectAtIndex:indexPath.row];
//    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @(presenceEvent.presenceTimetoken)];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", presenceEvent.presenceEvent];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
