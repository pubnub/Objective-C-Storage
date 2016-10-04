//
//  PubNubPersistence.m
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

#import "PubNubPersistence.h"
#import "PNPMessage+Additions.h"
#import "PNPStatus+Additions.h"
#import "PNPSubscribable+Additions.h"
#import "PNPTimetoken+Additions.h"

@interface PubNubPersistence () <PNObjectEventListener>

@property (nonatomic, strong) dispatch_queue_t networkQueue;

@end

@implementation PubNubPersistence
@synthesize persistentContainer = _persistentContainer;

/*
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
 */

+ (instancetype)clientWithConfiguration:(PNConfiguration *)configuration {
    dispatch_queue_t callbackQueue = dispatch_queue_create("com.PubNubPersistence.CoreDataNetworkingQueue", DISPATCH_QUEUE_CONCURRENT);
    return [self clientWithConfiguration:configuration callbackQueue:callbackQueue];
}

+ (instancetype)clientWithConfiguration:(PNConfiguration *)configuration callbackQueue:(dispatch_queue_t)callbackQueue {
    PubNubPersistence *client = [super clientWithConfiguration:configuration callbackQueue:callbackQueue];
    [client persistentContainer];
    [client addListener:client];
    return client;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkQueue = dispatch_queue_create("com.PubNubPersistence.NetworkingQueue", DISPATCH_QUEUE_CONCURRENT);
        // need an excuse to start the persistent container immediately
        [self _threadSafePersistentContainer];
        // this should never be nil
        [self addListener:self];
    }
    return self;
}

#pragma mark - Destructors

- (void)dealloc {
    [self removeListener:self];
}

#pragma mark - Getters

- (PNPTimetoken *)newestTimetokenInContext:(NSManagedObjectContext *)context {
    NSParameterAssert(context);
    __block PNPTimetoken *timetoken = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPTimetoken *> *fetchRequest = [PNPTimetoken fetchRequest];
        NSSortDescriptor *timeOrdered = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:NO];
        fetchRequest.sortDescriptors = @[
                                         timeOrdered,
                                         ];
        NSError *fetchError;
        NSArray<PNPTimetoken *> *matchedTimetokens = [fetchRequest execute:&fetchError];
        timetoken = matchedTimetokens.firstObject;
    }];
    return timetoken;
}

- (PNPTimetoken *)newestMessageTimetokenInContext:(NSManagedObjectContext *)context {
    NSParameterAssert(context);
    __block PNPTimetoken *timetoken = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPTimetoken *> *fetchRequest = [PNPTimetoken fetchRequest];
        NSSortDescriptor *timeOrdered = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:NO];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"messages.@count > 0"];
        fetchRequest.sortDescriptors = @[
                                         timeOrdered,
                                         ];
        NSError *fetchError;
        NSArray<PNPTimetoken *> *matchedTimetokens = [fetchRequest execute:&fetchError];
        timetoken = matchedTimetokens.firstObject;
    }];
    return timetoken;
}

- (nullable NSArray<PNPMessage *> *)newestMessagesInContext:(NSManagedObjectContext *)context {
    return [self newestTimetokenInContext:context].messages.allObjects;
}

- (NSManagedObjectContext *)viewContext {
    return self.persistentContainer.viewContext;
}

- (NSManagedObjectContext *)newBackgroundContext NS_RETURNS_RETAINED {
    return self.persistentContainer.newBackgroundContext;
}

