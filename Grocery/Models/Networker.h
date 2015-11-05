//
//  Networker.h
//  JsonStoryboard
//
//  Created by GranadaMa. Charmelle on 28/10/2015.
//  Copyright © 2015 Charmelle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networker : NSObject


+ (NSURLSession *)dataSession;

+ (void) fetchContentsOfURL:(NSURL*)url
                 completion:(void (^)(NSData *data, NSError *error)) completionHandler;

+ (void) fetchContentsOfRequest:(NSMutableURLRequest *)request
                     completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler;

+ (void) downloadFileAtURL:(NSURL*)url
                toLocation:(NSURL*)destinationURL
                completion:(void (^)(NSError *error)) completionHandler;

@end
