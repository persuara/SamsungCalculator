//
//  TryCatch.h
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/17/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TryCatch : NSObject
+ (BOOL)tryBlock:(void(^)(void))tryBlock
           error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
