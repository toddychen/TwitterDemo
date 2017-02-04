//
//  User.m
//  TwitterDemo
//
//  Created by Yi Chen on 1/31/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url_https"];
        self.backgroundImageUrl = dictionary[@"profile_background_image_url_https"];
        self.tagline = dictionary[@"description"];
        
        self.statusesCount = dictionary[@"statuses_count"];
        self.followingCount = dictionary[@"friends_count"];
        self.followersCount = dictionary[@"followers_count"];
    }
    
    return self;
}


@end
