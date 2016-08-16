//
//  PNPPubNubViewController.h
//  PubNubPersistence
//
//  Created by Jordan Zucker on 7/11/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PubNub;

@interface PNPPubNubViewController : UIViewController

@property (nonatomic, strong, readonly) PubNub *client;

@end
