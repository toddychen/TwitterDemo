//
//  TwitterClient.h
//  TwitterDemo
//
//  Created by Yi Chen on 1/30/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "User.h"

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError * error))completion;
- (void)openURL:(NSURL *)url;


@end
