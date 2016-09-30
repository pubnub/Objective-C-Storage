//
//  PNPMessage+CoreDataClass.m
//  Pods
//
//  Created by Jordan Zucker on 9/27/16.
//
//

#import "PNPMessage+CoreDataClass.h"
#import "PNPSubscribable+CoreDataClass.h"
#import "PNPTimetoken+CoreDataClass.h"

@implementation PNPMessage

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.creationDate = [NSDate date];
}

/*
- (BOOL)validateAge:(id*)ioValue error:(NSError**)outError
{
    if (*ioValue == nil) {
        return YES;
    }
    if ([*ioValue floatValue] <= 0.0) {
        if (outError == NULL) {
            return NO;
        }
        NSString *errorStr = NSLocalizedStringFromTable(@"Age must be greater than zero", @"Employee", @"validation: zero age error");
        NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey: errorStr};
        NSError *error = [[NSError alloc] initWithDomain:EMPLOYEE_ERROR_DOMAIN code:PERSON_INVALID_AGE_CODE userInfo:userInfoDict];
        *outError = error;
        return NO;
    } else {
        return YES;
    }
}
 */

/*
- (BOOL)validatePayload:(id *)ioValue error:(NSError **)outError {
    if (*ioValue == nil) {
        if (outError == NULL) {
            return NO;
        }
        NSString *errorStr = [NSString stringWithFormat:@"payload cannot be nil"];
        NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey: errorStr};
        NSError *error = [[NSError alloc] initWithDomain:@"PubNubPersistence" code:200 userInfo:userInfoDict];
        *outError = error;
        return NO;
    }
    return YES;
}
 */

@end
