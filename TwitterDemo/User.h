//
//  User.h
//  TwitterDemo
//
//  Created by Yi Chen on 1/31/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *backgroundImageUrl;
@property (nonatomic, strong) NSString *tagline;

@property (nonatomic, strong) NSNumber *statusesCount;
@property (nonatomic, strong) NSNumber *followingCount;
@property (nonatomic, strong) NSNumber *followersCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
