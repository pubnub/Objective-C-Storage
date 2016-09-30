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

#pragma mark - Methods

- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext * _Nonnull))block {
    [self performBackgroundTaskAndSave:block withCompletion:nil];
}

- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext *))block withCompletion:(nullable void (^)(NSManagedObjectContext *, NSError * _Nullable))completionBlock {
    dispatch_async(self.networkQueue, ^{
        // probably don't need this, just in case
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
#warning this merge policy needs to be set, convenience method would be helpful
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            block(context);
#warning should we check [context hasChanges] before saving?
            NSError *saveError;
            [context save:&saveError];
            if (completionBlock) {
                completionBlock(context, saveError);
#warning probably want to remove this
                NSAssert(!saveError, @"Save error: %@", saveError.localizedDescription);
            }
        }];
    });
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    /*
    dispatch_async(self.networkQueue, ^{
        // probably don't need this, just in case
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
#warning this merge policy needs to be set, convenience method would be helpful
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            PNPMessage *createdMessage = [PNPStatus createOrUpdate:status inContext:context];
            NSError *saveError;
            [context save:&saveError];
            NSAssert(!saveError, @"%@", saveError.debugDescription);
        }];
    });
     */
    [self performBackgroundTaskAndSave:^void(NSManagedObjectContext * _Nonnull context) {
        PNPStatus *createdStatus = [PNPStatus createOrUpdate:status inContext:context];
    }];
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    //NSLog(@"receive message %@", message.debugDescription);
    [self performBackgroundTaskAndSave:^(NSManagedObjectContext * _Nonnull context) {
        PNPMessage *createdMessage = [PNPMessage messageWithMessage:message inContext:context];
    }];
    /*
    dispatch_async(self.networkQueue, ^{
        // probably don't need this, just in case
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
            NSLog(@"add message %@", message.debugDescription);
#warning this merge policy needs to be set, convenience method would be helpful
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            PNPMessage *createdMessage = [PNPMessage messageWithMessage:message inContext:context];
            NSError *saveError;
            [context save:&saveError];
            NSAssert(!saveError, @"%@", saveError.debugDescription);
            if (saveError) {
                NSDictionary *userInfo = [saveError userInfo];
                if (userInfo[NSPersistentStoreSaveConflictsErrorKey]) {
                    NSArray<NSMergeConflict *> *conflicts = userInfo[NSPersistentStoreSaveConflictsErrorKey];
                    for (NSMergeConflict *conflict in conflicts) {
                        NSLog(@"conflict: %@", conflict);
                        PNPSubscribable *subscribable = (PNPSubscribable *)conflict.sourceObject;
                        NSLog(@"subscribable: %@", subscribable);
                    }
                }
            }
        }];
    });
     */
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

#pragma mark - History

- (void)historyForChannel:(NSString *)channel start:(NSNumber *)startDate end:(NSNumber *)endDate withCompletion:(PNPHistoryCompletionBlock)block {
    [self.client historyForChannel:channel start:startDate end:endDate includeTimeToken:YES withCompletion:^(PNHistoryResult * _Nullable result, PNErrorStatus * _Nullable status) {
        __block NSMutableArray<NSManagedObjectID *> *savedMessages = [NSMutableArray array];
        if (status) {
            return;
        }
        [self performBackgroundTaskAndSave:^(NSManagedObjectContext * _Nonnull context) {
            for (NSDictionary *historyMessage in result.data.messages) {
                NSLog(@"message: %@", historyMessage);
                NSNumber *messageTimetoken = (NSNumber *)historyMessage[@"timetoken"];
                id messagePayload = historyMessage[@"message"];
#warning need to fix this up
                //PNPMessage *createdMessage = [PNPMessage messageWithMessage:message inContext:context];
                PNPMessage *createdMessage = [PNPMessage messageWithChannel:channel timetoken:messageTimetoken message:messagePayload inContext:context];
                [savedMessages addObject:createdMessage.objectID];
            }
        } withCompletion:^(NSManagedObjectContext * _Nonnull context, NSError * _Nullable error) {
            if (block) {
                // first check if there is a status
                if (status) {
                    NSError *historyError = [NSError errorWithDomain:@"PubNubPersistence" code:100 userInfo:@{
                                                                                                              @"description": status.stringifiedCategory,
                                                                                                              }];
                    block(nil, error);
                    return;
                }
                // then check for a save error
                if (error) {
                    if (savedMessages.count) {
                        block(savedMessages.copy, error);
                    } else {
                        block(nil, error);
                    }
                    return;
                }
                // else just return
                block(savedMessages.copy, nil);
            }
        }];
    }];
}

- (void)testHistory {
#warning need to include a time token
    [self.client historyForChannel:@"a" withCompletion:^(PNHistoryResult * _Nullable result, PNErrorStatus * _Nullable status) {
        dispatch_async(self.networkQueue, ^{
            // probably don't need this, just in case
            [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
#warning this merge policy needs to be set, convenience method would be helpful
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
                for (id message in result.data.messages) {
                    NSLog(@"message: %@", message);
                    PNPMessage *createdMessage = [PNPMessage messageWithMessage:message inContext:context];
                }
                NSError *saveError;
                [context save:&saveError];
                NSAssert(!saveError, @"%@", saveError.debugDescription);
                if (saveError) {
                    NSDictionary *userInfo = [saveError userInfo];
                    if (userInfo[NSPersistentStoreSaveConflictsErrorKey]) {
                        NSArray<NSMergeConflict *> *conflicts = userInfo[NSPersistentStoreSaveConflictsErrorKey];
                        for (NSMergeConflict *conflict in conflicts) {
                            NSLog(@"conflict: %@", conflict);
                            PNPSubscribable *subscribable = (PNPSubscribable *)conflict.sourceObject;
                            NSLog(@"subscribable: %@", subscribable);
                        }
                    }
                }
            }];
        });
    }];
}

@end
