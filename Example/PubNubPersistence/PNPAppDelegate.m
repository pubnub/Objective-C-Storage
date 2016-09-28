//
//  PNPAppDelegate.m
//  PubNubPersistence
//
//  Created by Jordan Zucker on 07/07/2016.
//  Copyright (c) 2016 Jordan Zucker. All rights reserved.
//

#import <PubNub/PubNub.h>
#import <PubNubPersistence/Persistence.h>
#import "PNPAppDelegate.h"

@interface PNPAppDelegate ()
@property (nonatomic, strong, readwrite) PubNubPersistence *persistence;
@property (nonatomic, strong, readwrite) PubNub *client;

@end

@implementation PNPAppDelegate
@synthesize client = _client;
@synthesize persistence = _persistence;

- (PubNub *)client {
    if (!_client) {
        PNConfiguration *config = [PNConfiguration configurationWithPublishKey:@"demo-36" subscribeKey:@"demo-36"];
        _client = [PubNub clientWithConfiguration:config];
        _client.logger.enabled = YES;
        [_client.logger setLogLevel:PNVerboseLogLevel];
    }
    return _client;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    PNConfiguration *config = [PNConfiguration configurationWithPublishKey:@"demo-36" subscribeKey:@"demo-36"];
//    self.client = [PubNub clientWithConfiguration:config];
//    PNPPersistenceLayerConfiguration *persistenceConfig = [PNPPersistenceLayerConfiguration persistenceLayerConfigurationWithClient:self.client];
//    self.persistenceLayer = [PNPPersistenceLayer persistenceLayerWithConfiguration:persistenceConfig];
    PNPPersistenceConfiguration *config = [PNPPersistenceConfiguration persistenceConfigurationWithClient:self.client];
    self.persistence = [PubNubPersistence persistenceWithConfiguration:config];
    [self.client subscribeToChannels:@[@"c"] withPresence:YES];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self testRealm];
//    });
    return YES;
}

/*
- (void)testRealm {
    RLMResults *messages = [PNPMessage allObjects];
    NSLog(@"messages: %@", messages);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testRealm];
    });
}
 */

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
