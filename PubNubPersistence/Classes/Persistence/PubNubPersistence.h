//
//  PubNubPersistence.h
//  Pods
//
//  Created by Jordan Zucker on 8/12/16.
//
//

@import CoreData;
#import <Foundation/Foundation.h>

#import "PNPConstants.h"

@class PubNub;
@class PNPPersistenceConfiguration;

NS_ASSUME_NONNULL_BEGIN

@interface PubNubPersistence : NSObject

@property (nonatomic, strong, readonly) PubNub *client;
@property (nonatomic, strong, readonly) PNPPersistenceConfiguration *configuration;

- (instancetype)initWithConfiguration:(PNPPersistenceConfiguration *)configuration;
+ (instancetype)persistenceWithConfiguration:(PNPPersistenceConfiguration *)configuration;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (void)testHistory;

/*
- (void)historyForChannel:(NSString *)channel start:(nullable NSNumber *)startDate
                      end:(nullable NSNumber *)endDate includeTimeToken:(BOOL)shouldIncludeTimeToken
           withCompletion:(PNHistoryCompletionBlock)block
 */
//typedef void(^PNHistoryCompletionBlock)(PNHistoryResult * _Nullable result, PNErrorStatus * _Nullable status);
typedef void (^PNPHistoryCompletionBlock)(NSArray<NSManagedObjectID *> * _Nullable messages, NSError * _Nullable error);
- (void)historyForChannel:(NSString *)channel start:(nullable NSNumber *)startDate end:(nullable NSNumber *)endDate withCompletion:(nullable PNPHistoryCompletionBlock)block;

// if block return is YES then will save, if NO then will not save
- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext *))block;
- (void)performBackgroundTaskAndSave:(void (^)(NSManagedObjectContext *))block withCompletion:(nullable void (^)(NSManagedObjectContext *, NSError * _Nullable))completionBlock;

@end

NS_ASSUME_NONNULL_END
