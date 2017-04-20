//
//  Webservices.m
//  Acronyms
//
//  Created by Sneha Rao on 4/20/17.
//  Copyright © 2017 Sneha Rao. All rights reserved.
//

#import "Webservices.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"


@implementation Webservices
+(void)getDataWithURLString:(NSString*)urlStr completionSuccess:(successBlock)successResult completionfailure:(failureBlock)failureError{
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:appDel.window];
    HUD.delegate=nil;
    HUD.label.text = @"Loading...";
    [appDel.window addSubview:HUD];
    [HUD showAnimated:true];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    

    NSURL *url = [NSURL URLWithString:urlStr];
    

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failureError(error.localizedDescription);
                [HUD removeFromSuperview];
            }else{
                
                NSError *errorJson=nil;
                NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJson];
                successResult(responseDict);
                [HUD removeFromSuperview];
            }
        });
    }];
    [dataTask resume];
}
@end
