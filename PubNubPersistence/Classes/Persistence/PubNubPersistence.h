//
//  PubNubPersistence.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

@import CoreData;
#import <PubNub/PubNub.h>

#import "PNPConstants.h"
#import "PNPMessaging.h"

@class PNPTimetoken;
@class PNPMessage;
@class PNPSubscribable;

NS_ASSUME_NONNULL_BEGIN

@interface PubNubPersistence : PubNub

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
- (NSManagedObjectContext *)viewContext;
- (NSManagedObjectContext *)newBackgroundContext NS_RETURNS_RETAINED;
- (void)performBackgroundTask:(void (^)(NSManagedObjectContext *))block;

- (nullable PNPTimetoken *)newestTimetokenInContext:(NSManagedObjectContext *)context;
- (nullable PNPTimetoken *)newestMessageTimetokenInContext:(NSManagedObjectContext *)context;

- (nullable NSArray<PNPMessage *> *)newestMessagesInContext:(NSManagedObjectContext *)context;

- (nullable PNPTimetoken *)newestMessageTimetokenForChannel:(NSString *)channel inContext:(NSManagedObjectContext *)context;
- (nullable PNPMessage *)newestMessageForChannel:(NSString *)channel inContext:(NSManagedObjectContext *)context;

typedef void (^PNPHistoryCompletionBlock)(NSArray<NSManagedObjectID *> * _Nullable messages, NSError * _Nullable error);

- (void)persistentHistoryForChannel:(NSString *)channel start:(nullable NSNumber *)startDate end:(nullable NSNumber *)endDate withCompletion:(nullable PNPHistoryCompletionBlock)block;

- (void)catchUpOnChannel:(NSString *)channel withCompletion:(nullable PNPHistoryCompletionBlock)block;

- (void)persistentPublish:(id)message toChannel:(NSString *)channel withMetadata:(nullable NSDictionary<NSString *,id> *)metadata completion:(nullable PNPublishCompletionBlock)block;
- (void)persistentPublish:(id)message toChannel:(NSString *)channel completion:(nullable PNPublishCompletionBlock)block;


- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext *))block;
- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext *))block withCompletion:(nullable void (^)(NSManagedObjectContext *, NSError * _Nullable))completionBlock;

@end

NS_ASSUME_NONNULL_END
