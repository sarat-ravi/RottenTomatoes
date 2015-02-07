//
//  SaratUtils.m
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/6/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "SaratUtils.h"

@implementation SaratUtils

+ (void)makeRequestToUrl: (NSString *) urlString {
    [self makeRequestToUrl:urlString
         completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             if (connectionError) {
                 NSLog(@"Connection error, failed to request: %@", urlString);
             } else {
                 NSLog(@"Successful request: %@", urlString);
             }
         }];
}

+ (void)makeRequestToUrl: (NSString *) urlString
       completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler {
    
    // Creating a request
    NSLog(@"Requesting data from URL: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Sending a request
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: handler];
}

@end
