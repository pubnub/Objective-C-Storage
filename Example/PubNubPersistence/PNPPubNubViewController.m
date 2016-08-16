//
//  PNPPubNubViewController.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/11/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <PubNub/PubNub.h>
#import "PNPAppDelegate.h"
#import "PNPPubNubViewController.h"

@interface PNPPubNubViewController ()
@property (nonatomic, strong, readwrite) PubNub *client;
@end

@implementation PNPPubNubViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
        _client = appDelegate.client;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
