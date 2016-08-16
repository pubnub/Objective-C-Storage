//
//  PNPViewController.h
//  PubNubPersistence
//
//  Created by Jordan Zucker on 07/07/2016.
//  Copyright (c) 2016 Jordan Zucker. All rights reserved.
//

@import UIKit;
#import "PNPPubNubViewController.h"

@class RLMResults;
@class PubNubPersistence;

@interface PNPViewController : PNPPubNubViewController

@property (nonatomic, strong, readonly) PubNubPersistence *persistence;

- (RLMResults *)dataSourceResults;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

@end
