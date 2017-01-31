//
//  TwitterClient.m
//  TwitterDemo
//
//  Created by Yi Chen on 1/30/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"fGjYHwWSkxv2SvYX5t94xE2MX";
NSString * const kTwitterConsumerSecret = @"GlmJ1HtcSa0uBq3kYXZWBdZrso5wUakPqACxvluyzxB6VEj4xo";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";



@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });

    return instance;
}


@end
