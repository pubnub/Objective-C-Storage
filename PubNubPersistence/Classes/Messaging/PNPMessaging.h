//
//  PNPMessaging.h
//  Pods
//
//  Created by Jordan Zucker on 10/4/16.
//
//

#import <Foundation/Foundation.h>

@protocol PNPDataSerializer <NSObject>

- (NSData *)dataFromMessage;

@end

@protocol PNPObjectDeserializer <NSObject>

- (instancetype)initFromData:(NSData *)data;

@end

@protocol PNPMessaging <PNPDataSerializer, PNPObjectDeserializer>

@end