- (nullable PNPMessage *)newestMessageForChannel:(NSString *)channel inContext:(NSManagedObjectContext *)context {
    NSParameterAssert(context);
    __block PNPMessage *message = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPMessage *> *fetchRequest = [PNPMessage fetchRequest];
        NSSortDescriptor *creationDateOrdered = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];
        NSSortDescriptor *timetokenOrdering = [NSSortDescriptor sortDescriptorWithKey:@"timetoken.timetoken" ascending:NO];
        fetchRequest.sortDescriptors = @[
                                         timetokenOrdering,
                                         creationDateOrdered,
                                         ];
        //NSPredicate *constainsMessagesPredicate = [NSPredicate predicateWithFormat:@"(messages.@count > 0)"];
        //@"SUBQUERY(tasks, $task, $task.completionDate != nil AND $task.user = 'Alex') .@count > 0"
        //NSPredicate *messagesFromChannelPredicate = [NSPredicate predicateWithFormat:@"SUBQUERY(messages, $message, $message.)"]
        //fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(messages.@count > 0) AND (messages.)"];
        //PNPSubscribable *fetchedChannel = [PNPSubscribable createOrUpdateChannel:channel inContext:context];
        NSPredicate *matchesChannelPredicate = [NSPredicate predicateWithFormat:@"SUBQUERY(subscribables, $subscribable, $subscribable.type == 0 AND $subscribable.name == %@).@count > 0", channel];
        fetchRequest.predicate = matchesChannelPredicate;
        
        NSError *fetchError;
        NSArray<PNPMessage *> *matchedMessages = [fetchRequest execute:&fetchError];
        message = matchedMessages.firstObject;
    }];
    return message;
}

- (nullable PNPTimetoken *)newestMessageTimetokenForChannel:(NSString *)channel InContext:(NSManagedObjectContext *)context {
    /*
    NSParameterAssert(context);
    __block PNPTimetoken *timetoken = nil;
    [context performBlockAndWait:^{
        NSFetchRequest<PNPTimetoken *> *fetchRequest = [PNPTimetoken fetchRequest];
        NSSortDescriptor *timeOrdered = [NSSortDescriptor sortDescriptorWithKey:@"timetoken" ascending:NO];
        NSPredicate *constainsMessagesPredicate = [NSPredicate predicateWithFormat:@"(messages.@count > 0)"];
        //@"SUBQUERY(tasks, $task, $task.completionDate != nil AND $task.user = 'Alex') .@count > 0"
        NSPredicate *messagesFromChannelPredicate = [NSPredicate predicateWithFormat:@"SUBQUERY(messages, $message, $message.)"]
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(messages.@count > 0) AND (messages.)"];
        fetchRequest.sortDescriptors = @[
                                         timeOrdered,
                                         ];
        NSError *fetchError;
        NSArray<PNPTimetoken *> *matchedTimetokens = [fetchRequest execute:&fetchError];
        timetoken = matchedTimetokens.firstObject;
    }];
    return timetoken;
     */
    return [self newestMessageForChannel:channel inContext:context].timetoken;
}

#pragma mark - Methods

- (void)performBackgroundTask:(void (^)(NSManagedObjectContext *))block {
    [self.persistentContainer performBackgroundTask:block];
}

- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext * _Nonnull))block {
    [self performBackgroundTaskAndSave:block withCompletion:nil];
}

- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext *))block withCompletion:(nullable void (^)(NSManagedObjectContext *, NSError * _Nullable))completionBlock {
    // returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};
    // (void (^)(NSManagedObjectContext *))block
    void (^task)(NSManagedObjectContext *) = ^void(NSManagedObjectContext * _Nonnull context) {
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
            /*
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
             */
        }
    };
    if ([NSThread isMainThread]) {
        // just test for now
        abort();
        /*
        dispatch_async(self.networkQueue, ^{
            [self performBackgroundTask:task];
        });
         */
    } else {
        [self performBackgroundTask:task];
    }
}

#pragma mark - PNObjectEventListener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    [self performBackgroundTaskAndSave:^void(NSManagedObjectContext * _Nonnull context) {
        NSLog(@"pnp-event: **************** status: %@ ****************", status.debugDescription);
        PNPStatus *createdStatus = [PNPStatus createOrUpdate:status inContext:context];
    }];
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    [self performBackgroundTaskAndSave:^(NSManagedObjectContext * _Nonnull context) {
        NSLog(@"pnp-event: ================ message: %@ ================", message.debugDescription);
        PNPMessage *createdMessage = [PNPMessage subscribedMessageWithMessage:message inContext:context];
    }];
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

