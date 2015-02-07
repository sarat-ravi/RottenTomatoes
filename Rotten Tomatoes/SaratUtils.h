//
//  SaratUtils.h
//  Rotten Tomatoes
//
//  Created by Sarat Tallamraju on 2/6/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaratUtils : NSObject

// Make request to specified url.
+ (void)makeRequestToUrl: (NSString *) urlString;

// Make request to specified url and handle the reasponse
+ (void)makeRequestToUrl: (NSString *) urlString
       completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler;

@end
