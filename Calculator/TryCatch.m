//
//  TryCatch.m
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/17/23.
//

#import "TryCatch.h"

@implementation TryCatch

+ (BOOL)tryBlock:(void(^)(void))tryBlock
           error:(NSError **)error
{
    @try {
        tryBlock ? tryBlock() : nil;
    }
    @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"com.something"
                                         code:42
                                     userInfo:@{NSLocalizedDescriptionKey: exception.name}];
        }
        return NO;
    }
    return YES;
}

@end