- (void)persistentHistoryForChannel:(NSString *)channel start:(NSNumber *)startDate end:(NSNumber *)endDate withCompletion:(PNPHistoryCompletionBlock)block {
    [self historyForChannel:channel start:startDate end:endDate includeTimeToken:YES withCompletion:^(PNHistoryResult * _Nullable result, PNErrorStatus * _Nullable status) {
        __block NSMutableArray<NSManagedObjectID *> *savedMessages = [NSMutableArray array];
        if (status) {
            return;
        }
        [self performBackgroundTaskAndSave:^(NSManagedObjectContext * _Nonnull context) {
            PNPSubscribable *fetchedChannel = [PNPSubscribable createOrUpdateChannel:channel inContext:context];
            for (NSDictionary *historyMessage in result.data.messages) {
                //NSLog(@"message: %@", historyMessage);
                NSNumber *messageTimetoken = (NSNumber *)historyMessage[@"timetoken"];
                id messagePayload = nil;
                if (historyMessage[@"message"]) {
                    messagePayload = historyMessage[@"message"];
                    PNPMessage *historyMessage = [PNPMessage historyMessageWithFetchedChannel:fetchedChannel timetoken:messageTimetoken message:messagePayload inContext:context];
                    //PNPMessage *historyMessage = [PNPMessage messageWithFetchedChannel:fetchedChannel timetoken:messageTimetoken message:messagePayload inContext:context];
                    [savedMessages addObject:historyMessage.objectID];
                }
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

- (void)persistentHistoryForChannelObject:(PNPSubscribable *)channel start:(NSNumber *)startDate end:(NSNumber *)endDate withCompletion:(PNPHistoryCompletionBlock)block {
    [self historyForChannel:channel.name start:startDate end:endDate includeTimeToken:YES withCompletion:^(PNHistoryResult * _Nullable result, PNErrorStatus * _Nullable status) {
        __block NSMutableArray<NSManagedObjectID *> *savedMessages = [NSMutableArray array];
        if (status) {
            return;
        }
        [self performBackgroundTaskAndSave:^(NSManagedObjectContext * _Nonnull context) {
            PNPSubscribable *fetchedChannel = (PNPSubscribable *)[context objectWithID:channel.objectID];
            for (NSDictionary *historyMessage in result.data.messages) {
                //NSLog(@"message: %@", historyMessage);
                NSNumber *messageTimetoken = (NSNumber *)historyMessage[@"timetoken"];
                id messagePayload = nil;
                if (historyMessage[@"message"]) {
                    messagePayload = historyMessage[@"message"];
                    PNPMessage *historyMessage = [PNPMessage historyMessageWithFetchedChannel:fetchedChannel timetoken:messageTimetoken message:messagePayload inContext:context];
                    //PNPMessage *historyMessage = [PNPMessage messageWithFetchedChannel:fetchedChannel timetoken:messageTimetoken message:messagePayload inContext:context];
                    [savedMessages addObject:historyMessage.objectID];
                }
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

- (void)catchUpOnChannel:(NSString *)channel withCompletion:(PNPHistoryCompletionBlock)block {
    [self performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        PNPTimetoken *newestTimetoken = [self newestMessageTimetokenForChannel:channel InContext:context];
        NSDate *startDate = @([NSDate date].timeIntervalSince1970);
        [self persistentHistoryForChannel:channel start:startDate end:@(newestTimetoken.timetoken) withCompletion:^(NSArray<NSManagedObjectID *> * _Nullable messages, NSError * _Nullable error) {
            if (block) {
                block(messages, error);
            }
        }];
    }];
}

@end
