//
//  Networker.m
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 28/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import "Networker.h"



@implementation Networker


// Shared Instance of NSURLSession
+ (NSURLSession *)dataSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSLog(@"dataSession");
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    
    return session;
}



+ (void) fetchContentsOfRequest:(NSMutableURLRequest *)request
                     completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler
{
        NSURLSessionDataTask *dataTask = [[self dataSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (completionHandler == nil) return;
            
            if (error) {
                completionHandler(nil, nil, error);
                return;
            }
            
            //NSLog(@"fetching Request...: %@", response);
            completionHandler(data, response, nil);
        }];
    
    [dataTask resume];
}



+ (void) fetchContentsOfURL:(NSURL*)url
                 completion:(void (^)(NSData *data, NSError *error)) completionHandler
{
    NSURLSessionDataTask *dataTask = [[self dataSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (completionHandler == nil) return;
        
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        //NSLog(@"fetching Data...: %@", data);
        completionHandler(data, nil);
    }];
    
    [dataTask resume];
}



+ (void) downloadFileAtURL:(NSURL*)url
                toLocation:(NSURL*)destinationURL
                completion:(void (^)(NSError *error)) completionHandler
{
    NSURLSessionDownloadTask *fileDownloadTask =
    [[self dataSession] downloadTaskWithRequest:[NSURLRequest requestWithURL:url]
                              completionHandler:
     
     ^(NSURL *location, NSURLResponse *response, NSError *error) {
         
         if (completionHandler == nil) return;
         
         if (error) {
             completionHandler(error);
             return;
         }
         
         NSError *fileError = nil;
         [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:NULL];
         [[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationURL error:&fileError];
         completionHandler(fileError);
     }];
    
    [fileDownloadTask resume];
}

@end
