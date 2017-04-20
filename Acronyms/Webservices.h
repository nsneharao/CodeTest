//
//  Webservices.h
//  Acronyms
//
//  Created by Sneha Rao on 4/20/17.
//  Copyright © 2017 Sneha Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id result);
typedef void(^failureBlock)(NSString *errMsg);

@interface Webservices : NSObject
+(void)getDataWithURLString:(NSString*)urlStr completionSuccess:(successBlock)successResult completionfailure:(failureBlock)failureError;
@end
