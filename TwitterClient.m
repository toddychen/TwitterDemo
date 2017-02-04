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

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

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

- (void)loginWithCompletion:(void (^)(User *user, NSError * error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"got the request token: %@", requestToken.token);

        NSURL *authURL = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL options:@{} completionHandler:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the request token!");
        self.loginCompletion(nil, error);
    }];

}

- (void)openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got the access token: %@", accessToken.token);
        
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"doing nothing in progress");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"my user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"current user: %@, screen_name: %@", user.name, user.screenname);
            self.loginCompletion(user, nil);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failed to get current user!");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token!");
    }];

}


@end
