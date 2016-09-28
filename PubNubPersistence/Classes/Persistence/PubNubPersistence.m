//
//  PubNubPersistence.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import <PubNub/PubNub.h>
#import "PNPPersistenceConfiguration.h"
#import "PubNubPersistence.h"
#import "PNPMessage+Additions.h"
#import "PNPStatus+Additions.h"

@interface PubNubPersistence () <PNObjectEventListener>
@property (nonatomic, strong, readwrite) PNPPersistenceConfiguration *configuration;

@property (nonatomic, strong) dispatch_queue_t networkQueue;

@end

@implementation PubNubPersistence
@synthesize persistentContainer = _persistentContainer;

- (instancetype)initWithConfiguration:(PNPPersistenceConfiguration *)configuration {
    NSParameterAssert(configuration);
    self = [super init];
    if (self) {
        _networkQueue = dispatch_queue_create("com.PubNubPersistence.NetworkingQueue", DISPATCH_QUEUE_CONCURRENT);
        _configuration = configuration.copy;
        // need an excuse to start the persistent container immediately
        [self _threadSafePersistentContainer];
        // this should never be nil
        [_configuration.client addListener:self];
    }
    return self;
}

+ (instancetype)persistenceWithConfiguration:(PNPPersistenceConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

#pragma mark - Destructors

- (void)dealloc {
    [self.client removeListener:self];
}

#pragma mark - Getters

- (PubNub *)client {
    return self.configuration.client;
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    dispatch_async(self.networkQueue, ^{
        // probably don't need this, just in case
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
            PNPMessage *createdMessage = [PNPStatus createOrUpdate:status inContext:context];
            NSError *saveError;
            [context save:&saveError];
            NSAssert(!saveError, @"%@", saveError.debugDescription);
        }];
    });
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    dispatch_async(self.networkQueue, ^{
        // probably don't need this, just in case
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
            PNPMessage *createdMessage = [PNPMessage messageWithMessage:message inContext:context];
            NSError *saveError;
            [context save:&saveError];
            NSAssert(!saveError, @"%@", saveError.debugDescription);
        }];
    });
}

#pragma mark - CoreData

- (NSPersistentContainer *)_threadSafePersistentContainer {
    // The persistent container for the framework. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            NSLog(@"!!!!!!!!!!!!!! Creating Persistent Container !!!!!!!!!!!!!!");
            
            NSBundle *podBundle = [NSBundle bundleForClass:self.classForCoder];
            NSURL *dataModelBundleURL = [podBundle URLForResource:@"DataModel" withExtension:@"bundle"];
            NSBundle *dataModelBundle = [NSBundle bundleWithURL:dataModelBundleURL];
            //NSURL *dataModelURL = [dataModelBundle URLForResource:@"PubNubPersistence" withExtension:@"xcdatamodeld"];
            //NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"DataModel" ofType:@"bundle"];
            //NSBundle *podBundle = [NSBundle bundleWithPath:bundlePath];
            NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:@[dataModelBundle]];
            
            //NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:dataModelURL];
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"PubNubPersistence" managedObjectModel:model];
            _persistentContainer.viewContext.automaticallyMergesChangesFromParent = YES;
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

- (NSPersistentContainer *)persistentContainer {
    return [self _threadSafePersistentContainer];
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
